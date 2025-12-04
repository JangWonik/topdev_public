package kr.co.toplac.lecture;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.sysadm.HolidayViewVO;
import kr.co.toplac.sysadm.SysAdmHolidayVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.PaginationInfo;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.rpt.MainLeftUtil;
import kr.co.toplac.lecture.LectureRoomViewVO;

@Controller
public class LectureRoomController {

	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	MainLeftUtil mlu;
	
	@RequestMapping(value="lectureRoomCalendar")
	public String lectureRoomCalendar(HttpServletRequest request, Model model, HttpSession session,LectureRoomViewVO lectureVO) {
		
        //===============================================
        //	파라미터 체크
        //===============================================
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
//		TopMbrBscVO mbrVo = (TopMbrBscVO)session.getAttribute("mbrVo_Session");
		String user_no = (String)session.getAttribute("user_no_Session");

		paramMap.put("user_no", user_no);
		
		//===============================================
        // 비즈니스 로직
        //===============================================		
		//현재 년도,월 구하기
		if(lectureVO.getSelectMonth() == null || lectureVO.getSelectMonth().equals("")){
			Date today = new Date();
			DateFormat sd1 = new SimpleDateFormat("yyyy-MM");
			lectureVO.setSearchString(sd1.format(today));
		}else{
			if(lectureVO.getSelectMonth().length() == 1){
				lectureVO.setSelectMonth("0"+lectureVO.getSelectMonth());
			}
			lectureVO.setSearchString(lectureVO.getSelectYear() + "-" + lectureVO.getSelectMonth());
		}
		String searchString = lectureVO.getSearchString();
		paramMap.put("lecture_room_date", searchString);
		
		//년도 리스트 가져오기
		List<String> yearList = sqlSession.selectList("HolidayMapper.yearList");
        
		//해당 날짜의 요일 구하기
		List<SysAdmHolidayVO> oneMonthList = sqlSession.selectList("HolidayMapper.oneMonthList2",searchString);
        
        //강의실 신청 정보 가져오기
        List<Map<String,Object>> lectureRoomList = sqlSession.selectList("LectureRoomMapper.selectLectureRoomList", paramMap);
        
        //신청자 기본정보 가져오기
      	List<Map<String,Object>> lectureRoomInfo = sqlSession.selectOne("LectureRoomMapper.getLectureRoomApplicantInfo",paramMap);
      	
		//===============================================
        // 뷰단 데이터 세팅
        //===============================                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ================ 
        model.addAttribute("paramMap", paramMap);
        model.addAttribute("yearList", yearList);
        model.addAttribute("oneMonthList", oneMonthList);
        model.addAttribute("lectureRoomList", lectureRoomList);
        model.addAttribute("lectureRoomInfo", lectureRoomInfo);
        model.addAttribute("selectedYear", lectureVO.getSearchString().substring(0, 4));
        model.addAttribute("selectedMonth",lectureVO.getSearchString().substring(5));
        model.addAttribute("startYoil",oneMonthList.get(0).getHoliday_yoil());
        
		return "top_lecture_room/top_lecture_room_main";
	}
	
	@RequestMapping(value="lectureRoomApplication")
	public String lectureRoomApplication(HttpServletRequest request, Model model, HttpSession session, TopMbrBscVO tmbVO) {
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		TopMbrBscVO mbrVo = (TopMbrBscVO)session.getAttribute("mbrVo_Session");
		String user_no = (String)session.getAttribute("user_no_Session");
		String team_id = mbrVo.getTeam_id_main();
		String lecture_room_date = String.valueOf(paramMap.get("lecture_room_date"));
		
		paramMap.put("user_no", user_no);
		paramMap.put("team_id", team_id);
		
		//신청자 기본정보 가져오기
		Map<String,Object> lectureRoomInfo = sqlSession.selectOne("LectureRoomMapper.getLectureRoomApplicantInfo",paramMap);
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================				
		model.addAttribute("user_no",user_no);		
		model.addAttribute("team_id",team_id);		
		model.addAttribute("lectureRoomInfo",lectureRoomInfo);		
		model.addAttribute("lecture_room_date",lecture_room_date);		
		
		
		return "top_lecture_room/top_lecture_room_application";
	}
	
	@RequestMapping(value="popMyApplicationUpdate")
	public String popMyApplicationUpdate(HttpServletRequest request, Model model, HttpSession session, TopMbrBscVO tmbVO) {
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		TopMbrBscVO mbrVo = (TopMbrBscVO)session.getAttribute("mbrVo_Session");
		String user_no = (String)session.getAttribute("user_no_Session");
		String team_id = mbrVo.getTeam_id_main();
		String lecture_room_date = String.valueOf(paramMap.get("lecture_room_date"));
		
		paramMap.put("user_no", user_no);
		paramMap.put("team_id", team_id);
		//신청자 기본정보 가져오기
		Map<String,Object> lectureRoomInfo = sqlSession.selectOne("LectureRoomMapper.selectLectureRoomApplicationInfo",paramMap);
			
		//===============================================
		// 뷰단 데이터 세팅
		//===============================================				
		model.addAttribute("user_no",user_no);		
		model.addAttribute("team_id",team_id);		
		model.addAttribute("paramMap",paramMap);		
		model.addAttribute("lectureRoomInfo",lectureRoomInfo);		
		model.addAttribute("lecture_room_date",lecture_room_date);		
		
		
		return "top_lecture_room/lecture_room_application_update";
	}
	
