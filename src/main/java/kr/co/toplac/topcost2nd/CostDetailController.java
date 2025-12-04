package kr.co.toplac.topcost2nd;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.toplac.cmm.service.CodeDicService;
import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import kr.co.toplac.topindividual.TopMyCostInsCompositeVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.CommonUtils;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;

@Controller
public class CostDetailController {

	private static final Logger logger = LoggerFactory.getLogger(CostDetailController.class);

	@Autowired
	private SqlSession sqlSession;
	
    @Autowired
    private CodeDicService service;
	
	
	@RequestMapping(value = "cost_detail")
	public String new_cost_detail(Model model, HttpSession session, HttpServletRequest request) {

		logger.info("======= cost_detail =======");
		
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        //TopMbrAuthVO mbrAuthVo = (TopMbrAuthVO) SessionUtil.getAuthorities();
        
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 현재 일자 세팅
        //===============================================
        String stdBgnde = StringUtil.null2blank(request.getParameter("stdBgnde"));  //기준일자 시작일
        String stdEndde = StringUtil.null2blank(request.getParameter("stdEndde"));  //기준일자 종료일
        
        if ("".equals(stdBgnde)){
            stdBgnde = DateUtil.getStartMonthDay();
            stdEndde = DateUtil.getEndMonthDay();

            stdBgnde = DateUtil.getDateFormat(stdBgnde,"-");
            stdEndde = DateUtil.getDateFormat(stdEndde,"-");

            paramMap.put("stdBgnde",stdBgnde);
            paramMap.put("stdEndde",stdEndde);
        }

        //===============================================
        // 필요 날짜 SET
        //===============================================
        String bgnDe = stdBgnde.replace("-","");
        String endDe = DateUtil.addDate(stdEndde.replace("-",""),1);
        String yearMonth = endDe.substring(2,6);
        String bgnYearDe = (Integer.parseInt(endDe.substring(0,4)) - 1)  + "1216";
        String endYearDe = endDe.substring(0,4) + "1216";

        paramMap.put("bgnDe", bgnDe);
        paramMap.put("endDe", endDe);
        paramMap.put("bgnYearDe", bgnYearDe);
        paramMap.put("endYearDe", endYearDe);
        paramMap.put("yearMonth", yearMonth);
        
        //===============================================
        //	직원 정보
        //===============================================	       
        String userNo = StringUtil.null2blank(request.getParameter("user_no"));
        
        Map<String,String> userMap = new HashMap<String,String>();
        if ("".equals(userNo)){
        	userMap.put("user_no", mbrVo.getUser_no());
        	userMap.put("user_name", mbrVo.getUser_name());
        	userMap.put("team_id", mbrVo.getTeam_id_main());
        	userMap.put("team_name", mbrVo.getTeam_name());
        	userMap.put("team_type", mbrVo.getTeam_type());
        	
        	paramMap.put("user_no",mbrVo.getUser_no());
        }else{
        	userMap = sqlSession.selectOne("CostDetailMapper.selectCostDetailMember",userNo);
        }
        
        //===============================================
        //	화면 파라미터 체크 및 초기화
        //===============================================      
        String costClassNo = StringUtil.null2blank(request.getParameter("cost_class_no"));
        String costKind = StringUtil.null2blank(request.getParameter("cost_kind"));
        
        if ("".equals(costClassNo)){
        	paramMap.put("cost_class_no",0);
        }
        
        if ("".equals(costKind)){
        	paramMap.put("cost_kind",1);
        	costKind = "1";
        }
        
        
        //===============================================
        //	계정명 코드
        //===============================================		
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_cost_item_2nd");
        codeVo.setCol_nm("cost_class_no");
        codeVo.setCol_cd1(costKind);
        List<SysAdmCodeDicVO> costClassNoList = service.codeList3(codeVo);
        model.addAttribute("costClassNoList",costClassNoList);
        
        
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================   		
        model.addAttribute("srchArg", paramMap);
        model.addAttribute("userInfo", userMap);         
        
		
		return "top_cost_2nd/cost_detail_main";
	}

	
	@RequestMapping(value = "cost_detail_contents")
	public String cost_detail_contents(Model model, HttpSession session, HttpServletRequest request) {
		logger.info("======= cost_detail_contents =======");
		
        //=======================================================================
        //	파라미터 체크
        //=======================================================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        //=======================================================================
        //	경비내역 (param : user_no, viewFromDate, viewToDate, cost_class_no)
        //=======================================================================
        List<Map<String,Object>> costDetailContents = sqlSession.selectList("CostDetailMapper.selectCostDetailContents", paramMap);
        HashMap<String,Object> costDeposit = sqlSession.selectOne("CostDetailMapper.selectCostDeposit",paramMap);
        model.addAttribute("costDetailContents", costDetailContents);
        model.addAttribute("costDeposit", costDeposit);
        
        //=======================================================================
        //	4종 협조건 (param : user_no, bgnDe, endDe)
        //=======================================================================  
        if ("4".equals(paramMap.get("team_type"))){
        	List<Map<String,Object>> rptHelpClientList = sqlSession.selectList("CostDetailMapper.selectRptHelpClinetList", paramMap);
        	List<Map<String,Object>> rptHelpAcceptList = sqlSession.selectList("CostDetailMapper.selectRptHelpAcceptList", paramMap);
        	model.addAttribute("rptHelpClientList",rptHelpClientList);
        	model.addAttribute("rptHelpAcceptList",rptHelpAcceptList);
        }
        
        
        //===============================================
        //	계정명 코드
        //===============================================		
        String costKind = String.valueOf( paramMap.get("cost_kind") );
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_cost_item_2nd");
        codeVo.setCol_nm("cost_class_no");
        codeVo.setCol_cd1(costKind);
        List<SysAdmCodeDicVO> costClassNoList = service.codeList3(codeVo);
        model.addAttribute("costClassNoList",costClassNoList);
        
        model.addAttribute("costKind", costKind);
        model.addAttribute("srchArg",paramMap);
        
        if ("3".equals(costKind)){
        	return "top_cost_2nd/cost_detail_contents_claim";
        }else{
        	return "top_cost_2nd/cost_detail_contents";
        }
        
	}

