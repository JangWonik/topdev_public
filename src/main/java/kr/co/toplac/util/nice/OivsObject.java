package kr.co.toplac.util.nice;

import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.util.Date;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;



	//#############################################################################
	//#####
	//#####	본인확인서비스 확인 스크립트
	//#####
	//#####	=====================================================================
	//#####
	//#####	Descriptions
	//#####		- 나이스평가정보에서 제공하는 서비스에 대한 확인 작업을 처리한다.
	//#####
	//#####	---------------------------------------------------------------------
	//#####
	//#####	작성자 		: 나이스평가정보 (www.nice.co.kr)
	//#####	원본참조	:
	//#####	원본파일	:
	//#####	작성일자	: 2006.03.07
	//#####
	//#############################################################################

public class OivsObject 
{
	public final static String DELIMETER_NORMAL = "!#!";

	public final static String DELIMETER_DATA = "!@!";

	public final static String SVC_TYPE_PERSONAL = "0";

	public final static String SVC_TYPE_CORPERATE = "1";

	public final static String SVC_TYPE_FOREIGNER = "2";

	public final static int CRND_SIZE = 24;

	public final static int SRND_SIZE = 112;

	public final static String CHARSET_DEFAULT = "8859_1";

	public final static String CHARSET_SERVER = "utf-8";

	public final static String URL_PING = "http://secure.nuguya.com/nuguya/rlnmPing.do";

	public String athKeyStr = "";

	private String hexPseudo[] = { "0", "1", "2", "3", "4", "5", "6", "7", "8",
			"9", "a", "b", "c", "d", "e", "f" };

	// 데이터 필드
	public String clientData = "";

	public String niceId = "";

	public String pingInfo = "";

	public String message = "";

	public String retCd = "";

	public String resCd = "";

	public String skData = "";

	public String ckData = "";

	public String identifier = "";

	public String residNo = "";

	public String ordNo = "";

	public String trNo = "";

	public String phoneNo = "";

	public byte[] encRslt;

	/**
	 * 기본 생성자로 필드 초기화화와 서비스 정보를 처리한다.
	 */
	public OivsObject() {
		initialize();
	}

	/*
	 * 필드를 초기화 처리한다.
	 */
	private void initialize() {
		this.pingInfo = webGetter(URL_PING);
	}

	/*
	 * 지정된 URL을 호출하여 반환 정보를 반환한다.
	 */
	private String webGetter(String targetUrl) {
		URLConnection conn = null;

		try {
			URL url = new URL(targetUrl);
			conn = url.openConnection();
		} catch (Exception ex) {
			return "";
		}

		StringBuffer sbHtml = new StringBuffer();
		InputStream in = null;

		try {
			in = conn.getInputStream();
			int offset = 0;

			while (offset > -1) {
				byte[] b = new byte[1024];
				offset = in.read(b);
				if (offset > 0)
					sbHtml.append(new String(b, 0, offset));
			}
		} catch (Exception ex) {
			this.message = "나이스평가정보의 서비스에 접속할 수 없습니다. [nice.nuguya.oivs.inc - makeServiceCaller]";
			return "";
		} finally {
			try {
				if (in != null)
					in.close();
			} catch (Exception ex) {
			}
		}

		return sbHtml.toString().trim();
	}

	/*
	 * 전달된 문자열을 Decode하여 반환한다.
	 */
	private byte[] decode(String encodeString) {
		BASE64Decoder B64Decoder = new BASE64Decoder();
		byte[] bytDecodedData;

		try {
			bytDecodedData = B64Decoder.decodeBuffer(encodeString);
			return bytDecodedData;
		} catch (Exception ex) {
			this.message = "서비스에서 사용할 문자열을 변환(Decode)할 수 없습니다. [nice.nuguya.oivs.inc - decode]";
			return null;
		}
	}

	/*
	 * 전달된 byte[]를 Encode된 문자열로 반환한다.
	 */
	public String encode(byte[] plainData) {
		BASE64Encoder B64Encoder = new BASE64Encoder();
		String strEncodedString;

		try {
			strEncodedString = B64Encoder.encode(plainData);
			return strEncodedString;
		} catch (Exception ex) {
			this.message = "서비스에서 사용할 문자열을 변환(Encode)할 수 없습니다. [nice.nuguya.oivs.inc - encode]";
			return "";
		}
	}

