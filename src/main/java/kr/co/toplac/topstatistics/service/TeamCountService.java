package kr.co.toplac.topstatistics.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.toplac.topgeneral.EmpNmlstVO;
import kr.co.toplac.util.cmm.DateUtil;

@Service
public class TeamCountService {
	
	//private static final Logger logger = LoggerFactory.getLogger(WorkloadService.class);

    @Autowired
    SqlSession sqlSession;
    
    /**
     * 일별 팀별 장비갯수를 카운트하기위한 배치
     */
    public void updateTeamEquipmentCnt() {
    	
    	String sBase_date = DateUtil.getTodayString("yyyy-MM-dd");    	
    	
    	List<Map<String, Object>> equipmentTeamList = sqlSession.selectList("ItMgmtMapper.getAllTeamListByEquipmentSchedule");
    	
    	Map<String, Object> teamMap = new HashMap<String, Object>();
    	
    	int nChk = 0;
    	
    	for( int i=0; i < equipmentTeamList.size(); i++ ) {
    		
    		teamMap = equipmentTeamList.get(i);
    		teamMap.put("base_date", sBase_date);
    		
    		nChk = sqlSession.selectOne("ItMgmtMapper.getTeamEquipmentScheduleChk", teamMap);
    		
    		if( nChk == 0 ) {		//기존 등록 값이 없을때 Insert 한다.
    			sqlSession.insert("ItMgmtMapper.insertTeamEquipmentSchedule", teamMap);
    		}    		
    		
    	}
    	
    }
    
    /**
     * 일별 팀인원수를 카운트 하기위한 배치 
     */
    public void updateTeamCnt(){    	
    	
    	String sBase_date = DateUtil.getTodayString("yyyy-MM-dd");
    	//System.out.println("sBase_date="+sBase_date);
    	
    	//기존에 해당 날짜로 들어간 데이터가 있는지 확인한다.
    	int nCnt = 0;
    	
    	//체크
    	nCnt = sqlSession.selectOne("EmpNmlstTmListMapper.countTeamCnt", sBase_date);
    	
    	//업무지원 인원 추가를 위한 임시 변수
    	String sWorkTeamid = "";
    	String sWorkTeamlevel = "";
    	String sWorkTeamgrouporder = "";
    	int nSub_memberCnt = 0;
    	
    	if( nCnt == 0 ) {		//기존에 입력된 카운트가 없을때만 실행된다.
    		//countTeamCnt
        	List<EmpNmlstVO> teamList_1 = sqlSession.selectList("EmpNmlstTmListMapper.getExpenseTeam1");    	
        	
        	Map<String, Object> teamMap = new HashMap<String, Object>();
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	
        	int member_cnt = 0;
        	
        	for (int i = 0; i < teamList_1.size(); i++) {    			
    			
    			sWorkTeamid = teamList_1.get(i).getTeam_id().toString();
    			
    			teamMap.put("team_id", teamList_1.get(i).getTeam_id());
    			teamMap.put("team_level", teamList_1.get(i).getTeam_level());
    			teamMap.put("team_group_order",teamList_1.get(i).getTeam_group_order());
    			teamMap.put("team_order", teamList_1.get(i).getTeam_order());
    			teamMap.put("team_name", teamList_1.get(i).getTeam_name());
    			teamMap.put("team_manager", teamList_1.get(i).getTeam_manager());
    			teamMap.put("team_sector", teamList_1.get(i).getTeam_sector());
    			teamMap.put("team_center", teamList_1.get(i).getTeam_center());    			
    			teamMap.put("base_date", sBase_date);
    			
    			//배상1센터, 정책1센터, 정책2센터, 전문인 배상센터는 업무지원 인원을 카운트에 추가한다. 
    			if( "35".equals(sWorkTeamid) || "77".equals(sWorkTeamid) || "34".equals(sWorkTeamid) || "73".equals(sWorkTeamid) || "1800".equals(sWorkTeamid) || "1810".equals(sWorkTeamid) || "194".equals(sWorkTeamid) || "195".equals(sWorkTeamid) ) {    				
    				//해당팀의 업무지원 인원카운트를 가져온다.
    				sWorkTeamlevel = teamList_1.get(i).getTeam_level().toString();
    				sWorkTeamgrouporder = teamList_1.get(i).getTeam_group_order();
    				
    				if( "0".equals(sWorkTeamlevel) ) {
    					//센터로 카운트 처리
    					paramMap.put("team_group_order", sWorkTeamgrouporder);    					
    					nSub_memberCnt = sqlSession.selectOne("EmpNmlstTmListMapper.getSubCenterMemberCnt", paramMap);
    					
    				}else {
    					//팀으로 카운트 처리
    					paramMap.put("team_id", sWorkTeamid);    					
    					nSub_memberCnt = sqlSession.selectOne("EmpNmlstTmListMapper.getSubTeamMemberCnt", paramMap);
    				}  
    				
    				member_cnt = Integer.parseInt(teamList_1.get(i).getCnt())+nSub_memberCnt;
    				
    				//인원수에서 자기자신은 뺀다. (센터장 본인미포함 > 포함으로 변경) 20200807
    				//if(member_cnt > 0) {
    					//member_cnt = member_cnt - 1;
    				//}
    				
    				teamMap.put("member_cnt", member_cnt);
    			}else {
    				    				
    				member_cnt = Integer.parseInt(teamList_1.get(i).getCnt());
    				
    				//인원수에서 자기자신은 뺀다. (센터장 본인미포함 > 포함으로 변경) 20200807
    				//if(member_cnt > 0) {
    					//member_cnt = member_cnt - 1;
    				//}
    				
    				teamMap.put("member_cnt", member_cnt);
    			}
    			
    			/*
    			 * System.out.println(teamList_1.get(i).getTeam_id() + " : " +
    			 * teamList_1.get(i).getTeam_level() + " : " +
    			 * teamList_1.get(i).getTeam_group_order() + " : " +
    			 * teamList_1.get(i).getTeam_name() + " : " +
    			 * teamList_1.get(i).getTeam_manager() + " : " +
    			 * teamList_1.get(i).getTeam_sector() + " : " +
    			 * teamList_1.get(i).getTeam_center() + " : " + teamList_1.get(i).getCnt() +
    			 * " : " + sBase_date);
    			 */
    			
    			sqlSession.insert("EmpNmlstTmListMapper.insertTeamCnt", teamMap);
    		}
    	}
    }
}