	@RequestMapping(value = "valid_cost_item", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> valid_cost_item(Model model, HttpSession session, String action,  HttpServletResponse response, HttpServletRequest request) {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		Map<String,Object> retMap = new HashMap<String,Object>();
		retMap.put("result_code", "0000");
		
		String paramCostKind = String.valueOf(paramMap.get("cost_kind"));
		
		//추가 청구시, 추가청구 발생월이 입금완료가 되어야만 추가청구가 됨. 김두현차장님 요청
		String cost_kind = request.getParameter("cost_kind");
		
		Map<String,Object> addValidMap =  sqlSession.selectOne("CostDetailMapper.selectCostAddValid",paramMap);
		if (addValidMap == null && "2".equals(cost_kind) && "C".equals(action)){
			String msg = "추가청구 요청한 발생일의 해당 월에 입금내역이 없습니다.\n해당 건은 해당월 일반경비내역에 청구 하시기 바랍니다.";
			
			retMap.put("result_code", "0001");
			retMap.put("result_msg", msg);			
			
		}
		
		
		List<HashMap<String,Object>> validList = sqlSession.selectList("CostDetailMapper.selectCostItemValid",paramMap);
		for(Map<String,Object> validMap : validList){
			
			String validCostKind = String.valueOf(validMap.get("costKind"));
			
//			if ( !validCostKind.equals(paramCostKind) ){
//				continue;
//			}
			
			if ( "0".equals(validMap.get("costItemStateCnt")) ){
				break;
			}
			
			int costKind = (int) (validMap.get("costKind"));
			String year = String.valueOf(paramMap.get("cost_year_month")).substring(0,2);
			String month = String.valueOf(paramMap.get("cost_year_month")).substring(2,4);
			String msg = year+"년 "+month+"월 ";  
			
			if (costKind == 1){
				msg += "경비 내역에 이미 결재된 내역이 존재합니다.";
			}else if (costKind == 2){
				msg += "추가 경비내역에 이미 결재된 내역이 존재합니다.";
			}else{
				msg += "클레임 경비 내역에 이미 결재된 내역이 존재합니다.";
			}
			
			retMap.put("result_code", "0001");
			retMap.put("result_msg", msg);
			
			break;
		}
		
		return retMap;
	}
	
	
	@RequestMapping(value = "action_cost_item", method = RequestMethod.POST)
	public String action_cost_item(Model model, HttpSession session, HttpServletResponse response, String action, HttpServletRequest request) {
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		String costKind = StringUtil.null2blank(request.getParameter("cost_kind"));
		String costPayPlace = StringUtil.null2blank(request.getParameter("cost_pay_place"));
		String costInvolvedCom = StringUtil.null2blank(request.getParameter("cost_involved_com"));
		String costInvolvedMan = StringUtil.null2blank(request.getParameter("cost_involved_man"));
		String costMemo = StringUtil.null2blank(request.getParameter("cost_memo"));
		
		
		if ("".equals(costPayPlace)){
			paramMap.put("cost_pay_place","-");
		}
		if ("".equals(costInvolvedCom)){
			paramMap.put("cost_involved_com","-");
		}
		if ("".equals(costInvolvedMan)){
			paramMap.put("cost_involved_man","-");
		}
		if ("".equals(costMemo)){
			paramMap.put("cost_memo","-");
		}

		
		if ("C".equals(action)){
			sqlSession.insert("CostDetailMapper.insertCostItem",paramMap);
		}else if("D".equals(action)){
			sqlSession.delete("CostDetailMapper.deleteCostItem",paramMap);
		}else if("U".equals(action)){
			sqlSession.delete("CostDetailMapper.updateCostItem",paramMap);
		}
		
        //===============================================
        //	top_cost_deposit_2nd 
        //===============================================
		int cost_pay_amt_sum = sqlSession.selectOne("CostDetailMapper.selectCostItemSum",paramMap);
		paramMap.put("cost_deposit_basic_amt", 0);
		paramMap.put("cost_deposit_add_amt", 0);
		paramMap.put("cost_deposit_claim_amt", 0);
		
		//user_no, cost_year_month를 이용하여 deposit확인 
		HashMap<String,Object> depositMap = sqlSession.selectOne("CostDetailMapper.selectCostDeposit",paramMap);
		if(depositMap == null){
			if ("1".equals(costKind)){
				paramMap.put("cost_deposit_basic_amt", cost_pay_amt_sum);
			}else if ("2".equals(costKind)){
				paramMap.put("cost_deposit_add_amt", cost_pay_amt_sum);
			}else if ("3".equals(costKind)){
				paramMap.put("cost_deposit_claim_amt", cost_pay_amt_sum);
			}
			sqlSession.insert("CostDetailMapper.insertCostDeposit",paramMap);
		}else{
			if ("1".equals(costKind)){
				paramMap.put("cost_deposit_basic_amt", cost_pay_amt_sum);
				paramMap.put("cost_deposit_add_amt", depositMap.get("cost_deposit_add_amt"));
				paramMap.put("cost_deposit_claim_amt", depositMap.get("cost_deposit_claim_amt"));
			}else if ("2".equals(costKind)){
				paramMap.put("cost_deposit_basic_amt", depositMap.get("cost_deposit_basic_amt"));
				paramMap.put("cost_deposit_add_amt", cost_pay_amt_sum);
				paramMap.put("cost_deposit_claim_amt", depositMap.get("cost_deposit_claim_amt"));
			}else if ("3".equals(costKind)){
				paramMap.put("cost_deposit_basic_amt", depositMap.get("cost_deposit_basic_amt"));
				paramMap.put("cost_deposit_add_amt", depositMap.get("cost_deposit_add_amt"));
				paramMap.put("cost_deposit_claim_amt", cost_pay_amt_sum);
			}
			
			sqlSession.update("CostDetailMapper.updateCostDeposit",paramMap);
		}
		
		String queryString = "?user_no="+paramMap.get("user_no");
		queryString += "&cost_kind="+paramMap.get("cost_kind");
		queryString += "&cost_year_month="+paramMap.get("cost_year_month");
		queryString += "&bgnDe="+paramMap.get("bgnDe");
		queryString += "&endDe="+paramMap.get("endDe");
		
		
		if ("D".equals(action)){
			queryString += "&cost_class_no="+paramMap.get("cost_class_no");
		}
		
		String retURL = "redirect:/cost_detail_contents"+queryString;
		
		return retURL;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "aprv_cost_item_all", method = RequestMethod.POST)
	public Map<String, Object> aprv_cost_item_all(Model model, HttpSession session, HttpServletResponse response, String action, HttpServletRequest request) {
		
		Map<String, Object> resultMap = new HashMap<String,Object>();
		
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();	
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        //===============================================
        //	top_cost_item_2nd 팀장결재 및 결재취소
        //===============================================
        paramMap.put("cost_aprv_user_no", mbrVo.getUser_no());
        
        //승인금액 업데이트 추가
        sqlSession.update("CostDetailMapper.updateAprvCostTotalAmt",paramMap);
        
		sqlSession.update("CostDetailMapper.updateAprvCostItem",paramMap);		
		sqlSession.update("CostDetailMapper.updateArpvCostDeposit1st",paramMap);
		sqlSession.insert("CostDetailMapper.insertCostDepositLog",paramMap);
		
		resultMap.put("result", "success");
		
		return resultMap;
		
	}	
	
	@RequestMapping(value = "aprv_cost_item", method = RequestMethod.POST)
	public String aprv_cost_item(Model model, HttpSession session, HttpServletResponse response, String action, HttpServletRequest request) {
		
        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();	
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
        //===============================================
        //	top_cost_item_2nd 팀장결재 및 결재취소
        //===============================================
        paramMap.put("cost_aprv_user_no", mbrVo.getUser_no());
		sqlSession.update("CostDetailMapper.updateAprvCostItem",paramMap);
		
        //===============================================
        //	top_cost_deposit_2nd 결재상태 체크 및 변경
        //===============================================		
		int stateChkCnt = sqlSession.selectOne("CostDetailMapper.selectCostItemStateCheck",paramMap);
		if (stateChkCnt > 0){
			//청구 상태인 결재가 있으면 deposit 0 변경
			paramMap.put("aprv_state", 0);
		}else{
			//전부 팀장 결재 상태이면 deposit 변경
			paramMap.put("aprv_state", 1);
		}
		
		sqlSession.update("CostDetailMapper.updateArpvCostDeposit1st",paramMap);
		sqlSession.insert("CostDetailMapper.insertCostDepositLog",paramMap);
		
		String queryString = "?user_no="+paramMap.get("user_no");
		queryString += "&cost_kind="+paramMap.get("cost_kind");
		queryString += "&cost_year_month="+paramMap.get("cost_year_month");
		queryString += "&bgnDe="+paramMap.get("bgnDe");
		queryString += "&endDe="+paramMap.get("endDe");
		
		
		if ("D".equals(action)){
			queryString += "&cost_class_no="+paramMap.get("cost_class_no");
		}
		
		String retURL = "redirect:/cost_detail_contents"+queryString;
		
		return retURL;
		
	}	
	
	
	@RequestMapping(value = "select_cost_class_list", method = RequestMethod.POST)
	@ResponseBody
	public List<SysAdmCodeDicVO> select_cost_class_list(Model model, HttpSession session, HttpServletResponse response, String cost_kind, HttpServletRequest request) {
		
        //===============================================
        //	계정명 코드
        //===============================================		
        SysAdmCodeDicVO codeVo = new SysAdmCodeDicVO();
        codeVo.setTbl_nm("top_cost_item_2nd");
        codeVo.setCol_nm("cost_class_no");
        codeVo.setCol_cd1(cost_kind);
        
        List<SysAdmCodeDicVO> costClassNoList = service.codeList3(codeVo);
        model.addAttribute("costClassNoList",costClassNoList);
        
		return costClassNoList;
	}
	
	
	@RequestMapping(value = "cost_detail_print", method = RequestMethod.GET)
	public String cost_detail_print(Model model, HttpSession session,  HttpServletRequest request) {
	
		logger.info("========= cost_detail_print =========");
		
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);		
		
        String user_no = String.valueOf(paramMap.get("user_no"));
		
		//==========================================
		//	엑셀 처리
		//==========================================
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));  //엑셀다운 여부
		if ("".equals(excelYN)){
			excelYN = "N";
		}
		
		TopMbrBscVO userInfo = sqlSession.selectOne("MyEmpCertIns.getMyInfo", user_no);
				
		List<Map<String,Object>> costDetailList = sqlSession.selectList("CostDetailMapper.selectCostDetailPrint",paramMap);
		
		List<Map<String,Object>> basicCardList = new ArrayList<>();
		List<Map<String,Object>> basicCashList = new ArrayList<>();
		
		List<Map<String,Object>> addCardList = new ArrayList<>();
		List<Map<String,Object>> addCashList = new ArrayList<>();
		
		List<Map<String,Object>> claimCardList = new ArrayList<>();
		List<Map<String,Object>> claimCashList = new ArrayList<>();
		
		for(Map<String,Object> costDetailMap : costDetailList){
			String costKind = String.valueOf(costDetailMap.get("costKind"));
			String costPayType= String.valueOf(costDetailMap.get("costPayType"));
			//0 : 현금, 1: 카드
			//1 : 일반, 2: 추가, 3: 클레임
			if ("0".equals(costPayType)){
				if ("1".equals(costKind)){
					basicCashList.add(costDetailMap);
				}else if ("2".equals(costKind)){
					addCashList.add(costDetailMap);
				}else if("3".equals(costKind)){
					claimCashList.add(costDetailMap);
				}
			}else if("1".equals(costPayType)){
				if ("1".equals(costKind)){
					basicCardList.add(costDetailMap);
				}else if ("2".equals(costKind)){
					addCardList.add(costDetailMap);
				}else if("3".equals(costKind)){
					claimCardList.add(costDetailMap);
				}				
			}
		}
		
		List<Map<String,Object>> helpClientList = sqlSession.selectList("CostDetailMapper.selectRptHelpClinetList",paramMap); 
		List<Map<String,Object>> helpAcceptList = sqlSession.selectList("CostDetailMapper.selectRptHelpAcceptList",paramMap);
		
		model.addAttribute("srchArg",paramMap);
		model.addAttribute("userInfo",userInfo);
		
		model.addAttribute("basicCardList",basicCardList);
		model.addAttribute("basicCashList",basicCashList);
		model.addAttribute("addCardList",addCardList);
		model.addAttribute("addCashList",addCashList);
		model.addAttribute("claimCardList",claimCardList);
		model.addAttribute("claimCashList",claimCashList);
		
		model.addAttribute("helpClientList",helpClientList);
		model.addAttribute("helpAcceptList",helpAcceptList);
		
		String retURL = "top_cost_2nd/cost_detail_print";
		
		if ("Y".equals(excelYN)){
			retURL = "top_individual/my_cost_print_excel";
		}
		
		return retURL;
		
	}	
	

	
	@RequestMapping(value = "cost_detail_comment")
	public String cost_detail_comment(Model model, HttpSession session, HttpServletRequest request) {
        //=======================================================================
        //	파라미터 체크
        //=======================================================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        String cost_deposit_no = request.getParameter("cost_deposit_no");
        
        List<Map<String,Object>> costDetailFileList = new ArrayList();
        if (!"".equals(cost_deposit_no)){
        	costDetailFileList = sqlSession.selectList("CostDetailMapper.selectCostDetailFileList",paramMap);
        }
        
        model.addAttribute("costDetailFileList",costDetailFileList);
        model.addAttribute("costDepositNo",paramMap.get("cost_deposit_no"));
        model.addAttribute("costDepositState",paramMap.get("cost_deposit_state"));
        
		return "top_cost_2nd/cost_detail_file";
	}
	
	
	/* *****************
	 * 영수증 파일 처리
	 * ******************/
	@RequestMapping(value = "cost_detail_file")
	public String cost_detail_file(Model model, HttpSession session, HttpServletRequest request) {
        //=======================================================================
        //	파라미터 체크
        //=======================================================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        String cost_deposit_no = request.getParameter("cost_deposit_no");
        
        List<Map<String,Object>> costDetailFileList = new ArrayList();
        if (!"".equals(cost_deposit_no)){
        	costDetailFileList = sqlSession.selectList("CostDetailMapper.selectCostDetailFileList",paramMap);
        }
        
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();
        
        String sUser_no = mbrVo.getUser_no();
        String sUserState = mbrVo.getUser_state();

        model.addAttribute("user_no",sUser_no);
        model.addAttribute("user_state",sUserState);
        model.addAttribute("costDetailFileList",costDetailFileList);
        model.addAttribute("costDepositNo",paramMap.get("cost_deposit_no"));
        model.addAttribute("costDepositState",paramMap.get("cost_deposit_state"));
        
		return "top_cost_2nd/cost_detail_file";
	}
	
    
    @RequestMapping(value = "/cost_detail_file_upload")
    public String cost_detail_file_upload(HttpServletRequest request , Model model, String costDepositNo, MultipartFile costDetailFile) throws Exception{
        //===============================================
        //	파일명 암호화 및 데이터 세팅
        //===============================================
	    
    	String orgFileName = costDetailFile.getOriginalFilename();							//원본 파일명
//		String fileExt = FilenameUtils.getExtension(orgFileName);							//파일 확장자
//		String encFileName = UUID.randomUUID().toString().replaceAll("-", "") +"."+fileExt;	//암호화 파일명
		
		
		Calendar calendar = Calendar.getInstance();
     	int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH)+1;
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		
		String filePath = "/ls_data/cost/"+year+"/"+month+"/"+day+"/"+ costDepositNo +"/";
		String fullPath =  "/home/hosting_users/toplac/www"+filePath;
		
		try {
			File file = new File(fullPath,orgFileName);
			if(!file.exists()){
				file.mkdirs();
			}
			
			costDetailFile.transferTo(file);
			
			Map<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("filePath", filePath);
			paramMap.put("fileName", orgFileName);
			paramMap.put("costDepositNo", costDepositNo);
			
			sqlSession.insert("CostDetailMapper.insertCostDetailFile",paramMap);
		} catch (IOException e) {
			e.printStackTrace();
		} // try - catch
		
        return "redirect:./cost_detail_file?cost_deposit_no="+costDepositNo;
    }	
	
    @RequestMapping(value = "/cost_detail_file_down")
    public void cost_detail_file_down(HttpServletResponse response, Model model, String serialNo) throws Exception{
    	
    	Map<String,Object> costDetailFile = sqlSession.selectOne("CostDetailMapper.selectCostDetailFile",serialNo);
    	
    	String encFileName ="";
    	String fileName = String.valueOf(costDetailFile.get("file_name"));
    	String filePath = String.valueOf(costDetailFile.get("file_path"));
    	
    	
       	try {
       		encFileName = java.net.URLEncoder.encode(fileName,"UTF-8");
    	} catch (UnsupportedEncodingException e) {
    		e.printStackTrace();
    	}
    	
    	response.setHeader("Content-Disposition","attachment;filename="+encFileName);
    	
		String fullPath =  "/home/hosting_users/toplac/www"+filePath+fileName;
    	
    	ServletOutputStream sout;
    	try {
    		sout = response.getOutputStream();
    		FileInputStream fin = new FileInputStream(fullPath);
    		byte[] buf = new byte[1024];
    		int size=0;
    		while((size=fin.read(buf,0,1024))!=-1){
    			sout.write(buf,0,size);
    		}
    		sout.flush();
    		fin.close();
    		sout.close();
    	} catch (IOException e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	
    }	
	
    @RequestMapping(value = "/cost_detail_file_delete")
    public String cost_detail_file_delete(HttpServletRequest request , Model model) throws Exception{
    	
        //=======================================================================
        //	파라미터 체크
        //=======================================================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        String serialNo = String.valueOf(paramMap.get("serialNo"));
        String costDepositNo = String.valueOf(paramMap.get("costDepositNo"));
    	
    	Map<String,Object> costDetailFile = sqlSession.selectOne("CostDetailMapper.selectCostDetailFile",serialNo);
    	
		if (costDetailFile != null){
			
			String filePath = String.valueOf(costDetailFile.get("file_path"));
			String fileName = String.valueOf(costDetailFile.get("file_name"));
			
			String fullPath =  "/home/hosting_users/toplac/www"+filePath+fileName;			
			
			
			File file = new File(fullPath);
			if(file.exists() == true){
				file.delete();
				sqlSession.delete("CostDetailMapper.deleteCostDetailFile",paramMap);
			}
		}
    	
		return "redirect:./cost_detail_file?cost_deposit_no="+costDepositNo;
    	
    }	
	
	
	
	
	
	
	
	
	
	
	
}//class
