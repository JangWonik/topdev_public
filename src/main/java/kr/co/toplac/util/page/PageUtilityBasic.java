package kr.co.toplac.util.page;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

/*
*********************************************************
* Program ID	: PageUtilityBasic
* Program Name	: 페이지 유틸리티 기본
* Description	: 페이지 모듈화
* Author		: rjh
* Date			: 2016.04.11.
*********************************************************
*/
public class PageUtilityBasic {

	private static final Logger logger = LoggerFactory.getLogger(PageUtilityBasic.class);

	/*
	*********************************************************
	* Method ID		: pageBasic1
	* Method Name	: 페이지 기본 1
	* Arguments1	: int no - 하나의 jsp에 여러 페이징이 있을 경우, 구분을 위한 숫자
	* Arguments2	: SqlSession sqlSession - 조회를 위해 controller로부터 빌려온 mybatis 객체
	* Arguments3	: String listMapper - 페이징을 적용하여 조회해야하는 list sql mapper
	* Arguments4	: String reqPgNo - 조회를 요청받은 페이지 번호
	* Arguments5	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments6	: String pgNm - jsp에서 페이징에 html로 연결하여야하는 리퀘스트 맵핑 값
	* Description	: 페이지 모듈화
	* Author		: rjh
	* Date			: 2016.04.11.
	*********************************************************
	*/
	public Object pageBasic1(int no, SqlSession sqlSession, String listMapper, String reqPgNo, Model model, String pgNm){

		logger.info("======= pageBasic1 =======");

		if(reqPgNo == null || reqPgNo.trim().equals("")){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * 18) - 18;//sql limit에 적용할 값

		int totCntInt = sqlSession.selectOne(listMapper+"Cnt");//총 조회 건수
		int totPgCntInt = (int) (totCntInt / 18);//총 페이지 수
		if((totCntInt % 18) != 0){
			totPgCntInt = totPgCntInt + 1;
		}

		int startPgNoInt = 1;//화면 페이징 시작 값
		if(reqPgNo.length() >= 2){
			String tmpStr = reqPgNo.substring(reqPgNo.length()-1, reqPgNo.length());
			if(tmpStr.equals("0")){
				startPgNoInt = reqPgNoInt - 10 + 1;
			}else{
				startPgNoInt = reqPgNoInt - Integer.parseInt(tmpStr) + 1;
			}
		}

		int endPgNoInt = startPgNoInt + 9;//화면 페이징 끝 값
		if(endPgNoInt >= totPgCntInt){
			endPgNoInt = totPgCntInt;
		}

		model.addAttribute("totCntIntForListNo"+no, totCntInt);//총 목록 수
		model.addAttribute("totPgCntInt"+no, totPgCntInt);//총 페이지 수
		model.addAttribute("reqPgNoInt"+no, reqPgNoInt);//요청 페이지
		model.addAttribute("startPgNoInt"+no, startPgNoInt);//화면 페이징 시작 값
		model.addAttribute("endPgNoInt"+no, endPgNoInt);//화면 페이징 끝 값
		model.addAttribute("pgNm"+no, pgNm);//연결 리퀘스트 맵핑

		return sqlSession.selectList(listMapper, queryPgNoInt);
	}//end of pageBasic1
	
