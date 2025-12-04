package kr.co.toplac.topdutycost;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topstatistics.StatisticsNowVO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.cmm.DateUtil;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.cmm.WebUtil;

@Controller("topDutyCostController")

public class TopDutyCostController {
	private static final Logger logger = LoggerFactory.getLogger(TopDutyCostController.class);
	
    private static final String SVR_PATH = "/home/hosting_users/toplac/www";
    //private static final String SVR_PATH = "/Users/kohyeonseok/devroot/91.devUpload/toplac/hosting_users/toplac/www";
    
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping(value = "/dutyList")
	public String dutyList(Model model,HttpServletRequest request, TopDutyCostVO inVO){
		//===============================================
        //	파라미터 체크
        //===============================================
		Map<String,Object>paramMap = RequestUtil.getParameterMap(request);
		
		String yearMonth = StringUtil.null2blank(request.getParameter("yearMonth"));
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));
		
		if("".equals(yearMonth)){
			paramMap.put("yearMonth", StringUtil.getMonthString()); //paramMap에 yearMonth 를 넣어준다
			
		}
		
        //===============================================
        //	비즈니스 로직
        //===============================================		
		
		List<TopTmBscVO> topTeamList = sqlSession.selectList("HelpBscMapper.topTeamList");
		List<Map<String,Object>> dutyList = sqlSession.selectList("dutyCostMapper.selectList",paramMap);

		
		
		model.addAttribute("topTeamList", topTeamList);
		model.addAttribute("list",dutyList);
		model.addAttribute("srchArg", paramMap);

		
		String retUrl = "top_duty_cost/dutyList";
		
		if("Y".equals(excelYN)){
			retUrl = "top_duty_cost/dutyListExcel"; 
		}
		
		return retUrl;
	}	
	
	@RequestMapping(value = "/dutyCostList")
	public String dutyCostList(Model model,HttpServletRequest request){
		//===============================================
        //	파라미터 체크
        //===============================================
		Map<String,Object>paramMap = RequestUtil.getParameterMap(request);
		String yearMonth = StringUtil.null2blank(request.getParameter("yearMonth"));
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));
		
        TopMbrBscVO mbrBscVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		TopMbrAuthVO authVO = (TopMbrAuthVO)SessionUtil.getAuthorities();
		
		String sessionMbrPms22 = authVO.getMbr_pms_22();
		String sessionMbrPms23 = authVO.getMbr_pms_23();
	        
        String sessionUserNo = mbrBscVo.getUser_no();
		
		if("".equals(yearMonth)){
			paramMap.put("yearMonth", StringUtil.getMonthString());
			
		}
        //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
        int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
        int currentPage = 0;        // 현재 페이지
        int limitPage = 0;          // sql limit
        
        	
        if("Y".equals(excelYN)){
        	sizePerPage = 10000;
        }
        
        //===============================================
        // 현재 페이지 세팅
        //===============================================
        String pageIdx = StringUtil.null2blank(request.getParameter("pageIdx"));
        if("".equals(pageIdx)){
            currentPage = 0;
            limitPage = 0;
        }else{
            currentPage = (Integer.parseInt(pageIdx) - 1);
            limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
        }
        paramMap.put("sizePerPage", sizePerPage);
        paramMap.put("limitPage", limitPage);
        paramMap.put("userNo",sessionUserNo);
        paramMap.put("sessionMbrPms22", sessionMbrPms22);
        paramMap.put("sessionMbrPms23", sessionMbrPms23);
        //===============================================
        //	비즈니스 로직
        //===============================================
		
		List<Map<String, Object>> list = sqlSession.selectList("dutyCostMapper.selectCostList",paramMap);
        Long count = sqlSession.selectOne("dutyCostMapper.selectListCnt",paramMap);
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        // 페이징 처리
        PaginationInfo pageInfo = new PaginationInfo();
        pageInfo.setRecordCountPerPage(sizePerPage);            // 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                     //페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             // index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(count);                    // 총 글 갯수

        model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("list",list);
		model.addAttribute("srchArg", paramMap);
		
		
		String retUrl = "top_duty_cost/dutyCostList";
		
		if("Y".equals(excelYN)){
			retUrl = "top_duty_cost/dutyCostListExcel"; 
		}
		
		return retUrl;
	}
	
	@RequestMapping(value = "/dutyAppList")
	public String dutyAppList(Model model,HttpServletRequest request){
		//===============================================
        //	파라미터 체크
        //===============================================
		Map<String,Object>paramMap = RequestUtil.getParameterMap(request);
		//===============================================
        //	권한 체크
        //===============================================		
		TopMbrAuthVO authVO = (TopMbrAuthVO)SessionUtil.getAuthorities();
		
		if(!"1".equals(authVO.getMbr_pms_22())){
			SessionUtil.setMessage("결재 권한이 없습니다.");
			return "redirect:/dutyCostList";
		}
		
        //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
        int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
        int currentPage = 0;        // 현재 페이지
        int limitPage = 0;          // sql limit

        //===============================================
        // 현재 페이지 세팅
        //===============================================
        String pageIdx = StringUtil.null2blank(request.getParameter("pageIdx"));
        if("".equals(pageIdx)){
            currentPage = 0;
            limitPage = 0;
        }else{
            currentPage = (Integer.parseInt(pageIdx) - 1);
            limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
        }
        paramMap.put("sizePerPage", sizePerPage);
        paramMap.put("limitPage", limitPage);
        //===============================================
        //	비즈니스 로직
        //===============================================
		
		List<Map<String, Object>> list = sqlSession.selectList("dutyCostMapper.selectAppList",paramMap);
        Long count = sqlSession.selectOne("dutyCostMapper.selectAppCnt",paramMap);
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        // 페이징 처리
        PaginationInfo pageInfo = new PaginationInfo();
        pageInfo.setRecordCountPerPage(sizePerPage);            // 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                     //페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             // index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(count);                    // 총 글 갯수

        model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("list",list);
		model.addAttribute("srchArg", paramMap);
		
		return "top_duty_cost/dutyAppList";
	}	
	
	@RequestMapping(value = "/dutyDepList")
	public String dutyDepList(Model model,HttpServletRequest request){
		//===============================================
        //	파라미터 체크
        //===============================================
		Map<String,Object>paramMap = RequestUtil.getParameterMap(request);
		
		String excelYN = StringUtil.null2blank(request.getParameter("excelYN"));
		
		//===============================================
        //	권한 체크
        //===============================================		
		TopMbrAuthVO authVO = (TopMbrAuthVO)SessionUtil.getAuthorities();
		
		if(!"1".equals(authVO.getMbr_pms_18())){
			SessionUtil.setMessage("입금처리 권한이 없습니다.");
			return "redirect:/dutyCostList";
		}
		
        //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 18;       // 한페이지당 보여줄 글 갯수
        int sizePerBlock = 10;      // 페이지당 보여줄 블럭 갯수
        int currentPage = 0;        // 현재 페이지
        int limitPage = 0;          // sql limit

        if("Y".equals(excelYN)){
        	sizePerPage = 10000;
        }
        
        //===============================================
        // 현재 페이지 세팅
        //===============================================
        String pageIdx = StringUtil.null2blank(request.getParameter("pageIdx"));
        if("".equals(pageIdx)){
            currentPage = 0;
            limitPage = 0;
        }else{
            currentPage = (Integer.parseInt(pageIdx) - 1);
            limitPage = ((Integer.parseInt(pageIdx) - 1) * sizePerPage);
        }
        paramMap.put("sizePerPage", sizePerPage);
        paramMap.put("limitPage", limitPage);
        //===============================================
        //	비즈니스 로직
        //===============================================
		
		List<Map<String, Object>> list = sqlSession.selectList("dutyCostMapper.selectDepList",paramMap);
        Long count = sqlSession.selectOne("dutyCostMapper.selectDepCnt",paramMap);
        
        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        // 페이징 처리
        PaginationInfo pageInfo = new PaginationInfo();
        pageInfo.setRecordCountPerPage(sizePerPage);            // 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                     //페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);             // index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(count);                    // 총 글 갯수

        model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("list",list);
		model.addAttribute("srchArg", paramMap);
		
		
		String retUrl = "top_duty_cost/dutyDepList";
		if("Y".equals(excelYN)){
			retUrl = "top_duty_cost/dutyDepListExcel"; 
		}
		
		return retUrl;
	}	
	
	@RequestMapping(value = "/dutyCostRegister")
	public String dutyCostRegister(HttpServletRequest request,Model model){
		//===============================================
        //	파라미터 체크
        //===============================================
		
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		String dutyId = StringUtil.null2blank(request.getParameter("dutyId"));
		
		if("".equals(dutyId)){
			return "redirect:/dutyList";
		}
		//===============================================
        //	비지니스 로직
        //===============================================	
		Map<String,Object> dutyVo = sqlSession.selectOne("dutyCostMapper.select",paramMap);
		
		if(dutyVo == null){
			return "redirect:/dutyList";
		}
		
		
		
		TopMbrBscVO mbrBscVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		String regUserNo = String.valueOf(dutyVo.get("userNo"));
		String cnYearMonth = String.valueOf(dutyVo.get("dutyDe"));
		String date[] = cnYearMonth.split("-");
		
		
		if(!regUserNo.equals(mbrBscVo.getUser_no()) && !"9".equals(mbrBscVo.getUser_state())){
			return "redirect:/dutyList?yearMonth=" + date[0] + date[1];
		}		
		
		 //파일 리스트 가져오기
        List<Map<String, String>> fileList = sqlSession.selectList("dutyCostMapper.selectFileList", paramMap);
        
        //===============================================
        // 뷰에 전달할 값들 세팅
        //===============================================
        model.addAttribute("dutyVo",dutyVo);
        model.addAttribute("fileList", fileList);
		
		return "top_duty_cost/dutyCostRegister";
	}
	
	
	@RequestMapping(value = "/dutyCostView")
	public String dutyCostView(Model model,HttpServletRequest request){
		//===============================================
        //	파라미터 체크
        //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		String dutyId = StringUtil.null2blank(request.getParameter("dutyId"));
		
		if("".equals(dutyId)){
			return "redirect:/dutyList";
		}
        //===============================================
        //	비즈니스 로직
        //===============================================
		Map<String,Object> dutyVo = sqlSession.selectOne("dutyCostMapper.select",paramMap);
		
		if(dutyVo == null){
			return "redirect:/dutyList";
		}	

		 //파일 리스트 가져오기
        List<Map<String, String>> fileList = sqlSession.selectList("dutyCostMapper.selectFileList", paramMap);
		
		model.addAttribute("dutyVo",dutyVo);
		model.addAttribute("fileList",fileList);
		
		return "top_duty_cost/dutyCostView";
	}
	
	@RequestMapping(value = "/dutyCostEdit")
	public String dutyCostEdit(){
		return "top_duty_cost/dutyCostEdit";
	}
	
	@RequestMapping(value = "/dutyInsert", method = RequestMethod.POST)
	public String dutyInsert(HttpServletRequest request, TopDutyCostVO vo) throws Exception{
		
		TopMbrBscVO mbrBscVO = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		vo.setFrstRegisterNo(mbrBscVO.getUser_no());
		vo.setLastUpdtusrNo(mbrBscVO.getUser_no());
				
		vo.setDutyDe(vo.getDutyDe().replace("-", ""));
		
					
		
		sqlSession.insert("dutyCostMapper.dutyInsert", vo);
		
		return "redirect:/dutyList";
	}
	
	@RequestMapping(value = "/dutyCostInsert", method = RequestMethod.POST)
	public String dutyCostInsert(HttpServletRequest request, TopDutyCostVO vo) throws Exception{
		
		
		return "redirect:/dutyCostList";
	}	
	
	@RequestMapping(value = "/dutyCostUpdate", method = RequestMethod.POST)
	public String dutyCostUpdate(HttpServletRequest request,MultipartRequest multipartRequest, TopDutyCostVO vo) throws Exception {
		//===============================================
        //	파라미터 체크
        //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		String dutyId = StringUtil.null2blank(request.getParameter("dutyId"));
		if("".equals(dutyId)){
			return "redirect:/dutyList";
		}
		//===============================================
        //	비즈니스 로직
        //===============================================
		Map<String,Object> dutyVo = sqlSession.selectOne("dutyCostMapper.select",paramMap);
		
		if(dutyVo == null){
			return "redirect:/dutyList";
		}
		
		TopMbrBscVO mbrBscVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		String regUserNo = String.valueOf(dutyVo.get("userNo"));
		
		if( !"9".equals(mbrBscVo.getUser_state()) ){
			if(!regUserNo.equals(mbrBscVo.getUser_no())){
				return "redirect:/dutyList";
			}			
		}
		

		
		vo.setLastUpdtusrNo(mbrBscVo.getUser_no());
		vo.setDutyStatus("10");
		
		sqlSession.update("dutyCostMapper.updateCost", vo);

        //===============================================
        //첨부파일 처리
        //===============================================
        String dateFrm = DateUtil.getTodayString("yyyyMM");

        String svrPath = SVR_PATH;
        String dbPath = "/duty/" + dateFrm + "/";


        String savePath = svrPath + dbPath;
        List<Map<String, String>> saveFileList = uploadFileSaves(multipartRequest, savePath);

        for (Map<String, String> fileMap : saveFileList){
            fileMap.put("dutyId", dutyId);
            fileMap.put("streFilePath", fileMap.get("streFilePath").toString().replace(svrPath,""));
            sqlSession.insert("dutyCostMapper.insertFile", fileMap);

        }	
        
        String tabFlag = StringUtil.null2blank(request.getParameter("tabFlag"));
        if("1".equals(tabFlag)) {
        	return "redirect:/dutyCostList";
        }else if("2".equals(tabFlag)) {
        	return "redirect:/dutyAppList";
        }else {
        	return "redirect:/dutyList";
        }
        
	}
	
	@RequestMapping(value = "/dutyUpdate", method = RequestMethod.POST)
	public String dutyUpdate(HttpServletRequest request, TopDutyCostVO vo){
		//===============================================
        //	파라미터 체크
        //===============================================
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		String dutyId = StringUtil.null2blank(request.getParameter("dutyId"));
		if("".equals(dutyId)){
			return "redirect:/dutyList";
		}
		//===============================================
        //	비즈니스 로직
        //===============================================
		Map<String,Object> dutyVo = sqlSession.selectOne("dutyCostMapper.select",paramMap);
		
		if(dutyVo == null){
			return "redirect:/dutyList";
		}
		
		TopMbrBscVO mbrBscVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
/*		String regUserNo = String.valueOf(dutyVo.get("userNo"));*/
		
/*		if(!regUserNo.equals(mbrBscVo.getUser_no())){
			return "redirect:/dutyList";
		}*/
		System.out.println(dutyId + 22222);
		vo.setLastUpdtusrNo(mbrBscVo.getUser_no());
		vo.setDutyStatus("10");
		vo.setDutyDe(vo.getDutyDe().replace("-", ""));
		
		sqlSession.update("dutyCostMapper.updateDuty", vo);
		
		return "redirect:/dutyList";
	}
	
	@RequestMapping(value = "/dutyCostStatusUpdate")
	public String dutyCostStatusUpdate(Model model, HttpServletRequest request){
		//===============================================
        //	파라미터 체크
        //===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		String dutyId = StringUtil.null2blank(request.getParameter("dutyId"));
		String dutyStatus = StringUtil.null2blank(request.getParameter("dutyStatus"));
		String cmd = StringUtil.null2blank(request.getParameter("cmd"));
		String retType = StringUtil.null2blank(request.getParameter("retType"));
		String pageIdx = StringUtil.null2blank(request.getParameter("pageIdx"));
		String type = StringUtil.null2blank(request.getParameter("type"));
		

		//===============================================
        //	파라미터가 없을 경우 리스트로 보낸다
        //===============================================
		if("".equals(dutyId) || "".equals(dutyStatus) || "".equals(cmd)){
			return "redirect:/dutyList";
		}
		
		//===============================================
        //	해당값이 있는지 체크
        //===============================================
		Map<String,Object> dutyVo = sqlSession.selectOne("dutyCostMapper.select",paramMap);		
		if(dutyVo == null){
			return "redirect:/dutyList";
		}
		
		TopMbrBscVO mbrBscVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		
		String sessionUserNo = mbrBscVo.getUser_no();
		String dutyUserNo = String.valueOf(dutyVo.get("userNo"));
		
		TopMbrAuthVO authVO = sqlSession.selectOne("PopMbrAuthIns.userAuth", sessionUserNo);
		
		//===============================================
        //	결재 권한 체크
        //===============================================		
		if("A".equals(cmd)){
			if("20".equals(dutyStatus)){

				if(!"1".equals(authVO.getMbr_pms_22())){
					SessionUtil.setMessage("결재 권한이 없습니다.");
					return "redirect:/dutyCostList";
				}
			}
			
			if("30".equals(dutyStatus)){
				
				if(!"1".equals(authVO.getMbr_pms_18())){
					SessionUtil.setMessage("입금처리 권한이 없습니다.");
					return "redirect:/dutyCostList";
				}			
			}			
		}
		
		if("C".equals(cmd)){
			if("20".equals(dutyStatus)){
				
				if(!"1".equals(authVO.getMbr_pms_18())){
					SessionUtil.setMessage("입금취소 권한이 없습니다.");
					return "redirect:/dutyCostList";
				}			
			}
			
			if("10".equals(dutyStatus)){

				if(!"1".equals(authVO.getMbr_pms_22())){
					SessionUtil.setMessage("결재취소 권한이 없습니다.");
					return "redirect:/dutyCostList";
				}
			}
			
			if("0".equals(dutyStatus)){

				if(!"1".equals(authVO.getMbr_pms_22()) && !sessionUserNo.equals(dutyUserNo)){
					SessionUtil.setMessage("결재취소 권한이 없습니다.");
					return "redirect:/dutyCostList";
				}
			}
		}

		
		paramMap.put("userNo", sessionUserNo);
		
		if("A".equals(cmd)){
			sqlSession.update("dutyCostMapper.updateCostStatusAprov", paramMap);
		}else if("C".equals(cmd)){
			sqlSession.update("dutyCostMapper.updateCostStatusCancel", paramMap);
		}
		
		
		if("C".equals(cmd) && "0".equals(dutyStatus)){
			//파일 리스트 가져오기
	        List<Map<String, String>> fileList = sqlSession.selectList("dutyCostMapper.selectFileList", paramMap);		
	        
	        //첨부파일 삭제
	        deleteFiles(fileList);
	        
	        //첨부파일 DB삭제
	        sqlSession.delete("dutyCostMapper.deleteFiles", paramMap);			
		}
        		
		
		String retUrl = "redirect:/dutyCostList";
		
		if("10".equals(retType)){
			retUrl = "redirect:/dutyAppList";
		}else if("20".equals(retType)){
			retUrl = "redirect:/dutyDepList?pageIdx="+pageIdx+"&type="+type;
		}
		
		return retUrl;
	}
	
	@RequestMapping(value = "/dutyCostStatusAllUpdate")
	public String dutyCostAllUpdate(Model model, HttpServletRequest request){
        Map<String, Object> paramMap = new HashMap<>();
        
        System.out.println("dutyCostStatusAllUpdate");
        
        String[] dutyIds = request.getParameterValues("dutyId");
        String cmd = StringUtil.null2blank(request.getParameter("cmd"));
        
        if (dutyIds == null || "".equals(cmd)){
            System.out.println("dutyId is null !!!!!");
            return "redirect:/dutyDepList";
        }
        
        
        TopMbrBscVO mbrBscVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
        
        String sessionUserNo = mbrBscVo.getUser_no();
        
        TopMbrAuthVO authVO = sqlSession.selectOne("PopMbrAuthIns.userAuth", sessionUserNo);
        
        if(!"1".equals(authVO.getMbr_pms_18())){
            SessionUtil.setMessage("입금처리 권한이 없습니다.");
            return "redirect:/dutyDepList";
        }
        
        
        
        paramMap.put("userNo",sessionUserNo);
        paramMap.put("dutyIds",dutyIds);
        
        
        
        if("A".equals(cmd)){
            sqlSession.update("dutyCostMapper.updateCostStatusAprovAll", paramMap);
        }else if("C".equals(cmd)){
            sqlSession.update("dutyCostMapper.updateCostStatusCancelAll", paramMap);
        }
        
        return "redirect:/dutyDepList";
        
    }
	
	
	@RequestMapping(value = "/dutyCostDelete")
	public String dutyCostDelete(HttpServletRequest request){
        //===============================================
        //	권한체크
        //===============================================
		TopMbrBscVO mbrBscVo = (TopMbrBscVO)SessionUtil.getAuthenticatedUser();
		String userNo = mbrBscVo.getUser_no();
		
		TopMbrAuthVO authVO = sqlSession.selectOne("PopMbrAuthIns.userAuth", userNo);

		
        if(!"1".equals(authVO.getMbr_pms_23())){
        	SessionUtil.setMessage("삭제 권한이 없습니다.");
        	return "redirect:/dutyList";
		}
        //===============================================
        //	파라미터 체크
        //===============================================
        
		Map<String,Object> paramMap = RequestUtil.getParameterMap(request);
		String dutyId = StringUtil.null2blank(request.getParameter("dutyId"));
		
		if("".equals(dutyId)){
			return "redirect:/dutyCostList";
		}        
        //===============================================
        // 비즈니스 로직
        //===============================================		
		Map<String,Object> dutyVo = sqlSession.selectOne("dutyCostMapper.select",paramMap);
		
		if(dutyVo == null){
			return "redirect:/dutyList";
		}
		
		 sqlSession.delete("dutyCostMapper.delete", paramMap);
		
		return "redirect:/dutyList";
	}
	
	
    @RequestMapping(value = "/duty_cost_info")
    public @ResponseBody Map<String, Object> dutyCostInfo(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        //===============================================
        // 비즈니스 로직
        //===============================================
        paramMap.put("RSLTCODE", "0");
        

		String dutyId = StringUtil.null2blank(request.getParameter("dutyId"));
		
		if("".equals(dutyId)){
			paramMap.put("RSLTCODE", "10");
		}
        //===============================================
        //	비즈니스 로직
        //===============================================
		Map<String,Object> dutyVo = sqlSession.selectOne("dutyCostMapper.select",paramMap);
		
		if(dutyVo == null){
			paramMap.put("RSLTCODE", "20");
		}	        
        
        
		paramMap.put("dutyVo", dutyVo);
        return paramMap;
    }	
    
    
    /**
     * DUTY 파일 다운로드 처리
     * @param request
     * @param response
     */
    @RequestMapping("/duty_cost_file_down")
    public void dutyFileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String file_no = StringUtil.null2blank(request.getParameter("file_no"));

        Map<String, String> resutMap = sqlSession.selectOne("dutyCostMapper.selectFile", paramMap);

        if (resutMap != null){

            String svrPath = SVR_PATH;
            String dbPath = resutMap.get("streFilePath");

            String streFilePath = svrPath + dbPath;
            File uFile = new File(streFilePath, resutMap.get("streFileNm"));

            String mimetype = "application/x-msdownload";

            response.setContentType(mimetype);
            response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(resutMap.get("orignlFileNm"), "utf-8") + "\"");

            BufferedInputStream in = null;
            BufferedOutputStream out = null;

            try {
                in = new BufferedInputStream(new FileInputStream(uFile));
                out = new BufferedOutputStream(response.getOutputStream());

                FileCopyUtils.copy(in, out);
                out.flush();
            } catch (IOException ex) {
                ex.printStackTrace();
            } finally {
                in.close();
                out.close();
            }



        }else{
            response.setCharacterEncoding("utf-8");
            System.out.println("파일없을때 ......");
            response.setContentType("text/html;charset=utf-8");

            PrintWriter printwriter = response.getWriter();

            printwriter.println("<html>");
            printwriter.println("<br><br><br><h2>파일을 찾을수 없습니다.</h2>");
            printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
            printwriter.println("<br><br><br>&copy; webAccess");
            printwriter.println("</html>");

            printwriter.flush();
            printwriter.close();
        }

    }    
    
    /**
     * DUTY 첨부파일 삭제
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/duty_cost_file_delete")
    public @ResponseBody Map<String, Object> dutyFileDelete(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

        paramMap.put("Authorize", "T");

        //===============================================
        //	권한체크
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        if (!"9".equals(mbrVo.getUser_state())){
            paramMap.put("Authorize", "F");
            return paramMap;
        }

        //===============================================
        // 비즈니스 로직
        //===============================================
        //이미 있는지 체크
        Map<String, String> dutyFile = sqlSession.selectOne("dutyCostMapper.selectFile", paramMap);

        if (dutyFile != null){
            sqlSession.delete("dutyCostMapper.deleteFile", paramMap);

            //파일 삭제 처리
            String svrPath = SVR_PATH;
            String dbPath = dutyFile.get("streFilePath");
            String streFileNm = dutyFile.get("streFileNm");
            String filePath = svrPath + dbPath + streFileNm;
            File file = new File(filePath);
            file.delete();

            paramMap.put("Result", "success");
        }else{
            paramMap.put("Result", "fail");
        }

        //===============================================
        // 뷰단 데이터 세팅
        //===============================================

        return paramMap;
    }    
    
    
	
    /**
     * 여러파일 업로드 처리
     * @param multipartRequest
     * @return Map
     * streFilePath : 저장경로
     * streFileNm   : 저장파일명
     * orignlFileNm : 원본파일명
     */
    private List<Map<String, String>> uploadFileSaves(MultipartRequest multipartRequest, String savePath) throws Exception {

        int fileKey = 0;

        File dir = new File(savePath);

        if(!dir.exists() || !dir.isDirectory()){
            System.out.println("exists!!!!!!!!===============");
            dir.mkdirs();
        }

        List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();

        String filePath = "";
        Iterator<String> files = multipartRequest.getFileNames();

        while (files.hasNext()){
            String upFileKey = files.next();
            MultipartFile mFile = multipartRequest.getFile(upFileKey);

            String orignlFileNm = mFile.getOriginalFilename();
            //======================================
            // 원 파일명이 없는 경우 처리
            // (첨부가 되지 않은 input file type)
            //======================================
            if ("".equals(orignlFileNm)) {
                continue;
            }

            //String streFileNm = DateUtil.getTimeStamp() + fileKey;
            String streFileNm = StringUtil.getRandomUUID() + fileKey;

            if (!"".equals(orignlFileNm)) {
                filePath = savePath + File.separator + streFileNm;
                mFile.transferTo(new File(WebUtil.filePathBlackList(filePath)));
            }

            Map<String, String> resultMap = new HashMap<>();
            resultMap.put("streFilePath", savePath);
            resultMap.put("streFileNm", streFileNm);
            resultMap.put("orignlFileNm", orignlFileNm);

            resultList.add(resultMap);

            System.out.println("orignlfileNm:["+orignlFileNm+"]");
            System.out.println("streFileNm:["+streFileNm+"]");
            System.out.println("streFilePath:["+savePath+"]");

            fileKey++;

        }
        return resultList;
    }	

    /**
     * 첨부파일 삭제
     * @param fileList
     */
    private void deleteFiles(List<Map<String, String>> fileList) {

        String realSvrPath = SVR_PATH;

        for (int i = 0; i < fileList.size(); i++){

            Map<String, String> item = fileList.get(i);
            String filePath = item.get("streFilePath") + item.get("streFileNm");
            String folderPath = String.valueOf(item.get("streFilePath"));

            String realFilePath = realSvrPath + filePath;
            String realFolderPath = realSvrPath + folderPath;

            if(!folderPath.equals("")){
                File file = new File(realFilePath);
                File dir = new File(realFolderPath);
                file.delete();
                dir.delete();
            }
        }
    }    

    
}
