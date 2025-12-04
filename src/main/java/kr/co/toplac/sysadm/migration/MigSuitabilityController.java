package kr.co.toplac.sysadm.migration;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.toplac.topteam.TopMbrBscVO;

@Controller
public class MigSuitabilityController {

	@Autowired
	private SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(MigSuitabilityController.class);

	@RequestMapping(value = "/migSuitability", method = RequestMethod.GET)
	public String migSuitability(Model model, HttpSession session) {

		logger.info("======= migSuitability =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migSuitability - no permession user_no : " + session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		return "sys_adm_migration/mig_suitability";
	}//migSuitability

	@RequestMapping(value = "/migrationSuitability12Oj", method = RequestMethod.GET)
	public String migrationSuitability12Oj(Model model, HttpSession session) {

		logger.info("======= migrationSuitability12Oj =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationSuitability12Oj - no permession user_no : " + session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigSuitabilityUtilMapper.suitability12OjDeleteAll");

		//입력 대상 data 조회
		List<MigSuitability12OjVO> targetList = sqlSession.selectList("MigSuitabilityUtilMapper.migForSuitability12OjList");

		//data 입력
		MigSuitability12OjVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		MigSuitability12OjVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			int ridInt = tmpVO.getRid();
			int forCnt = tmpVO.getRqOjCt();
			String[] rqOj_OjSeqnoArr				=	tmpVO.getRqOj_OjSeqno().split("enterpoint");
			String[] rqOj_BldSeqnoArr				=	tmpVO.getRqOj_BldSeqno().split("enterpoint");
			String[] rqOj_OjSignArr					=	tmpVO.getRqOj_OjSign().split("enterpoint");
			String[] rqOj_OjTpArr					=	tmpVO.getRqOj_OjTp().split("enterpoint");
			String[] rqOj_RnkArr					=	tmpVO.getRqOj_Rnk().split("enterpoint");
			String[] rqOj_Dt_MttArr					=	tmpVO.getRqOj_Dt_Mtt().split("enterpoint");
			String[] rqOj_Dt_AccptPlcArr			=	tmpVO.getRqOj_Dt_AccptPlc().split("enterpoint");
			String[] rqOj_AccptPlcFlgcdArr			=	tmpVO.getRqOj_AccptPlcFlgcd().split("enterpoint");
			String[] rqOj_FldstObjFlgcdArr			=	tmpVO.getRqOj_FldstObjFlgcd().split("enterpoint");//야적물건 (미사용 추측)
			String[] rqOj_UndgAccptYnArr			=	tmpVO.getRqOj_UndgAccptYn().split("enterpoint");
			String[] rstOj_OjTpEqalYnArr			=	tmpVO.getRstOj_OjTpEqalYn().split("enterpoint");
			String[] rstOj_RnkEqalYnArr				=	tmpVO.getRstOj_RnkEqalYn().split("enterpoint");
			String[] rstOj_Dt_MttEqalYnArr			=	tmpVO.getRstOj_Dt_MttEqalYn().split("enterpoint");
			String[] rstOj_Dt_AccptPlcEqalYnArr		=	tmpVO.getRstOj_Dt_AccptPlcEqalYn().split("enterpoint");
			String[] rstOj_AccptPlcFlgcdEqalYnArr	=	tmpVO.getRstOj_AccptPlcFlgcdEqalYn().split("enterpoint");
			String[] rstOj_FldstObjFlgcdEqalYnArr	=	tmpVO.getRstOj_FldstObjFlgcdEqalYn().split("enterpoint");
			String[] rstOj_UndgAccptYnEqalYnArr		=	tmpVO.getRstOj_UndgAccptYnEqalYn().split("enterpoint");
			String[] rstOj_EtMttArr					=	tmpVO.getRstOj_EtMtt().split("enterpoint");
			for(int k = 0; k < forCnt; k++){
				inVO = new MigSuitability12OjVO();
				inVO.setSuim_rpt_no(""+ridInt);
				if(rqOj_OjSeqnoArr.length -1 >= k){
					inVO.setRqOj_OjSeqno(rqOj_OjSeqnoArr[k]);
				}
				if(rqOj_BldSeqnoArr.length -1 >= k){
					inVO.setRqOj_BldSeqno(rqOj_BldSeqnoArr[k]);
				}
				if(rqOj_OjSignArr.length -1 >= k){
					inVO.setRqOj_OjSign(rqOj_OjSignArr[k]);
				}
				if(rqOj_OjTpArr.length -1 >= k){
					inVO.setRqOj_OjTp(rqOj_OjTpArr[k]);
				}
				if(rqOj_RnkArr.length -1 >= k){
					inVO.setRqOj_Rnk(rqOj_RnkArr[k]);
				}
				if(rqOj_Dt_MttArr.length -1 >= k){
					inVO.setRqOj_Dt_Mtt(rqOj_Dt_MttArr[k]);
				}
				if(rqOj_Dt_AccptPlcArr.length -1 >= k){
					inVO.setRqOj_Dt_AccptPlc(rqOj_Dt_AccptPlcArr[k]);
				}
				if(rqOj_AccptPlcFlgcdArr.length -1 >= k){
					inVO.setRqOj_AccptPlcFlgcd(rqOj_AccptPlcFlgcdArr[k]);
				}
				if(rqOj_FldstObjFlgcdArr.length -1 >= k){
					inVO.setRqOj_FldstObjFlgcd(rqOj_FldstObjFlgcdArr[k]);//야적물건 (미사용 추측)
				}
				if(rqOj_UndgAccptYnArr.length -1 >= k){
					inVO.setRqOj_UndgAccptYn(rqOj_UndgAccptYnArr[k]);
				}
				if(rstOj_OjTpEqalYnArr.length -1 >= k){
					inVO.setRstOj_OjTpEqalYn(rstOj_OjTpEqalYnArr[k]);
				}
				if(rstOj_RnkEqalYnArr.length  -1 >= k){
					inVO.setRstOj_RnkEqalYn(rstOj_RnkEqalYnArr[k]);
				}
				if(rstOj_Dt_MttEqalYnArr.length  -1 >= k){
					inVO.setRstOj_Dt_MttEqalYn(rstOj_Dt_MttEqalYnArr[k]);
				}
				if(rstOj_Dt_AccptPlcEqalYnArr.length -1 >= k){
					inVO.setRstOj_Dt_AccptPlcEqalYn(rstOj_Dt_AccptPlcEqalYnArr[k]);
				}
				if(rstOj_AccptPlcFlgcdEqalYnArr.length -1 >= k){
					inVO.setRstOj_AccptPlcFlgcdEqalYn(rstOj_AccptPlcFlgcdEqalYnArr[k]);
				}
				if(rstOj_FldstObjFlgcdEqalYnArr.length -1 >= k){
					inVO.setRstOj_FldstObjFlgcdEqalYn(rstOj_FldstObjFlgcdEqalYnArr[k]);
				}
				if(rstOj_UndgAccptYnEqalYnArr.length -1 >= k){
					inVO.setRstOj_UndgAccptYnEqalYn(rstOj_UndgAccptYnEqalYnArr[k]);
				}
				if(rstOj_EtMttArr.length -1 >= k){
					inVO.setRstOj_EtMtt(rstOj_EtMttArr[k]);
				}
				sqlSession.insert("MigSuitabilityUtilMapper.migSuitability12OjWrite", inVO);
			}
		}

		return "sys_adm_migration/migration_print1_ok";
	}//migrationSuitability12Oj

	@RequestMapping(value = "/migrationSuitability12Bld", method = RequestMethod.GET)
	public String migrationSuitability12Bld(Model model, HttpSession session) {

		logger.info("======= migrationSuitability12Bld =======");

		/*세션 유효 검사 시작*/
		TopMbrBscVO mbrVo = (TopMbrBscVO) session.getAttribute("mbrVo_Session");
		if(mbrVo == null || !mbrVo.getUser_state().equals("9") ){
			logger.info("migrationSuitability12Bld - no permession user_no : " + session.getAttribute("user_no_Session"));
			session.invalidate();
			return "top_login/top_login";
		}
		/*세션 유효 검사 종료*/

		//기존 data 삭제
		sqlSession.delete("MigSuitabilityUtilMapper.suitability12BldDeleteAll");

		//입력 대상 data 조회
		List<MigSuitability12BldVO> targetList = sqlSession.selectList("MigSuitabilityUtilMapper.migForSuitability12BldList");

		//data 입력
		MigSuitability12BldVO tmpVO = null;
		String tmpStr = null;
		String [] tmpArr1 = null;
		MigSuitability12BldVO inVO = null;
		for(int i = 0; i < targetList.size(); i++){
			tmpVO = targetList.get(i);
			int ridInt = tmpVO.getRid();
			int forCnt = tmpVO.getRqBldCt();
			String[] arr_rqBld_Lctno			=	tmpVO.getRqBld_Lctno			().split("enterpoint");
			String[] arr_rqBld_OjSeqno			=	tmpVO.getRqBld_OjSeqno			().split("enterpoint");
			String[] arr_rqBld_BldSeqno			=	tmpVO.getRqBld_BldSeqno			().split("enterpoint");
			String[] arr_rqBld_RlOwrNm			=	tmpVO.getRqBld_RlOwrNm			().split("enterpoint");
			String[] arr_rqBld_CtnAdr			=	tmpVO.getRqBld_CtnAdr			().split("enterpoint");
			String[] arr_rqBld_MngmBnnm			=	tmpVO.getRqBld_MngmBnnm			().split("enterpoint");
			String[] arr_rqBld_BldRnkcd			=	tmpVO.getRqBld_BldRnkcd			().split("enterpoint");
			String[] arr_rqBld_Plenm			=	tmpVO.getRqBld_Plenm			().split("enterpoint");
			String[] arr_rqBld_Rofnm			=	tmpVO.getRqBld_Rofnm			().split("enterpoint");
			String[] arr_rqBld_Wllnm			=	tmpVO.getRqBld_Wllnm			().split("enterpoint");
			String[] arr_rqBld_Grod				=	tmpVO.getRqBld_Grod				().split("enterpoint");
			String[] arr_rqBld_Undg				=	tmpVO.getRqBld_Undg				().split("enterpoint");
			String[] arr_rqBld_Ttare			=	tmpVO.getRqBld_Ttare			().split("enterpoint");
			String[] arr_rqBld_IsAre			=	tmpVO.getRqBld_IsAre			().split("enterpoint");
			String[] arr_rqBld_IsTp				=	tmpVO.getRqBld_IsTp				().split("enterpoint");
			String[] arr_rqBld_BldXpnm			=	tmpVO.getRqBld_BldXpnm			().split("enterpoint");
			String[] arr_rstBld_Rcndt			=	tmpVO.getRstBld_Rcndt			().split("enterpoint");
			String[] arr_rstBld_InvpsNm			=	tmpVO.getRstBld_InvpsNm			().split("enterpoint");
			String[] arr_rstBld_CrRelpcRel		=	tmpVO.getRstBld_CrRelpcRel		().split("enterpoint");
			String[] arr_rstBld_InvpsCntad		=	tmpVO.getRstBld_InvpsCntad		().split("enterpoint");
			String[] arr_rstBld_RlOwrNm			=	tmpVO.getRstBld_RlOwrNm			().split("enterpoint");
			String[] arr_rstBld_CtnAdr			=	tmpVO.getRstBld_CtnAdr			().split("enterpoint");
			String[] arr_rstBld_MngmBnnm		=	tmpVO.getRstBld_MngmBnnm		().split("enterpoint");
			String[] arr_rstBld_BldRnkcd		=	tmpVO.getRstBld_BldRnkcd		().split("enterpoint");
			String[] arr_rstBld_GrodEqalYn		=	tmpVO.getRstBld_GrodEqalYn		().split("enterpoint");
			String[] arr_rstBld_UndgEqalYn		=	tmpVO.getRstBld_UndgEqalYn		().split("enterpoint");
			String[] arr_rstBld_TtareEqalYn		=	tmpVO.getRstBld_TtareEqalYn		().split("enterpoint");
			String[] arr_rstBld_IsAreEqalYn		=	tmpVO.getRstBld_IsAreEqalYn		().split("enterpoint");
			String[] arr_rstBld_IsTpEqalYn		=	tmpVO.getRstBld_IsTpEqalYn		().split("enterpoint");
			String[] arr_rstBld_RlOwrNmEtMtt	=	tmpVO.getRstBld_RlOwrNmEtMtt	().split("enterpoint");
			String[] arr_rstBld_CtnAdrEtMtt		=	tmpVO.getRstBld_CtnAdrEtMtt		().split("enterpoint");
			String[] arr_rstBld_MngmBnnmEtMtt	=	tmpVO.getRstBld_MngmBnnmEtMtt	().split("enterpoint");
			String[] arr_rstBld_BldRnkcdEtMtt	=	tmpVO.getRstBld_BldRnkcdEtMtt	().split("enterpoint");
			String[] arr_rstBld_GrodEtMtt		=	tmpVO.getRstBld_GrodEtMtt		().split("enterpoint");
			String[] arr_rstBld_UndgEtMtt		=	tmpVO.getRstBld_UndgEtMtt		().split("enterpoint");
			String[] arr_rstBld_TtareEtMtt		=	tmpVO.getRstBld_TtareEtMtt		().split("enterpoint");
			String[] arr_rstBld_IsAreEtMtt		=	tmpVO.getRstBld_IsAreEtMtt		().split("enterpoint");
			String[] arr_rstBld_IsTpEtMtt		=	tmpVO.getRstBld_IsTpEtMtt		().split("enterpoint");
			String[] arr_rstBld_Plenm			=	tmpVO.getRstBld_Plenm			().split("enterpoint");
			String[] arr_rstBld_Rofnm			=	tmpVO.getRstBld_Rofnm			().split("enterpoint");
			String[] arr_rstBld_Wllnm			=	tmpVO.getRstBld_Wllnm			().split("enterpoint");
			String[] arr_rstBld_PanlYn			=	tmpVO.getRstBld_PanlYn			().split("enterpoint");
			String[] arr_rstBld_PanlPst			=	tmpVO.getRstBld_PanlPst			().split("enterpoint");
			String[] arr_rstBld_TntYn			=	tmpVO.getRstBld_TntYn			().split("enterpoint");
			String[] arr_rstBld_TntPst			=	tmpVO.getRstBld_TntPst			().split("enterpoint");
			String[] arr_rstBld_FlrFirZoneYn	=	tmpVO.getRstBld_FlrFirZoneYn	().split("enterpoint");
			String[] arr_rstBld_EtMtt1			=	tmpVO.getRstBld_EtMtt1			().split("enterpoint");
			String[] arr_rstBld_FlrBtpUndg		=	tmpVO.getRstBld_FlrBtpUndg		().split("enterpoint");
			String[] arr_rstBld_FlrBtpFloor1	=	tmpVO.getRstBld_FlrBtpFloor1	().split("enterpoint");
			String[] arr_rstBld_FlrBtpFloor2	=	tmpVO.getRstBld_FlrBtpFloor2	().split("enterpoint");
			String[] arr_rstBld_FlrBtpFloor3	=	tmpVO.getRstBld_FlrBtpFloor3	().split("enterpoint");
			String[] arr_rstBld_SlEqmtDcYn		=	tmpVO.getRstBld_SlEqmtDcYn		().split("enterpoint");
			String[] arr_rstBld_MrkYn			=	tmpVO.getRstBld_MrkYn			().split("enterpoint");
			String[] arr_rstBld_EtMtt2			=	tmpVO.getRstBld_EtMtt2			().split("enterpoint");
			for(int k = 0; k < forCnt; k++){
				inVO = new MigSuitability12BldVO();
				inVO.setSuim_rpt_no(""+ridInt);
				if(arr_rqBld_Lctno.length -1 >= k){
					inVO.setRqBld_Lctno(arr_rqBld_Lctno[k]);
				}
				if(arr_rqBld_OjSeqno.length -1 >= k){
					inVO.setRqBld_OjSeqno(arr_rqBld_OjSeqno[k]);
				}
				if(arr_rqBld_BldSeqno.length -1 >= k){
					inVO.setRqBld_BldSeqno(arr_rqBld_BldSeqno[k]);
				}
				if(arr_rqBld_RlOwrNm.length -1 >= k){
					inVO.setRqBld_RlOwrNm(arr_rqBld_RlOwrNm[k]);
				}
				if(arr_rqBld_CtnAdr.length -1 >= k){
					inVO.setRqBld_CtnAdr(arr_rqBld_CtnAdr[k]);
				}
				if(arr_rqBld_MngmBnnm.length -1 >= k){
					inVO.setRqBld_MngmBnnm(arr_rqBld_MngmBnnm[k]);
				}
				if(arr_rqBld_BldRnkcd.length -1 >= k){
					inVO.setRqBld_BldRnkcd(arr_rqBld_BldRnkcd[k]);
				}
				if(arr_rqBld_Plenm.length -1 >= k){
					inVO.setRqBld_Plenm(arr_rqBld_Plenm[k]);
				}
				if(arr_rqBld_Rofnm.length -1 >= k){
					inVO.setRqBld_Rofnm(arr_rqBld_Rofnm[k]);
				}
				if(arr_rqBld_Wllnm.length -1 >= k){
					inVO.setRqBld_Wllnm(arr_rqBld_Wllnm[k]);
				}
				if(arr_rqBld_Grod.length -1 >= k){
					inVO.setRqBld_Grod(arr_rqBld_Grod[k]);
				}
				if(arr_rqBld_Undg.length -1 >= k){
					inVO.setRqBld_Undg(arr_rqBld_Undg[k]);
				}
				if(arr_rqBld_Ttare.length -1 >= k){
					inVO.setRqBld_Ttare(arr_rqBld_Ttare[k]);
				}
				if(arr_rqBld_IsAre.length -1 >= k){
					inVO.setRqBld_IsAre(arr_rqBld_IsAre[k]);
				}
				if(arr_rqBld_IsTp.length -1 >= k){
					inVO.setRqBld_IsTp(arr_rqBld_IsTp[k]);
				}
				if(arr_rqBld_BldXpnm.length -1 >= k){
					inVO.setRqBld_BldXpnm(arr_rqBld_BldXpnm[k]);
				}
				if(arr_rstBld_Rcndt.length -1 >= k){
					inVO.setRstBld_Rcndt(arr_rstBld_Rcndt[k]);
				}
				if(arr_rstBld_InvpsNm.length -1 >= k){
					inVO.setRstBld_InvpsNm(arr_rstBld_InvpsNm[k]);
				}
				if(arr_rstBld_CrRelpcRel.length -1 >= k){
					inVO.setRstBld_CrRelpcRel(arr_rstBld_CrRelpcRel[k]);
				}
				if(arr_rstBld_InvpsCntad.length -1 >= k){
					inVO.setRstBld_InvpsCntad(arr_rstBld_InvpsCntad[k]);
				}
				if(arr_rstBld_RlOwrNm.length -1 >= k){
					inVO.setRstBld_RlOwrNm(arr_rstBld_RlOwrNm[k]);
				}
				if(arr_rstBld_CtnAdr.length -1 >= k){
					inVO.setRstBld_CtnAdr(arr_rstBld_CtnAdr[k]);
				}
				if(arr_rstBld_MngmBnnm.length -1 >= k){
					inVO.setRstBld_MngmBnnm(arr_rstBld_MngmBnnm[k]);
				}
				if(arr_rstBld_BldRnkcd.length -1 >= k){
					inVO.setRstBld_BldRnkcd(arr_rstBld_BldRnkcd[k]);
				}
				if(arr_rstBld_GrodEqalYn.length -1 >= k){
					inVO.setRstBld_GrodEqalYn(arr_rstBld_GrodEqalYn[k]);
				}
				if(arr_rstBld_UndgEqalYn.length -1 >= k){
					inVO.setRstBld_UndgEqalYn(arr_rstBld_UndgEqalYn[k]);
				}
				if(arr_rstBld_TtareEqalYn.length -1 >= k){
					inVO.setRstBld_TtareEqalYn(arr_rstBld_TtareEqalYn[k]);
				}
				if(arr_rstBld_IsAreEqalYn.length -1 >= k){
					inVO.setRstBld_IsAreEqalYn(arr_rstBld_IsAreEqalYn[k]);
				}
				if(arr_rstBld_IsTpEqalYn.length -1 >= k){
					inVO.setRstBld_IsTpEqalYn(arr_rstBld_IsTpEqalYn[k]);
				}
				if(arr_rstBld_RlOwrNmEtMtt.length -1 >= k){
					inVO.setRstBld_RlOwrNmEtMtt(arr_rstBld_RlOwrNmEtMtt[k]);
				}
				if(arr_rstBld_CtnAdrEtMtt.length -1 >= k){
					inVO.setRstBld_CtnAdrEtMtt(arr_rstBld_CtnAdrEtMtt[k]);
				}
				if(arr_rstBld_MngmBnnmEtMtt.length -1 >= k){
					inVO.setRstBld_MngmBnnmEtMtt(arr_rstBld_MngmBnnmEtMtt[k]);
				}
				if(arr_rstBld_BldRnkcdEtMtt.length -1 >= k){
					inVO.setRstBld_BldRnkcdEtMtt(arr_rstBld_BldRnkcdEtMtt[k]);
				}
				if(arr_rstBld_GrodEtMtt.length -1 >= k){
					inVO.setRstBld_GrodEtMtt(arr_rstBld_GrodEtMtt[k]);
				}
				if(arr_rstBld_UndgEtMtt.length -1 >= k){
					inVO.setRstBld_UndgEtMtt(arr_rstBld_UndgEtMtt[k]);
				}
				if(arr_rstBld_TtareEtMtt.length -1 >= k){
					inVO.setRstBld_TtareEtMtt(arr_rstBld_TtareEtMtt[k]);
				}
				if(arr_rstBld_IsAreEtMtt.length -1 >= k){
					inVO.setRstBld_IsAreEtMtt(arr_rstBld_IsAreEtMtt[k]);
				}
				if(arr_rstBld_IsTpEtMtt.length -1 >= k){
					inVO.setRstBld_IsTpEtMtt(arr_rstBld_IsTpEtMtt[k]);
				}
				if(arr_rstBld_Plenm.length -1 >= k){
					inVO.setRstBld_Plenm(arr_rstBld_Plenm[k]);
				}
				if(arr_rstBld_Rofnm.length -1 >= k){
					inVO.setRstBld_Rofnm(arr_rstBld_Rofnm[k]);
				}
				if(arr_rstBld_Wllnm.length -1 >= k){
					inVO.setRstBld_Wllnm(arr_rstBld_Wllnm[k]);
				}
				if(arr_rstBld_PanlYn.length -1 >= k){
					inVO.setRstBld_PanlYn(arr_rstBld_PanlYn[k]);
				}
				if(arr_rstBld_PanlPst.length -1 >= k){
					inVO.setRstBld_PanlPst(arr_rstBld_PanlPst[k]);
				}
				if(arr_rstBld_TntYn.length -1 >= k){
					inVO.setRstBld_TntYn(arr_rstBld_TntYn[k]);
				}
				if(arr_rstBld_TntPst.length -1 >= k){
					inVO.setRstBld_TntPst(arr_rstBld_TntPst[k]);
				}
				if(arr_rstBld_FlrFirZoneYn.length -1 >= k){
					inVO.setRstBld_FlrFirZoneYn(arr_rstBld_FlrFirZoneYn[k]);
				}
				if(arr_rstBld_EtMtt1.length -1 >= k){
					inVO.setRstBld_EtMtt1(arr_rstBld_EtMtt1[k]);
				}
				if(arr_rstBld_FlrBtpUndg.length -1 >= k){
					inVO.setRstBld_FlrBtpUndg(arr_rstBld_FlrBtpUndg[k]);
				}
				if(arr_rstBld_FlrBtpFloor1.length -1 >= k){
					inVO.setRstBld_FlrBtpFloor1(arr_rstBld_FlrBtpFloor1[k]);
				}
				if(arr_rstBld_FlrBtpFloor2.length -1 >= k){
					inVO.setRstBld_FlrBtpFloor2(arr_rstBld_FlrBtpFloor2[k]);
				}
				if(arr_rstBld_FlrBtpFloor3.length -1 >= k){
					inVO.setRstBld_FlrBtpFloor3(arr_rstBld_FlrBtpFloor3[k]);
				}
				if(arr_rstBld_SlEqmtDcYn.length -1 >= k){
					inVO.setRstBld_SlEqmtDcYn(arr_rstBld_SlEqmtDcYn[k]);
				}
				if(arr_rstBld_MrkYn.length -1 >= k){
					inVO.setRstBld_MrkYn(arr_rstBld_MrkYn[k]);
				}
				if(arr_rstBld_EtMtt2.length -1 >= k){
					inVO.setRstBld_EtMtt2(arr_rstBld_EtMtt2[k]);
				}
				sqlSession.insert("MigSuitabilityUtilMapper.migSuitability12BldWrite", inVO);
			}
		}

		return "sys_adm_migration/migration_print1_ok";
	}//migrationSuitability12Bld

}//end of class