	/*
	*********************************************************
	* Method ID		: pageBasic1Samsung
	* Method Name	: 페이지 기본 1
	* Arguments1	: int no - 하나의 jsp에 여러 페이징이 있을 경우, 구분을 위한 숫자
	* Arguments2	: SqlSession sqlSession - 조회를 위해 controller로부터 빌려온 mybatis 객체
	* Arguments3	: String listMapper - 페이징을 적용하여 조회해야하는 list sql mapper
	* Arguments4	: String reqPgNo - 조회를 요청받은 페이지 번호
	* Arguments5	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments6	: String pgNm - jsp에서 페이징에 html로 연결하여야하는 리퀘스트 맵핑 값
	* Description	: 페이지 모듈화
	* Author		: rjh
	* Date			: 2016.09.22.
	*********************************************************
	*/
	public Object pageBasic1Samsung(int no, SqlSession sqlSession, String listMapper, String reqPgNo, Model model, String pgNm){

		logger.info("======= pageBasic1Samsung =======");

		if(reqPgNo == null || reqPgNo.trim().equals("")){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * 17) - 17;//sql limit에 적용할 값

		int totCntInt = sqlSession.selectOne(listMapper+"Cnt");//총 조회 건수
		int totPgCntInt = (int) (totCntInt / 17);//총 페이지 수
		if((totCntInt % 17) != 0){
			totPgCntInt = totPgCntInt + 1;
		}

		int startPgNoInt = 1;//화면 페이징 시작 값
		if(reqPgNo.length() >= 2){
			String tmpStr = reqPgNo.substring(reqPgNo.length()-1, reqPgNo.length());
			if(tmpStr.equals("0")){
				startPgNoInt = reqPgNoInt - 10 + 1;
			}else{
				startPgNoInt = reqPgNoInt - Integer.parseInt(tmpStr) + 1;
			}
		}

		int endPgNoInt = startPgNoInt + 9;//화면 페이징 끝 값
		if(endPgNoInt >= totPgCntInt){
			endPgNoInt = totPgCntInt;
		}

		model.addAttribute("totPgCntInt"+no, totPgCntInt);//총 페이지 수
		model.addAttribute("reqPgNoInt"+no, reqPgNoInt);//요청 페이지
		model.addAttribute("startPgNoInt"+no, startPgNoInt);//화면 페이징 시작 값
		model.addAttribute("endPgNoInt"+no, endPgNoInt);//화면 페이징 끝 값
		model.addAttribute("pgNm"+no, pgNm);//연결 리퀘스트 맵핑

		return sqlSession.selectList(listMapper, queryPgNoInt);
	}//end of pageBasic1

	/*
	*********************************************************
	* Method ID		: pageBasic1Search
	* Method Name	: 페이지 기본 1
	* Arguments1	: int no - 하나의 jsp에 여러 페이징이 있을 경우, 구분을 위한 숫자
	* Arguments2	: SqlSession sqlSession - 조회를 위해 controller로부터 빌려온 mybatis 객체
	* Arguments3	: String listMapper - 페이징을 적용하여 조회해야하는 list sql mapper
	* Arguments4	: String reqPgNo - 조회를 요청받은 페이지 번호
	* Arguments5	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments6	: String pgNm - jsp에서 페이징에 html로 연결하여야하는 리퀘스트 맵핑 값
	* Arguments7	: HashMap<String, String> searchKeyMap - sql 실행에 필요한 조회 값
	* Description	: 페이지 모듈화
	* Author		: rjh
	* Date			: 2016.04.11.
	*********************************************************
	*/
	public Object pageBasic1Search(int no, SqlSession sqlSession, String listMapper, String reqPgNo, Model model, String pgNm, HashMap<String, Object> searchKeyMap){

		logger.info("======= pageBasic1Search =======");

		if(reqPgNo == null || reqPgNo.trim().equals("")){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * 18) - 18;//sql limit에 적용할 값

		int totCntInt = sqlSession.selectOne(listMapper+"Cnt", searchKeyMap);//총 조회 건수
		int totPgCntInt = (int) (totCntInt / 18);//총 페이지 수
		if((totCntInt % 18) != 0){
			totPgCntInt = totPgCntInt + 1;
		}

		int startPgNoInt = 1;//화면 페이징 시작 값
		if(reqPgNo.length() >= 2){
			String tmpStr = reqPgNo.substring(reqPgNo.length()-1, reqPgNo.length());
			if(tmpStr.equals("0")){
				startPgNoInt = reqPgNoInt - 10 + 1;
			}else{
				startPgNoInt = reqPgNoInt - Integer.parseInt(tmpStr) + 1;
			}
		}

		int endPgNoInt = startPgNoInt + 9;//화면 페이징 끝 값
		if(endPgNoInt >= totPgCntInt){
			endPgNoInt = totPgCntInt;
		}

		model.addAttribute("totCntIntForListNo"+no, totCntInt);//총 목록 수
		model.addAttribute("totPgCntInt"+no, totPgCntInt);//총 페이지 수
		model.addAttribute("reqPgNoInt"+no, reqPgNoInt);//요청 페이지
		model.addAttribute("startPgNoInt"+no, startPgNoInt);//화면 페이징 시작 값
		model.addAttribute("endPgNoInt"+no, endPgNoInt);//화면 페이징 끝 값
		model.addAttribute("pgNm"+no, pgNm);//연결 리퀘스트 맵핑

		searchKeyMap.put("queryPgNoInt", queryPgNoInt);

		return sqlSession.selectList(listMapper, searchKeyMap);
	}//end of pageBasic1Search
	
