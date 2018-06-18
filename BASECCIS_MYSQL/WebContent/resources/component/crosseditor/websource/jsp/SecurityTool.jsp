<%@ page pageEncoding = "UTF-8" %>
<%!
// @UTF-8 SecurityUtil.jsp
/*
 * SecurityUtil: CrossEditor Web Attack Defender 
 * Author : djlee <djlee@namo.co.kr>
 * Last modified Sep 13 2012
 * History:
 *     Sep 14 2012 - KISA XSS
 */
	

	/* XSS s:String */
	public boolean detectXSS(String s) {

		java.util.Vector listXSS = new java.util.Vector();

		listXSS.add("PHNjcmlwdA==");
		listXSS.add("JTNzY3JpcHQ=");
		listXSS.add("XHgzc2NyaXB0");
		listXSS.add("amF2YXNjcmlwdDo=");
		listXSS.add("JTAw");
		listXSS.add("ZXhwcmVzc2lvbiAqXCgqXCk=");
		listXSS.add("eHNzOipcKCpcKQ==");
		listXSS.add("ZG9jdW1lbnQuY29va2ll");
		listXSS.add("ZG9jdW1lbnQubG9jYXRpb24=");
		listXSS.add("ZG9jdW1lbnQud3JpdGU=");
		listXSS.add("b25BYm9ydCAqPQ==");
		listXSS.add("b25CbHVyICo9");
		listXSS.add("b25DaGFuZ2UgKj0=");
		listXSS.add("b25DbGljayAqPQ==");
		listXSS.add("b25EYmxDbGljayAqPQ==");
		listXSS.add("b25EcmFnRHJvcCAqPQ==");
		listXSS.add("b25FcnJvciAqPQ==");
		listXSS.add("b25Gb2N1cyAqPQ==");
		listXSS.add("b25LZXlEb3duICo9");
		listXSS.add("b25LZXlQcmVzcyAqPQ==");
		listXSS.add("b25LZXlVcCAqPQ==");
		listXSS.add("b25sb2FkICo9");
		listXSS.add("b25tb3VzZWRvd24gKj0=");
		listXSS.add("b25tb3VzZW1vdmUgKj0=");
		listXSS.add("b25tb3VzZW91dCAqPQ==");
		listXSS.add("b25tb3VzZW92ZXIgKj0=");
		listXSS.add("b25tb3VzZXVwICo9");
		listXSS.add("b25tb3ZlICo9");
		listXSS.add("b25yZXNldCAqPQ==");
		listXSS.add("b25yZXNpemUgKj0=");
		listXSS.add("b25zZWxlY3QgKj0=");
		listXSS.add("b25zdWJtaXQgKj0=");
		listXSS.add("b251bmxvYWQgKj0=");
		listXSS.add("bG9jYXRpb24uaHJlZiAqPQ==");

		boolean bStatus = false;
		java.util.Enumeration e = listXSS.elements();

		while (e.hasMoreElements()) {
			String r = (String)e.nextElement();
			r = new String(getBase64Decode(r));
			if (r.length() == 0)
				continue;
			
			// r:Roll, s:String
			if (compareRegex(r, s)) {
				bStatus = true;
			}
		}
		return bStatus;
	}
	public String detectXSSEx(String s) {
		if(s != null){
			s = s.replaceAll("<", "&lt;");
			s = s.replaceAll(">", "&gt;");
			s = s.replaceAll("&", "&amp;");
			s = s.replaceAll("\"", "&quot;");
			s = s.replaceAll("\r", "");
			s = s.replaceAll("\n", "");
		}else{
			s = "";
		}
		if (detectXSS(s)) {
			return "";
		}
		return s;
	}

	public String detectXSSEx2(String s) {
		
		if (detectXSS(s)) {
			return "";
		}
		return s;
	}


	// Base64Decode
	public static byte[] getBase64Decode(String base64) {

		int pad = 0;

		for (int i = base64.length() - 1; base64.charAt(i) == '='; i--)
			pad++;

		int length = base64.length() * 6 / 8 - pad;
		byte[] raw = new byte[length];
		int rawIndex = 0;

		for (int i = 0; i < base64.length(); i += 4) {

			int block =
				(getValue(base64.charAt(i)) << 18)
					+ (getValue(base64.charAt(i + 1)) << 12)
					+ (getValue(base64.charAt(i + 2)) << 6)
					+ (getValue(base64.charAt(i + 3)));

			for (int j = 0; j < 3 && rawIndex + j < raw.length; j++)
				raw[rawIndex + j] = (byte) ((block >> (8 * (2 - j))) & 0xff);

			rawIndex += 3;
		}

		return raw;
	}


	// compare 
	public boolean compareRegex(String r, String s) {
		
		boolean found = false;

		try {

			if(r == null || s == null) {
				return false;
			}

			java.util.regex.Pattern p = java.util.regex.Pattern.compile(r, java.util.regex.Pattern.UNICODE_CASE | java.util.regex.Pattern.CASE_INSENSITIVE);
			java.util.regex.Matcher m = p.matcher(s); 	
			while (m.find()) 
				found = true;
		}catch(PatternSyntaxException ex) {
			return false;
		}catch(Exception e){
			return false;
		}

		try {

			String ns = new String(s.getBytes("UTF-8"), "eucKR");

			java.util.regex.Pattern p = java.util.regex.Pattern.compile(r, java.util.regex.Pattern.UNICODE_CASE | java.util.regex.Pattern.CASE_INSENSITIVE);
			java.util.regex.Matcher m = p.matcher(ns); 	

			while (m.find()) 
				found = true;

		}catch(PatternSyntaxException ex) {
			return false;
		}catch(Exception e){
			return false;
		}

		return found;
	}

	// getValue
	protected static int getValue(char c) {

		if (c >= 'A' && c <= 'Z')
			return c - 'A';

		if (c >= 'a' && c <= 'z')
			return c - 'a' + 26;

		if (c >= '0' && c <= '9')
			return c - '0' + 52;

		if (c == '+')
			return 62;

		if (c == '/')
			return 63;

		if (c == '=')
			return 0;

		return -1;
	}
%>
<%
/**
*	
*	 detectXSS("<script",listXSS)
*
*	
*	 if (detectXSS(defaultUPath) || detectXSS(defaultUPath)) { }
**/
// out.println(detectXSS("<script"));
%>