	@RequestMapping(value="lectureRoomUpdate")
	@ResponseBody	
	public String lectureRoomUpdate(HttpServletRequest request, Model model, HttpSession session, TopMbrBscVO tmbVO) {
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);

		//===============================================
        // 비즈니스 로직
        //===============================================	
		//기존 신청건 삭제
		sqlSession.delete("LectureRoomMapper.deleteLectureRoomApplication", paramMap);
		
        //중복시간 체크하기
		int check = sqlSession.selectOne("LectureRoomMapper.selectDuplicationCheck",paramMap);
		
		if(check >= 1) {
			return "1";
		}

		// 강의실 신청하기
		sqlSession.insert("LectureRoomMapper.insertLectureRoom", paramMap);		
		
		return "2";		
	}
	
	@RequestMapping(value="lectureRoomList")
	public String lectureRoomList(HttpServletRequest request, Model model, HttpSession session) {
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		String lecture_room_date = String.valueOf(paramMap.get("lecture_room_date"));
		TopMbrBscVO mbrVo = (TopMbrBscVO)session.getAttribute("mbrVo_Session");
		String user_no = (String)session.getAttribute("user_no_Session");
		String team_id = mbrVo.getTeam_id_main();
		
		paramMap.put("user_no", user_no);
		paramMap.put("team_id", team_id);
		
		//===============================================
        // 비즈니스 로직
        //===============================================			
		//강의실 신청정보 가져오기
		List<Map<String,Object>> lectureRoomList = sqlSession.selectList("LectureRoomMapper.selectLectureRoomState1",paramMap);		
        //신청자 기본정보 가져오기
      	List<Map<String,Object>> lectureRoomInfo = sqlSession.selectList("LectureRoomMapper.getLectureRoomApplicantInfo",paramMap);
		
      	//===============================================
        // 뷰단 데이터 세팅
        //===============================================	
		model.addAttribute("lectureRoomList",lectureRoomList);	
		model.addAttribute("lecture_room_date",lecture_room_date);	
		model.addAttribute("lectureRoomInfo",lectureRoomInfo);	
		
		return "top_lecture_room/top_lecture_room_list";
	}
	
	@RequestMapping(value="lectureRoomApproveList")
	public String lectureRoomApproveList(HttpServletRequest request, Model model, HttpSession session) {
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		TopMbrBscVO mbrVo = (TopMbrBscVO)session.getAttribute("mbrVo_Session");
		String user_no = (String)session.getAttribute("user_no_Session");
		String team_id = mbrVo.getTeam_id_main();
		
		paramMap.put("user_no", user_no);
		paramMap.put("team_id", team_id);
		
		//===============================================
        // 비즈니스 로직
        //===============================================			
        //신청자 기본정보 가져오기
      	List<Map<String,Object>> lectureRoomInfo = sqlSession.selectList("LectureRoomMapper.getLectureRoomApplicantInfo",paramMap);
        //===============================================
        // 페이지 관련 변수 선언
        //===============================================
        int sizePerPage = 15;       // 한페이지당 보여줄 글 갯수
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
        
    	//목록 가져오기
    	List<Map<String,Object>> lectureRoomList = sqlSession.selectList("LectureRoomMapper.selectList", paramMap);
        
        //전체 목록 개수 가져오기
        Long count = sqlSession.selectOne("LectureRoomMapper.selectListCnt", paramMap);
		
        // 페이징 처리
        PaginationInfo pageInfo = new PaginationInfo();
        pageInfo.setRecordCountPerPage(sizePerPage);            // 한페이지당 보여줄 글 갯수
        pageInfo.setPageSize(sizePerBlock);                     		 //페이지 리스트 에 보여줄 불럭 갯수
        pageInfo.setCurrentPageNo(currentPage + 1);              // index 가 0 부터 시작 해서 플러스 1해줌
        pageInfo.setTotalRecordCount(count);                     	 // 총 글 갯수
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================	
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("lectureRoomList", lectureRoomList);
        model.addAttribute("srchArg", paramMap);
        model.addAttribute("lectureRoomInfo", lectureRoomInfo);
        model.addAttribute("count", count);
        
		return "top_lecture_room/top_lecture_room_approve_list";
	}
	
	
	@RequestMapping(value="lectureRoomApplicationList")
	public String lectureRoomApplicationList(HttpServletRequest request, Model model, HttpSession session) {
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		TopMbrBscVO mbrVo = (TopMbrBscVO)session.getAttribute("mbrVo_Session");
		String user_no = (String)session.getAttribute("user_no_Session");

		paramMap.put("user_no", user_no);
		
		//나의  강의실 신청정보 가져오기
		List<Map<String,Object>> myLectureRoomInfo = sqlSession.selectList("LectureRoomMapper.myLectureRoomApplicationList",paramMap);
		
		//===============================================
        // 뷰단 데이터 세팅
        //===============================================	
		model.addAttribute("myLectureRoomInfo", myLectureRoomInfo);
		
		return "top_lecture_room/top_lecture_room_application_list";
	}
	
	
	@RequestMapping(value="popReturnReason")
	public String popReturnReason(HttpServletRequest request, Model model) {
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		String serial_no = String.valueOf(paramMap.get("serial_no"));
		String currentIdx = String.valueOf(paramMap.get("currentIdx"));

		//===============================================
		// 뷰단데이터세팅
		//===============================================	
		model.addAttribute("serial_no",serial_no);
		model.addAttribute("currentIdx",currentIdx);
		model.addAttribute("srchArg",paramMap);
		
		return "top_lecture_room/popReturnReason";
	}
	
	
	@RequestMapping(value="popReturnReasonView")
	public String popReturnReasonView(HttpServletRequest request, Model model,HttpSession session) {
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		String user_no = (String)session.getAttribute("user_no_Session");		
		paramMap.put("user_no", user_no);
		
		//===============================================
		// 뷰단데이터세팅
		//===============================================	
		model.addAttribute("serialNo",paramMap.get("serial_no"));
		
		return "top_lecture_room/popReturnReasonView";
	}
	
	@RequestMapping(value="lectureRoomIns")
	@ResponseBody
	public String lectureRoomIns(HttpServletRequest request, Model model,HttpServletResponse response) throws IOException {
		//===============================================
        //	파라미터 체크
        //===============================================		
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//===============================================
        // 비즈니스 로직
        //===============================================
        //중복시간 체크하기
		int check = sqlSession.selectOne("LectureRoomMapper.selectDuplicationCheck",paramMap);
		
		if(check >= 1) {
			return "1";
		}
		
		// 강의실 신청하기
		sqlSession.insert("LectureRoomMapper.insertLectureRoom", paramMap);		
		
		return "2";
	}
	
	@RequestMapping(value="lectureRoomApproveOK")
	public String lectureRoomApproveOK(HttpServletRequest request, Model model) {
		//===============================================
		//	파라미터 체크
		//===============================================	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		String currentIdx = String.valueOf(paramMap.get("currentIdx"));
		//===============================================
		// 비즈니스 로직
		//===============================================
		sqlSession.update("LectureRoomMapper.updateLectureRoomApprove", paramMap);		
		
		String state = String.valueOf(paramMap.get("fnState"));
		if(state != "") {
			return "redirect:/lectureRoomApproveList?pageIdx=" + currentIdx + "&state=" + state;
		}else {		
			return "redirect:/lectureRoomApproveList?pageIdx=" + currentIdx;
		}		
	}

	@RequestMapping(value="udtLectureRoomReturnReason")
	public String udtLectureRoomReturnReason(HttpServletRequest request, Model model) {
		//===============================================
		//	파라미터 체크
		//===============================================	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		String currentIdx = String.valueOf(paramMap.get("currentIdx"));
		
		//===============================================
		// 비즈니스 로직
		//===============================================
		sqlSession.update("LectureRoomMapper.updateReturnReason", paramMap);		
		
		String state = String.valueOf(paramMap.get("fnstate"));
		
		if(state != "") {
			return "redirect:/lectureRoomApproveList?pageIdx=" + currentIdx + "&state=0";
		}else {		
			return "redirect:/lectureRoomApproveList?pageIdx=" + currentIdx;
		}			
	}
	
	@RequestMapping(value="deleteLectureRoomApplication")
	public String deleteLectureRoomApplication(HttpServletRequest request, Model model) {
		//===============================================
		//	파라미터 체크
		//===============================================	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		
		//===============================================
		// 비즈니스 로직
		//===============================================
		sqlSession.delete("LectureRoomMapper.deleteLectureRoomApplication", paramMap);	
		
		return "redirect:/lectureRoomApplicationList";
	}
	
	@RequestMapping(value="lectureRoomApproveCancel")
	public String lectureRoomApproveCancel(HttpServletRequest request, Model model) {
		//===============================================
		//	파라미터 체크
		//===============================================	
		Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
		String currentIdx = String.valueOf(paramMap.get("currentIdx"));
		//===============================================
		// 비즈니스 로직
		//===============================================
		sqlSession.update("LectureRoomMapper.updateApproveCancel", paramMap);	
		
		String state = String.valueOf(paramMap.get("fnState"));
		if(state != "") {
			return "redirect:/lectureRoomApproveList?pageIdx=" + currentIdx + "&state=" + state;
		}else {		
			return "redirect:/lectureRoomApproveList?pageIdx=" + currentIdx;
		}
	}	

}
