package kr.co.toplac.util.etc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

/*
*********************************************************
* Program ID	: SplitPhoneNo
* Program Name	: 전화번호자르기
* Description	: 전화번호자르기
* Author		: rjh
* Date			: 2016.04.27.
*********************************************************
*/
public class SplitPhoneNo {

	private static final Logger logger = LoggerFactory.getLogger(SplitPhoneNo.class);

	/*
	*********************************************************
	* Method ID		: splitPhoneNo
	* Method Name	: 전화번호자르기
	* Description	: 전화번호자르기
	* Author		: rjh
	* Date			: 2016.04.27.
	* Arguments1	: Model model - jsp에 데이터를 보내기 위해 controller로부터 빌려온 spring 객체
	* Arguments2	: String strForSplit - 잘라야하는 문자열 객체
	* Arguments3	: String splitStandard - split을 적용하여 문자를 자르기 위한 기준이 되는 문자열 객체
	* Arguments4	: String nameForModel - split을 적용하여 잘려진 문자를 모델에 넣을 때 사용하는 이름
	* 예) splitPhoneNo(model, "010-1111-2222", "-", "모델에tel이라는이름의순번으로저장해주세요");
	*********************************************************
	*/
	public void splitPhoneNo(Model model, String strForSplit, String splitStandard, String nameForModel){
		
		String[] tmpArr = strForSplit.split(splitStandard);
		if(tmpArr.length == 3){
			model.addAttribute(nameForModel + "_1", tmpArr[0]);
			model.addAttribute(nameForModel + "_2", tmpArr[1]);
			model.addAttribute(nameForModel + "_3", tmpArr[2]);
		}

	}//end of splitPhoneNo

}//end of class
