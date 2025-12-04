package kr.co.toplac.util.cmm;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.FieldPosition;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

/**
 * Created by kohyeonseok on 2017. 3. 13..
 */
public class DateUtil {
	
	/**
	 * 문자열로된 월, 날짜를 받아 두자리의 문자열로 바꾸어준다.
	 * ex: 2,3 > 02,03
	 * @param String
	 * @return String 2 Pattern
	 * @author top3009
	 */	
	public static String getFormatMonth(String sInput) {
		String sRet = "";
		if( sInput.length() == 1 ) {
			sRet = "0"+sInput;
		}else {
			sRet = sInput;
		}
		return sRet;
	}
	
	/**
	 * 문자열로 된 날짜를 받아서 Calendar 형으로 변경해준다.
	 * @param from
	 * @return
	 * @author top3009
	 * @throws ParseException 
	 */
	public static Calendar getDateTime(String strDatetime){
		/*
		 * Calendar cal = Calendar.getInstance();
		 * 
		 * String[] strSplitDateTime = strDatetime.split(" "); String[] strSplitDate =
		 * strSplitDateTime[0].split("-"); //String[] strSplitTime =
		 * strSplitDateTime[1].split(":"); String[] strSplitTime =
		 * strSplitDateTime[1].split(":"); cal.set(Integer.parseInt(strSplitDate[0]),
		 * Integer.parseInt(strSplitDate[1]) - 1, Integer.parseInt(strSplitDate[2]),
		 * Integer.parseInt(strSplitTime[0]), Integer.parseInt(strSplitTime[1]),
		 * Integer.parseInt(strSplitTime[2]));
		 */
		Calendar cal = Calendar.getInstance();
		
		try {
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = formatter.parse(strDatetime);			
			cal.setTime(date);
		} catch (Exception e) {
			System.out.println("parseException : "+e.getMessage());
		}						
		
		return cal;
	}
	
	/**
	 * 시작일자와 종료일자 사이에 특정날짜가 포함되어있는지 확인한다.
	 * @param strStart 시작시간
	 * @param strEnd 종료시간
	 * @param strValue 비교시간
	 * @return true : 시작시간과 종료시간 사이에 포함됨, false : 시작시간과 종료시간 사이에 비교시간이 포함되지 않음
	 * @author top3009
	 */
	public static Boolean getValidDate(String strStart, String strEnd, String strValue) {
		Calendar calStart = getDateTime(strStart);
		Calendar calEnd = getDateTime(strEnd);
		Calendar calValue = getDateTime(strValue);

		Boolean bValid = false;
		if (calStart.before (calValue) && calEnd.after(calValue)) {
			bValid = true;
		}else if( calStart.equals(calValue) ) {		//시작시간과 동일한 경우 포함
			bValid = true;
		}
		
		return bValid;
	}
	
