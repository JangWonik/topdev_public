package kr.co.toplac.util.sms;

import kr.co.toplac.cmm.util.SessionUtil;
import kr.co.toplac.topsuim.SuimRptCompositeVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.util.cmm.RequestUtil;
import kr.co.toplac.util.cmm.StringUtil;
import kr.co.toplac.util.etc.Damo;
import kr.co.toplac.util.file.GetImageBase64;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by kohyeonseok on 2017. 8. 10..
 */
@Controller
public class SuimMMSController {
    private static final Logger logger = LoggerFactory.getLogger(SuimMMSController.class);
    private static final String UPLOAD_PATH_MMS = "/home/hosting_users/toplac/www/ls_data/member_mms/";
    //private static final String UPLOAD_PATH_MMS = "/Users/kohyeonseok/devroot/91.devUpload/toplac/hosting_users/toplac/www/ls_data/member_mms/";

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping(value = "/suim_mms_write")
    public String mmsWrite(HttpServletRequest request, Model model){
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suimRptNo = StringUtil.null2blank(request.getParameter("suim_rpt_no"));
        String type = StringUtil.null2blank(request.getParameter("type"));
        //===============================================
        //  권한 체크
        //===============================================
        // auth = 0 정상
        // auth = 1 로그인 사용자가 처리담당자가 아님
        // auth = 2 사용자의 MMS 이미지가 등록되어 있지 않음
        // auth = 3 파라미터가 잘못됐음
        //===============================================
        int auth = 0;

        if ("".equals(suimRptNo) || "".equals(type)){
            auth = 3;
            model.addAttribute("auth", auth);
            return "util_sms/suim_mms_write";
        }

        //===============================================
        //  로그인 사용자 정보
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        //===============================================
        //  수임기본정보 가져오기
        //===============================================
        Map<String, String> suimVo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        if (suimVo == null){
            auth = 3;
            model.addAttribute("auth", auth);
            return "util_sms/suim_mms_write";
        }
        String user_no = String.valueOf(suimVo.get("userNo"));

        //===============================================
        //  처리담당자 와 로그인사용자 비교
        //===============================================
        if (!user_no.equals(mbrVo.getUser_no())){
            auth = 1;
            model.addAttribute("auth", auth);
            return "util_sms/suim_mms_write";
        }

        //===============================================
        //  사용자 정보 가져오기 -> MMS picture 정보
        //===============================================
        TopMbrBscVO memberVo = sqlSession.selectOne("MyInfoUdtMapper.myinfo", user_no);
        if (memberVo.getMmsPicture() == null || "".equals(memberVo.getMmsPicture())){
            auth = 2;
            model.addAttribute("auth", auth);
            return "util_sms/suim_mms_write";
        }

        //===============================================
        // 계약자 피보험자 보험사 담당자 전화번호 복호화 진행
        //===============================================
        String message = "";
        Damo damo = new Damo();

        String policyholderTel = suimVo.get("policyholderTel");
        String beneficiaryTel = suimVo.get("beneficiaryTel");
        String ptnrMbrHp = suimVo.get("ptnrMbrHp");

        if (policyholderTel != null && !"".equals(policyholderTel)){
            suimVo.put("policyholderTel",damo.decodeDamo(policyholderTel));
        }
        if (beneficiaryTel != null && !"".equals(beneficiaryTel)){
            suimVo.put("beneficiaryTel",damo.decodeDamo(beneficiaryTel));
        }
        if (ptnrMbrHp != null && !"".equals(ptnrMbrHp)){
            suimVo.put("ptnrMbrHp",damo.decodeDamo(ptnrMbrHp));
        }
        
        System.out.println(memberVo.getTeam_telephone());
        System.out.println(memberVo.getOffice_tel());
        System.out.println(memberVo.getHandphone());
        

        //===============================================
        // 메시지 처리
        //===============================================
        if ("1".equals(type)){
            message = "안녕하십니까? "
                    + suimVo.get("ptnrMbrNm") + "담당자님의 " + suimVo.get("policyholderNm") + "고객 "
                    + "위임건에 대한 손해사정 업무를 담당하게 된, 탑손해사정(주) "
                    + memberVo.getUser_name()
                    + "입니다. 금번 위임건을 신속하고 정확하게 처리할 수 있도록 최선을 다하겠습니다."
                    + "<br/>담당자 직통번호 : " + memberVo.getOffice_tel()
                    + "<br/>담당자 휴대전화 : " + memberVo.getHandphone()
                    + "<br/>담당부서 전화번호 : " + memberVo.getTeam_telephone()
                    + "";
        } else if ("2".equals(type)){
            message = "안녕하십니까? "
                    + suimVo.get("policyholderNm")
                    + "고객님의 보험사고에 대한 손해사정 업무를 담당하게 된, 탑손해사정(주) "
                    + memberVo.getUser_name()
                    + "입니다. "
                    + suimVo.get("policyholderNm") + "고객님의 보험사고를 신속하게 처리할 수 있도록 최선을 다하겠습니다."
                    + "<br/>담당자 직통번호 : " + memberVo.getOffice_tel()
                    + "<br/>담당자 휴대전화 : " + memberVo.getHandphone()
                    + "<br/>담당부서 전화번호 : " + memberVo.getTeam_telephone()                 
                    + "";
        } else if ("3".equals(type)){
            message = "안녕하십니까? "
                    + suimVo.get("beneficiaryNm")
                    + "고객님의 보험사고에 대한 손해사정 업무를 담당하게 된, 탑손해사정(주) "
                    + memberVo.getUser_name()
                    + "입니다. "
                    + suimVo.get("beneficiaryNm") + "고객님의 보험사고를 신속하게 처리할 수 있도록 최선을 다하겠습니다."
                    + "<br/>담당자 직통번호 : " + memberVo.getOffice_tel()
                    + "<br/>담당자 휴대전화 : " + memberVo.getHandphone()
                    + "<br/>담당부서 전화번호 : " + memberVo.getTeam_telephone()                  
                    + "";
        }


        //=====================================================
        //  MMS 이미지
        //=====================================================
        GetImageBase64 imageUtil = new GetImageBase64();
        if (memberVo.getMmsPicture() != null && !"".equals(memberVo.getMmsPicture())){
            String dbpath = UPLOAD_PATH_MMS + memberVo.getMmsPicture();
            String fileType = dbpath.substring(dbpath.lastIndexOf(".")+1, dbpath.length());
            model.addAttribute("mmsImageBase64", imageUtil.imageBase64Small(dbpath, fileType));
        }else{
            model.addAttribute("mmsImageBase64", "");
        }


        //===============================================
        //  발송 리스트 가져오기
        //===============================================
        List<Map<String, Object>> sendList = sqlSession.selectList("SimpleSMSMapper.selectTopRptMmsList", paramMap);

        for (Map<String, Object> item : sendList) {
            item.put("recptnMbtlnum", damo.decodeDamo(String.valueOf(item.get("recptnMbtlnum"))));
            item.put("sndngMbtlnum", damo.decodeDamo(String.valueOf(item.get("sndngMbtlnum"))));
        }

        model.addAttribute("auth", auth);
        model.addAttribute("message", message);
        model.addAttribute("suimVo", suimVo);
        model.addAttribute("memberVo", memberVo);
        model.addAttribute("sendList", sendList);

        return "util_sms/suim_mms_write";
    }

