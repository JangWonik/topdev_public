package kr.co.toplac.sysadm;


import java.io.File;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.toplac.sysadm.service.RptPrivateDelService;
import kr.co.toplac.util.cmm.DateUtil;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topsuim.SuimRptOrgFileVO;
import kr.co.toplac.topsuim.SuimRptSiteImgVO;
import kr.co.toplac.topsuim.SuimRptSiteVO;
import kr.co.toplac.topsuit.KB.SuimSuit_10_FileVO;
import kr.co.toplac.topsuit.SS.SuimSuit_18_FileVO;
import kr.co.toplac.topsuit12.SuimSuit12OrgFileVO;
import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class TopRptDelPrivateInfo {

	private static final Logger logger = LoggerFactory.getLogger(TopRptDelPrivateInfo.class);

	@Autowired
	SqlSession sqlSession;

    @Autowired
    RptPrivateDelService service;
	
	private static int meritzPtnrId = 16;
	private static int samsungPtnrId = 18;
	private static int kbPtnrId = 29;
	private static int ligPtnrId = 10;
	private static int hanhwaPtnrId = 12;
	private static int nhPtnrId = 6;
	private static int heungPtnrId = 17;
	private static int kfccPtnrId = 26;			//새마을금고
	
	private static int meritzDelDate = 15;
	private static int samsungDelDate = 5;
	private static int kbDelDate = 90;
	private static int ligDelDate = 5;
	private static int hanhwaDelDate = 7;
	private static int nhDelDate = 30;
	private static int heungDelDate = 1825; //5년
	private static int kfccDeldate = 5;			//새마을금고 보고서 삭제주기 5일


    @RequestMapping(value = "/topRptDelPrivateInfo", method = RequestMethod.POST)
	public void topRptDelPrivateInfo(HttpSession session, HttpServletRequest request, PrintWriter out){
        logger.info("======= topRptDelPrivateInfo =======");
        TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
        if(mbrVo != null && mbrVo.getUser_state().equals("9")){
            service.deletePrivateInfoBatch();
            out.print(1);
        }else{
            logger.info("home - no permession : "+request.getRemoteAddr());
            session.invalidate();
            out.print(0);
        }

    }

	//@RequestMapping(value = "/topRptDelPrivateInfoBackup", method = RequestMethod.POST)
	public void topRptDelPrivateInfoBackup(HttpSession session, HttpServletRequest request, PrintWriter out) {
		
		logger.info("======= topRptDelPrivateInfo =======");
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9")){
			logger.info("home - no permession : "+request.getRemoteAddr());
			session.invalidate();
			out.print(0);
		}else{
			
			int resultCount = 0;
			int resultRptBsc = 0;
			
			int delPtnrId[] = {meritzPtnrId, samsungPtnrId, kbPtnrId, ligPtnrId, hanhwaPtnrId, nhPtnrId, heungPtnrId, kfccPtnrId};
			int delDate[] = {meritzDelDate, samsungDelDate, kbDelDate, ligDelDate, hanhwaDelDate, nhDelDate, heungDelDate, kfccDeldate};
			
			HashMap<String,Integer> map = new HashMap<String,Integer>();
			
			
			
			for (int i = 0; i < delPtnrId.length; i++) {
				
				map.put("delDate", delDate[i]);
				map.put("ptnrId", delPtnrId[i]);
				
				/* 1. 갱신 대상인 건들 추출 : 2에서 같은 조건의 top_rpt_head/body 를 갱신하지만, 
				 * 기타 테이블(top_rpt_site_interim, top_rpt_ctrl, top_rpt_memo, top_rpt_file)
				 * 들을 보험사별로 삭제해야하기 때문에 한번 더 추출하여 갖고 있는다 
				 * */ 
				List<String> targetList = sqlSession.selectList("DelPrivateInfoForCloseRpt.getDelTargetRpt",map);
				
				/* 2. 구 ls_report 갱신 부분*/
				resultRptBsc = sqlSession.update("DelPrivateInfoForCloseRpt.updateRptForCloseOrCancel", map);
				
				int resultRptEtc = 0;
				
				for (int j = 0; j < targetList.size(); j++) {
					
					/*사고처리 과정표 갱신*/
					resultRptEtc = sqlSession.update("DelPrivateInfoForCloseRpt.updateRptCtl",targetList.get(j).split("+")[0]);
					resultRptBsc += resultRptEtc;
					resultRptEtc = 0;
					
					/*중간보고서 , 현장 보고서 삭제 시작*/
					String suim_rpt_no = targetList.get(j).split("+")[0];
					List<SuimRptSiteVO> suimRptSiteInterimList = sqlSession.selectList("SuimRptSiteMapper.getSiteInterimListForDelete", suim_rpt_no);
					
					String imgSerial = "";
					String thisfile = "";
					String fileforder = "";
					String fileforderForSiteInterim = "";
					String siteRptNo = "";
					String suimRptNo = suim_rpt_no;
					
					for (int k = 0; k < suimRptSiteInterimList.size(); k++) {
						
						List<SuimRptSiteImgVO> suimRptSiteImgList = sqlSession.selectList("SuimRptSiteMapper.getSiteInterimImgList",suimRptSiteInterimList.get(k).getRptSiteNo());
						
						
						/*현장, 중간 이미지 삭제 시작*/
						for (int l = 0; l < suimRptSiteImgList.size(); l++) {
							
							imgSerial = suimRptSiteImgList.get(l).getRptSiteImgNo();
							thisfile = suimRptSiteImgList.get(l).getImgPath()+ suimRptSiteImgList.get(l).getImgName() ;
							fileforder = suimRptSiteImgList.get(l).getImgPath().substring(0, thisfile.lastIndexOf("/"));
							
							//현장,중간 이미지 파일 삭제 시작
							if(fileforder != ""){
								
								File file = new File(thisfile);
								File dir = new File(fileforder);
								file.delete();
								dir.delete();
								
							}
							//현장,중간 이미지 삭제 종료
							
							
							sqlSession.update("SuimRptSiteMapper.siteImgDel", imgSerial );
						} // end for j
						/*현장, 중간 이미지 삭제 끝*/
						
						fileforderForSiteInterim = suimRptSiteInterimList.get(k).getFilePath().substring(0, suimRptSiteInterimList.get(k).getFilePath().lastIndexOf("/"));
						
						//파일 삭제 시작
						if(!fileforderForSiteInterim.equals("")){
							
							File file = new File(suimRptSiteInterimList.get(i).getFilePath()+suimRptSiteInterimList.get(i).getFileName());
							File dir = new File(fileforderForSiteInterim);
							file.delete();
							dir.delete();
							
						}
						//파일 삭제 종료
						
						siteRptNo = suimRptSiteInterimList.get(i).getRptSiteNo();
						sqlSession.update("SuimRptSiteMapper.delSiteInterimFile", siteRptNo);
						
					}
					
					sqlSession.delete("SuimBookUdtMapper.rptActionDelSiteInterim",suimRptNo);
					
					/*중간보고서 , 현장 보고서 삭제 끝*/
					
					/*현재 진행사항 삭제*/
					sqlSession.delete("SuimBookUdtMapper.rptActionDelMemo",suimRptNo);
					
					/*나도 한마디 삭제*/
					sqlSession.delete("SuimBookUdtMapper.rptActionDelNow",suimRptNo);
					
					/*보고서 원본 파일 삭제*/
					
					List<SuimRptOrgFileVO> suimRptOrgFileList = sqlSession.selectList("SuimBookDtlMapper.rptOrgFileList",suim_rpt_no);
					
					if(suimRptOrgFileList.size() >0){
						for (int m = 0; m < suimRptOrgFileList.size(); m++) {
							
							fileforder = suimRptOrgFileList.get(i).getFilePath().substring(0, suimRptOrgFileList.get(i).getFilePath().lastIndexOf("/"));
							
							//파일 삭제 시작
							if(!fileforder.equals("")){
								
								File file = new File(suimRptOrgFileList.get(i).getFilePath()+suimRptOrgFileList.get(i).getFileName());
								File dir = new File(fileforder);
								file.delete();
								dir.delete();
								
							}
							//파일 삭제 종료
							
							sqlSession.delete("SuimBookUdtMapper.delRptOrgFile", suimRptOrgFileList.get(i).getSerialNo());
							
						}
					}
					/*원본 파일 삭제 끝*/
					
					/*인보험 보고서 작성 삭제*/
					
					String targetPrint = "";
					String type2 = targetList.get(j).split("+")[1];
					
					if(type2.equals("1")){ // 일반 
						
						targetPrint = "top_rpt_print_1";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_1_2";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_1_5";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_1_6_1";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_1_6_2";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_1_8";
						delPrint(targetPrint,suim_rpt_no);
						
					}else if(type2.equals("6")){
						targetPrint = "top_rpt_print_6";
						delPrint(targetPrint,suim_rpt_no);
					}else if(type2.equals("9")){
						targetPrint = "top_rpt_print_9";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_9_5_1";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_9_5_2";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_9_6";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_9_8";
						delPrint(targetPrint,suim_rpt_no);
					}else if(type2.equals("16")){
						targetPrint = "top_rpt_print_16";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_16_3";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_16_4";
						delPrint(targetPrint,suim_rpt_no);
					}else if(type2.equals("17")){
						targetPrint = "top_rpt_print_17";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_17_2";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_17_4";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_17_7";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_17_13";
						delPrint(targetPrint,suim_rpt_no);
					}else if(type2.equals("1700")){
						targetPrint = "top_rpt_print_1700";
						delPrint(targetPrint,suim_rpt_no);
						targetPrint = "top_rpt_print_1700_7";
						delPrint(targetPrint,suim_rpt_no);
					}
					
					
				}
				
				map.clear();
				
			}
			
			/*삼성 적부 삭제 시작*/
			
			Calendar cal = Calendar.getInstance();    
			cal.setTime(new Date());    
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");    
			String today = df.format(cal.getTime());
			String day = today.substring(8, today.length());
			
			/*지금 년월에 1일을 셋팅*/
			cal.set(Calendar.DATE, 1);
			String firstDay = df.format(cal.getTime());
			
			if( Integer.parseInt(day) > 24){
				
				List<String> ssDelList = sqlSession.selectList("DelPrivateInfoForCloseRpt.getDelSSJuckbuNo", firstDay);
				
				sqlSession.update("DelPrivateInfoForCloseRpt.udtSSjukbu", firstDay);
				String suim_rpt_no = "";
				for (int i = 0; i < ssDelList.size(); i++) {
					
					suim_rpt_no = ssDelList.get(i);
					List<SuimSuit_18_FileVO> fileList = sqlSession.selectList("DelPrivateInfoForCloseRpt.getSSfileList",suim_rpt_no);
					
					for (int j = 0; j < fileList.size(); j++) {
						
						//파일 삭제 시작
						if(!fileList.get(i).getFilePath().equals("")){
							
							File file = new File(fileList.get(i).getFilePath()+"/"+fileList.get(i).getFileName());
							File dir = new File(fileList.get(i).getFilePath());
							file.delete();
							dir.delete();
							
						}
						//파일 삭제 종료
						
						sqlSession.delete("DelPrivateInfoForCloseRpt.delSSfile", fileList.get(i).getSerialNo());
					}
				}
			}
			/*삼성 적부 삭제 끝*/
			
		}
			
	}//topMainIndex



	private void delPrint(String targetPrint, String suim_rpt_no) {
		HashMap<String,String> map = new HashMap<String,String>();
		
		map.put("targetPrint", targetPrint);
		map.put("suim_rpt_no", suim_rpt_no);
		
		sqlSession.delete("DelPrivateInfoForCloseRpt.delPrint", map);
	}
	
	
	
	@RequestMapping(value = "/delJukbuPop", method = RequestMethod.GET)
	public String delJukbuPop(Model model,HttpSession session, HttpServletRequest request) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9")){
			logger.info("home - no permession : "+request.getRemoteAddr());
			model.addAttribute("authFlag", "no");
		}else{
			model.addAttribute("authFlag", "yes");
		}
		
		return "sys_adm/top_del_Jukbu";
	}
	
	@RequestMapping(value = "/deljuk", method = RequestMethod.POST)
	public void deljuk(Model model,HttpSession session, HttpServletRequest request, PrintWriter out, String date, String ptnrId) {
		
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9")){
			logger.info("home - no permession : "+request.getRemoteAddr());
			out.print(2);
		}else{
			
			HashMap<String,String> map = new HashMap<String,String>();
			map.put("ptnrId", ptnrId);
			map.put("date", date);
			
			/*본 테이블 갱신*/
			int result = sqlSession.update("DelPrivateInfoForCloseRpt.deljuk", map);
			
			/*부속 테이블 삭제(파일)*/
			if(ptnrId.equals("10")){
				List<String> kbDelList = sqlSession.selectList("DelPrivateInfoForCloseRpt.getKBListForDel",map);
				
				String suim_rpt_no = "";
				for (int i = 0; i < kbDelList.size(); i++) {
					
					suim_rpt_no = kbDelList.get(i);
					List<SuimSuit_10_FileVO> kbDelFileList = sqlSession.selectList("DelPrivateInfoForCloseRpt.getKBFileListForDel",suim_rpt_no);
					
					for (int j = 0; j < kbDelFileList.size(); j++) {						
						//파일 삭제 시작
						if(!kbDelFileList.get(i).getFilePath().equals("")){
							
							File file = new File(kbDelFileList.get(i).getFilePath()+"/"+kbDelFileList.get(i).getFileName());
							File dir = new File(kbDelFileList.get(i).getFilePath());
							file.delete();
							dir.delete();
							
						}
						//파일 삭제 종료
					}
					
					/*파일 테이블 삭제*/
					sqlSession.delete("DelPrivateInfoForCloseRpt.delKBfileData", suim_rpt_no);
					
				}
				
			}else if(ptnrId.equals("12")){
				List<String> hanDelList = sqlSession.selectList("DelPrivateInfoForCloseRpt.getHanListForDel",map);
				
				String suim_rpt_no = "";
				for (int i = 0; i < hanDelList.size(); i++) {
					
					suim_rpt_no = hanDelList.get(i);
					List<SuimSuit12OrgFileVO> hanDelFileList = sqlSession.selectList("DelPrivateInfoForCloseRpt.getHanFileListForDel",suim_rpt_no);
					
					for (int j = 0; j < hanDelFileList.size(); j++) {						
						//파일 삭제 시작
						if(!hanDelFileList.get(i).getFilePath().equals("")){
							
							File file = new File(hanDelFileList.get(i).getFilePath()+"/"+hanDelFileList.get(i).getFileName());
							File dir = new File(hanDelFileList.get(i).getFilePath());
							file.delete();
							dir.delete();
							
						}
						//파일 삭제 종료
					}
					
					/*파일 테이블 삭제*/
					sqlSession.delete("DelPrivateInfoForCloseRpt.delHanfileData", suim_rpt_no);
					
					/*bld 테이블 삭제*/
					sqlSession.delete("DelPrivateInfoForCloseRpt.delHanOjData", suim_rpt_no);
					
					/*oj 테이블 삭제*/
					sqlSession.delete("DelPrivateInfoForCloseRpt.delHanBldData", suim_rpt_no);
					
				}
			}
			
			
			out.print(result);
		}
		
		out.close();
	}
	

}//end of class
