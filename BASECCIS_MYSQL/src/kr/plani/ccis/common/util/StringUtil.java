package kr.plani.ccis.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.StringTokenizer;
import java.util.TimeZone;
import java.util.Vector;

import org.apache.commons.lang3.StringUtils;

import sun.misc.BASE64Encoder;
/**
 * 문자열 처리 유틸리티
 */
public class StringUtil
{
    /**
     * str이 null일 경우 defaultStr을 리턴
     *
     * @param str
     * @param defaultStr
     * @return String
     */
	public static String getString(String str, String defaultStr)
    {
        return ( "".equals(str) || str == null) ? defaultStr : str;
    }

    /**
     * obj가 null일 경우 defaultStr을 리턴. obj가 null이 아닌 경우 obj.toString() 이 리턴된다.
     *
     * @param obj
     * @param defaultStr
     * @return
     */
    public static String getString(Object obj, String defaultStr)
    {
        return (obj == null) ? defaultStr : obj.toString();
    }

    /**
     * 문자열 null 체크
     *
     * @param obj
     * @param String str
     * @return
     */
	public static boolean isNotBlank(String str) {
		if(str != null) {
			if(StringUtils.isNotBlank(StringUtils.trim(str))) {
				return true;
			}
		}
		return false;
	}

    /**
     * String 이 null 인지 체크 하여 null 이면 공백문자("")를 넘겨준다
     *
     * @param str 체크할 String
     * @return String
     */
    public static String nullCheck(Object obj)
    {

        return (obj == null) ? "" : obj.toString();
        
    }
    
    /**
     * Comment  : 입력받은 수만큼 날자 더하기.
     * @version : 1.0
     * @tags    : @param gubun
     * @tags    : @param nValue
     * @tags    : @return
     * @date    : 2010. 10. 29.
     */
	 public static String getDate(String gubun, int nValue){
		 Calendar temp = Calendar.getInstance();
		 StringBuffer sbDate = new StringBuffer();
		 
		 if(gubun.equals("day")){
			 temp.add(Calendar.DAY_OF_MONTH, nValue);
		 }else if(gubun.equals("month")){
			 temp.add(Calendar.MONTH, nValue);
		 }
		 
		 int nYear = temp.get(Calendar.YEAR);
		 int nMonth = temp.get(Calendar.MONTH)+1;
		 int nDay = temp.get(Calendar.DAY_OF_MONTH);

		 sbDate.append(nYear);
		 sbDate.append("-");
		 
		 if(nMonth < 10) sbDate.append("0");
		 sbDate.append(nMonth);
		 sbDate.append("-");
		 
		 if(nDay < 10) sbDate.append("0");
		 sbDate.append(nDay);

		 return sbDate.toString();
	 }
    
    /**
     * Comment  : 현재년도 받아오기.
     * @version : 1.0
     * @tags    : @return
     * @date    : 2010. 10. 29.
     */
	 public static String getYear(){
		 Calendar temp = Calendar.getInstance();
		 StringBuffer sbDate = new StringBuffer();

		 int nYear = temp.get(Calendar.YEAR);
		 sbDate.append(nYear);

		 return sbDate.toString();
	 }

    /**
	 * Comment  : 현재월 받아오기.
     * @version : 1.0
     * @tags    : @return
     * @date    : 2010. 10. 29.
     */
	 public static String getMonth(){
		 Calendar temp = Calendar.getInstance();
		 StringBuffer sbDate = new StringBuffer();

		 int nMonth = temp.get(Calendar.MONTH)+1;
		 sbDate.append(nMonth);

		 return sbDate.toString();
	 }
	 
	 /**
	 * Comment  : 현재일 받아오기.
     * @version : 1.0
     * @tags    : @return
     * @date    : 2010. 10. 29.
     */
	 public static String getDay(){
		 Calendar temp = Calendar.getInstance();
		 StringBuffer sbDate = new StringBuffer();

		 int nMonth = temp.get(Calendar.DAY_OF_MONTH);
		 sbDate.append(nMonth);

		 return sbDate.toString();
	 }

	 public static SimpleDateFormat formatter_y = new SimpleDateFormat("yyyy");
	 public static SimpleDateFormat formatter_m = new SimpleDateFormat("MM");

	/**
	 * 지정한 연/월로 달력을 만든다
	 * @param year
	 * @param month
	 */
	public static String[][] generateCalendar(int year, int month) {

		Calendar calendar = getCalendar();
		calendar.set(year, month-1,1);
		calendar.setFirstDayOfWeek(Calendar.MONDAY);
		
		int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		int firstDay = calendar.get(Calendar.DAY_OF_WEEK);
		if(firstDay == 1) firstDay = 8;
		
		String days[][] = new String[6][7];
		int dayCount = 1;
		String day = "";
		
		for ( int i = 0 ; i< 6 ; i++ ) {
			for ( int j = 0 ; j < 7; j++ ) {
				
				if ( firstDay -1 > 0 || dayCount > lastDay ) {
					days[i][j] = "";
					firstDay--;
					continue;
				} else {
					day = addZero(Integer.toString(dayCount));
					
					days[i][j] = day;
				}
				
				dayCount++;
			}
		}
		
		return days;
		
	}
		
	/**
	 * 기본 Calendar 설정
	 * @return
	 */
	public static Calendar getCalendar(){
		return Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"), Locale.KOREA);
	}
	
	 /**
	 * 10미만 숫자에 0추가 문자열로 리턴
	 * @param value
	 * @return
	 */
	public static String addZero(String value){
		String returnValue ="";
		
		if(value.length() < 2){
			returnValue = "0"+value;
		}else{
			returnValue = String.valueOf(value);
		}
		
		return returnValue; 
	}

