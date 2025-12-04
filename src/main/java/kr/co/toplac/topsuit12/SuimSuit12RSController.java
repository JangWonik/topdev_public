package kr.co.toplac.topsuit12;

import java.io.File;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topsuim.SuimRegInsController;
import kr.co.toplac.topsuit.SuimSuit_10VO;
import kr.co.toplac.topteam.TopMbrAuthVO;
import kr.co.toplac.topteam.TopMbrBscVO;
import kr.co.toplac.topteam.TopTmBscVO;
import kr.co.toplac.util.page.PageUtilityBasic;

@Controller
public class SuimSuit12RSController {
	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(SuimSuit12RSController.class);

	public String Rpad(String str, int len, String addStr) {
		if(str == null){
			str = "";
		}
		byte[] bytTemp = null;
		int realLength = 0;
		
		try {
			bytTemp = str.getBytes("EUC-KR");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int iLength = bytTemp.length;


		for(int iIndex = 0; iIndex < iLength; iIndex++) {
			
			int iChar = (int)bytTemp[iIndex];
			
			if((iChar > 127)|| (iChar < 0)) {
				
				iIndex++;
				realLength++;
			}
			
			realLength++;
		}
		
		
        String result = str;
        int templen   = len - realLength; //result.length()

        for (int i = 0; i < templen; i++){
              result = result+addStr;
        }
        
        return result;
    }//Rpad

	@RequestMapping(value = "suit12RsList", method = RequestMethod.GET)
	public String suit12RsList(Model model, HttpServletResponse response, String viewFromDate, String viewToDate) { //param

		HashMap<String,String> map = new HashMap<String, String>();
		map.put("viewFromDate", viewFromDate);
		map.put("viewToDate", viewToDate);
		List<SuimSuit_12VO> getSuimSuit12Bsc = sqlSession.selectList("SuimSuit12ListMapper.getSuimSuit12Bsc", map);
		List<SuimSuit_12VO> getSuimSuit12Bld = sqlSession.selectList("SuimSuit12ListMapper.getSuimSuit12Bld", map);
		List<SuimSuit_12VO> getSuimSuit12Oj  = sqlSession.selectList("SuimSuit12ListMapper.getSuimSuit12Oj", map);

		String reponseStr = "";
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMdd");
		String filename = timeForNaming.format(today);

		for(int a = 0; a < getSuimSuit12Bsc.size() ; a++){
			reponseStr += "TOPIN";
			reponseStr += "HWINS";
			reponseStr += "11";
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRqDlFlgCd(), 2, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRqPptyRqDt(), 8, " ") ;
			reponseStr += filename;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRqPlNo(), 16, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRqRequSeqNo(), 3, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRqPlyNo(), 20, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRstPptyNvCpltYn(), 1, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRstUcNspRs(), 2, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRstNvRst(), 2, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRstNvRstCtn(), 200, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRstCclDt(), 8, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRstRptgFileCt(), 2, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRqBldCt(), 2, " ") ;
			reponseStr += Rpad(getSuimSuit12Bsc.get(a).getRqOjCt(), 2, " ") ;

			String basicSuimRptNo = getSuimSuit12Bsc.get(a).getSuimRptNo();
			int bulidingFlag = 0;
			for(int b = 0; b < getSuimSuit12Bld.size() ; b++){
				if(basicSuimRptNo.equals(getSuimSuit12Bld.get(b).getSuimRptNo())){
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRqBld_LctNo(), 8, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRqBld_OjSeqNo(), 5, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRqBld_BldSeqNo(), 5, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getUserName(), 20, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_RcnDt().replace("-", ""), 10, " ") ;
					reponseStr += Rpad("탑", 20, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_InvpsNm(), 20, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_CrRelpcRel(), 20, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_InvpsCntAd(), 20, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_RlOwrNm(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_CtnAdr(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_MngmBnNm(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_BldRnkCd(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_GrodEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_UndgEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_TtareEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_IsAreEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_IsTpEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_RlOwrNmEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_CtnAdrEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_MngmBnnmEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_BldRnkcdEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_GrodEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_UndgEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_TtareEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_IsAreEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_IsTpEtMtt(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_PleNm(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_RofNm(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_WllNm(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_PanlYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_PanlPst(), 100, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_TntYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_TntPst(), 100, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_FlrFirZoneYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_EtMtt1(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_FlrBtpUndg(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_FlrBtpFloor1(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_FlrBtpFloor2(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_FlrBtpFloor3(), 200, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_SlEqmtDcYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_MrkYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Bld.get(b).getRstBld_EtMtt2(), 200, " ") ;
					bulidingFlag++;
				}
			}
			for(int c = bulidingFlag; c < 2 ; c++){
				reponseStr += Rpad(" ", 3345, " ") ;
			}

			int objectFlag = 0;
			for(int d = 0; d < getSuimSuit12Oj.size(); d++){
				if(basicSuimRptNo.equals(getSuimSuit12Oj.get(d).getSuimRptNo())){
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRqOj_OjSeqNo(), 1, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRqOj_BldSeqNo(), 200, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRqOj_OjSign(), 200, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_OjTpEqalYn(), 200, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_RnkEqalYn(), 200, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_Dt_MttEqalYn(), 200, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_Dt_AccptPlcEqalYn(), 1, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_AccptPlcFlgcdEqalYn(), 1, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_FldstObjFlgcdEqalYn(), 200, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_UndgAccptYnEqalYn(), 1, " ") ;
//					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_EtMtt(), 200, " ") ; 
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRqOj_OjSeqNo(), 5, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRqOj_BldSeqNo(), 5, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRqOj_OjSign(), 5, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_OjTpEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_RnkEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_Dt_MttEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_Dt_AccptPlcEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_AccptPlcFlgcdEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_FldstObjFlgcdEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_UndgAccptYnEqalYn(), 1, " ") ;
					reponseStr += Rpad(getSuimSuit12Oj.get(d).getRstOj_EtMtt(), 200, " ") ; 
					objectFlag++;
				}
			}
			for(int e = objectFlag; e < 10 ; e++){
				reponseStr += Rpad(" ", 222, " ") ;
			}
			
			//보험 계약자 정보 추가 시작 (한화 요청사항으로 응답전문에는 데이터를 넣지 않는다.)
			//reponseStr += Rpad(getSuimSuit12Bsc.get(a).getPrHndphTlno(), 14," ");
			//보험 계약자 정보 추가 끝
			reponseStr += "\n";
		} 
		
		/*응답전문 내보낸 건들 락걸기*/
		sqlSession.update("SuimSuit12ListMapper.suit12lockAfterRsPrint",map);

		response.setHeader("Content-Disposition", "attachment;filename="+"TOPINHWINS_"+filename+"_1.dat");
		/*response.setHeader("Content-Description", "JSP Generated Data");*/
		response.setHeader("Content-Transfer-Encoding", "binary");

		model.addAttribute("reponseStr", reponseStr);

		return "top_suim_suit12/suit12_rpt_print_rs";	
		
	}//suit12RsList

}//class