	/*
	*********************************************************
	* Method ID		: pageBasicSamsungSearch
	* Method Name	: 페이지 기본 1
	* Arguments1	: int no - 하나의 jsp에 여러 페이징이 있을 경우, 구분을 위한 숫자
	* Arguments2	: SqlSession sqlSession - 조회를 위해 controller로부터 빌려온 mybatis 객체
	* Arguments3	: String listMapper - 페이징을 적용하여 조회해야하는 list sql mapper
	* Arguments4	: String reqPgNo - 조회를 요청받은 페이지 번호
	* Arguments5	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments6	: String pgNm - jsp에서 페이징에 html로 연결하여야하는 리퀘스트 맵핑 값
	* Arguments7	: HashMap<String, String> searchKeyMap - sql 실행에 필요한 조회 값
	* Description	: 페이지 모듈화
	* Author		: rjh
	* Date			: 2016.09.22.
	*********************************************************
	*/
	public Object pageBasicSamsungSearch(int no, SqlSession sqlSession, String listMapper, String reqPgNo, Model model, String pgNm, HashMap<String, Object> searchKeyMap){

		logger.info("======= pageBasicSamsungSearch =======");

		if(reqPgNo == null || reqPgNo.trim().equals("")){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * 17) - 17;//sql limit에 적용할 값

		int totCntInt = sqlSession.selectOne(listMapper+"Cnt", searchKeyMap);//총 조회 건수
		int totPgCntInt = (int) (totCntInt / 17);//총 페이지 수
		if((totCntInt % 17) != 0){
			totPgCntInt = totPgCntInt + 1;
		}

		int startPgNoInt = 1;//화면 페이징 시작 값
		if(reqPgNo.length() >= 2){
			String tmpStr = reqPgNo.substring(reqPgNo.length()-1, reqPgNo.length());
			if(tmpStr.equals("0")){
				startPgNoInt = reqPgNoInt - 10 + 1;
			}else{
				startPgNoInt = reqPgNoInt - Integer.parseInt(tmpStr) + 1;
			}
		}

		int endPgNoInt = startPgNoInt + 9;//화면 페이징 끝 값
		if(endPgNoInt >= totPgCntInt){
			endPgNoInt = totPgCntInt;
		}

		model.addAttribute("totPgCntInt"+no, totPgCntInt);//총 페이지 수
		model.addAttribute("reqPgNoInt"+no, reqPgNoInt);//요청 페이지
		model.addAttribute("startPgNoInt"+no, startPgNoInt);//화면 페이징 시작 값
		model.addAttribute("endPgNoInt"+no, endPgNoInt);//화면 페이징 끝 값
		model.addAttribute("pgNm"+no, pgNm);//연결 리퀘스트 맵핑

		searchKeyMap.put("queryPgNoInt", queryPgNoInt);

		return sqlSession.selectList(listMapper, searchKeyMap);
	}//end of pageBasic1Search
	