	public static String asciiToHex(String ascii){
		StringBuilder hex = new StringBuilder();
		int cnt = 0;
		for (int i=0; i < ascii.length(); i++) {
		    hex.append(Integer.toHexString(ascii.charAt(i)));
		    
		    cnt++;
		} 
		
		//바코드 출력용 32자리
		for (int i=hex.toString().length(); i < 32; i++) {
		    hex.append(0);
		}
		return hex.toString().toUpperCase();
	}
    
    
	public static String reverse(String str) {
		char[] result = new char[str.length()]; //main에서 입력받은 문자열과 같은 크기으 배열을 하나 생성한다.
		char[] input = str.toCharArray(); //main에서 입력받은 문자열을 char배열에 저장한다.
		String rtnStr="";
		int nCtn = 0;
		for (int j = str.length() - 1; j >= 0; j--) { //input을 거꾸로 입력받아 하나씩 result에 저장한다.
			result[str.length() - 1 - j] = input[j];
			
			if(nCtn != 0){
				rtnStr = rtnStr + "|";
			}
			rtnStr = rtnStr + input[j];
			nCtn++;
		}
		//rtnStr = result.toString();
		
		return rtnStr;
	}
    
    
    /**
     * HTML 형식으로 반환
     *
     * @param str
     * @return 변환된 String. str이 <code>null</code>일 경우 null을 리턴
     */
    public static String toHTML(String str)
    {
        if (str == null)
            return null;

        String returnStr = str;
        returnStr = returnStr.replaceAll("&", "&amp;"); // &를 제일 먼저 변환
        returnStr = returnStr.replaceAll(" ", "&nbsp;");
        returnStr = returnStr.replaceAll("\"", "&#34;");
        returnStr = returnStr.replaceAll("<", "&lt;"); // \n 보다 앞에...
        returnStr = returnStr.replaceAll(">", "&gt;"); // \n 보다 앞에...
        returnStr = returnStr.replaceAll("\n", "<br>");
        returnStr = returnStr.replaceAll("\r", "");

        return returnStr;
    }
    
    /**
     * HTML 형식으로 반환(사업목록/개요/vo의 TEXTAREA)
     *
     * @param str
     * @return 변환된 String. str이 <code>null</code>일 경우 null을 리턴
     */
    public static String ConvtoHTML(String str)
    {
        if (str == null)
            return null;

        String returnStr = str;
        returnStr = returnStr.replaceAll("&", "&amp;"); // &를 제일 먼저 변환
        returnStr = returnStr.replaceAll(" ", "&nbsp;");
        returnStr = returnStr.replaceAll("\"", "&#34;");
        returnStr = returnStr.replaceAll("<", "&lt;"); // \n 보다 앞에...
        returnStr = returnStr.replaceAll(">", "&gt;"); // \n 보다 앞에...
        //returnStr = returnStr.replaceAll("\n", "<br>");
        returnStr = returnStr.replaceAll("\r", "");

        return returnStr;
    }

    /**
     * TEXT 형식으로 반환
     *
     * @param str
     * @return 변환된 String. str이 <code>null</code>일 경우 null을 리턴
     */
    public static String toTEXT(String str)
    {
        if (str == null)
            return null;

        String returnStr = str;
        returnStr = returnStr.replaceAll("<br>", "\n");
        returnStr = returnStr.replaceAll("&gt;", ">");
        returnStr = returnStr.replaceAll("&lt;", "<");
        returnStr = returnStr.replaceAll("&quot;", "\"");
        returnStr = returnStr.replaceAll("&nbsp;", " ");
        returnStr = returnStr.replaceAll("&amp;", "&");
        returnStr = returnStr.replaceAll("\"", "&#34;");
        //returnStr = returnStr.replaceAll("&#34;", "\"");

        return returnStr;
    }

    /**
     * toTEXT_VIEW
     *
     * @param str String
     * @return String
     */
    public static String toTEXT_VIEW(String str)
    {
        if (str == null)
            return null;

        String returnStr = str;
        returnStr = returnStr.replaceAll("<br>", "\n");
        returnStr = returnStr.replaceAll("&gt;", ">");
        returnStr = returnStr.replaceAll("&lt;", "<");
        returnStr = returnStr.replaceAll("&quot;", "\"");
        returnStr = returnStr.replaceAll("&nbsp;", " ");
        returnStr = returnStr.replaceAll("&amp;", "&");
        returnStr = returnStr.replaceAll("&#34;", "\"");

        return returnStr;
    }

    /**
     * String Array를 String으로 반환
     *
     * @param value
     * @param str
     * @return 변환된 String
     * @throws value가
     *             <code>null</code>이면 NullPointerException 발생
     */
    public static String arrToStr(String[] value, String str)
    {
        String rtn = "";

        for (int i = 0; i < value.length; i++)
        {
            rtn = rtn + value[i];

            if (i < value.length - 1)
                rtn = rtn + str;
        }

        return rtn;
    }

    /**
     * String을 Seperator로 나눠서 String Array로 반환
     *
     * @param source
     * @param sp
     * @return 변환된 String[]
     * @throws source가
     *             <code>null</code>이면 NullPointerException 발생
     */
    public static String[] strToArr(String source, String sp)
    {
        Vector newarray = new Vector();

        int i = 0;
        int inpos = 0;

        String temp = "";
        String[] sarray = null;

        try
        {
            while (source.length() > 0)
            {
                inpos = source.indexOf(sp);

                if (inpos < 0)
                {
                    inpos = source.length();
                }

                temp = source.substring(0, inpos);
                newarray.addElement(temp);

                if (inpos != source.length())
                {
                    source = source.substring((inpos + sp.length()), source.length());
                }
                else
                {
                    source = "";
                }

                i++;
            }

            sarray = new String[i];

            for (int j = 0; j < i; j++)
            {
                sarray[j] = newarray.elementAt(j).toString();
            }

        }
        catch (Exception e)
        {

        	System.out.println("처리 중 오류가 발생했습니다.");
        }

        return sarray;
    }