    public static Date stringToDate(String from) {
        Date to;

        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            to = transFormat.parse(from);
        } catch (Exception ex) {
            to = null;
            ex.printStackTrace();

        }
        return to;
    }

    /**
     * 두 날짜 사이의 일수를 계산
     * @param startDate
     * @param endDate
     * @return
     */
    public static int getDiffDayCount(String startDate, String endDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

        try {
            return (int) ((sdf.parse(endDate).getTime() - sdf.parse(startDate).getTime()) / 1000 / 60 / 60 / 24);
        } catch (Exception e) {
            return 0;
        }
    }
    
    public static int getDiffDayCountNew(String startDate, String endDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            return (int) ((sdf.parse(endDate).getTime() - sdf.parse(startDate).getTime()) / 1000 / 60 / 60 / 24);
        } catch (Exception e) {
            return 0;
        }
    }
    
    public static Long getDiffSecondCount(String startDate, String endDate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

        try {
            return (Long) ((sdf.parse(endDate).getTime() - sdf.parse(startDate).getTime()) / 1000);
        } catch (Exception e) {
            return 0L;
        }
    }
    
    /**
     * 두 날짜 사이의 일수를 주말(토,일) 제외하고 계산
     * @param startDateStr
     * @param endDateStr
     * @return count
     */
    public static int getDiffDayCountNotWeekend(String startDateStr, String endDateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date startDate = null, endDate = null;
		try {
			startDate = sdf.parse(startDateStr);
			endDate= sdf.parse(endDateStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int count = 0;
    	
    	Calendar cal = Calendar.getInstance();
		
		while(true){
			if (startDate.getTime() > endDate.getTime()){
				break;
			}else{
				cal.setTime(startDate);
				int tmpDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
				if ( !(tmpDayOfWeek == 1 || tmpDayOfWeek == 7) ){
					count++;
				}
				startDate = DateUtil.addDate(startDate, 1);
			}
		}
		return count;
    }    
    
    
    /**
     * 입력한 날짜에 일수를 더한 날짜를 리턴한다.
     * @param date
     * @param day
     * @return
     */
    public static Date addDate(Date date, int day) {
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(date);
            cal.add(Calendar.DAY_OF_YEAR, day);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return cal.getTime();
    }

    
    /**
     * 입력한 날짜에 년수를 더한 날짜를 리턴한다.
     * @param date
     * @param month
     * @return
     */
    public static Date addYear(Date date, int year) {
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(date);
            cal.add(Calendar.YEAR, year);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return cal.getTime();
    }
    
    /**
     * 입력한 날짜에 월수를 더한 날짜를 리턴한다.
     * @param date
     * @param month
     * @return
     */
    public static Date addMonth(Date date, int month) {
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(date);
            cal.add(Calendar.MONTH, month);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return cal.getTime();
    }
    
    /**
     * yyyy-MM-dd 날짜형식의 문자열을 일수를 더하여 리턴한다.
     * @param strDate
     * @param day
     * @return
     */
    public static String addDateNew(String strDate, int day) {
        Date date = DateUtil.getDateFromDateNewStr(strDate);
        date = DateUtil.addDate(date, day);
        return DateUtil.getStringFromDate(date, "yyyy-MM-dd");
    }
    
    /**
     * yyyyMMdd 날짜형식의 문자열을 일수를 더하여 리턴한다.
     * @param strDate
     * @param month
     * @return
     */
    public static String addYearNew(String strDate, int year) {
        Date date = DateUtil.getDateFromDateStr(strDate);
        date = DateUtil.addYear(date, year);
        return DateUtil.getStringFromDate(date, "yyyy-MM-dd");
    }

    /**
     * yyyyMMdd 날짜형식의 문자열을 일수를 더하여 리턴한다.
     * @param strDate
     * @param month
     * @return
     */
    public static String addMonthNew(String strDate, int month) {
        Date date = DateUtil.getDateFromDateStr(strDate);
        date = DateUtil.addMonth(date, month);
        return DateUtil.getStringFromDate(date, "yyyy-MM-dd");
    }

    /**
     * yyyyMMdd 날짜형식의 문자열을 일수를 더하여 리턴한다.
     * @param strDate
     * @param day
     * @return
     */
    public static String addDate(String strDate, int day) {
        Date date = DateUtil.getDateFromDateStr(strDate);
        date = DateUtil.addDate(date, day);
        return DateUtil.getStringFromDate(date, "yyyyMMdd");
    }

    /**
     * yyyyMMdd 날짜형식의 문자열을 일수를 더하여 리턴한다.
     * @param strDate
     * @param month
     * @return
     */
    public static String addMonth(String strDate, int month) {
        Date date = DateUtil.getDateFromDateStr(strDate);
        date = DateUtil.addMonth(date, month);
        return DateUtil.getStringFromDate(date, "yyyyMMdd");
    }
    
    /**
     * 년월일(예:20090807) 을 입력하여 Date 타입 데이터를 가져온다
     * @param yyyymmdd
     * @return
     */
    public static Date getDateFromDateNewStr(String inputS) {
        int year = 0;
        int month = 0;
        int date = 0;
        Date dt = null;
        if(inputS.length() == 10) {
            year = Integer.parseInt(inputS.substring(0, 4));
            month = Integer.parseInt(inputS.substring(5, 7));
            date = Integer.parseInt(inputS.substring(8, 10));
            dt = getDateFromDateStr(year, month, date);
        }
        return dt;
    }
    
    /**
     * 년월일(예:2009-08-07) 을 입력하여 Date 타입 데이터를 가져온다
     * @param sDate = yyyy-mm-dd
     * @return
     */
    public static Date getDateFromDateStrNew(String sDate) {
        int year = 0;
        int month = 0;
        int date = 0;
        Date dt = null;
        if(sDate.length() == 10) {
            year = Integer.parseInt(sDate.substring(0, 4));
            month = Integer.parseInt(sDate.substring(5, 7));
            date = Integer.parseInt(sDate.substring(8,10));
            dt = getDateFromDateStr(year, month, date);
        }
        return dt;
    }

    /**
     * 년월일(예:20090807) 을 입력하여 Date 타입 데이터를 가져온다
     * @param yyyymmdd
     * @return
     */
    public static Date getDateFromDateStr(String yyyymmdd) {
        int year = 0;
        int month = 0;
        int date = 0;
        Date dt = null;
        if(yyyymmdd.length() == 8) {
            year = Integer.parseInt(yyyymmdd.substring(0, 4));
            month = Integer.parseInt(yyyymmdd.substring(4, 6));
            date = Integer.parseInt(yyyymmdd.substring(6, 8));
            dt = getDateFromDateStr(year, month, date);
        }
        return dt;
    }

    /**
     * 년월일을 입력하여 Date 타입 데이터를 가져온다.
     * @param year
     * @param month
     * @param date
     * @return
     */
    public static Date getDateFromDateStr(int year, int month, int date) {
        return getDateFromDateStr(year, month, date, 0, 0, 0);
    }

    /**
     * 년월일시분초를 입력하여 Date타입 데이터를 가져온다.
     * @param year
     * @param month
     * @param date
     * @param hour
     * @param minute
     * @param second
     * @return
     */
    public static Date getDateFromDateStr(int year, int month, int date, int hour, int minute, int second) {
        Calendar cal = Calendar.getInstance();
        cal.set(year, month-1, date, hour, minute, second);

        return cal.getTime();
    }

    /**
     * Date 타입의 date 를 기본포맷인 yyyy/MM/dd로 포맷팅하여 리턴한다.
     * @param date
     * @return
     */
    public static String getStringFromDate(Date date) {
        return getStringFromDate(date, "yyyy/MM/dd");
    }

    /**
     * Date  타입의 date 를 포맷문자열(format) 형식의 문자열로 리턴한다.
     * @param date
     * @param format
     * @return
     */
    public static String getStringFromDate(Date date, String format) {
        StringBuffer dateResult = new StringBuffer();
        SimpleDateFormat simpleDate = new SimpleDateFormat(format);
        simpleDate.format(date, dateResult, new FieldPosition(1));
        return dateResult.toString();
    }


    /**
     * 날짜를 입력하면 구분자(/) 을 붙여서 리턴한다.
     *
     * @param date
     * @return
     */
    public static String getDateFormat(String date) {
        return getDateFormat(date, "/");
    }

    /**
     * 8자리의 날짜값을 token 값에 따라 날짜포맷으로 리턴한다.
     * data: 20080101   token : "-"
     * result: 2008-01-01
     *
     * @param date
     * @param token
     * @return
     */
    public static String getDateFormat(String date, String token) {
        StringBuffer ret = new StringBuffer();
        try {
            if (date != null && date.trim().length() == 8) {
                date = date.trim();
                ret.append(date.substring(0, 4)).append(token).append(
                        date.substring(4, 6)).append(token).append(
                        date.substring(6));
            } else {
                ret.append("-");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret.toString();
    }

    /**
     * 오늘 날짜를 문자열로 리턴한다.
     * @return
     */
    public static String getTodayString() {
        //SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        return getTodayString("yyyyMMdd");
    }

    public static String getTodayString(String sFormat) {
        SimpleDateFormat format = new SimpleDateFormat(sFormat, Locale.KOREA);

        return format.format(new Date());
    }

    public static Long getUnixTimeStamp(String yyyymmdd) {
        Date date = getDateFromDateStr(yyyymmdd);
        return date.getTime() / 1000;
    }

    /**
     * 한달 간격의 시작일자를 린턴한다.
     * 한달 간격은 전월 16일 부터 당월 15일 까지다.
     */
    public static String getStartMonthDay(){
        String sToday = getTodayString();
        Date dToday = getDateFromDateStr(sToday);

        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        sToday = sToday.substring(0,6) + "16";
        if (day < 16){
            sToday = addMonth(sToday, -1);
        }
        return sToday;
    }





    /**
     * 한달 간격의 종료일자를 린턴한다.
     * 한달 간격은 전월 16일 부터 당월 15일 까지다.
     */
    public static String getEndMonthDay(){
        String sToday = getTodayString();
        Date dToday = getDateFromDateStr(sToday);

        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        sToday = sToday.substring(0,6) + "15";
        if (day >= 16){
            sToday = addMonth(sToday, 1);
        }
        return sToday;

    }

    /**
     * Timestamp 값 생성
     * @return
     */
    public static String getTimeStamp() {

        String rtnStr = null;

        // 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
        String pattern = "yyyyMMddhhmmssSSS";

        SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
        Timestamp ts = new Timestamp(System.currentTimeMillis());

        rtnStr = sdfCurrent.format(ts.getTime());

        return rtnStr;
    }
    
    /**
     * 날짜 비교함수
     * @param sSourceDate : 원날짜, sTargetDate : 비교날짜
     * @return int (-1 : 비교날짜가 이전날짜, 0 : 같은날짜, 1: 이후날짜)
     * @exception : 9 (문제발생)
     */
    
    public static int compareDate(String sSourceDate, String sTargetDate) {
    	int nRet = 0;
    	
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	
    	try {
    		Date sourceTime = dateFormat.parse(sSourceDate);
        	Date targetTime = dateFormat.parse(sTargetDate);
        	
        	if( sourceTime.compareTo(targetTime) > 0) {
        		nRet = -1;
        	}else if(sourceTime.compareTo(targetTime) < 0) {
        		nRet = 1;
        	}else if(sourceTime.compareTo(targetTime) == 0) {
        		nRet = 0;
        	}else {
        		nRet = 9;
        	}
        	
    	}catch (Exception e) {
    		e.printStackTrace();
    		nRet = 9;
		}
    	
    	return nRet;
    }    
    
    
    /**
     * 1년 전 날짜체크
     * 1년을 초과한 경우 true, 1년 미만 false
     */
    
    public static boolean chkYear(String sChkdate, String sBasedate) {		//체크날짜(입사일), 기준날짜    	
    	boolean bRet = false;
    	String sChkdateTemp = "";
    	//1년전 날짜
    	int year = Integer.parseInt(sChkdate.substring(0,4));
    	year += 1;
    	
    	sChkdateTemp = String.valueOf(year)+sChkdate.substring(4,10);
    	
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	
    	try {
    		Date startTime = dateFormat.parse(sChkdateTemp);
        	Date endTime = dateFormat.parse(sBasedate);
        	
        	if(startTime.compareTo(endTime) > 0) {
        		bRet = false;
        	}else {
        		bRet = true;
        	}
        	
		} catch (Exception e) {
			e.printStackTrace();
		}    	
    	
    	return bRet;    	
    }
    
    
    /**
     * 특정년도 전 년도 계산하기
     * @param sBaseDate : 기준년도, nBeforeYear : 특정년도 전
     * @return sRet : 변환된 년도
     */
    public static String beforeYear(String sBaseDate, int nBeforeYear) {
    	
    	String sRet = "";
    	
    	try {
    		//nBeforeYear 년전 날짜
        	int year = Integer.parseInt(sBaseDate.substring(0,4));
        	year = year - nBeforeYear;
        	
        	sRet = String.valueOf(year)+sBaseDate.substring(4,10);
        	
		} catch (Exception e) {			//예외발생시 입력값을 그대로 리턴
			e.printStackTrace();
			sRet = sBaseDate;
		}    	
    	
    	return sRet;
    	
    }
    
    /**
     * 특정 기간 사이에 날짜를 ArrayList 로 return
     * @param sStartDate
     * @param sEndDate
     * @return
     * @throws ParseException
     */
    
    public static ArrayList getBetweenDate(String sStartDate, String sEndDate) throws ParseException {
    	ArrayList<String> dates = new ArrayList<String>();
    	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = sdf.parse(sStartDate);
		Date endDate = sdf.parse(sEndDate);
		
		Date currentDate = startDate;
        while (currentDate.compareTo(endDate) <= 0) {
            dates.add(sdf.format(currentDate));
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
        }        
    	
    	return dates;
    }
    
    /**
    * 월차계산 함수
    * @param sJoindate : 입사일
    * @param sBasicdate : 기준일
    * @return nRet : 발생월차
    * @throws ParseException
    */
  	public static int nCalMonthVacation( String sJoindate, String sBasicdate) {
  		int nRet = 0;
  		
  		//계산할 날짜의 월,일을 쪼갠다.
  		String [] sJoinTemp = sJoindate.split("-");
  		String [] sBaseTemp = sBasicdate.split("-");
  		
  		int nJoinYear = Integer.parseInt(sJoinTemp[0]);
  		int nJoinMonth = Integer.parseInt(sJoinTemp[1]);
  		int nJoinDay = Integer.parseInt(sJoinTemp[2]);
  		
  		int nBaseYear = Integer.parseInt(sBaseTemp[0]);
  		int nBaseMonth = Integer.parseInt(sBaseTemp[1]);
  		int nBaseDay = Integer.parseInt(sBaseTemp[2]);
  		
  		//년도차이가 발생하면 기준 월에 11를 다한다.
  		if( nJoinYear < nBaseYear ) {
  			nBaseMonth += 12;
  		}
  		
  		//일자가 기준일보다 작은경우 (한달을 못채운경우 월차에서 1을 뺀다.)
  		if( nBaseDay < nJoinDay) {
  			nBaseMonth -= 1;
  		}
  		
  		nRet = nBaseMonth - nJoinMonth;
  		
  		return nRet;
  	}
  	
  	/**
     * 공휴일 계산 함수
     * @param sJoindate : 입사일
     * @param sBasicdate : 기준일
     * @return nCal : 발생연차
     * @throws ParseException
     */  	
  	public static int chkHoliday(String sJoindate,String sBasicdate) {
		int nRet = 0;
		boolean bFlag = false;
		
		//2018년 1월부터, 2019년 기념일 배열		/
		String[] holidays = { "2018-01-01", "2018-02-15", "2018-02-16", "2018-03-01", "2018-05-07", "2018-05-22", "2018-06-06", "2018-01-13",
				"2018-08-15", "2018-09-24", "2018-09-25", "2018-09-26", "2018-10-03", "2018-10-09", "2018-12-25",
				"2019-01-01", "2019-02-04", "2019-02-05","2019-02-06", "2019-03-01", "2019-05-06", "2019-06-06",
				"2019-08-15", "2019-09-12", "2019-09-13","2019-10-03","2019-10-09","2019-12-25"};
		
		for(int i=0; i < holidays.length; i++) {
			bFlag = DateUtil.getValidDate(sJoindate,sBasicdate,holidays[i]);
			if(bFlag) {
				nRet++;
			}
		}		
		return nRet;		
	}
  	
  	/**
     * 년차계산 함수
     * @param sJoindate : 입사일
     * @param sBasicdate : 기준일
     * @return nCal : 발생연차
     * @throws ParseException
     */
   	public static int nCalYearVacation( String sJoindate, String sBasicdate) {
   		int nRet = 0;
   		int nCal = 0;
   		
   		//계산할 날짜의 월,일을 쪼갠다.
   		String [] sJoinTemp = sJoindate.split("-");
   		String [] sBaseTemp = sBasicdate.split("-");
   		
   		int nJoinYear = Integer.parseInt(sJoinTemp[0]);
   		int nJoinMonth = Integer.parseInt(sJoinTemp[1]);
   		int nJoinDay = Integer.parseInt(sJoinTemp[2]);
   		
   		int nBaseYear = Integer.parseInt(sBaseTemp[0]);
   		int nBaseMonth = Integer.parseInt(sBaseTemp[1]);
   		int nBaseDay = Integer.parseInt(sBaseTemp[2]);
   		
   		if( nBaseYear <=  nJoinYear ) {		//입사년도가 오늘 날짜와 같거나 큰경우는 연차 0
   			nRet = 0;
   		}else {   		
	   		//월일을 가지고 해당년도에 1년을 더한다.
   			nRet = nBaseYear - nJoinYear;
	   		if( nBaseMonth < nJoinMonth ) {			//오늘 날짜가 입사날짜(월)보다 이전인 경우
	   			nRet--;
	   		}else if( nBaseMonth == nJoinMonth ){
	   			if( nBaseDay < nJoinDay ) {
	   				nRet--;
	   			}
	   		}
   		}
   		
   		if( nRet == 0 ) {
   			nCal = 0;
   		}else if( nRet > 0 && nRet < 3){
			nCal = 15;
		}else if( nRet >= 3 && nRet < 5) {
			nCal = 16;
		}else if( nRet >= 5 && nRet < 7) {
			nCal = 17;
		}else if( nRet >= 7 && nRet < 9) {
			nCal = 18;
		}else if( nRet >= 9 && nRet < 11) {
			nCal = 19;
		}else if( nRet >= 11 && nRet < 13) {
			nCal = 20;
		}else if( nRet >= 13 && nRet < 15) {
			nCal = 21;
		}else if( nRet >= 15 && nRet < 17) {
			nCal = 22;
		}else if( nRet >= 17 && nRet < 19) {
			nCal = 23;
		}else if( nRet >= 19 && nRet < 21) {
			nCal = 24;
		}else if( nRet >= 21) {
			nCal = 25;
		}
   		
   		return nCal;
   	}
   	
   	/**
     * 한달 간격의 전월 시작일자를 린턴한다.
     * 한달 간격은 전전월 16일 부터 당월 15일 까지다.
     */
    public static String getBeforeStartMonthDate(String sDate){
    	
    	String sRet = sDate.replace("-", "");				//변환기준일    	
        Date dToday = getDateFromDateStr(sRet);

        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        sRet = sRet.substring(0,6) + "16";
        if (day < 16){
        	sRet = addMonth(sRet, -2);
        }else {
        	sRet = addMonth(sRet, -1);
        }
        return sRet;
    }    
  	
   	/**
     * 한달 간격의 시작일자를 린턴한다.
     * 한달 간격은 전월 16일 부터 당월 15일 까지다.
     */
    public static String getStartMonthDate(String sDate){
    	
    	String sRet = sDate.replace("-", "");				//변환기준일    	
        Date dToday = getDateFromDateStr(sRet);

        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        sRet = sRet.substring(0,6) + "16";
        if (day < 16){
        	sRet = addMonth(sRet, -1);
        }
        return sRet;
    }
    
    /**
     * 이전달의 종료일자를 린턴한다.
     * 한달 간격은 전월 16일 부터 당월 15일 까지다.
     */
    public static String getBeforeEndMonthDate(String sDate){
    	
    	String sRet = sDate.replace("-", "");				//변환기준일
        Date dToday = getDateFromDateStr(sRet);

        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        sRet = sRet.substring(0,6) + "15";
        if (day < 16){
        	sRet = addMonth(sRet, -1);
        }
        return sRet;

    }


    /**
     * 한달 간격의 종료일자를 린턴한다.
     * 한달 간격은 전월 16일 부터 당월 15일 까지다.
     */
    public static String getEndMonthDate(String sDate){
    	
    	String sRet = sDate.replace("-", "");				//변환기준일
        Date dToday = getDateFromDateStr(sRet);

        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);

        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        sRet = sRet.substring(0,6) + "15";
        if (day >= 16){
        	sRet = addMonth(sRet, 1);
        }
        return sRet;

    }
    
    /**
     * 한주의 시작요일 (월요일의 날짜 가져오기)
     * @param args
     */
    public static String getStartWeek(String sDate) {
    	String sRet = sDate.replace("-", "");
    	
    	Date dToday = getDateFromDateStr(sRet);

        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);
        
        //일요일은 1, 토요일은 7
        int nWeek = cal.get(Calendar.DAY_OF_WEEK);
        
        if( nWeek == 1) {		//일요일은 6일전 날짜
        	sRet = DateUtil.addDate(sRet, -6);
        }else if( nWeek == 3 ) {		//화요일	
        	sRet = DateUtil.addDate(sRet, -1);
        }else if( nWeek == 4 ) {		//수요일	
        	sRet = DateUtil.addDate(sRet, -2);
        }else if( nWeek == 5 ) {		//목요일	
        	sRet = DateUtil.addDate(sRet, -3);
        }else if( nWeek == 6 ) {		//금요일	
        	sRet = DateUtil.addDate(sRet, -4);
        }else if( nWeek == 7 ) {		//토요일	
        	sRet = DateUtil.addDate(sRet, -5);
        }    	
    	return sRet;
    }
    
    /**
     * 한주의 종료요일 (일요일의 날짜 가져오기)
     * @param args
     */
    
    public static String getEndWeek(String sDate) {
    	String sRet = sDate.replace("-", "");
    	//한주의 시작요일에 6일을 더 한다.
    	sRet = DateUtil.getStartWeek(sRet);
    	sRet = DateUtil.addDate(sRet, 6);    	
    	return sRet;    	
    }
	
    /**
     * 1년기준 시작일자를 가져온다.(오늘날짜의 전년도 12월 16일)
     * @return
     */
    public static String getStartYearDay( String sDate ){
    	
    	String sResult = "";
    	String sRet = sDate.replace("-", "");				//변환기준일
        Date dToday = getDateFromDateStr(sRet);
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);

        int year = cal.get(Calendar.YEAR);        
                
        String compareDate = year+"-12-16";
        
        int nTmp = DateUtil.compareDate( compareDate, sDate);
        
        //오늘 날짜가 해당년도 12월 16일 이전이면 년도를 전년도(-1)로 처리한다.        
        if( nTmp < 0 ) {		//전년도로 리턴
        	sResult = (year-1) + "-12-16";        	
        }else{					//해당년도로 리턴
        	sResult = compareDate;
        }
        
    	return sResult;
    }
    
    public static String getEndYearDay( String sDate ) {
    	
    	String sResult = "";
    	String sRet = sDate.replace("-", "");				//변환기준일
        Date dToday = getDateFromDateStr(sRet);
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(dToday);

        int year = cal.get(Calendar.YEAR);        
                
        String compareDate = year+"-12-15";
        
        int nTmp = DateUtil.compareDate( compareDate, sDate);
        
        //오늘 날짜가 해당년도 12월 16일 이후이면 다음년도로 가져온다.        
        if( nTmp > 0 ) {		//다음해로 리턴(쿼리상 비교때문에 하루 다음날로 넣어준다.)
        	sResult = (year+1) + "-12-16";        	
        }else{					//해당년도로 리턴
        	sResult = DateUtil.addDateNew(compareDate,1);
        }
        
    	return sResult;
    }
    
    /**
     * '2020-01-01' 형태의 문자열을 2020년 01월 01일 형태로 포맷을 바꿔준다.
     * @param sDate
     * @return
     * @throws ParseException 
     */
    public static String getTextDateFormat( String sDate ) throws ParseException {
    	
    	String sResult = "";
    	
    	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
    	Date transDate = transFormat.parse(sDate);
    	SimpleDateFormat sText = new SimpleDateFormat("yyyy년 MM월 dd일");
    	
    	sResult = sText.format(transDate);
    	
    	return sResult;
    }
    
    public static String parseMonthToYear( String sMonth) {
    	String sResult = "";
    	
    	int nMonth = Integer.parseInt(sMonth);
    	int nYear = 0;
    	
    	if( nMonth == 0 ) {
    		sResult = "0 개월";
    	}else{
    		//nYear = Math.floorDiv(nMonth, 12);
    		//nMonth = Math.floorMod(nMonth, 12);
    		nYear = nMonth / 12;
    		nMonth = nMonth % 12;
    		
    		if( nYear > 0 ) {
    			sResult = nYear+"년";
    		}
    		
    		if( nMonth > 0) {
    			sResult += " "+nMonth+"개월";    			
    		}
    	}
    	
    	return sResult;
    }    
    
    /**
     * 인보험 급여 날짜 계산용 함수 조회 시작일자 리턴     *
     * 급여정산 시작일은 전달 21일이다.  
     */
    public static String getBeforeMonthSalary4( String sDate ) {
    	String sRet = sDate.replace("-", "");
    	
    	Date dToday = getDateFromDateStr(sRet);
    	
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(dToday);         
    	cal.add(Calendar.MONTH, -1);
    	sRet = new SimpleDateFormat("yyyy-MM").format(cal.getTime())+"-21";        
    	
    	return sRet;
    }
    
    /**
     * 특정 날짜의 마지막 일을 return
     * @param args
     */
    public static String getMonthEndDay( String sDate ) {
    	
    	String sRet = sDate.replace("-", "");
    	
    	Date dToday = getDateFromDateStr(sRet);
    	
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(dToday);
    	
    	int nEnd = cal.getActualMaximum(cal.DAY_OF_MONTH);
    	
    	sRet = String.valueOf(nEnd);    			
    	
    	return sRet;    	
    }
    
    /**
	 * 특정날짜 3일전 구하기 (근무일수 기준. 계산된 날짜 이전날짜가 휴일인 경우 휴일이 기준날짜가 된다.)	 * 
	 * @param sInputDate
	 * @return sRet : 해당일자포함 이전날짜는 3일 초과된 날짜이다.
	 */    
	public static String getChkDateTo3Workdays( SqlSession sqlSession, String sInputDate ) {
		
		String sRet = "";
		
		//입력값이 없는경우 오늘 날짜로 계산한다.
		if( "".equals( sInputDate ) ) {
			sInputDate = getTodayString("yyyy-MM-dd");
		}
		
		List<Map<String, Object>> holidayList = sqlSession.selectList("MainIndexListMapper.selectWorkdayToBefore",sInputDate);
				
		int nChkDate = 3;
		int nSumWorkDays = 0;
				
		for( int i=0; i < holidayList.size(); i++ ) {
			nSumWorkDays += Integer.parseInt(String.valueOf(holidayList.get(i).get("h_flag")));
			
			if( nChkDate < nSumWorkDays ) {
				sRet = String.valueOf(holidayList.get(i).get("holiday_date"));				
				break;
			}
		}		
		return sRet;
	}
		
	/**
	 * 입력일자의 분기 기준시작, 종료일자를 return 한다.
	 * @param sSourceDate : 입력일자
	 * @return Map sDate : 시작일자, eDate : 종료일자, baseYear : 기준년도
	 */
	public static Map<String, Object> makeQuarterDate( String sSourceDate ){
		
		Map<String, Object> returnDate = new HashMap<>();
		
		//sSourceDate 의 기준 분기날짜를 만든다.
		String nowYear = sSourceDate.substring(0, 4);
		String beforeYear = String.valueOf(Integer.parseInt(nowYear)-1);
		String nextYear = String.valueOf(Integer.parseInt(nowYear)+1);
		
		String sDate0 = beforeYear+"-12-16";
		String sDate1 = nowYear+"-03-16";
		String sDate2 = nowYear+"-06-16";
		String sDate3 = nowYear+"-09-16";
		String sDate4 = nowYear+"-12-16";
		String sDate5 = nextYear+"-03-16";
		
		boolean bChk = false;
		
		bChk = getValidDate( sDate0, sDate1, sSourceDate);
		if( bChk ) {
			returnDate.put("sDate", sDate0);
			returnDate.put("eDate", sDate1);
			returnDate.put("baseYear", nowYear);
			returnDate.put("quaterFlag", "1");
		}
		
		bChk = getValidDate( sDate1, sDate2, sSourceDate);
		if( bChk ) {
			returnDate.put("sDate", sDate1);
			returnDate.put("eDate", sDate2);
			returnDate.put("baseYear", nowYear);
			returnDate.put("quaterFlag", "2");
		}
		
		bChk = getValidDate( sDate2, sDate3, sSourceDate);
		if( bChk ) {
			returnDate.put("sDate", sDate2);
			returnDate.put("eDate", sDate3);
			returnDate.put("baseYear", nowYear);
			returnDate.put("quaterFlag", "3");
		}
		
		bChk = getValidDate( sDate3, sDate4, sSourceDate);
		if( bChk ) {
			returnDate.put("sDate", sDate3);
			returnDate.put("eDate", sDate4);
			returnDate.put("baseYear", nowYear);
			returnDate.put("quaterFlag", "4");
		}
		
		bChk = getValidDate( sDate4, sDate5, sSourceDate);
		if( bChk ) {
			returnDate.put("sDate", sDate4);
			returnDate.put("eDate", sDate5);
			returnDate.put("baseYear", nextYear);
			returnDate.put("quaterFlag", "1");
		}
		
		return returnDate;
	}
	
	/**
	 * 입력날짜로 기준년도 가져오기
	 * @param sSourceDate
	 * @return
	 */
	public static String getBaseYear(String sSourceDate) {
		
		String sRet = "";
		String endDay = getEndYearDay(sSourceDate); 
		
		//sSourceDate 의 기준 분기날짜를 만든다.
		sRet = endDay.substring(0, 4);		 
		
		return sRet;
	}
	
	/**
	 * 입력 날짜까지의 분기시작 종료일을 List로 가져온다.
	 * @param sSourceDate
	 * @return
	 */
	public static List<Map<String, Object>> makeQuarterDateList(String sSourceDate){
		
		List<Map<String,Object>> returnList = new ArrayList<>();
		
		Map<String, Object> returnDate = new HashMap<>();		
		
		returnDate = makeQuarterDate(sSourceDate);
		
		int nQuarter = Integer.parseInt(String.valueOf(returnDate.get("quaterFlag")));
		String sBaseYear = String.valueOf(returnDate.get("baseYear"));
		
		//sSourceDate 의 기준 분기날짜를 만든다.
		String nowYear = sBaseYear.substring(0, 4);
		String beforeYear = String.valueOf(Integer.parseInt(nowYear)-1);		
		
		String sDate0 = beforeYear+"-12-16";
		String sDate1 = nowYear+"-03-16";
		String sDate2 = nowYear+"-06-16";
		String sDate3 = nowYear+"-09-16";
		String sDate4 = nowYear+"-12-16";
		
		for( int i=0; i < nQuarter; i++ ) {
			
			Map<String, Object> tempMap = new HashMap<>();
			
			if( i == 0 ) {
				tempMap.put("sQuarterFlag", "1");
				tempMap.put("sDate", sDate0);
				if( i+1 == nQuarter ) {
					tempMap.put("eDate", sSourceDate);
				}else{
					tempMap.put("eDate", sDate1);
				}				
			}else if( i == 1) {
				tempMap.put("sQuarterFlag", "2");
				tempMap.put("sDate", sDate1);
				if( i+1 == nQuarter ) {
					tempMap.put("eDate", sSourceDate);
				}else{
					tempMap.put("eDate", sDate2);
				}				
			}else if( i == 2) {
				tempMap.put("sQuarterFlag", "3");
				tempMap.put("sDate", sDate2);
				if( i+1 == nQuarter ) {
					tempMap.put("eDate", sSourceDate);
				}else{
					tempMap.put("eDate", sDate3);
				}				
			}else{
				tempMap.put("sQuarterFlag", "4");
				tempMap.put("sDate", sDate3);
				if( i+1 == nQuarter ) {
					tempMap.put("eDate", sSourceDate);
				}else{
					tempMap.put("eDate", sDate4);
				}				
			}
			
			returnList.add(i,tempMap);						
			
		}		
		return returnList;
	}
	
	/**
	 * 기준연도와 분기로 시작, 종료날짜 가져오기
	 * @param sBaseYear
	 * @param sQuarterFlag
	 * @return Map, sDate, eDate
	 */
	public static Map<String, Object> makeQuarterDateMap( String sBaseYear, String sQuarterFlag ){
		
		Map<String, Object> returnDate = new HashMap<>();
		
		String nowYear = sBaseYear;		
		String beforeYear = String.valueOf(Integer.parseInt(sBaseYear)-1);
		
		String sDate = "";
		String eDate = "";
				
		if( "2".equals(sQuarterFlag) ) {				//2분기
			sDate = nowYear+"-03-16";
			eDate = nowYear+"-06-15";			
		}else if( "3".equals(sQuarterFlag) ) {		//3분기
			sDate = nowYear+"-06-16";
			eDate = nowYear+"-09-15";
		}else if( "4".equals(sQuarterFlag) ) {		//4분기
			sDate = nowYear+"-09-16";
			eDate = nowYear+"-12-15";
		}else{												//1분기
			sDate = beforeYear+"-12-16";
			eDate = nowYear+"-03-15";
		}
		
		returnDate.put("sDate", sDate);
		returnDate.put("eDate", eDate);
		
		return returnDate;
	}
	
	/**
	 * 특정 일자 사이의 근무일 기준 (주말과 휴일을 제외) 날짜목록을 불러온다.	
	 * @param sDate : 시작일자 (yyyyMMdd)
	 * @param eDate : 종료일자 (yyyyMMdd)
	 * @return
	 */
	public static List<String> getBetweenWorkDateToList( String sDate, String eDate, SqlSession sqlSession ){
		
		List<String> dateList = new ArrayList<String>();
		
		String inputStartDate = sDate;
        String inputEndDate = eDate;
        
        String sPattern = "yyyyMMdd";
        
        //입력되는 데이터 양식에 따라 패턴을 바꿔준다.
        if(inputStartDate.contains("-")){
        	sPattern = "yyyy-MM-dd";
        }
        
        SimpleDateFormat sdf = new SimpleDateFormat(sPattern);
        Date startDate = null;
        Date endDate = null;
        int nHoliday = 0;
        
        try {
            startDate = sdf.parse(inputStartDate);
            endDate = sdf.parse(inputEndDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        Date currentDate = startDate;
        while (currentDate.compareTo(endDate) <= 0) {
        	//dateList.add(sdf.format(currentDate));
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            
            //주말은 제외
            int tmpDayOfWeek = c.get(Calendar.DAY_OF_WEEK);            
            if ( !(tmpDayOfWeek == 1 || tmpDayOfWeek == 7) ){
            	//공휴일 제외 (nHoliday가 1이면 공휴일)
            	nHoliday = sqlSession.selectOne("topVacationMapper.selectEventChk", sdf.format(currentDate));
            	if( nHoliday == 0 ) {			//공휴일이 아니면 List에 넣어준다.
            		dateList.add(sdf.format(currentDate));
            	}
			}
            
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
        }		
		return dateList;		
	}
	
	/**
	 * 
	 * 특정 일자 사이의 근무일 기준 (주말과 휴일을 제외) 날짜갯수를 불러온다.	
	 * @param sDate : 시작일자 (yyyyMMdd)
	 * @param eDate : 종료일자 (yyyyMMdd)
	 * @return
	 */
	public static int getBetweenWorkDateToCount( String sDate, String eDate, SqlSession sqlSession ) {
		
		int nCount = 0;
		
		String inputStartDate = sDate;
        String inputEndDate = eDate;
        String sPattern = "yyyyMMdd";
        
        //입력되는 데이터 양식에 따라 패턴을 바꿔준다.
        if(inputStartDate.contains("-")){
        	sPattern = "yyyy-MM-dd";
        }
        
        SimpleDateFormat sdf = new SimpleDateFormat(sPattern);
        Date startDate = null;
        Date endDate = null;
        int nHoliday = 0;
        
        try {
            startDate = sdf.parse(inputStartDate);
            endDate = sdf.parse(inputEndDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        Date currentDate = startDate;
        while (currentDate.compareTo(endDate) <= 0) {
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            
            //주말은 제외
            int tmpDayOfWeek = c.get(Calendar.DAY_OF_WEEK);            
            if ( !(tmpDayOfWeek == 1 || tmpDayOfWeek == 7) ){
            	//공휴일 제외 (nHoliday가 1이면 공휴일)
            	nHoliday = sqlSession.selectOne("topVacationMapper.selectEventChk", sdf.format(currentDate));
            	if( nHoliday == 0 ) {			//공휴일이 아니면 카운트를 증가시켜준다.            		
            		nCount++;
            	}
			}
            
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
        }		
		
		return nCount;
	}
	
	/**
	 * 입력연도가 윤년이면 366일을 가져오고 평년이면 365를 가져온다.
	 * @param sYear
	 * @return
	 */
	public static int getYearToDays(String sYear) {
		
		int nRet = 365;
		int nYear = Integer.parseInt(sYear);
		
		//윤년여부 확인 (해당연도를 4로 나눈값이 0인것을 의미하나 100으로 나눈값이 0인것은 윤년에서 제외)
		if( (nYear % 4 == 0 && nYear % 100 !=0) || nYear % 400 == 0) {
			nRet = 366;
		}
		
		return nRet;
	}
	
}