	/*
	*********************************************************
	* Method ID		: pageBasic3
	* Method Name	: 페이지 기본 3
	* Arguments1	: int no - 하나의 jsp에 여러 페이징이 있을 경우, 구분을 위한 숫자
	* Arguments2	: SqlSession sqlSession - 조회를 위해 controller로부터 빌려온 mybatis 객체
	* Arguments3	: String listMapper - 페이징을 적용하여 조회해야하는 list sql mapper
	* Arguments4	: String reqPgNo - 조회를 요청받은 페이지 번호
	* Arguments5	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments6	: String pgNm - jsp에서 페이징에 html로 연결하여야하는 리퀘스트 맵핑 값
	* Arguments7	: String pgSize - jsp에서 한페지이에 보여줘야할 페이지 크기
	* Description	: 페이지 모듈화
	* Author		: top3009
	* Date			: 2020.07.13
	*********************************************************
	*/
	public int pageBasic3(int no, int totCntInt, String reqPgNo, Model model, String pgNm, int pgSize){

		logger.info("======= pageBasic3 =======");

		if(reqPgNo == null){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * pgSize) - pgSize;//sql limit에 적용할 값

		int totPgCntInt = (int) (totCntInt / pgSize);//총 페이지 수
		if((totCntInt % pgSize) != 0){
			totPgCntInt = totPgCntInt + 1;
		}

		int startPgNoInt = 1;//화면 페이징 시작 값
		if(reqPgNo.length() >= 2){
			String tmpStr = reqPgNo.substring(reqPgNo.length()-1, reqPgNo.length());
			if(tmpStr.equals("0")){
				startPgNoInt = reqPgNoInt - 10 + 1;
			}else{
				startPgNoInt = reqPgNoInt - Integer.parseInt(tmpStr) + 1;
			}
		}

		int endPgNoInt = startPgNoInt + 9;//화면 페이징 끝 값
		if(endPgNoInt >= totPgCntInt){
			endPgNoInt = totPgCntInt;
		}

		model.addAttribute("totPgCntInt"+no, totPgCntInt);//총 페이지 수
		model.addAttribute("reqPgNoInt"+no, reqPgNoInt);//요청 페이지
		model.addAttribute("startPgNoInt"+no, startPgNoInt);//화면 페이징 시작 값
		model.addAttribute("endPgNoInt"+no, endPgNoInt);//화면 페이징 끝 값
		model.addAttribute("pgNm"+no, pgNm);//연결 리퀘스트 맵핑
		model.addAttribute("pgSize", pgSize);//화면 내 페이지 크기

		return queryPgNoInt;
	}

	/*
	*********************************************************
	* Method ID		: pageBasic2
	* Method Name	: 페이지 기본 2
	* Arguments1	: int no - 하나의 jsp에 여러 페이징이 있을 경우, 구분을 위한 숫자
	* Arguments2	: SqlSession sqlSession - 조회를 위해 controller로부터 빌려온 mybatis 객체
	* Arguments3	: String listMapper - 페이징을 적용하여 조회해야하는 list sql mapper
	* Arguments4	: String reqPgNo - 조회를 요청받은 페이지 번호
	* Arguments5	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments6	: String pgNm - jsp에서 페이징에 html로 연결하여야하는 리퀘스트 맵핑 값
	* Description	: 페이지 모듈화
	* Author		: rjh
	* Date			: 2016.04.11.
	*********************************************************
	*/
	public int pageBasic2(int no, int totCntInt, String reqPgNo, Model model, String pgNm){

		logger.info("======= pageBasic2 =======");

		if(reqPgNo == null){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * 18) - 18;//sql limit에 적용할 값

		int totPgCntInt = (int) (totCntInt / 18);//총 페이지 수
		if((totCntInt % 18) != 0){
			totPgCntInt = totPgCntInt + 1;
		}

		int startPgNoInt = 1;//화면 페이징 시작 값
		if(reqPgNo.length() >= 2){
			String tmpStr = reqPgNo.substring(reqPgNo.length()-1, reqPgNo.length());
			if(tmpStr.equals("0")){
				startPgNoInt = reqPgNoInt - 10 + 1;
			}else{
				startPgNoInt = reqPgNoInt - Integer.parseInt(tmpStr) + 1;
			}
		}

		int endPgNoInt = startPgNoInt + 9;//화면 페이징 끝 값
		if(endPgNoInt >= totPgCntInt){
			endPgNoInt = totPgCntInt;
		}

		model.addAttribute("totPgCntInt"+no, totPgCntInt);//총 페이지 수
		model.addAttribute("reqPgNoInt"+no, reqPgNoInt);//요청 페이지
		model.addAttribute("startPgNoInt"+no, startPgNoInt);//화면 페이징 시작 값
		model.addAttribute("endPgNoInt"+no, endPgNoInt);//화면 페이징 끝 값
		model.addAttribute("pgNm"+no, pgNm);//연결 리퀘스트 맵핑

		return queryPgNoInt;
	}//end of pageBasic1