    /**
     * 특정 길이 이후로 잘라내고 '...'을 붙임
     *
     * @param str
     * @param len
     * @return 변환된 String
     * @throws str이
     *             <code>null</code>이면 NullPointerException 발생
     */
    public static String cutString(String str, int len)
    {
        return cutString(str, len, "...");
    }

    /**
     * 특정 길이 이후로 잘라냄
     *
     * @param str
     * @param len
     * @param extraStr
     * @return
     */
    public static String cutString(String str, int len, String extraStr)
    {
        return (str.length() > len) ? str.substring(0, len) + ((extraStr != null) ? extraStr : "") : str;
    }

    /**
     * String을 특정길이로 만듬.. 자릿수를 주어진 String으로 채운다. (Left Padding)
     *
     * @param sourceStr
     * @param dimension
     * @param insertStr
     * @return 변환된 String
     * @throws sourceStr이
     *             <code>null</code>이면 NullPointerException 발생
     * @throws insertStr이
     *             <code>null</code>이면 NullPointerException 발생
     */
    public static String lpad(String sourceStr, int dimension, String insertStr)
    {
        String str = sourceStr;
        int len = str.length();

        if (len < dimension)
        {
            for (int i = 0; i < dimension - len; i++)
            {
                str = insertStr + str;
            }
        }
        else if (len > dimension)
        {
            str = str.substring(0, dimension);
        }
        return str;
    }

    /**
     * String을 특정길이로 만듬.. 자릿수를 주어진 String으로 채운다. (Right Padding)
     *
     * @param sourceStr
     * @param dimension
     * @param insertStr
     * @return 변환된 String
     * @throws sourceStr이
     *             <code>null</code>이면 NullPointerException 발생
     * @throws insertStr이
     *             <code>null</code>이면 NullPointerException 발생
     */
    public static String rpad(String sourceStr, int dimension, String insertStr)
    {
        String str = sourceStr;
        int len = str.length();

        if (len < dimension)
        {
            for (int i = 0; i < dimension - len; i++)
            {
                str = str + insertStr;
            }
        }
        else if (len > dimension)
        {
            str = str.substring(0, dimension);
        }
        return str;
    }

    /**
     * 숫자형 Left Padding ('0'으로 채운다.)
     *
     * @param sourceStr
     * @param dimension
     * @return 변환된 String
     * @throws sourceStr이
     *             <code>null</code>이면 NullPointerException 발생
     */
    public static String DecimalLPad(String sourceStr, int dimension)
    {
        return lpad(sourceStr, dimension, "0");
    }

    /**
     * ASCII 코드 반환
     *
     * @param s
     * @return 변환된 int[] - 아스키 코드 값
     * @throws s가
     *             <code>null</code>이면 NullPointerException 발생
     */
    public static int[] toASCII(String s)
    {
        int[] ascii = new int[s.length()];
        char[] chars = s.toCharArray();
        int len = chars.length;
        for (int i = 0; i < len; i++)
        {
            ascii[i] = chars[i];
        }

        return ascii;
    }

    /**
     * 문자열의 특정 위치에 해당 문자열을 바인딩 ('?'를 대상으로 바인딩)
     *
     * @param targetStr :
     *            대상 문자열
     * @param list :
     *            대체할 문자열 리스트
     * @return 바인딩 된 String
     * @throws targetStr이
     *             <code>null</code>이면 NullPointerException 발생
     * @throws list가
     *             <code>null</code>이면 NullPointerException 발생
     * @throws targetStr에
     *             바인딩 될 문자열의 갯수와 바인딩 할 문자열의 갯수가 일치하지 않으면 Exception 발생
     */
    public static String bind(String targetStr, String[] list) throws Exception
    {
        return bind(targetStr, list, "?");
    }

    /**
     * 문자열의 특정 위치에 해당 문자열을 바인딩
     *
     * @param targetStr :
     *            대상 문자열
     * @param list :
     *            대체할 문자열 리스트
     * @param bindingStr :
     *            대체될 문자열 (해당 문자열을 찾아 바인딩 할 문자열로 대체)
     * @return 바인딩 된 String
     * @throws targetStr이
     *             <code>null</code>이면 NullPointerException 발생
     * @throws list가
     *             <code>null</code>이면 NullPointerException 발생
     * @throws bindingStr이
     *             <code>null</code>이면 NullPointerException 발생
     * @throws targetStr에
     *             바인딩 될 문자열의 갯수와 바인딩 할 문자열의 갯수가 일치하지 않으면 Exception 발생
     */
    public static String bind(String targetStr, String[] list, String bindingStr) throws Exception
    {
        String[] sepStr = targetStr.split("[" + bindingStr + "]");
        int bindingPositionCount = sepStr.length - 1;
        if (bindingPositionCount != list.length)
            throw new Exception("Unmatched Binding Count");

        StringBuffer result = new StringBuffer();
        for (int i = 0; i < bindingPositionCount; i++)
        {
            result.append(sepStr[i]).append(list[i]);
        }
        result.append(sepStr[bindingPositionCount]);

        return result.toString();
    }

