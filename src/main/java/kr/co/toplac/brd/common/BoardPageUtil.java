package kr.co.toplac.brd.common;

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
public class BoardPageUtil {

	private static final Logger logger = LoggerFactory.getLogger(BoardPageUtil.class);

	/*
	*********************************************************
	* Method ID		: boardPageBasic1
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
	public Object boardPageBasic1(int no, SqlSession sqlSession, String listMapper, String reqPgNo, Model model, String pgNm){
		logger.info("======= boardPageBasic1 =======");

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

		model.addAttribute("totPgCntInt"+no, totPgCntInt);//총 페이지 수
		model.addAttribute("reqPgNoInt"+no, reqPgNoInt);//요청 페이지
		model.addAttribute("startPgNoInt"+no, startPgNoInt);//화면 페이징 시작 값
		model.addAttribute("endPgNoInt"+no, endPgNoInt);//화면 페이징 끝 값
		model.addAttribute("pgNm"+no, pgNm);//연결 리퀘스트 맵핑

		return sqlSession.selectList(listMapper, queryPgNoInt);
	}//end of boardPageBasic1

	/*
	*********************************************************
	* Method ID		: boardPageSearch1
	* Method Name	: 페이지 기본 1
	* Arguments1	: int no - 하나의 jsp에 여러 페이징이 있을 경우, 구분을 위한 숫자
	* Arguments2	: SqlSession sqlSession - 조회를 위해 controller로부터 빌려온 mybatis 객체
	* Arguments3	: String listMapper - 페이징을 적용하여 조회해야하는 list sql mapper
	* Arguments4	: BoardSearchVO searchVO - 검색 조회 조건
	* Arguments5	: String reqPgNo - 조회를 요청받은 페이지 번호
	* Arguments6	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments7	: String pgNm - jsp에서 페이징에 html로 연결하여야하는 리퀘스트 맵핑 값
	* Description	: 페이지 모듈화
	* Author		: rjh
	* Date			: 2016.04.11.
	*********************************************************
	*/
	public Object boardPageSearch1(int no, SqlSession sqlSession, String listMapper, BoardSearchVO searchVO, Model model, String pgNm){
		logger.info("======= boardPageSearch1 =======");

		String reqPgNo = searchVO.getReqPgNo();
		if(reqPgNo == null || reqPgNo.trim().equals("")){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * 18) - 18;//sql limit에 적용할 값

		int totCntInt = sqlSession.selectOne(listMapper+"Cnt", searchVO);//총 조회 건수
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

		searchVO.setQueryPgNoInt(queryPgNoInt);
		return sqlSession.selectList(listMapper, searchVO);
	}//end of boardPageSearch1
	
	/**
	 * 15개짜리 목록 추가
	 * @param no
	 * @param sqlSession
	 * @param listMapper
	 * @param searchVO
	 * @param model
	 * @param pgNm
	 * @return
	 */
	public Object boardPageSearch2(int no, SqlSession sqlSession, String listMapper, BoardSearchVO searchVO, Model model, String pgNm){
		logger.info("======= boardPageSearch2 =======");

		String reqPgNo = searchVO.getReqPgNo();
		if(reqPgNo == null || reqPgNo.trim().equals("")){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * 15) - 15;//sql limit에 적용할 값

		int totCntInt = sqlSession.selectOne(listMapper+"Cnt", searchVO);//총 조회 건수
		int totPgCntInt = (int) (totCntInt / 15);//총 페이지 수
		if((totCntInt % 15) != 0){
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

		searchVO.setQueryPgNoInt(queryPgNoInt);
		return sqlSession.selectList(listMapper, searchVO);
	}//end of boardPageSearch2
	
	public Object boardPageSearch3(int no, SqlSession sqlSession, String listMapper, BoardSearchVO searchVO, Model model, String pgNm){
		logger.info("======= boardPageSearch3 =======");

		String reqPgNo = searchVO.getReqPgNo();
		if(reqPgNo == null || reqPgNo.trim().equals("")){reqPgNo = "1";}
		int reqPgNoInt = Integer.parseInt(reqPgNo);
		int queryPgNoInt = (reqPgNoInt * 10) - 10;//sql limit에 적용할 값

		int totCntInt = sqlSession.selectOne(listMapper+"Cnt", searchVO);//총 조회 건수
		int totPgCntInt = (int) (totCntInt / 10);//총 페이지 수
		if((totCntInt % 10) != 0){
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

		searchVO.setQueryPgNoInt(queryPgNoInt);
		return sqlSession.selectList(listMapper, searchVO);
	}

}//end of class
