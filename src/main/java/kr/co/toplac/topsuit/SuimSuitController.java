package kr.co.toplac.topsuit;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DateUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topgeneral.TopPtnrMbrBscVO;
import kr.co.toplac.topsuim.SuimRegInsController;
import kr.co.toplac.topsuim.SuimRegInsViewVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.ftp.FtpControll;

@Controller
public class SuimSuitController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(SuimSuitController.class);
	
	public File multipartToFile(MultipartFile multipart) throws IllegalStateException, IOException 
	{
	        File convFile = new File( multipart.getOriginalFilename());
	        multipart.transferTo(convFile);
	        return convFile;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "readXls", method = RequestMethod.POST)
	public void readXls(Model model, HttpServletRequest req , MultipartRequest request, HttpServletResponse response,String actionFlag) { //param
		
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		//파일을 읽기위해 엑셀파일을 가져온다 
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(multipartToFile(request.getFile("attchFile")));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		HSSFWorkbook workbook = null;
		try {
			workbook = new HSSFWorkbook(fis);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		HSSFSheet sheet=workbook.getSheetAt(0);
		
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();
		
		JSONArray arr = new JSONArray();
		
		for(int rowindex=1; rowindex<rows; rowindex++){
			
			JSONObject obj = new JSONObject();
			
		    //행을 읽는다
		    HSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		        //셀의 수
		        int cells=row.getPhysicalNumberOfCells();
		        for(int columnindex=0; columnindex<=cells; columnindex++){
		            //셀값을 읽는다
		            HSSFCell cell=row.getCell(columnindex);
		            String value="";
		            //셀이 빈값일경우를 위한 널체크
		            if(cell==null){
		                continue;
		            }else{
		                //타입별로 내용 읽기
		                switch (cell.getCellType()){
		                case HSSFCell.CELL_TYPE_FORMULA:
		                    value=cell.getCellFormula();
		                    break;
		                case HSSFCell.CELL_TYPE_NUMERIC:
		                	if(DateUtil.isCellDateFormatted(cell)){
		                		Date date = cell.getDateCellValue();
		                		value = new SimpleDateFormat("yyyy-MM-dd").format(date);
		                	}else{
		                		value=cell.getNumericCellValue()+"";		                		
		                	}
		                    
		                    break;
		                case HSSFCell.CELL_TYPE_STRING:
		                    value=cell.getStringCellValue()+"";
		                    break;
		                case HSSFCell.CELL_TYPE_BLANK:
		                    value=cell.getBooleanCellValue()+"";
		                    break;
		                case HSSFCell.CELL_TYPE_ERROR:
		                    value=cell.getErrorCellValue()+"";
		                    break;		                    
		                }
		            	/*value=cell.getStringCellValue()+"";*/
		                value = value.replace(".0", "");
		            }
		            
		            obj.put("data"+(columnindex+1), value);
	            }
		        
		        arr.add(obj);
		        
		        /*저장하기 버튼일 경우: 일괄 등록 시작*/
		        if(actionFlag.equals("insert")){
		        	/*해당 행의 조사자 이름으로 팀정보와 사원정보 추출하기*/
		        	TopMbrBscVO tempMbr = new TopMbrBscVO();
		        	
		        	if(obj.get("data9") != null){
		        		String userName= (String) obj.get("data9");
		        		tempMbr = sqlSession.selectOne("SuimSuitMapper.getMbrDtl" , userName);		        		
		        	}else{
		        		tempMbr.setTeam_id_main("");
		        		tempMbr.setTeam_name("");
		        		tempMbr.setUser_id("");
		        		tempMbr.setUser_no("");
		        		tempMbr.setUser_name("");
		        	}
		        	
		        	/*해당 행의 담당자 이름으로 보험사 직원 정보 추출하기*/
		        	TopPtnrMbrBscVO tempPtnrBsc = new TopPtnrMbrBscVO();
		        	if(obj.get("data11") != null){
		        		String ptnrMbrName= (String) obj.get("data11");
		        		tempPtnrBsc = sqlSession.selectOne("SuimSuitMapper.getPtnrMbrDtlForMeritzAll" , ptnrMbrName);		        		
		        	}else{
		        		tempPtnrBsc.setPtnr_tm_nm("");
		        		tempPtnrBsc.setPtnr_mbr_no("");
		        		tempPtnrBsc.setPtnr_mbr_nm("");
		        	}
		        	
		        	String suimCode = "TL";
		        	
		        	/*날짜 계산*/
		    		Calendar cal = Calendar.getInstance();    
		    		cal.setTime(new Date());    
		    		
		    		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
		    		String suimDay = df.format(cal.getTime());  
		    		
		    		/*접수번호 앞자리의 연도 YY + 월 MM*/
		    		String suimYear = suimDay.substring(2, 4);
		    		String suimMonth = suimDay.substring(5, 7);
		    		
		    		String thisSuimCodeFront = suimCode+suimYear+suimMonth;
		    		String maxSuimNo = "";
		    		
		    		maxSuimNo = sqlSession.selectOne("SuimRegInsMapper.getMaxNo", thisSuimCodeFront);
		    		
		    		maxSuimNo = makeFourNumberWithZero(maxSuimNo);
		    		
		    		String reportId =  suimCode+suimYear+suimMonth+"-"+maxSuimNo;
		        	
		    		SuimRegInsViewVO meritzInsDataVo = new SuimRegInsViewVO();
		    		
		    		//String tempDay = df.format((( Integer.parseInt((String)obj.get("data6"))-25569)*86400) );  
		    		
		    		meritzInsDataVo.setSuimAcceptNo(reportId);
		    		meritzInsDataVo.setSuimRptType1("1");
		    		meritzInsDataVo.setTeamId(tempMbr.getTeam_id_main());
		    		meritzInsDataVo.setUserNo(tempMbr.getUser_no());
		    		meritzInsDataVo.setPtnrId("16");
		    		meritzInsDataVo.setPtnrDeptId(tempPtnrBsc.getPtnr_dept_id()); //getPtnr_tm_nm()
		    		meritzInsDataVo.setPtnrMbrNo(tempPtnrBsc.getPtnr_mbr_no());
		    		meritzInsDataVo.setPolicyholderNm( (String)obj.get("data4")); //4번
		    		meritzInsDataVo.setAccidentDate((String)obj.get("data6")); //6번 ($tmp_array[5]-25569)*86400
		    		meritzInsDataVo.setRegDate( (String)obj.get("data6"));
		    		meritzInsDataVo.setSuimRptType2("1");
		    		meritzInsDataVo.setBeneficiaryNm("");
		    		meritzInsDataVo.setDamagedNm("");
		    		
		    		if((String)obj.get("data7") == null){
		    			meritzInsDataVo.setDamagedAmtEstimated(""); //7번
		    		}else{
		    			meritzInsDataVo.setDamagedAmtEstimated((String)obj.get("data7")); //7번
		    		}
		    		if((String)obj.get("data12") == null){
		    			meritzInsDataVo.setCommissionEstimated(""); //7번
		    		}else{
		    			meritzInsDataVo.setCommissionEstimated((String)obj.get("data12")); //7번
		    		}
		    		
		    		meritzInsDataVo.setRegDate((String)obj.get("data6")); //6번
		    		meritzInsDataVo.setAccidentNo((String)obj.get("data2")); //2번
		    		meritzInsDataVo.setPolicyNo((String)obj.get("data3"));//3번
		    		
		    		//int resultSuim = sqlSession.insert("SuimRegInsMapper.insMeritzAll",meritzInsDataVo);
		    		
		    		int resultHead = sqlSession.insert("SuimRegInsMapper.suimInsHead1", meritzInsDataVo);
					
					String suim_rpt_no = sqlSession.selectOne("SuimRegInsMapper.getSuimRptNo", meritzInsDataVo.getSuimAcceptNo());
					meritzInsDataVo.setSuimRptNo(suim_rpt_no);
					
					/*추정 손해액, 추정 수수료 미입력시 0 으로 세팅*/
					if(meritzInsDataVo.getCommissionEstimated().equals("")){
						meritzInsDataVo.setCommissionEstimated("0");
					}
					
					if(meritzInsDataVo.getDamagedAmtEstimated().equals("")){
						meritzInsDataVo.setDamagedAmtEstimated("0");
					}
					
					/*번호 2*/
					int resultBody = sqlSession.insert("SuimRegInsMapper.suimInsBody1", meritzInsDataVo);
					
					/*번호 3*/
					int resultInv = sqlSession.insert("SuimRegInsMapper.suimInsInvoice", meritzInsDataVo.getSuimRptNo());
		    		
					if(resultHead >0 && resultBody>0 && resultInv>0){
						obj.put("insOk", "yes");
					}else{
						obj.put("insOk", "no");
					}
		        	
		        }else{ // 메리츠 일괄 입력 중 한행 입력 끝 : end for j
		        	//Todo
		        }
	        }
		}
		
		String jsonStr = arr.toString();
		out.print(jsonStr);
		out.close();
	}
	
	@SuppressWarnings("unused")
	private String encodeIsoToEuc(String strData) { //	
		
		String newStr = "";
		try {
			newStr = new String(strData.getBytes("ISO-8859-1"),"EUC-KR");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	   	return newStr;
	}
    
    private String encodeIsoToUTF(String strData) { //
        
        String newStr = "";
        try {
            newStr = new String(strData.getBytes("ISO-8859-1"),"UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        
        return newStr;
    }
	
	
	/*
	 * ***************************************
	 * Method ID : getContractInfo
	 * Method Name :  getContractInfo
	 * Description : 적부 보안 데이터 출력 화면
	 * 
	 * Author : 이선형
	 * Date : 20160908
	 * UpdateDate 	: 20161215, by 임대성
	 * UpdateDate2 	: 20170828, by 임대성
	 * Description  : 기존 popup방식에서 AJAX로 변경
	 * ***************************************
	 * */
	@RequestMapping(value = "getContractInfo")
	@ResponseBody
//	public String getContractInfo(Model model, String ptnrId, String suimRptNo, String target, String suitFlag, HttpSession session) {
	public Map<String,Object> getContractInfo(HttpServletRequest request, String suitFlag, HttpSession session) {
		
		//===========================================
		// ResultMap Setting 
		//===========================================s
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		//===========================================
		// ParameterMap Setting 
		//===========================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
        
		/*로그인 정보 유지 여부 확인*/
        if ( mbrVo.getUser_no() == null || "".equals(mbrVo.getUser_no()) ){
	        paramMap.put("Authorize", "F");
	        return paramMap;
        }
//		
		String resultStr = sqlSession.selectOne("SuimSuitMapper.getContractInfo",paramMap);
		if ( resultStr != null && !"".equals(resultStr) ){
			
			String target = String.valueOf( paramMap.get("target") );
			//KB적부의 경우 암호화를 하지 않음
			if (!suitFlag.equals("10")){ 
				Damo damo = new Damo();
				if (target.equals("conHndPhoneNo") || target.equals("clerkHndPhoneNo") ||
					target.equals("Policyholder_hp") || target.equals("conHomeTelNo")  ||
					target.equals("bd1_b") || target.equals("bd1_d")  ||
					target.equals("bd2_b") || target.equals("bd2_d")  ||
					target.equals("bd3_b") || target.equals("bd3_d")) {
					resultStr = damo.decodeDamo(resultStr);
				}
			}
			resultMap.put("contents", resultStr);
			
			switch(target){
				case "contractorName"	: resultMap.put("title", "계약자명"); break;
				case "conHndPhoneNo"	: resultMap.put("title", "계약자핸드폰"); break;
				case "conHomeTelNo"		: resultMap.put("title", "계약자자택"); break;
				case "conOfficeNo"		: resultMap.put("title", "계약자직장"); break;
				case "bd1_a"			: resultMap.put("title", "소유자명"); break;
				case "bd1_b"			: resultMap.put("title", "소유자 핸드폰"); break;
				case "bd1_d"			: resultMap.put("title", "소재지명"); break;
				case "bd2_a"			: resultMap.put("title", "소유자명"); break;
				case "bd2_b"			: resultMap.put("title", "소유자 핸드폰"); break;
				case "bd2_d"			: resultMap.put("title", "소재지명"); break;
				case "bd3_a"			: resultMap.put("title", "소유자명"); break;
				case "bd3_b"			: resultMap.put("title", "소유자 핸드폰"); break;
				case "bd3_d"			: resultMap.put("title", "소재지명"); break;
				case "hostName"			: resultMap.put("title", "소유자명"); break;
				case "hostHndPhoneNo"	: resultMap.put("title", "소유자 핸드폰"); break;
				case "hostHomeTelNo"	: resultMap.put("title", "소유자 자택"); break;
				case "hostOfficeNo"		: resultMap.put("title", "소유자 직장"); break;
				case "buildingAddr"		: resultMap.put("title", "소재지 상세"); break;
			}
			resultMap.put("result", "0000");
		}else{
			resultMap.put("result", "9999");
		}
		
		
		return resultMap;
		
//		<c:if test="${field eq 'contractorName'}">계약자명</c:if>
//		<c:if test="${field eq 'conHndPhoneNo'}">계약자핸드폰</c:if>
//		<c:if test="${field eq 'conHomeTelNo'}">계약자자택</c:if>
//		<c:if test="${field eq 'conOfficeNo'}">계약자직장</c:if>
//		
//		<c:if test="${field eq 'bd1_a'}">소유자명</c:if>
//		<c:if test="${field eq 'bd1_b'}">소유자 핸드폰</c:if>
//		<c:if test="${field eq 'bd1_d'}">소재지명</c:if>
//		<c:if test="${field eq 'bd2_a'}">소유자명</c:if>
//		<c:if test="${field eq 'bd2_b'}">소유자 핸드폰</c:if>
//		<c:if test="${field eq 'bd2_d'}">소재지명</c:if>
//		<c:if test="${field eq 'bd3_a'}">소유자명</c:if>
//		<c:if test="${field eq 'bd3_b'}">소유자 핸드폰</c:if>
//		<c:if test="${field eq 'bd3_d'}">소재지명</c:if>
//		
//		<c:if test="${field eq 'hostName'}">소유자명</c:if>
//		<c:if test="${field eq 'hostHndPhoneNo'}">소유자핸드폰</c:if>
//		<c:if test="${field eq 'hostHomeTelNo'}">소유자자택</c:if>
//		<c:if test="${field eq 'hostOfficeNo'}">소유자직장</c:if>
//		<c:if test="${field eq 'buildingAddr'}">소재지상세</c:if>
		
//		model.addAttribute("field", target);
//		model.addAttribute("resultStr", resultStr);
//		
//		return "top_suit/suit_rpt_view_pop";
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value = "readSuit", method = RequestMethod.POST)
	public void readSuit(Model model, HttpServletRequest req , MultipartRequest request
			,String actionFlagForSuit, PrintWriter out, String igId, String topTeamIdForSuit, String topMbrForSuit, HttpSession session) throws Exception { //param
		
		logger.info("readSuit");
		
		/*권한체크 :  수임등록 권한 -> 1*/
		TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) session.getAttribute("mbrAuthVo_Session");
		
		if(mbrAuthVo.getMbr_pms_1() == null || mbrAuthVo.getMbr_pms_1().equals("0") || mbrAuthVo.getMbr_pms_1().equals("")){
			
			logger.info("suimRptBscDtl - no permissions user "+session.getAttribute("user_no_Session"));
			session.invalidate();
			
			out.print(3);
		}else{
			//System.out.println(igId);
			//System.out.println(topTeamIdForSuit);
			
			/*날짜 계산*/
			Calendar cal = Calendar.getInstance();    
			cal.setTime(new Date());    
			
			//System.out.println("11111111111111");
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
			String suimDay = df.format(cal.getTime());  
			
			/*접수번호 앞자리의 연도 YY + 월 MM*/
			String suimYear = suimDay.substring(2, 4);
			String suimMonth = suimDay.substring(5, 7);
			/*접수번호 구하기*/
			String todayAcceptFront = "";
			
			if(igId.equals("17")){
				todayAcceptFront = "TJ"+suimYear+suimMonth;
			}else if(igId.equals("12")){
				todayAcceptFront = "TJ"+suimYear+suimMonth;
			}else if(igId.equals("10")){
				todayAcceptFront = "TJ"+suimYear+suimMonth;
			}else if(igId.equals("18")){
				todayAcceptFront = "TS"+suimYear+suimMonth;
			}
			
			
			FileInputStream fis = null;
			/*파일 리드 시작*/
			if(!igId.equals("18")){
				try {
					fis = new FileInputStream(multipartToFile(request.getFile("attchFileForSuit")));
					//System.out.println("55555");
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
			
			
			
			/*흥국의 제외한 적부 파일 문자열 배열 저장*/
			String tmpStr = new String();
			String strArr[] = null;
			
			if(!igId.equals("18")){
				try {
					
					int inputValue = 0;
					while ((inputValue = fis.read()) != -1) {
						
						tmpStr = tmpStr + (char) inputValue;
						
						if((char) inputValue == '\n'){
							tmpStr = tmpStr + "enterpoint";
						}
					}
					
					if(igId.equals("10") || igId.equals("17")) {
                        strArr = encodeIsoToEuc(tmpStr).split("enterpoint");
                        //insert
                        //sqlSession.insert("SuimSuitMapper.testLds",tmpStr);
                    }else if(igId.equals("1700000")){
                        strArr = encodeIsoToUTF(tmpStr).split("enterpoint");
					}else{
						strArr = tmpStr.split("enterpoint");	
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}
			/*파일 리드 끝*/
			
			
			
			/*흥국의 경우 xls 파일 리드*/
			if(igId.equals("17")){

/*
				//파일을 읽기위해 엑셀파일을 가져온다
				HSSFWorkbook workbook = null;
				try {
					workbook = new HSSFWorkbook(fis);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				
				//시트 수 (첫번째에만 존재하므로 0을 준다)
				//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				HSSFSheet sheet=workbook.getSheetAt(0);
*/
				
				//행의 수
				//int rows = sheet.getPhysicalNumberOfRows();
				int rows = strArr.length;
				
				SuimSuit_17VO tempSuit17vo = new SuimSuit_17VO();
				
				Damo damo = new Damo();
				
				
				//============================================================
                //  흥국 적부 파일이 엑셀에서 텍스트 파일로 변경되어서 텍스트파일 처리로 바꿈
                //  2016-10-20
                //============================================================
				for(int rowIdx = 0; rowIdx < rows; rowIdx++){
                    //System.out.println("ROWDATA:["+ strArr[rowIdx] + "]");
                    
                    String[] items = strArr[rowIdx].split("[|]");
                    
//                    int cols = items.length;
//                    for(int colIdx = 0; colIdx < cols; colIdx++){
//                        System.out.println("ITEMS["+colIdx+"]:["+items[colIdx]+"]");
//                    }
                    tempSuit17vo.setInfoA(items[0]);
                    tempSuit17vo.setInfoB(items[1]);
                    tempSuit17vo.setInfoC(items[2]);
                    tempSuit17vo.setInfoD(items[3]);
                    tempSuit17vo.setInfoE(items[4]);
                    tempSuit17vo.setInfoF(items[5]);
                    tempSuit17vo.setInfoG(items[6]);
                    tempSuit17vo.setInfoH(items[7]);
                    tempSuit17vo.setInfoI(items[8]);
                    tempSuit17vo.setInfoJ(items[9]);
                    tempSuit17vo.setInfoK(items[10]);
                    if("공장".equals(items[11])){
                        tempSuit17vo.setBdType("2");
                    }else{
                        tempSuit17vo.setBdType("1");
                    }
                    
                    tempSuit17vo.setInfoM(items[11]);
                    tempSuit17vo.setInfoN(items[12]);
                    tempSuit17vo.setInfoO(items[13]);
                    tempSuit17vo.setInfoP(items[14]);
                    tempSuit17vo.setPolicyholderNm(items[15]);
                    
                    if(items[16] != null && !items[16].equals("")){
                        tempSuit17vo.setPolicyholderTel1(damo.encodeDamo(items[16]));
                    }
                    if(items[17] != null && !items[17].equals("")){
                        tempSuit17vo.setPolicyholderTel2(damo.encodeDamo(items[17]));
                    }
                    if(items[18] != null && !items[18].equals("")){
                        tempSuit17vo.setPolicyholderHp(damo.encodeDamo(items[18]));
                    }
                    
                    tempSuit17vo.setInfoU(items[19]);
                    tempSuit17vo.setInfoUa(items[20]);
                    tempSuit17vo.setInfoUb(items[21]);
                    
                    
                    tempSuit17vo.setInfoV(items[22]);
                    
                    if(items[23] != null && !items[23].equals("")){
                        tempSuit17vo.setInfoW(damo.encodeDamo(items[23]));
                    }
                    
                    tempSuit17vo.setInfoX(items[24]);
                    
                    tempSuit17vo.setInfoY(items[25]);
                    
                    if(items[26] != null && !items[26].equals("")){
                        tempSuit17vo.setInfoZ(damo.encodeDamo(items[26]));
                    }
                    
                    tempSuit17vo.setInfoAa(items[27]);
                    tempSuit17vo.setInfoAb(items[28]);
                    
                    if(items[29] != null && !items[29].equals("")){
                        tempSuit17vo.setInfoAc(damo.encodeDamo(items[29]));
                    }
                    
                    tempSuit17vo.setInfoAd(items[30]);
                    tempSuit17vo.setInfoAe(items[31]);
                    tempSuit17vo.setInfoAf(items[32]);
                    
                    tempSuit17vo.setUserNo(topMbrForSuit);
                    tempSuit17vo.setTeamId(topTeamIdForSuit);
                    
                    String acceptNo ="";
                    
                    // 입력될 보고서의 접수번호 뒷자리 = 보고서 현재 '접수번호 앞자리' 로 검색되는 보고서의 총 개수 +1
                    acceptNo = sqlSession.selectOne("SuimSuitMapper.getAcceptForSuit17", todayAcceptFront);
                    //접수번호 뒷자리 만들기
                    if(acceptNo == null || acceptNo.equals("")){
                        acceptNo = "0001";
                    }else{
                        acceptNo = makeFourNumberWithZero(acceptNo);
                        //acceptNo = String.format("%04d", acceptNo);
                    }
                    
                    
                    acceptNo = makeFourNumberWithZero(acceptNo);
                    
                    tempSuit17vo.setSuimAcceptNo(todayAcceptFront+"-"+acceptNo);
                    int result = sqlSession.insert("SuimSuitMapper.insNewSuit17",tempSuit17vo);
                    
                }
				
				
/*
				for(int rowindex = 1; rowindex < rows; rowindex++){
					//행을 읽는다
					HSSFRow row=sheet.getRow(rowindex);
					String[] value= new String[35];
					if(row !=null){
						//셀의 수
						int cells=row.getPhysicalNumberOfCells();
						System.out.println("cells : " +cells);
						for(int columnindex=0; columnindex<cells; columnindex++){
							//셀값을 읽는다
							HSSFCell cell=row.getCell(columnindex);
							//셀이 빈값일경우를 위한 널체크
							if(cell==null){
								value[columnindex] = "";
							}else{
								
								//타입별로 내용 읽기
								switch (cell.getCellType()){
								case HSSFCell.CELL_TYPE_FORMULA:
									value[columnindex]=cell.getCellFormula();
									break;
								case HSSFCell.CELL_TYPE_NUMERIC:
									if(DateUtil.isCellDateFormatted(cell)){
										Date date = cell.getDateCellValue();
										value[columnindex] = new SimpleDateFormat("yyyy-MM-dd").format(date);
									}else{
										value[columnindex]=cell.getNumericCellValue()+"";		                		
									}
									
									break;
								case HSSFCell.CELL_TYPE_STRING:
									value[columnindex]=cell.getStringCellValue()+"";
									break;
								case HSSFCell.CELL_TYPE_BLANK:
									value[columnindex]=cell.getBooleanCellValue()+"";
									break;
								case HSSFCell.CELL_TYPE_ERROR:
									value[columnindex]=cell.getErrorCellValue()+"";
									break;		                    
								}
								*//*value=cell.getStringCellValue()+"";*//*
								value[columnindex] = value[columnindex].replace(".0", "");
							}
						}// for j
						
						tempSuit17vo.setInfoA(value[0]);
						tempSuit17vo.setInfoB(value[1]);
						tempSuit17vo.setInfoC(value[2]);
						tempSuit17vo.setInfoD(value[3]);
						tempSuit17vo.setInfoE(value[4]);
						tempSuit17vo.setInfoF(value[5]);
						tempSuit17vo.setInfoG(value[6]);
						tempSuit17vo.setInfoH(value[7]);
						tempSuit17vo.setInfoI(value[8]);
						tempSuit17vo.setInfoJ(value[9]);
						tempSuit17vo.setInfoK(value[10]);
						tempSuit17vo.setBdType(value[11]);
						tempSuit17vo.setInfoM(value[12]);
						tempSuit17vo.setInfoN(value[13]);
						tempSuit17vo.setInfoO(value[14]);
						tempSuit17vo.setInfoP(value[15]);
						tempSuit17vo.setPolicyholderNm(value[16]);
						
						System.out.println("A : "+tempSuit17vo.getInfoA());
						System.out.println("B : "+tempSuit17vo.getInfoB());
						System.out.println("C : "+tempSuit17vo.getInfoC());
						System.out.println("D : "+tempSuit17vo.getInfoD());
						System.out.println("E : "+tempSuit17vo.getInfoE());
						System.out.println("F : "+tempSuit17vo.getInfoF());
						System.out.println("G : "+tempSuit17vo.getInfoG());
						System.out.println("H : "+tempSuit17vo.getInfoH());
						System.out.println("I : "+tempSuit17vo.getInfoI());
						System.out.println("J : "+tempSuit17vo.getInfoJ());
						System.out.println("K : "+tempSuit17vo.getInfoK());
						
						if(value[17] != null && !value[17].equals("")){
							tempSuit17vo.setPolicyholderTel1(damo.encodeDamo(value[17]));
						}
						if(value[18] != null && !value[18].equals("")){
							tempSuit17vo.setPolicyholderTel2(damo.encodeDamo(value[18]));
						}
						if(value[19] != null && !value[19].equals("")){
							tempSuit17vo.setPolicyholderHp(damo.encodeDamo(value[19]));
						}
						
						tempSuit17vo.setInfoU(value[20]);
						tempSuit17vo.setInfoUa(value[21]);
						tempSuit17vo.setInfoUb(value[22]);
						
						
						tempSuit17vo.setInfoV(value[23]);
						
						if(value[24] != null && !value[24].equals("")){
							tempSuit17vo.setInfoW(damo.encodeDamo(value[24]));
						}
						
						tempSuit17vo.setInfoX(value[25]);
						
						tempSuit17vo.setInfoY(value[26]);
						
						if(value[27] != null && !value[27].equals("")){
							tempSuit17vo.setInfoZ(damo.encodeDamo(value[27]));
						}
						
						tempSuit17vo.setInfoAa(value[28]);
						tempSuit17vo.setInfoAb(value[29]);
						
						if(value[30] != null && !value[30].equals("")){
							tempSuit17vo.setInfoAc(damo.encodeDamo(value[30]));
						}
						
						tempSuit17vo.setInfoAd(value[31]);
						tempSuit17vo.setInfoAe(value[32]);
						tempSuit17vo.setInfoAf(value[33]);
						
						String userName = value[34];
						
						*//*해당 행의 조사자 이름으로 팀정보와 사원정보 추출하기*//*
			        	TopMbrBscVO tempMbr = new TopMbrBscVO();
						
						if(!userName.equals("")){
							tempMbr = sqlSession.selectOne("SuimSuitMapper.getMbrDtl" , userName);
							if(!tempMbr.getUser_id().equals("")){
								tempSuit17vo.setUserNo(tempMbr.getUser_no());
								tempSuit17vo.setTeamId(tempMbr.getTeam_id_main());
							}else{
								tempSuit17vo.setTeamId("27"); //인보험 본부
							}
						}
						
						String acceptNo ="";
						*//*입력될 보고서의 접수번호 뒷자리 = 보고서 현재 '접수번호 앞자리' 로 검색되는 보고서의 총 개수 +1*//*
						acceptNo = sqlSession.selectOne("SuimSuitMapper.getAcceptForSuit17", todayAcceptFront); 
						*//*접수번호 뒷자리 만들기*//*
			    		if(acceptNo == null || acceptNo.equals("")){
			    			acceptNo = "0001";
			    		}else{
			    			acceptNo = makeFourNumberWithZero(acceptNo);
			    			//acceptNo = String.format("%04d", acceptNo);			    			
			    		}
						
						
						acceptNo = makeFourNumberWithZero(acceptNo);
						
			    		tempSuit17vo.setSuimAcceptNo(todayAcceptFront+"-"+acceptNo);
			    		int result = sqlSession.insert("SuimSuitMapper.insNewSuit17",tempSuit17vo);
			    		*//*if(!(result>0)){
			    			insFailList = insFailList+","+rowindex;
			    		}*//*
					} 
				}// for i
                */
                
				out.print(1);
			}else if(igId.equals("12")){ // 한화 : .dat 파일 리드
				SuimSuit_12VO suimSuit_12Vo = new SuimSuit_12VO();
				SuimSuit_12_bldVO suimSuit_12_bldVo = new SuimSuit_12_bldVO();
				SuimSuit_12_ojVO suimSuit_12_ojVo = new SuimSuit_12_ojVO();
				
				int result12Bld = 0;
				int result12Oj = 0;
				
				Damo damo = new Damo();
				for (int i = 0; i < strArr.length; i++) {
					suimSuit_12Vo.setRqTrsOrgcd( encodeIsoToEuc(strArr[i].substring(0, 5).trim()));
					suimSuit_12Vo.setRstRcvOrgcd( encodeIsoToEuc(strArr[i].substring(5, 10).trim()) );
					suimSuit_12Vo.setRqRqFlgcd(encodeIsoToEuc(strArr[i].substring(10, 12).trim() ));
					suimSuit_12Vo.setRqDlFlgcd(encodeIsoToEuc(strArr[i].substring(12, 14).trim()));
					suimSuit_12Vo.setRqPptyRqdt(encodeIsoToEuc(strArr[i].substring(14, 22).trim()));
					suimSuit_12Vo.setRqPlno(encodeIsoToEuc(strArr[i].substring(22, 38).trim()));
					suimSuit_12Vo.setRqRequSeqno(encodeIsoToEuc(strArr[i].substring(38, 41).trim()));
					suimSuit_12Vo.setRqPlyno(encodeIsoToEuc(strArr[i].substring(41, 61).trim()));
					suimSuit_12Vo.setRqGdcd(encodeIsoToEuc(strArr[i].substring(61, 71).trim()));
					suimSuit_12Vo.setRqGdnm(encodeIsoToEuc(strArr[i].substring(71, 171).trim()));
					suimSuit_12Vo.setRqPprDhOrgcd(encodeIsoToEuc(strArr[i].substring(171, 178).trim()));
					suimSuit_12Vo.setRqPprDhOrgnm(encodeIsoToEuc(strArr[i].substring(178, 218).trim()));
					suimSuit_12Vo.setRqDhOrgcd(encodeIsoToEuc(strArr[i].substring(218, 225).trim()));
					suimSuit_12Vo.setRqDhOrgnm(encodeIsoToEuc(strArr[i].substring(225, 265).trim()));
					suimSuit_12Vo.setRqDhOrgTlno(encodeIsoToEuc(strArr[i].substring(265, 279).trim()));
					suimSuit_12Vo.setRqDhStfno(encodeIsoToEuc(strArr[i].substring(279, 286).trim()));
					suimSuit_12Vo.setRqDhStfnm(encodeIsoToEuc(strArr[i].substring(286, 306).trim()));
					suimSuit_12Vo.setRqDhStfTlno(encodeIsoToEuc(strArr[i].substring(306, 320).trim()));
					suimSuit_12Vo.setRqUdChrOrgno(encodeIsoToEuc(strArr[i].substring(320, 327).trim()));
					suimSuit_12Vo.setRqUdChrOrgnm(encodeIsoToEuc(strArr[i].substring(327, 367).trim()));
					suimSuit_12Vo.setRqUdChrOrgTlno(encodeIsoToEuc(strArr[i].substring(367, 381).trim()));
					suimSuit_12Vo.setRqUdChrOrgFxno(encodeIsoToEuc(strArr[i].substring(381, 395).trim()));
					suimSuit_12Vo.setRqUdChrStfno(encodeIsoToEuc(strArr[i].substring(395, 402).trim()));
					suimSuit_12Vo.setRqUdChrStfnm(encodeIsoToEuc(strArr[i].substring(402, 422).trim()));
					suimSuit_12Vo.setRqCrtNm(encodeIsoToEuc(strArr[i].substring(422, 442).trim()));
					suimSuit_12Vo.setRqCnrdt(encodeIsoToEuc(strArr[i].substring(442, 450).trim()));

					String damoStr = "";
					if ( strArr[i].substring(450, 464).trim() != null && !strArr[i].substring(450, 464).trim().equals("")){
						damoStr = damo.encodeDamo(encodeIsoToEuc(strArr[i].substring(450, 464).trim()));
						suimSuit_12Vo.setRqCrtHomeTlno(damoStr);
					}
					if ( strArr[i].substring(464, 478).trim() != null && !strArr[i].substring(464, 478).trim().equals("")){
						damoStr = damo.encodeDamo(encodeIsoToEuc(strArr[i].substring(464, 478).trim()));
						suimSuit_12Vo.setRqCrtWpcTlno(damoStr);
					}
					if ( strArr[i].substring(478, 492).trim() != null && !strArr[i].substring(478, 492).trim().equals("")){
						damoStr = damo.encodeDamo(encodeIsoToEuc(strArr[i].substring(478, 492).trim()));
						suimSuit_12Vo.setRqCrtHndphTlno(damoStr);
					}
					
					if ( suimSuit_12Vo.getPolicyholderHp() != null && !suimSuit_12Vo.getPolicyholderHp().trim().equals("")){
						damoStr = damo.encodeDamo(suimSuit_12Vo.getPolicyholderHp());
						suimSuit_12Vo.setPolicyholderHp(damoStr);
					}
					
					suimSuit_12Vo.setRqBldCt(encodeIsoToEuc(strArr[i].substring(492, 494).trim()));
					suimSuit_12Vo.setRqOjCt(encodeIsoToEuc(strArr[i].substring(494, 496).trim()));
	
//						/*top_suitability_12 입력*/
//						String acceptNo = sqlSession.selectOne("SuimSuitMapper.getAcceptForSuit12", todayAcceptFront);
//			    		if(acceptNo == null || acceptNo.equals("")){
//			    			acceptNo = "0001";
//			    		}else{
//			    			acceptNo = makeFourNumberWithZero(acceptNo);
//			    			//acceptNo = String.format("%04d", acceptNo);			    			
//			    		}
					
					String acceptNo = "";
					
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("suim_accept_seq_no", "");
					/*입력될 보고서의 접수번호 뒷자리 = 보고서 현재 '접수번호 앞자리' 로 검색되는 보고서의 총 개수 +1*/  
					sqlSession.update("SuimRegInsMapper.getSuit12AcceptSeqNo", map);
					String suit12Accept = map.get("suim_accept_seq_no");
					acceptNo = makeFourNumberWithZero(suit12Accept);
					/*** 신 종결 번호 ***/
					
		    		suimSuit_12Vo.setUserNo(topMbrForSuit);
		    		suimSuit_12Vo.setTeamId(topTeamIdForSuit);
		    		
		    		suimSuit_12Vo.setSuimAcceptNo(todayAcceptFront+"-"+acceptNo);
		    		
		    		//설계자 핸드폰 정보 추가 (파일의 맨끝에서 읽어온다.) by top3009  시작
		    		//길이를 체크한다. 
		    		int nLength = strArr[i].length();
		    		
		    		//줄의 맨끝에 14자리 핸드폰 번호가 추가된 경우만 처리한다.		    		
		    		if( nLength == 6395) {		    			
		    			if ( strArr[i].substring(6380, 6395).trim() != null && !strArr[i].substring(6380, 6395).trim().equals("")){
							damoStr = damo.encodeDamo(encodeIsoToEuc(strArr[i].substring(6380, 6395).trim()));
							suimSuit_12Vo.setPrHndphTlno(damoStr);
						}else{				//길이는 맞으나 데이터 정보가 없는 경우 by top3009 (20230602)							
							suimSuit_12Vo.setPrHndphTlno("");
						}
		    		}else{		    			
		    			suimSuit_12Vo.setPrHndphTlno("");
		    		}		    		
		    		//설계자 핸드폰 정보 추가 (파일의 맨끝에서 읽어온다.) by top3009  끝		    		
		    		
					sqlSession.insert("SuimSuitMapper.insNewSuit12", suimSuit_12Vo);
					
					/*top_suitability_12_bld 입력*/
					suimSuit_12_bldVo.setSuimRptNo(suimSuit_12Vo.getId());
					suimSuit_12_ojVo.setSuimRptNo(suimSuit_12Vo.getId());
					
					int tmpNum = 0;
					int bldIndex = 496;
					
					for (int k = 0; k < 2; k++) {
						if(encodeIsoToEuc( strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+8).trim()).equals("0") || encodeIsoToEuc( strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+8).trim()).equals("")){
							continue;
						}
						suimSuit_12_bldVo.setRqBld_Lctno( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+8).trim() ));
						tmpNum += 8;
						suimSuit_12_bldVo.setRqBld_OjSeqno(encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+5).trim()));
						tmpNum += 5;
						suimSuit_12_bldVo.setRqBld_BldSeqno(encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+5).trim()));
						tmpNum += 5;
						suimSuit_12_bldVo.setRqBld_RlOwrNm( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+20).trim()));
						tmpNum += 20;
						suimSuit_12_bldVo.setRqBld_CtnAdr( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+200).trim()));
						tmpNum += 200;
						suimSuit_12_bldVo.setRqBld_MngmBnnm( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+100).trim()));
						tmpNum += 100;
						suimSuit_12_bldVo.setRqBld_BldRnkcd( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+1).trim()));
						tmpNum += 1;
						suimSuit_12_bldVo.setRqBld_Plenm(encodeIsoToEuc( strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+50).trim()));
						tmpNum += 50;
						suimSuit_12_bldVo.setRqBld_Rofnm( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+50).trim()));
						tmpNum += 50;
						suimSuit_12_bldVo.setRqBld_Wllnm(encodeIsoToEuc( strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+50).trim()));
						tmpNum += 50;
						suimSuit_12_bldVo.setRqBld_Grod(encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+3).trim()));
						tmpNum += 3;
						suimSuit_12_bldVo.setRqBld_Undg(encodeIsoToEuc( strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+3).trim()));
						tmpNum += 3;
						suimSuit_12_bldVo.setRqBld_Ttare( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+20).trim()));
						tmpNum += 20;
						suimSuit_12_bldVo.setRqBld_IsAre( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+20).trim()));
						tmpNum += 20;
						suimSuit_12_bldVo.setRqBld_IsTp(encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+2).trim()));
						tmpNum += 2;
						suimSuit_12_bldVo.setRqBld_BldXpnm( encodeIsoToEuc(strArr[i].substring(bldIndex+tmpNum, bldIndex+tmpNum+200).trim()));
						tmpNum += 200;
						
						result12Bld = sqlSession.insert("SuimSuitMapper.insNewSuit12Bld", suimSuit_12_bldVo);
					}
					
					tmpNum = 1970;
					int tmpNum2 = 0;
					
					for (int k = 0; k < 10; k++) {
						if(encodeIsoToEuc( strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+5).trim()).equals("0") ){
							continue;
						}
						suimSuit_12_ojVo.setRqOjOjSeqno( encodeIsoToEuc( strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+5).trim()) );
						tmpNum2 += 5;
						suimSuit_12_ojVo.setRqOjBldSeqno( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+5).trim()) );
						tmpNum2 += 5;
						suimSuit_12_ojVo.setRqOjOjSign( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+5).trim() ));
						tmpNum2 += 5;
						suimSuit_12_ojVo.setRqOjOjTp( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+20).trim() ));
						tmpNum2 += 20;
						suimSuit_12_ojVo.setRqOjRnk( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+1).trim() ));
						tmpNum2 += 1;
						suimSuit_12_ojVo.setRqOjDtMtt( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+200).trim()) );
						tmpNum2 += 200;
						suimSuit_12_ojVo.setRqOjDtAccptPlc( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+200).trim()) );
						tmpNum2 += 200;
						suimSuit_12_ojVo.setRqOjAccptPlcFlgcd( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+2).trim()) );
						tmpNum2 += 2;
						suimSuit_12_ojVo.setRqOjFldstObjFlgcd( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+2).trim()) );
						tmpNum2 += 2;
						suimSuit_12_ojVo.setRqOjUndgAccptYn( encodeIsoToEuc(strArr[i].substring(tmpNum+tmpNum2, tmpNum+tmpNum2+1).trim()) );
						tmpNum2 += 1;
						
						result12Oj = sqlSession.insert("SuimSuitMapper.insNewSuit12Oj", suimSuit_12_ojVo);
						
					}
					
				}
				
				if(result12Bld>0 && result12Oj>0){
					out.print(1);
				}else{
					out.print(0);
				}
			/************** end 한화 *************/
			}else if(igId.equals("10")){ // KB(구 lig) : .txt 파일 리드                     
				
				SuimSuit_10VO suimSuit_10Vo = new SuimSuit_10VO();
				
	    		suimSuit_10Vo.setUserNo(topMbrForSuit);
	    		suimSuit_10Vo.setTeamId(topTeamIdForSuit);
	    		//System.out.println("topMbrForSuit : "  +suimSuit_10Vo.getUserNo());
	    		//System.out.println("topTeamIdForSuit : "  +suimSuit_10Vo.getTeamId());
	    		int result10 =0;
	    		
	    		for (int j = 0; j < strArr.length; j++) {
	    			
	    			/*top_suitability_10 입력*/
					
					String acceptNo = sqlSession.selectOne("SuimSuitMapper.getAcceptForSuit10", todayAcceptFront);
		    		if(acceptNo == null || acceptNo.equals("")){
		    			acceptNo = "0001";
		    		}else{
		    			acceptNo = makeFourNumberWithZero(acceptNo);
		    			//acceptNo = String.format("%04d", acceptNo);			    			
		    		}
		    		
		    		suimSuit_10Vo.setSuimAcceptNo(todayAcceptFront+"-"+acceptNo);
	    			
		    		//System.out.println("suimSuit_10Vo.getSuimAcceptNo() : "+suimSuit_10Vo.getSuimAcceptNo());
	    			String[] tmpArr = strArr[j].split(";");
	    			
	    			//tmpArr[0].trim()
	    			suimSuit_10Vo.setJuckbuNo(tmpArr[0].trim());
	    			suimSuit_10Vo.setRegDate(tmpArr[1].trim());
	    			suimSuit_10Vo.setSendDate(tmpArr[1].trim());
	    			suimSuit_10Vo.setIvstComName(tmpArr[2].trim());
	    			suimSuit_10Vo.setBdType(tmpArr[3].trim());
	    			suimSuit_10Vo.setPlcyNo(tmpArr[4].trim());
	    			suimSuit_10Vo.setEntyDsgnNo(tmpArr[5].trim());
	    			suimSuit_10Vo.setPkgName(tmpArr[6].trim());
	    			suimSuit_10Vo.setAgrmDate(tmpArr[7].trim());
	    			suimSuit_10Vo.setContractorName(tmpArr[8].trim());
	    			suimSuit_10Vo.setConHndPhoneNo(tmpArr[9].trim());
	    			suimSuit_10Vo.setConHomeTelNo(tmpArr[10].trim());
	    			suimSuit_10Vo.setConOfficeNo(tmpArr[11].trim());
	    			suimSuit_10Vo.setHostName(tmpArr[12].trim());
	    			suimSuit_10Vo.setHostHndPhoneNo(tmpArr[13].trim());
	    			suimSuit_10Vo.setHostHomeTelNo(tmpArr[14].trim());
	    			suimSuit_10Vo.setHostOfficeNo(tmpArr[15].trim());
	    			suimSuit_10Vo.setHostContractor(tmpArr[16].trim());
	    			suimSuit_10Vo.setBuildingZipcode(tmpArr[17].trim());
	    			suimSuit_10Vo.setBuildingAddr(tmpArr[18].trim());
	    			
	    			suimSuit_10Vo.setBuildinginfo01(tmpArr[19].trim());
	    			suimSuit_10Vo.setBuildinginfo02(tmpArr[20].trim());
	    			suimSuit_10Vo.setBuildinginfo03(tmpArr[21].trim());
	    			suimSuit_10Vo.setBuildingMemo(tmpArr[22].trim());
	    			suimSuit_10Vo.setClerkName(tmpArr[23].trim());
	    			suimSuit_10Vo.setClerkSectName(tmpArr[24].trim());
	    			suimSuit_10Vo.setClerkDeptName(tmpArr[25].trim());
	    			suimSuit_10Vo.setClerkName2(tmpArr[26].trim());
	    			suimSuit_10Vo.setClerkHndPhoneNo(tmpArr[27].trim());
	    			suimSuit_10Vo.setClerkOfcTelNo(tmpArr[28].trim());
	    			
//	    			System.out.println("0getJuckbuNo : "+suimSuit_10Vo.getJuckbuNo());
//	    			System.out.println("1getRegDate : "+suimSuit_10Vo.getRegDate());
//	    			System.out.println("1getSendDate : "+suimSuit_10Vo.getSendDate());
//	    			System.out.println("2getIvstComName : "+suimSuit_10Vo.getIvstComName());
//	    			System.out.println("3getBdType : "+suimSuit_10Vo.getBdType());
//	    			System.out.println("4getPlcyNo : "+suimSuit_10Vo.getPlcyNo());
//	    			System.out.println("5getEntyDsgnNo : "+suimSuit_10Vo.getEntyDsgnNo());
//	    			System.out.println("6getPkgName : "+suimSuit_10Vo.getPkgName());
//	    			System.out.println("7getAgrmDate : "+suimSuit_10Vo.getAgrmDate());
//	    			System.out.println("8getContractorName : "+suimSuit_10Vo.getContractorName());
//	    			
//	    			System.out.println("9getConHndPhoneNo : "+suimSuit_10Vo.getConHndPhoneNo());
//	    			System.out.println("10getConHomeTelNo : "+suimSuit_10Vo.getConHomeTelNo());
//	    			System.out.println("11getConOfficeNo : "+suimSuit_10Vo.getConOfficeNo());
//	    			System.out.println("12getHostName : "+suimSuit_10Vo.getHostName());
//	    			System.out.println("13getHostHndPhoneNo : "+suimSuit_10Vo.getHostHndPhoneNo());
//	    			System.out.println("14getHostHomeTelNo : "+suimSuit_10Vo.getHostHomeTelNo());
//	    			System.out.println("15getHostOfficeNo : "+suimSuit_10Vo.getHostOfficeNo());
//	    			System.out.println("16getHostContractor : "+suimSuit_10Vo.getHostContractor());
//	    			System.out.println("17getBuildingZipcode : "+suimSuit_10Vo.getBuildingZipcode());
//	    			System.out.println("18getBuildingAddr : "+suimSuit_10Vo.getBuildingAddr());
//	    			
//	    			System.out.println("19getBuildinginfo01 : "+suimSuit_10Vo.getBuildinginfo01());
//	    			System.out.println("20getBuildinginfo02 : "+suimSuit_10Vo.getBuildinginfo02());
//	    			System.out.println("21getBuildinginfo03 : "+suimSuit_10Vo.getBuildinginfo03());
//	    			System.out.println("22getBuildingMemo : "+suimSuit_10Vo.getBuildingMemo());
//	    			System.out.println("23getClerkName : "+suimSuit_10Vo.getClerkName());
//	    			System.out.println("24getClerkSectName : "+suimSuit_10Vo.getClerkSectName());
//	    			System.out.println("25getClerkDeptName : "+suimSuit_10Vo.getClerkDeptName());
//	    			System.out.println("26getClerkName2 : "+suimSuit_10Vo.getClerkName2());
//	    			System.out.println("27getClerkHndPhoneNo : "+suimSuit_10Vo.getClerkHndPhoneNo());
//	    			System.out.println("28getClerkOfcTelNo : "+suimSuit_10Vo.getClerkOfcTelNo());
	    			
	    				
	    			result10 = sqlSession.insert("SuimSuitMapper.insNewSuit10", suimSuit_10Vo);
	    			System.out.println(result10);
				}
	    		
				out.print(result10);
				
			}else if(igId.equals("18")){

				String[] fileNameList = FtpControll.getSSFileInfo();
				
				Scanner s = null;
				int result18 =0;
				for (int j = 0; j < fileNameList.length; j++) {
				
					try {
						s = new Scanner(new File(FtpControll.LOCAL_DIR+"/"+fileNameList[j]),"EUC-KR");
					} catch (FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					while(s.hasNext()){
						SuimSuit_18VO suimSuit_18Vo = new SuimSuit_18VO();
						
						suimSuit_18Vo.setUserNo(topMbrForSuit);
						suimSuit_18Vo.setTeamId(topTeamIdForSuit);
						
						tmpStr = s.nextLine().replaceAll("&amp;et", "").replaceAll("&amp;#039;", "");
						System.out.println( "["+tmpStr+"]" );
						String[] thisStrSplit = tmpStr.split(";");
						
						suimSuit_18Vo.setRegDate(thisStrSplit[1].trim());
						suimSuit_18Vo.setPolicyholderNm(thisStrSplit[7].trim());
						suimSuit_18Vo.setPolicyholderHp(thisStrSplit[8].trim());
						suimSuit_18Vo.setMedType(thisStrSplit[0].trim());
						suimSuit_18Vo.setSendDate(thisStrSplit[1].trim());
						suimSuit_18Vo.setIvstComName(thisStrSplit[2].trim());
						suimSuit_18Vo.setPlcyNo(thisStrSplit[3].trim());
						suimSuit_18Vo.setEntyDsgnNo(thisStrSplit[4].trim());
						suimSuit_18Vo.setPkgName(thisStrSplit[5].trim());
						suimSuit_18Vo.setAgrmDate(thisStrSplit[6].trim());
						suimSuit_18Vo.setContractorName(thisStrSplit[7].trim());
						suimSuit_18Vo.setConHndPhoneNo(thisStrSplit[8].trim());
						suimSuit_18Vo.setConHomeTelNo(thisStrSplit[9].trim());
						suimSuit_18Vo.setBd1A(thisStrSplit[10].trim());
						suimSuit_18Vo.setBd1B(thisStrSplit[11].trim());
						suimSuit_18Vo.setBd1C(thisStrSplit[12].trim());
						suimSuit_18Vo.setBd1D(thisStrSplit[13].trim());
						suimSuit_18Vo.setBd1E(thisStrSplit[14].trim());
						suimSuit_18Vo.setBd1F(thisStrSplit[15].trim());
						suimSuit_18Vo.setBd1G(thisStrSplit[16].trim());
						suimSuit_18Vo.setBd1H(thisStrSplit[17].trim());
						suimSuit_18Vo.setBd2A(thisStrSplit[18].trim());
						suimSuit_18Vo.setBd2B(thisStrSplit[19].trim());
						suimSuit_18Vo.setBd2C(thisStrSplit[20].trim());
						suimSuit_18Vo.setBd2D(thisStrSplit[21].trim());
						suimSuit_18Vo.setBd2E(thisStrSplit[22].trim());
						suimSuit_18Vo.setBd2F(thisStrSplit[23].trim());
						suimSuit_18Vo.setBd2G(thisStrSplit[24].trim());
						suimSuit_18Vo.setBd2H(thisStrSplit[25].trim());
						suimSuit_18Vo.setBd3A(thisStrSplit[26].trim());
						suimSuit_18Vo.setBd3B(thisStrSplit[27].trim());
						suimSuit_18Vo.setBd3C(thisStrSplit[28].trim());
						suimSuit_18Vo.setBd3D(thisStrSplit[29].trim());
						suimSuit_18Vo.setBd3E(thisStrSplit[30].trim());
						suimSuit_18Vo.setBd3F(thisStrSplit[31].trim());
						suimSuit_18Vo.setBd3G(thisStrSplit[32].trim());
						suimSuit_18Vo.setBd3H(thisStrSplit[33].trim());
						suimSuit_18Vo.setBdType(thisStrSplit[34].trim());
						suimSuit_18Vo.setBdItem(thisStrSplit[35].trim());
						suimSuit_18Vo.setMemo1(thisStrSplit[36].trim());
						suimSuit_18Vo.setMemo2(thisStrSplit[37].trim());
						suimSuit_18Vo.setClerkName(thisStrSplit[38].trim());
						suimSuit_18Vo.setClerkDeptName(thisStrSplit[39].trim());
						suimSuit_18Vo.setClerkSectName(thisStrSplit[40].trim());
						suimSuit_18Vo.setClerkOfcTelNo(thisStrSplit[41].trim());
						suimSuit_18Vo.setClerkHndPhoneNo(thisStrSplit[42].trim());
						suimSuit_18Vo.setRqName(fileNameList[j]);
						suimSuit_18Vo.setRqDate(fileNameList[j].substring(9, 17));
						
						
						Damo damo = new Damo();
						if (suimSuit_18Vo.getPolicyholderHp() != null && !suimSuit_18Vo.getPolicyholderHp().equals("")){
							suimSuit_18Vo.setPolicyholderHp(damo.encodeDamo(suimSuit_18Vo.getPolicyholderHp()));
						}
						
						if (suimSuit_18Vo.getConHndPhoneNo() != null && !suimSuit_18Vo.getConHndPhoneNo().equals("")){
							suimSuit_18Vo.setConHndPhoneNo(damo.encodeDamo(suimSuit_18Vo.getConHndPhoneNo()));
						}
						
						if (suimSuit_18Vo.getConHomeTelNo() != null && !suimSuit_18Vo.getConHomeTelNo().equals("")){
							suimSuit_18Vo.setConHomeTelNo(damo.encodeDamo(suimSuit_18Vo.getConHomeTelNo()));
						}
						
						if (suimSuit_18Vo.getBd1B() != null && !suimSuit_18Vo.getBd1B().equals("")){
							suimSuit_18Vo.setBd1B(damo.encodeDamo(suimSuit_18Vo.getBd1B()));
						}
						
						if (suimSuit_18Vo.getBd1D() != null && !suimSuit_18Vo.getBd1D().equals("")){
							suimSuit_18Vo.setBd1D(damo.encodeDamo(suimSuit_18Vo.getBd1D()));
						}
						
						if (suimSuit_18Vo.getBd2B() != null && !suimSuit_18Vo.getBd2B().equals("")){
							suimSuit_18Vo.setBd2B(damo.encodeDamo(suimSuit_18Vo.getBd2B()));
						}
						
						if (suimSuit_18Vo.getBd2D() != null && !suimSuit_18Vo.getBd2D().equals("")){
							suimSuit_18Vo.setBd2D(damo.encodeDamo(suimSuit_18Vo.getBd2D()));
						}
						
						if (suimSuit_18Vo.getBd3B() != null && !suimSuit_18Vo.getBd3B().equals("")){
							suimSuit_18Vo.setBd3B(damo.encodeDamo(suimSuit_18Vo.getBd3B()));
						}
						
						if (suimSuit_18Vo.getBd3D() != null && !suimSuit_18Vo.getBd3D().equals("")){
							suimSuit_18Vo.setBd3D(damo.encodeDamo(suimSuit_18Vo.getBd3D()));
						}
						
						if (suimSuit_18Vo.getClerkOfcTelNo() != null && !suimSuit_18Vo.getClerkOfcTelNo().equals("")){
							suimSuit_18Vo.setClerkOfcTelNo(damo.encodeDamo(suimSuit_18Vo.getClerkOfcTelNo()));
						}
						
						if (suimSuit_18Vo.getClerkHndPhoneNo() != null && !suimSuit_18Vo.getClerkHndPhoneNo().equals("")){
							suimSuit_18Vo.setClerkHndPhoneNo(damo.encodeDamo(suimSuit_18Vo.getClerkHndPhoneNo()));
						}
						
						
						/*top_contract 입력*/
						String acceptNo = sqlSession.selectOne("SuimSuitMapper.getAcceptForSuit18", todayAcceptFront);
						if(acceptNo == null || acceptNo.equals("")){
							acceptNo = "0001";
						}else{
							acceptNo = makeFourNumberWithZero(acceptNo);
							//acceptNo = String.format("%04d", acceptNo);			    			
						}
						
						suimSuit_18Vo.setSuimAcceptNo(todayAcceptFront+"-"+acceptNo);
						result18 = sqlSession.insert("SuimSuitMapper.insNewSuit18", suimSuit_18Vo);
					}
					
					s.close();
				} // end for j
				
				/*임시 파일 삭제*/
				if(fileNameList.length > 0){
					//파일 삭제 시작
					for (int i = 0; i < fileNameList.length; i++) {							
						
						String filePath = "D://get/"+fileNameList[i];

						File tmpFile = new File(filePath);
						tmpFile.delete();
						
					}
					//파일 삭제 종료
				}

				out.print(result18);
				}
			//
			out.close();
		}
	}


	public String makeFourNumberWithZero(String maxSuimNo) {
		if(maxSuimNo.length() == 1){
			maxSuimNo = "000"+maxSuimNo;
		}else if(maxSuimNo.length() == 2){
			maxSuimNo = "00"+maxSuimNo;
		}else if(maxSuimNo.length() == 3){
			maxSuimNo = "0"+maxSuimNo;
		}
		return maxSuimNo;
	}

}