    /**
     * 문자열의 특정 위치에 해당 문자열을 바인딩 ('?'를 대상으로 바인딩)
     *
     * @param targetStr :
     *            대상 문자열
     * @param bindingIndex :
     *            바인딩 할 위치 (1부터 시작)
     * @param str :
     *            대체할 문자열
     * @return 바인딩 된 String
     * @throws targetStr이
     *             <code>null</code>이면 NullPointerException 발생
     * @throws bindingIndex
     *             위치가 정확하지 않으면 Exception 발생
     */
    public static String bind(String targetStr, int bindingIndex, String str) throws Exception
    {
        return bind(targetStr, bindingIndex, str, "?");
    }

    /**
     * 문자열의 특정 위치에 해당 문자열을 바인딩
     *
     * @param targetStr :
     *            대상 문자열
     * @param bindingIndex :
     *            바인딩 할 위치 (1부터 시작)
     * @param str :
     *            대체할 문자열
     * @param bindingStr :
     *            대체될 문자열 (해당 문자열을 찾아 바인딩 할 문자열로 대체)
     * @return 바인딩 된 String
     * @throws targetStr이
     *             <code>null</code>이면 NullPointerException 발생
     * @throws bindingStr이
     *             <code>null</code>이면 NullPointerException 발생
     * @throws bindingIndex
     *             위치가 정확하지 않으면 Exception 발생
     */
    public static String bind(String targetStr, int bindingIndex, String str, String bindingStr) throws Exception
    {
        int index = -1;
        for (int i = 0; i < bindingIndex; i++)
        {
            index = targetStr.indexOf(bindingStr, index + 1);
        }

        StringBuffer result = new StringBuffer();
        if (index < 0)
        {
            throw new Exception("Invalid Binding Index");
        }
        else
        {
            result.append(targetStr.substring(0, index));
            result.append(str);
            result.append(targetStr.substring(index + bindingStr.length()));
        }

        return result.toString();
    }

    public static String[] getTokenStr(String str, String dim)
    {
    	if( str==null || dim == null ) 
    		return null;
    	int i = 0, size = 0;
    	String[] value = null;
    	StringTokenizer token = new StringTokenizer(str, dim);
    	size = token.countTokens();
    	if ( size == 0 ) 
    		return null;
    	value = new String[size];
    	
		while(token.hasMoreTokens())
			value[i++] = token.nextToken();
		return value;
    }
    
    /**
     * 주어진 문자열에서 source를 찾아서 target로 변환한다.
     *
     * @param	str	입력문자열
     * @param	source	변환할 문자열
     * @param	taget	변환후 문자열
     * @return	변환된 문자열
     */
    public static String str_replace(String str, String source, String target) {
        int cur = 0, before = 0;

        if(source == null || source.equals("")) {
            return "";
        }

        StringBuffer sr = new StringBuffer();

        while((cur = str.indexOf(source, before)) >= 0) {
            sr.append(str.substring(before, cur));
            sr.append(target);
            before = cur + source.length();
        }

        sr.append(str.substring(before));

        return sr.toString();
    }

    // 문자열을 특정 문자를 기준으로 배열화
    public static String[] getStringSplit(String str, String div) {
        int arrayCount = 0;
        String temp1 = str;
        String temp2 = str;
        String[] stringArray = null;
        int index = -1;
        if(temp1 != null) {
            if(temp1.lastIndexOf(div) < (temp1.length() - div.length())) {
                temp1 += div;
                temp2 += div;
            } while((index = temp1.indexOf(div)) > -1) {
                temp1 = temp1.substring(index + div.length());
                arrayCount++;
            }
            stringArray = new String[arrayCount];
            for(int i = 0; i < arrayCount; i++) {
                index = temp2.indexOf(div);
                stringArray[i] = temp2.substring(0, index);
                temp2 = temp2.substring(index + div.length());
            }
        }
        return stringArray;
    }    

    public static String convertDateTimeType(String dateString)
    {
    	if(dateString.length() == 0)
    		return "";
    	if(dateString.length() != 14)
    	{
    		return "";
    	}else
    	{
    		String year = dateString.substring(0,4);
    		String month = dateString.substring(4,6);
    		String date = dateString.substring(6,8);
    		return year + "-" + month + "-" + date ;
    	}
    }
    
    public static String roundS(String s , int demi) {
        if( s == null || s.equals("")) return "";
        else {
        	String dps = "1.0e"+(demi-1);
        	double dp  = (new Double(dps)).doubleValue();
        	double sd = (new Double(s)).doubleValue();
        	sd = (Math.round(sd*dp)/dp);
        	String d1s = sd+"";
        	if(d1s.indexOf(".")==-1)
        	    d1s = d1s+".00";
        	else {
        	    String tmpzero =  rpad(d1s.substring(d1s.indexOf(".")+1),"0",demi -1);
        	    d1s = d1s.substring(0,d1s.indexOf("."))+"."+tmpzero;
        	}
        	return d1s;
        }
    }
    
    /**
     * 오른쪽에 특정 문자를 채운다. rpad("123","A",5) -> "123AA"
     * @param str 원래 문자열
     * @param pading 채울 문자
     * @param d 전체문자열의 길이
     * @return 채워진 문자열
     */
    public static String rpad(String str, String pading, int d) {
        String rtn = "";
        if(str.length()<d) {
            int paddingCount = d-str.length();
            for(int i=0 ;i < paddingCount ; i++) str=str+pading;
            rtn = str;
            }else rtn = str.substring(0,d);
        return rtn;
    }    
    