	/*
	*********************************************************
	* Method ID		: pageBasicPop1
	* Method Name	: 팝업창의 페이지 기본 1 
	* Arguments1	: int no - 하나의 jsp에 여러 페이징이 있을 경우, 구분을 위한 숫자
	* Arguments2	: SqlSession sqlSession - 조회를 위해 controller로부터 빌려온 mybatis 객체
	* Arguments3	: String listMapper - 페이징을 적용하여 조회해야하는 list sql mapper
	* Arguments4	: String reqPgNo - 조회를 요청받은 페이지 번호
	* Arguments5	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments6	: String pgNm - jsp에서 페이징에 html로 연결하여야하는 리퀘스트 맵핑 값
	* Description	: 페이지 모듈화
	* Author		: lsh
	* Date			: 2016.04.18.
	*********************************************************
	*/
	public Object pageBasicPop1(int no, SqlSession sqlSession, String listMapper, String reqPgNo, Model model, String pgNm,String user_no){

		logger.info("======= pageBasicPop1 =======");

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int pn = 0;
		if(pgNm.equals("myCertList")){
			pn = 17;
		}else{
			pn = 14;
		}

		if(reqPgNo == null){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * pn) - pn;//sql limit에 적용할 값
		
		int totCntInt =0;
		
		if(pgNm.equals("myCertList")){
			totCntInt = sqlSession.selectOne(listMapper+"Cnt",user_no);//총 조회 건수
		}else{
			totCntInt = sqlSession.selectOne(listMapper+"Cnt");//총 조회 건수
		}

		int totPgCntInt = (int) (totCntInt / pn);//총 페이지 수
		if((totCntInt % pn) != 0){
			totPgCntInt = totPgCntInt + 1;
		}
		
		/*if((totCntInt % 10) != 0){
			totPgCntInt = totPgCntInt + 1;
		}*/
		
		if(pgNm.equals("myCertList")){
			map.put("user_no", user_no);
			map.put("queryPgNoInt",  queryPgNoInt);
		}
		

		int startPgNoInt = 1;//화면 페이징 시작 값
		if(reqPgNo.length() >= 2){
			String tmpStr = reqPgNo.substring(reqPgNo.length()-1, reqPgNo.length());
			if(tmpStr.equals("0")){
				startPgNoInt = reqPgNoInt - 10 + 1;
			}else{
				startPgNoInt = reqPgNoInt - Integer.parseInt(tmpStr) + 1;
			}
		}

		int endPgNoInt = startPgNoInt + 9;//화면 페이징 끝 값
		if(endPgNoInt >= totPgCntInt){
			endPgNoInt = totPgCntInt;
		}

		model.addAttribute("totPgCntInt", totPgCntInt);//총 페이지 수
		model.addAttribute("reqPgNoInt", reqPgNoInt);//요청 페이지
		model.addAttribute("startPgNoInt", startPgNoInt);//화면 페이징 시작 값
		model.addAttribute("endPgNoInt", endPgNoInt);//화면 페이징 끝 값
		model.addAttribute("pgNm", pgNm);//연결 리퀘스트 맵핑

		if(pgNm.equals("myCertList")){
			return sqlSession.selectList(listMapper, map);
		}else{
			return sqlSession.selectList(listMapper, queryPgNoInt);
		}
	}// end of pageBasicPop1

}//end of class