	/*
	 * Triple-DES Decryption Method
	 */
	private String TriDES_DecryptString(byte[] key, byte[] encMessage) {
		byte[] bytDecryptedData;
		SecretKey sKey;
		Cipher DecryptCipher;

		try {
			// 키를 설정한다.
			sKey = new SecretKeySpec(key, "DESede");

			// Cipher를 생성하고 초기화 한다.
			DecryptCipher = Cipher
					.getInstance("DESede/CBC/NoPadding", "SunJCE");
			DecryptCipher.init(Cipher.DECRYPT_MODE, sKey, new IvParameterSpec(
					key, 0, 8));

			bytDecryptedData = DecryptCipher.doFinal(encMessage);
			return new String(bytDecryptedData, CHARSET_SERVER);
		} catch (Exception ex) {
			this.message = "서비스에서 사용할 문자열을 복호화처리 할 수 없습니다. [nice.nuguya.oivs.inc - TriDES_DecryptString]\\n[오류정보]\\n"
					+ ex.getMessage();
			return "";
		}
	}

	/*
	 * Triple-DES Encryption Method
	 */
	public byte[] TriDES_EncryptString(byte[] key, String plainMessage) {
		byte[] bytEncryptedData;
		SecretKey sKey;
		Cipher EncryptCipher;

		try {
			// 키를 설정한다.
			sKey = new SecretKeySpec(key, "DESede");

			// Cipher를 생성하고 초기화 한다.
			EncryptCipher = Cipher.getInstance("DESede/CBC/NoPadding");
			EncryptCipher.init(Cipher.ENCRYPT_MODE, sKey, new IvParameterSpec(
					key, 0, 8));

			bytEncryptedData = convert8bytes(plainMessage.getBytes());

			bytEncryptedData = EncryptCipher.doFinal(bytEncryptedData);
			return bytEncryptedData;
		} catch (Exception ex) {
			this.message = "서비스에서 사용할 문자열을 복호화처리 할 수 없습니다. [nice.nuguya.oivs.inc - TriDES_EncryptString]\\n[오류정보]\\n"
					+ ex.getMessage();
			return null;
		}
	}

	public SecretKey generateRandomKey(int keySize) {
		SecretKey sKey;

		try {
			KeyGenerator kg = KeyGenerator.getInstance("DESede");
			kg.init(keySize);
			sKey = kg.generateKey();

			return sKey;
		} catch (Exception ex) {
			this.message = "정보 보안을 위한 보안키를 생성할 수 없습니다. [nice.nuguya.oivs.inc : callService(generateRandomKey)] \\n\\n고객상담센터(☎ 1588-2486) 로 연락하십시오";
			return null;
		}
	}

	/*
	 * Byte Array를 Hex String으로 변환한다.
	 */
	public String convertByteArrayToHexString(byte[] sourceBytes) {
		byte ch = 0x00;
		int nIndex = 0;

		if (sourceBytes == null || sourceBytes.length <= 0)
			return "";

		StringBuffer sbOut = new StringBuffer(sourceBytes.length * 2);

		while (nIndex < sourceBytes.length) {
			ch = (byte) (sourceBytes[nIndex] & 0xF0); // Strip Off high nibble
			ch = (byte) (ch >>> 4); // Strip the bits down
			ch = (byte) (ch & 0x0F); // high order bit is on
			sbOut.append(hexPseudo[(int) ch]); // Convert the nibble to a
												// String Character
			ch = (byte) (sourceBytes[nIndex] & 0x0F); // Strip Off low nibble
			sbOut.append(hexPseudo[(int) ch]); // Convert the nibble to a
												// String Character
			nIndex++;
		}

		return sbOut.toString();
	}

	/*
	 * 
	 */
	public String getHashedString(String plainString) {
		MessageDigest md;
		byte[] bytData, bytHashedData;

		try {
			bytData = plainString.getBytes();
			md = MessageDigest.getInstance("MD5");
			md.update(bytData);

			bytHashedData = md.digest();

			return this.convertByteArrayToHexString(bytHashedData);
		} catch (Exception ex) {
			this.message = "정보 보안을 위한 해쉬정보를 생성할 수 없습니다. [nice.nuguya.oivs.inc : callService(getHashedString)] \\n\\n고객상담센터(☎ 1588-2486) 로 연락하십시오";
			return null;
		}
	}

	/*
	 * 
	 */
	private byte[] convert8bytes(byte[] srcBytes) {
		int nLength = (srcBytes.length + 8) / 8;
		byte[] bytTarget = new byte[nLength * 8];

		for (int nIndex = 0; nIndex < bytTarget.length; nIndex++)
			bytTarget[nIndex] = 0x00;

		System.arraycopy(srcBytes, 0, bytTarget, 0, srcBytes.length);

		return bytTarget;
	}