    public static String getRound(String org, int i) {
        String result = "";
        try {
            if(org != null && org.length() > 0 && i > 0) {
                double dTmp = Double.parseDouble(org);
                long lTmp = Math.round(dTmp * Math.pow(10, i));
                double dTmp2 = (double)lTmp / (double)Math.pow(10, i);
                result = Double.toString(dTmp2);
            }
        } catch(Exception ex) {
        	System.out.println("처리 중 오류가 발생했습니다.");
    	}
        return result;
    }
    
    public static String getCurrencyTypeDot(String strOrg, boolean bDot) {

        String strVal = "0.0";
        String strMinus = "";
        String strOut = "";

        if(strOrg.length() != 0) {

            if(strOrg.indexOf("-") == 0) {
                strOrg = strOrg.substring(1);
                strMinus = "-";
            }

            strOrg = getReplace(strOrg, "-", "");

            if(strOrg.indexOf(".") == -1) {
                strOrg += ".0";
            }
            strOrg += ".";

            String[] dotPos = getStringSplit(strOrg, ".");

            String dotU = dotPos[0];
            String dotD = dotPos[1];

            // 소숫점 반올림 처리
            String tmp = getRound("0." + dotD, 1);
            if(tmp.length() > 0) {
                dotD = tmp.substring(2);
            } else {
                dotD = tmp;
            }

            if(dotU == null || dotU.length() == 0) {
                dotU = "0";
            }

            if(dotD == null || dotD.length() == 0) {
                dotD = "0";
            }

            if(dotD.length() > 1) {
                dotD = dotD.substring(0, 1);
            }

            int commaFlag = dotU.length() % 3;

            if(commaFlag > 0) {
                strOut = dotU.substring(0, commaFlag);
                if(dotU.length() > 3) {
                    strOut += ",";
                }
            } else {
                strOut = "";
            }

            for(int i = commaFlag; i < dotU.length(); i += 3) {
                strOut += dotU.substring(i, i + 3);
                if(i < dotU.length() - 3) {
                    strOut += ",";
                }
            }
            
            if(bDot){
            	strVal = strMinus + strOut + "." + dotD;
            }else{
            	strVal = strMinus + strOut;
            }

        }

        return strVal;
    }    

    
    // 문자의 위치를 서로 바꾼다.
    public static String getReplace(String str, String n1, String n2) {
        int itmp = 0;
        if(str == null)
            return "";

        String tmp = str;
        StringBuffer sb = new StringBuffer();
        sb.append("");
        while(tmp.indexOf(n1) > -1) {
            itmp = tmp.indexOf(n1);
            sb.append(tmp.substring(0, itmp));
            sb.append(n2);
            tmp = tmp.substring(itmp + n1.length());
        }
        sb.append(tmp);
        return sb.toString();
    }
    
    ///////////////////////////////////////////////////////
    // 제목 일정 자리수이후로 짜르는 메소드
    // @param str	입력 데이터. String 타입.
    // @param i		byte 수. int 타입
    // @return		처리 결과. String 타입.
	public static String getShortString( String str, int i, String titleYn)
	{
		if (str==null) return "";
		
		String preStr = str;
		String tmp = str;
		
		int slen = 0, blen = 0;
		char c;
		if(tmp.getBytes().length>i)
		{
		    while (blen+1 < i)
			{
				c = tmp.charAt(slen);
				blen++;
				slen++;
				if (  new Character(c).toString().getBytes().length > 1  ) blen++; //2-byte character..
		    }
		    tmp=tmp.substring(0,slen)+"..";
		}
		if(titleYn.equals("Y"))
			return "<span title='"+preStr+"'>"+tmp+"</span>";
		else
			return tmp;
	}

