package kr.co.toplac.cmm.service;

import kr.co.toplac.sysadm.SysAdmCodeDic2VO;
import kr.co.toplac.sysadm.SysAdmCodeDicVO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by kohyeonseok on 2017. 8. 2..
 */
@Service
public class CodeDicService {
    private static final Logger logger = LoggerFactory.getLogger(CodeDicService.class);

    @Autowired
    SqlSession sqlSession;

    //codedic List 출력
    public List<SysAdmCodeDicVO> codeList(SysAdmCodeDicVO Vo){
        return sqlSession.selectList("CodeDicInsMapper.selectCodeList", Vo);
    }
    
    //codedic2 List 출력
    public List<SysAdmCodeDicVO> codeList2(SysAdmCodeDicVO Vo){
        return sqlSession.selectList("CodeDicInsMapper.selectCodeList2", Vo);
    }
    
    //codedic2의 col_cd2 리스트
    public List<SysAdmCodeDicVO> codeList3(SysAdmCodeDicVO Vo){
    	return sqlSession.selectList("CodeDicInsMapper.selectCodeList3", Vo);
    }
    
    //codedic의 1개 code value 값
    public SysAdmCodeDicVO selectCodeValue(SysAdmCodeDicVO Vo){
        return sqlSession.selectOne("CodeDicInsMapper.selectCodeValue", Vo);
    }
    
    //codedic2의 1개 code value 값
    public SysAdmCodeDicVO selectCode2Value(SysAdmCodeDicVO Vo){
        return sqlSession.selectOne("CodeDicInsMapper.selectCode2Value", Vo);
    }
    
    

}