	/*
	 * 
	 */
	private byte[] addBytes(byte[] arg1, byte[] arg2) {
		byte[] bytStream = new byte[arg1.length + arg2.length];

		System.arraycopy(arg1, 0, bytStream, 0, arg1.length);
		System.arraycopy(arg2, 0, bytStream, arg1.length, arg2.length);

		return bytStream;
	}

	public boolean resolveDatas(String sendInfo) {
		try {
			String strCDESInfo = "";
			String[] aryValues = null;

			strCDESInfo = new String(this.decode(sendInfo));
			aryValues = strCDESInfo.split(DELIMETER_DATA );

			if (aryValues.length < 4) {
				this.retCd = "0";
				this.message = "전달받은 데이터에 오류가 있습니다.";
				return false;
			}

			this.ordNo = aryValues[0];
			this.resCd = aryValues[1];
			this.message = URLDecoder.decode(aryValues[2], "UTF-8");
			strCDESInfo = aryValues[3];	
			
			String hashCnt = aryValues[4];	
			for(int i=0;i<Integer.parseInt(hashCnt);i++){
				this.athKeyStr = getHashedString(this.athKeyStr);
			}

			Date dateObj = new Date();
			int keyPivot = (dateObj.getYear() % 100 * 15 + (dateObj.getMonth() + 1)) % 8;

			byte[] key = this.athKeyStr.substring(keyPivot, keyPivot + 24)
					.getBytes();
			byte[] data = this.decode(strCDESInfo);

			strCDESInfo = this.TriDES_DecryptString(key, data);
			aryValues = strCDESInfo.split(DELIMETER_DATA);

			if (aryValues.length < 5) {
				this.retCd = "0";
				this.message = "전달 받은 데이터에 오류가 있습니다.";
				return false;
			} else if (!this.ordNo.equals(aryValues[1])
					|| !this.resCd.equals(aryValues[3])) {
				this.retCd = "0";
				this.message = "전달 받은 데이터에 오류가 있습니다.";
				return false;
			} else {
				this.niceId = aryValues[0];
				this.retCd = aryValues[2];
				this.residNo = aryValues[4];
				this.phoneNo = aryValues[5];

				return true;
			}
		}catch (Exception ex){
			return false;
		}
	}

	public String makeSendInfo(String ResidNo, String ReturnURL, String MobileNo, String ConfirmMsg) {
		
		String fnRslt = "";
		int keyHashineCnt = 0;

		
		if(!ConfirmMsg.equals("")) {
			keyHashineCnt = (int)(Math.random() * 100 + 1);
			for(int i=0;i<keyHashineCnt;i++){
				this.athKeyStr = getHashedString(this.athKeyStr);
			}

			Date dateObj = new Date();
			int keyPivot = (dateObj.getYear() % 100 * 15 + (dateObj.getMonth() + 1)) % 8;

			byte[] key = this.athKeyStr.substring(keyPivot, keyPivot + 24).getBytes();
			System.out.println("key ["+key+"]");
			System.out.println("ConfirmMsg ["+ConfirmMsg+"]");

			this.encRslt = this.TriDES_EncryptString(key, ConfirmMsg);

			fnRslt = this.encode(encRslt);
		}

		String strCDESInfo = "";

		if (this.pingInfo.equals("")) {
			this.message = "나이스평가정보의 서비스에 접속할 수 없습니다. [nice.nuguya.oivs.inc - makeSendInfo]";
			return "";
		}

		SecretKey sKey = this.generateRandomKey(SRND_SIZE);
		if (sKey == null)
			return "";

		this.ckData = this.encode(sKey.getEncoded()).substring(0, CRND_SIZE);

		byte[] bytEncData = this.TriDES_EncryptString(this.ckData.getBytes(),
				this.niceId + DELIMETER_NORMAL + pingInfo+ DELIMETER_NORMAL
						+ encode(this.addBytes((ResidNo+":"+MobileNo+":"+keyHashineCnt+":").getBytes(), fnRslt.getBytes())) + DELIMETER_NORMAL + "#"
						+ DELIMETER_NORMAL + ReturnURL);

		strCDESInfo = this.encode(this.addBytes(
				(this.ckData + DELIMETER_NORMAL).getBytes(), bytEncData));

		return strCDESInfo;
	}

}