	public static String stripTag(String str)
	{
		return str.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

    public static String getContentType(String strOrg) {
        String strResult = "";
        if(strOrg == null) {
            strResult = "";
        } else {
            strResult = strOrg;
            strResult = getReplace(strResult, "&", "&amp;");
            strResult = getReplace(strResult, "\"", "&quot;");
            strResult = getReplace(strResult, "<", "&lt;");
            strResult = getReplace(strResult, ">", "&gt;");
            strResult = getReplace(strResult, "\r\n", "<br>");
            strResult = getReplace(strResult, " ", "&nbsp;");
            strResult = getReplace(strResult, "\"", "''");
        }
        return strResult;
    }

    //URLEncoder
	public static String getURLEncoding(String str)
	{
		if(str == null)
	        return "";
	    else
	        return new String(java.net.URLEncoder.encode(str));

    }

	//URLDecoder
    public static String getURLDecoding(String str)
	{   	
        if(str == null)
            return "";
        else
            return new String(java.net.URLDecoder.decode(str));   
    	
    }


    public static String getCurrencyTypeDot(String strOrg) {

        String strVal = "0.0";
        String strMinus = "";
        String strOut = "";

        if(strOrg != null && strOrg.length() != 0) {

            if(strOrg.indexOf("-") == 0) {
                strOrg = strOrg.substring(1);
                strMinus = "-";
            }

            strOrg = getReplace(strOrg, "-", "");

            if(strOrg.indexOf(".") == -1) {
                strOrg += ".0";
            }
            strOrg += ".";

            String[] dotPos = getStringSplit(strOrg, ".");

            String dotU = dotPos[0];
            String dotD = dotPos[1];

            // 소숫점 반올림 처리
            String tmp = getRound("0." + dotD, 1);
            if(tmp.length() > 0) {
                dotD = tmp.substring(2);
            } else {
                dotD = tmp;
            }

            if(dotU == null || dotU.length() == 0) {
                dotU = "0";
            }

            if(dotD == null || dotD.length() == 0) {
                dotD = "0";
            }

            if(dotD.length() > 1) {
                dotD = dotD.substring(0, 1);
            }

            int commaFlag = dotU.length() % 3;

            if(commaFlag > 0) {
                strOut = dotU.substring(0, commaFlag);
                if(dotU.length() > 3) {
                    strOut += ",";
                }
            } else {
                strOut = "";
            }

            for(int i = commaFlag; i < dotU.length(); i += 3) {
                strOut += dotU.substring(i, i + 3);
                if(i < dotU.length() - 3) {
                    strOut += ",";
                }
            }

            strVal = strMinus + strOut + "." + dotD;

        }

        return strVal;

    }
    
    public static String getCurrencyType2Dot(String strOrg) {

        String strVal = "0.00";
        String strMinus = "";
        String strOut = "";

        if(strOrg != null && strOrg.length() != 0) {

            if(strOrg.indexOf("-") == 0) {
                strOrg = strOrg.substring(1);
                strMinus = "-";
            }
//			strOrg = strOrg.replace("-", "");
            strOrg = getReplace(strOrg, "-", "");

            if(strOrg.indexOf(".") == -1) {
                strOrg += ".00";
            }
            strOrg += ".";

            String[] dotPos = getStringSplit(strOrg, ".");

            String dotU = dotPos[0];
            String dotD = dotPos[1];

            // 소숫점 반올림 처리
            String tmp = getRound("0." + dotD, 2);
            if(tmp.length() > 0) {
                dotD = tmp.substring(2);
            } else {
                dotD = tmp;
            }

            if(dotU == null || dotU.length() == 0) {
                dotU = "0";
            }

            if(dotD == null || dotD.length() == 0) {
                dotD = "00";
            }

            if(dotD.length() == 1) {
                dotD = dotD + "0";
            } else if(dotD.length() > 2) {
                dotD = dotD.substring(0, 2);
            }

            int commaFlag = dotU.length() % 3;

            if(commaFlag > 0) {
                strOut = dotU.substring(0, commaFlag);
                if(dotU.length() > 3) {
                    strOut += ",";
                }
            } else {
                strOut = "";
            }

            for(int i = commaFlag; i < dotU.length(); i += 3) {
                strOut += dotU.substring(i, i + 3);
                if(i < dotU.length() - 3) {
                    strOut += ",";
                }
            }

            strVal = strMinus + strOut + "." + dotD;

        }

        return strVal;

    }

    public static String getCurrencyTypeDotDef(String strOrg, int dotLength) {

        String strVal = "";
        String strMinus = "";
        String strOut = "";

        if(strOrg != null && strOrg.length() != 0) {
            if(strOrg.indexOf("-") == 0) {
                strOrg = strOrg.substring(1);
                strMinus = "-";
            }

            strOrg = getReplace(strOrg, "-", "");

            String dotU = "";
            String dotD = "";
            
            if(dotLength == 0){
            	if(strOrg.indexOf(".") != -1){
    	            String[] dotPos = getStringSplit(strOrg, ".");
    	        	
    	            dotU = dotPos[0];
    	            dotD = dotPos[1];
    	            
    	            // 소숫점 반올림 처리
    	            Double tmp = Double.parseDouble("0." + dotD) + 0.5;
    	            if(tmp >= 1) {
    	            	dotU = (Double.parseDouble(dotU) + 1) + "";
    	            	dotU = dotU.substring(0, dotU.indexOf("."));
    	            }
            	}
            	else{
            		dotU = strOrg;
            	}
            }
            else{
	            if(strOrg.indexOf(".") == -1) {
	                strOrg += ".";
	                for(int i = 0; i < dotLength; i++)
	                	strOrg += "0";
	            }
	
	            String[] dotPos = getStringSplit(strOrg, ".");
	
	            dotU = dotPos[0];
	            dotD = dotPos[1];
	            
	            // 소숫점 반올림 처리
	            String tmp = getRound("0." + dotD, dotLength);
	            if(tmp.length() > 0) {
	                dotD = tmp.substring(2);
	            } else {
	                dotD = tmp;
	            }
	            
	            if(dotU == null || dotU.length() == 0) {
	                dotU = "0";
	            }
	
	            if(dotD == null || dotD.length() == 0) {
	                dotD = "";
	                for(int i = 0; i < dotLength; i++)
	                	dotD += "0";
	            }
	            else if(dotD.length() > dotLength) {
	                dotD = dotD.substring(0, dotLength);
	            }
	            else
	            {
	            	int k = dotD.length();
	            	for(int i = 0; i < dotLength - k; i++)
	                	dotD += "0";
	            }
            }
	
            int commaFlag = dotU.length() % 3;

            if(commaFlag > 0) {
                strOut = dotU.substring(0, commaFlag);
                if(dotU.length() > 3) {
                    strOut += ",";
                }
            } else {
                strOut = "";
            }

            for(int i = commaFlag; i < dotU.length(); i += 3) {
                strOut += dotU.substring(i, i + 3);
                if(i < dotU.length() - 3) {
                    strOut += ",";
                }
            }

            if(dotLength > 0)
            	strVal = strMinus + strOut + "." + dotD;
            else
            	strVal = strMinus + strOut;
        }
        else{
        	if(dotLength == 0)
        		strVal = "0";
        	else{
	        	strVal += "0.";
	            for(int i = 0; i < dotLength; i++)
	            	strVal += "0";
        	}
        }

        return strVal;
    }
    
    public static String getCurrencyTypeFree(String strOrg) {

        String strVal = "";
        String strMinus = "";
        String strOut = "";

        if(strOrg != null && strOrg.length() != 0) {

            if(strOrg.indexOf("-") == 0) {
                strOrg = strOrg.substring(1);
                strMinus = "-";
            }
            strOrg = getReplace(strOrg, "-", "");
            strOrg = getReplace(strOrg, ",", "");

            if(Double.parseDouble(strOrg) == 0){
            	strOrg = "0";
            	strMinus = "";
            }

            String dotU = "";
            String dotD = "";

            if(strOrg.indexOf(".") != -1) {
                strOrg += ".";
                String[] dotPos = getStringSplit(strOrg, ".");
                dotU = dotPos[0];
                dotD = dotPos[1];
                
                if(dotD != null && dotD.length() != 0){
                	String temp = "";
                	 for(int i = dotD.length() - 1; i >= 0; i --) {
                         if(!"0".equals(dotD.substring(i, i + 1))) {
                        	 temp =  dotD.substring(0, i + 1);
                        	 break;
                         }
                     }
                	 
                	 dotD = temp;
                }
            } else {
                dotU = strOrg;
            }

            if(dotU == null || dotU.length() == 0) {
                dotU = "0";
            }

            int commaFlag = dotU.length() % 3;

            if(commaFlag > 0) {
                strOut = dotU.substring(0, commaFlag);
                if(dotU.length() > 3) {
                    strOut += ",";
                }
            } else {
                strOut = "";
            }

            for(int i = commaFlag; i < dotU.length(); i += 3) {
                strOut += dotU.substring(i, i + 3);
                if(i < dotU.length() - 3) {
                    strOut += ",";
                }
            }

            if(dotD != null && dotD.length() != 0)
                strVal = strMinus + strOut + "." + dotD;
            else
                strVal = strMinus + strOut;
        }

        return strVal;
    }

    public static String getCurrencyType(String strOrg) {

        String strVal = "";
        String strMinus = "";

        if(strOrg != null && strOrg.length() != 0) {

            if(strOrg.indexOf("-") == 0) {
                strOrg = strOrg.substring(1);
                strMinus = "-";
            }
//			strOrg = strOrg.replace("-", "");
            strOrg = getReplace(strOrg, "-", "");

            int commaFlag = strOrg.length() % 3;

            String strOut = "";

            if(commaFlag > 0) {
                strOut = strOrg.substring(0, commaFlag);
                if(strOrg.length() > 3) {
                    strOut += ",";
                }
            } else {
                strOut = "";
            }

            for(int i = commaFlag; i < strOrg.length(); i += 3) {
                strOut += strOrg.substring(i, i + 3);
                if(i < strOrg.length() - 3) {
                    strOut += ",";
                }
            }

            strVal = strMinus + strOut;

        }

        return strVal;

    }

    public static String getNumberType(String strOrg) {

        String strVal = "";

        if(strOrg.length() != 0) {

            String out = "";

            for(int i = 0; i < strOrg.length(); i++) {
                if(strOrg.charAt(i) == ',') {
                    out += "";
                } else {
                    out += strOrg.charAt(i);
                }
            }

            strVal = out;

        }

        return strVal;

    }

    /*파일 명 중복 처리*/
    public static boolean setFileReName(String name, String rename, String path) {
        try {
            String oldname = path + "/" + name;
            String Rename = path + "/" + rename;
            File tmpname = new File(oldname);
            FileInputStream in = new FileInputStream(oldname);
            FileOutputStream outt = new FileOutputStream(Rename);
            byte[] buffer = new byte[16];
            int numberRead;
            while((numberRead = in.read(buffer)) >= 0)
                outt.write(buffer, 0, numberRead);
            outt.close();
            in.close();
            tmpname.delete();
            return true;
        } catch(Exception e) {
            //e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
            return false;
        }
    }


    public static String toEncoding(String str)
    {
        if (str == null)
            return null;

        String returnStr = str;
        returnStr = returnStr.replaceAll("&", "-"); // &를 제일 먼저 변환

        return returnStr;
    }
    
	/**
	 * 암호화 인코딩 처리
	 * 
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public static String encrypt(String str) throws Exception
	{
		MessageDigest md = MessageDigest.getInstance("SHA-1");
		md.update(str.getBytes("UTF-8"));
		
		return new BASE64Encoder().encode(md.digest());
	}
	
	
	/**
	 * StrToDate 문자를 Date 형식으로 반환
	 * @param str
	 * @param format
	 * @return
	 */
	public static String StrToDate(String str, String format){
		
		String strTemp = "";
		
		String tempFormat = "yyyy-MM-dd HH:mm:ss.S";
		
		if(format == null || format == ""){
			format = tempFormat;
		}
		
		if(str.length() < 15 ){
			for(int i=str.length(); i < 15; i++){
				str += "0";
			}
		}
		
		DateFormat date1 = new SimpleDateFormat("yyyyMMddHHmmss");
		DateFormat sdFormat = new SimpleDateFormat(format);
		
		try {
			
			Date date2 = date1.parse(str);
			String tempDate = sdFormat.format(date2);
			
			strTemp = tempDate;
		} catch (ParseException e) {
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
		
		return strTemp;
		
	}

	/**
	 * userAgent에서 브라우져 받아옴
	 * @param str
	 * @param format
	 * @return
	 */
	public static String browser(String userAgent){
		
		String strRtn = "";
		userAgent = userAgent.toLowerCase();
		
		if(userAgent.indexOf("msie") > -1){
			strRtn = "msie";
		}else if(userAgent.indexOf("chrome/") > -1){
			strRtn = "chrome";
		}else if(userAgent.indexOf("safari/") > -1){
			strRtn = "safari";
		}else if(userAgent.indexOf("navigator/") > -1){
			strRtn = "netscape";
		}else if(userAgent.indexOf("opera/") > -1){
			strRtn = "opera";
		}else if(userAgent.indexOf("flock/") > -1){
			strRtn = "flock";
		}else if(userAgent.indexOf("firefox/") > -1){
			strRtn = "firefox";
		}else{
			strRtn = "others";
		}
		
		return strRtn;
		
	}
	
	/**
	 * userAgent에서 os 받아옴
	 * @param str
	 * @param format
	 * @return
	 */
	public static String os(String userAgent){
		
		String strRtn = "";
		userAgent = userAgent.toLowerCase();
		
		if(userAgent.indexOf("android") > -1){
			strRtn = "android";
		}else if(userAgent.indexOf("iphone") > -1){
			strRtn = "iphone";
		}else if(userAgent.indexOf("blackberry") > -1){
			strRtn = "blackberry";
		}else if(userAgent.indexOf("navigator/") > -1){
			strRtn = "netscape";
		}else if(userAgent.indexOf("ipod") > -1){
			strRtn = "ipod";
		}else if(userAgent.indexOf("ipad") > -1){
			strRtn = "ipad";
		}else if(userAgent.indexOf("windows") > -1){
			strRtn = "windows";
		}else if(userAgent.indexOf("macintosh") > -1 || userAgent.indexOf("mac_powerpc") > -1 || userAgent.indexOf("mac") > -1){
			strRtn = "mac";
		}else if(userAgent.indexOf("lg") > -1){
			strRtn = "lg others";
		}else if(userAgent.indexOf("samsung") > -1){
			strRtn = "samsung others";
		}else if(userAgent.indexOf("iemobile") > -1){
			strRtn = "iemobile";
		}else{
			strRtn = "others";
		}
		
		return strRtn;
		
	}	
	
    /**
	 * XSS 방지 처리.
	 * 
	 * @param data
	 * @return
	 */
	public static String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}

		String ret = data;

		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");

		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");

		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");

		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");

		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		
		ret = ret.replaceAll("alert\\((.*)\\)", "");
		ret = ret.replaceAll("confirm\\((.*)\\)", "");
		ret = ret.replaceAll("prompt\\((.*)\\)", "");
		ret = ret.replaceAll("onerror\\((.*)\\)", "");
		ret = ret.replaceAll("onload\\((.*)\\)", "");
		ret = ret.replaceAll("onfocus\\((.*)\\)", "");
		ret = ret.replaceAll("onmouseover\\((.*)\\)", "");
		ret = ret.replaceAll("document.cookie\\((.*)\\)", "");
		ret = ret.replaceAll("iframe\\((.*)\\)", "");
		ret = ret.replaceAll("object\\((.*)\\)", "");
		ret = ret.replaceAll("script\\((.*)\\)", "");
		ret = ret.replaceAll("eval\\((.*)\\)", "");
		
		ret = ret.replaceAll("alert", "-");
		ret = ret.replaceAll("confirm", "-");
		ret = ret.replaceAll("prompt", "-");
		ret = ret.replaceAll("onerror", "-");
		ret = ret.replaceAll("onload", "-");
		ret = ret.replaceAll("onfocus", "-");
		ret = ret.replaceAll("onmouseover", "-");
		ret = ret.replaceAll("document.cookie", "-");
		ret = ret.replaceAll("iframe", "-");
		ret = ret.replaceAll("object", "-");
		ret = ret.replaceAll("script", "-");
		ret = ret.replaceAll("eval", "-");
		
		ret = ret.replaceAll("<", "&lt;");
		ret = ret.replaceAll(">", "&gt;");
		ret = ret.replaceAll("&lt;br/&gt;", "<br/>");

		return ret;
	}
	