    @RequestMapping("/suim_mms_insert")
    public @ResponseBody Map<String, Object> mmsInsert(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<>();
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        String suimRptNo = StringUtil.null2blank(request.getParameter("suim_rpt_no"));
        String type = StringUtil.null2blank(request.getParameter("type"));
        String call_to = StringUtil.null2blank(request.getParameter("call_to"));
        String call_from = StringUtil.null2blank(request.getParameter("call_from"));

        //===============================================
        //  권한 체크
        //===============================================
        // auth = 0 정상
        // auth = 1 로그인 사용자가 처리담당자가 아님
        // auth = 2 사용자의 MMS 이미지가 등록되어 있지 않음
        // auth = 3 파라미터가 잘못됐음
        //===============================================
        int auth = 0;


        if ("".equals(suimRptNo) || "".equals(type) || "".equals(call_to) || "".equals(call_from)){
            auth = 3;
            resultMap.put("RSLT_CODE", auth);
            return resultMap;
        }

        //===============================================
        //  로그인 사용자 정보
        //===============================================
        TopMbrBscVO mbrVo = (TopMbrBscVO) SessionUtil.getAuthenticatedUser();

        //===============================================
        //  수임기본정보 가져오기
        //===============================================
        Map<String, String> suimVo = sqlSession.selectOne("SuimReportMapper.selectSuimReport", paramMap);

        if (suimVo == null){
            auth = 3;
            resultMap.put("RSLT_CODE", auth);
            return resultMap;
        }

        String user_no = String.valueOf(suimVo.get("userNo"));

        //===============================================
        //  처리담당자 와 로그인사용자 비교
        //===============================================
        if (!user_no.equals(mbrVo.getUser_no())){
            auth = 1;
            resultMap.put("RSLT_CODE", auth);
            return resultMap;
        }

        //===============================================
        //  사용자 정보 가져오기 -> MMS picture 정보
        //===============================================
        TopMbrBscVO memberVo = sqlSession.selectOne("MyInfoUdtMapper.myinfo", user_no);
        if (memberVo.getMmsPicture() == null || "".equals(memberVo.getMmsPicture())){
            auth = 2;
            resultMap.put("RSLT_CODE", auth);
            return resultMap;
        }

        //===============================================
        // 계약자 피보험자 보험사 담당자 전화번호 복호화 진행
        //===============================================
        String message = "";
        Damo damo = new Damo();

//        String policyholderTel = suimVo.get("policyholderTel");
//        String beneficiaryTel = suimVo.get("beneficiaryTel");
//        String ptnrMbrHp = suimVo.get("ptnrMbrHp");
//        String decPolicyholderTel = "";
//        String decBeneficiaryTel = "";
//        String decPtnrMbrHp = "";
//
//        if (policyholderTel != null && !"".equals(policyholderTel)){
//            decPolicyholderTel = damo.decodeDamo(policyholderTel).replace("-","");
//        }
//        if (beneficiaryTel != null && !"".equals(beneficiaryTel)){
//            decBeneficiaryTel = damo.decodeDamo(beneficiaryTel).replace("-","");
//        }
//        if (ptnrMbrHp != null && !"".equals(ptnrMbrHp)){
//            decPtnrMbrHp = damo.decodeDamo(ptnrMbrHp).replace("-","");
//        }


        //===============================================
        // 메시지 처리
        // type 1: 보험사 담당자 2: 계약자 3: 피보험자
        //===============================================
        if ("1".equals(type)){
            message = "안녕하십니까? "
                    + suimVo.get("ptnrMbrNm") + "담당자님의 " + suimVo.get("policyholderNm") + "고객 "
                    + "위임건에 대한 손해사정 업무를 담당하게 된, 탑손해사정(주) "
                    + memberVo.getUser_name()
                    + "입니다. 금번 위임건을 신속하고 정확하게 처리할 수 있도록 최선을 다하겠습니다."
                    + "\n담당자 직통번호 : " + memberVo.getOffice_tel()
                    + "\n담당자 휴대전화 : " + memberVo.getHandphone()
                    + "\n담당부서 전화번호 : " + memberVo.getTeam_telephone()                    
                    + "";
        } else if ("2".equals(type)){
            message = "안녕하십니까? "
                    + suimVo.get("policyholderNm")
                    + "고객님의 보험사고에 대한 손해사정 업무를 담당하게 된, 탑손해사정(주) "
                    + memberVo.getUser_name()
                    + "입니다. "
                    + suimVo.get("policyholderNm") + "고객님의 보험사고를 신속하게 처리할 수 있도록 최선을 다하겠습니다."
                    + "\n담당자 직통번호 : " + memberVo.getOffice_tel()
                    + "\n담당자 휴대전화 : " + memberVo.getHandphone()
                    + "\n담당부서 전화번호 : " + memberVo.getTeam_telephone()                    
                    + "";
        } else if ("3".equals(type)){
            message = "안녕하십니까? "
                    + suimVo.get("beneficiaryNm")
                    + "고객님의 보험사고에 대한 손해사정 업무를 담당하게 된, 탑손해사정(주) "
                    + memberVo.getUser_name()
                    + "입니다. "
                    + suimVo.get("beneficiaryNm") + "고객님의 보험사고를 신속하게 처리할 수 있도록 최선을 다하겠습니다."
                    + "\n담당자 직통번호 : " + memberVo.getOffice_tel()
                    + "\n담당자 휴대전화 : " + memberVo.getHandphone()
                    + "\n담당부서 전화번호 : " + memberVo.getTeam_telephone()                    
                    + "";
        }


        //===============================================
        // MMS_CONTENTS_INFO insert
        //===============================================
        paramMap.put("file_cnt", "2");
        paramMap.put("mms_subject", "제목없음");
        paramMap.put("mms_body", message);
        paramMap.put("file_type1", "IMG");
        paramMap.put("file_name1", UPLOAD_PATH_MMS + memberVo.getMmsPicture());
        paramMap.put("service_dep1", "ALL");

        try {
            int result = sqlSession.insert("SimpleSMSMapper.insertMmsContentsInfo", paramMap);
            System.out.println("result:["+result+"]");
        }catch (Exception ex){
            ex.printStackTrace();
            resultMap.put("RSLT_CODE", "1010");
            return resultMap;
        }

        //===============================================
        // MSG_DATA 입력
        //===============================================
        paramMap.put("user_no", user_no);
        paramMap.put("cur_state", "0");
        paramMap.put("sms_txt", "");
        paramMap.put("msg_type", "6");

        try {
            int result = sqlSession.insert("insertMsgData", paramMap);
            System.out.println("result:["+result+"]");
        }catch (Exception ex) {
            ex.printStackTrace();
            resultMap.put("RSLT_CODE", "1020");
            return resultMap;
        }

        //===============================================
        // 발송 로그 입력
        //===============================================
        try {
            //암호화 된걸로 넣어야 되서 다시 체크
//            if ("1".equals(type)){
//                paramMap.put("call_to", ptnrMbrHp);
//            }else if("2".equals(type)){
//                paramMap.put("call_to", policyholderTel);
//            }else if("3".equals(type)){
//                paramMap.put("call_to", beneficiaryTel);
//            }
            paramMap.put("call_to", damo.encodeDamo(call_to));
            paramMap.put("call_from", damo.encodeDamo(call_from));


            sqlSession.insert("SimpleSMSMapper.insertTopRptMms", paramMap);
        }catch (Exception ex){
            ex.printStackTrace();
            resultMap.put("RSLT_CODE", "1030");
            return resultMap;
        }

        resultMap.put("RSLT_CODE", "0");
        return resultMap;
    }

}