    /**
	 * XSS 방지 처리.
	 * 
	 * @param data
	 * @return
	 */
	public static String paramUnscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}
		
		String ret = data;
		ret = unscript(ret);

		ret = ret.replaceAll("'", "&apos;");
		ret = ret.replaceAll("\"", "&quot;");
		ret = ret.replaceAll("<", "&lt;");
		ret = ret.replaceAll(">", "&gt;");
		//ret = ret.replaceAll(";", "&#59;");

		return ret;
	}
	
	/**
	 * XSS 방지 디코드 처리.
	 * 
	 * @param data
	 * @return
	 */
	public static String deParamUnscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}
		
		String ret = data;
		ret = unscript(ret);

		//ret = ret.replaceAll("&#59;", ";" );
		ret = ret.replaceAll( "&#34;" ,"\"");
		ret = ret.replaceAll( "&#39;", "'");
		ret = ret.replaceAll("&lt;", "<" );
		ret = ret.replaceAll("&gt;", ">" );
		ret = ret.replaceAll("&quot;", "\"" );
		ret = ret.replaceAll("&#37;", "%" );
		//ret = ret.replaceAll("\\(", "&#40;");
		//ret = ret.replaceAll("\\)", "&#41;");
		ret = ret.replaceAll( "&amp;", "&");
		//ret = ret.replaceAll("+", "&#43;");
		//ret = ret.replaceAll("&#59;", ";" ); 

		return ret;
	}
	
	/**
	 * StringBuffer가 replaceall 메소드를 지원하지 않기때문에 만듬.
	 * @param sb_
	 * @param replaceFrom
	 * @param replaceTo
	 */
	public static void replaceAllSB(StringBuffer sb_, String replaceFrom, String replaceTo){
		int idx = 0;
		while((idx = sb_.indexOf(replaceFrom)) >= 0)
		{
			sb_.replace(idx, idx + replaceFrom.length(), replaceTo);
		}
	}
	
	public static String getUpper1stChar(String inp){
		String str = inp.toLowerCase();
		String ret = ("" + str.charAt(0)).toUpperCase();
		ret += str.substring(1, str.length());
		return ret;	
	}
	
}
