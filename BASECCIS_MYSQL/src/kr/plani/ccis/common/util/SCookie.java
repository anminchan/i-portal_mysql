package kr.plani.ccis.common.util;

import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SCookie {

	public String userId;
	public String userName;
	public String kind;
	public String kindName;
	public String corpRegNo;

	public String dKey;

	public String cellPhone;

	public String totalAuth;
	
	HttpServletRequest request;
	HttpServletResponse response;

    /* 정상적인 로그인 시 쿠키 구울 때(고객 소유 도메인으로)*/
    public SCookie(HttpServletRequest request, HttpServletResponse response, 
    		String userId, String kName, String kind, String kindName, String corpRegNo)
    {
		this.request = request;
    	this.response = response;
		this.userId = userId;
		this.userName = kName;
		this.kind = kind;
		this.kindName = kindName;
		this.corpRegNo = corpRegNo;
		
	}
    
	/**
	 * Cookie를 가져오기 위한 생성자
	 */
	public SCookie(HttpServletRequest request)
	{
		this.request = request;
	}

	/**
     * Cookie를 저장하는 메쏘드
     */
	@SuppressWarnings("deprecation")
	public void setCookies() throws NullPointerException
	{
		Cookie c1 = new Cookie("userId", Cryptograph.Base64Encode(userId));
		c1.setPath("/" + this.request.getContextPath());
		c1.setSecure(true);
		response.addCookie(c1);

		Cookie c2 = new Cookie("userName", Cryptograph.Base64Encode(userName));
		c2.setPath("/" + this.request.getContextPath());
		c2.setSecure(true);
		response.addCookie(c2);

		Cookie c3 = new Cookie("kindName", Cryptograph.Base64Encode(kindName));
		c3.setPath("/" + this.request.getContextPath());
		c3.setSecure(true);
		response.addCookie(c3);

		Cookie c4 = new Cookie("kind", kind);
		c4.setPath("/" + this.request.getContextPath());
		c4.setSecure(true);
		response.addCookie(c4);

		Cookie c5 = new Cookie("corpRegNo", corpRegNo);
		c5.setPath("/" + this.request.getContextPath());
		c5.setSecure(true);
		response.addCookie(c5);
		
		Cookie c6 = new Cookie("dKey", dKey);
		c6.setPath("/" + this.request.getContextPath());
		c6.setSecure(true);
		response.addCookie(c6);
		
		Cookie c7 = new Cookie("cellPhone", Cryptograph.Base64Encode(cellPhone));
		c7.setPath("/" + this.request.getContextPath());
		c7.setSecure(true);
		response.addCookie(c7);

		Cookie c8 = new Cookie("totalAuth", totalAuth);
		c8.setPath("/" + this.request.getContextPath());
		c8.setSecure(true);
		response.addCookie(c8);
		
	}

	/**
	 * Cookie을 가져오기 위한 메쏘드
	 */
    @SuppressWarnings("deprecation")
	public void getCookies() throws NullPointerException
	{
		String del = "\\";
		Cookie[] cookies = null;
		try
		{
			cookies = request.getCookies();
		}
		catch(Exception e)
		{
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}

        if(cookies!=null) 
		{
		    try
		    {
				for (int i=0; i<cookies.length; i++) 
				{
					
					if(cookies[i].getName().equals("userId"))
					{
						userId = Cryptograph.Base64Encode(cookies[i].getValue()).trim();
						userId = getTokenValue(userId, del);
					}
					else if(cookies[i].getName().equals("kName"))
					{
						userName = Cryptograph.Base64Encode(cookies[i].getValue()).trim();
						userName = getTokenValue(userName, del);
					}
					else if(cookies[i].getName().equals("kindName"))
					{
						kindName = Cryptograph.Base64Encode(cookies[i].getValue()).trim();
						kindName = getTokenValue(kindName, del);
					}
					else if(cookies[i].getName().equals("kind"))
					{
						kind = cookies[i].getValue().trim();
						kind = getTokenValue(kind, del);
					}
					else if(cookies[i].getName().equals("corpRegNo"))
					{
						corpRegNo = cookies[i].getValue().trim();
						corpRegNo = getTokenValue(corpRegNo, del);
					}
					else if(cookies[i].getName().equals("dKey"))
					{
						dKey = cookies[i].getValue().trim();
						dKey = getTokenValue(dKey, del);
					}
					else if(cookies[i].getName().equals("cellPhone"))
					{
						cellPhone = Cryptograph.Base64Decode(cookies[i].getValue()).trim();
						cellPhone = getTokenValue(cellPhone, del);
					}
					else if(cookies[i].getName().equals("totalAuth"))
					{
						totalAuth = cookies[i].getValue().trim();
						totalAuth = getTokenValue(totalAuth, del);
					}
           		} 
			}
		    catch(Exception e)
		    {
				//e.printStackTrace();
	        	System.out.println("처리 중 오류가 발생했습니다.");
        	}	
        }
	}

	/**
	 * 쿠키 삭제하는 메쏘드
	 * 	: 회사의 쿠키를 삭제한다.
	 */
	public void delCookies()
	{
		Cookie c1 = new Cookie("userId",null);
		c1.setMaxAge(0);
		c1.setPath("/" + this.request.getContextPath());
		c1.setSecure(true);
		response.addCookie(c1);

		Cookie c2 = new Cookie("kName",null);
		c2.setMaxAge(0);
		c2.setPath("/" + this.request.getContextPath());
		c2.setSecure(true);
		response.addCookie(c2);

		Cookie c3 = new Cookie("kindName",null);
		c3.setMaxAge(0);
		c3.setPath("/" + this.request.getContextPath());
		c3.setSecure(true);
		response.addCookie(c3);

		Cookie c4 = new Cookie("kind",null);
		c4.setMaxAge(0);
		c4.setPath("/" + this.request.getContextPath());
		c4.setSecure(true);
		response.addCookie(c4);

		Cookie c5 = new Cookie("deptId",null);
		c5.setMaxAge(0);
		c5.setPath("/" + this.request.getContextPath());
		c5.setSecure(true);
		response.addCookie(c5);

		Cookie c6 = new Cookie("deptName",null);
		c6.setMaxAge(0);
		c6.setPath("/" + this.request.getContextPath());
		c6.setSecure(true);
		response.addCookie(c6);

		Cookie c7 = new Cookie("corpRegNo",null);
		c7.setMaxAge(0);
		c7.setPath("/" + this.request.getContextPath());
		c7.setSecure(true);
		response.addCookie(c7);
		
		Cookie c8 = new Cookie("dKey",null);
		c8.setMaxAge(0);
		c8.setPath("/" + this.request.getContextPath());
		c8.setSecure(true);
		response.addCookie(c8);

		Cookie c9 = new Cookie("cellPhone", null);
		c9.setMaxAge(0);
		c9.setPath("/" + this.request.getContextPath());
		c9.setSecure(true);
		response.addCookie(c9);
		
		Cookie c10 = new Cookie("zipCode", null);
		c10.setMaxAge(0);
		c10.setPath("/" + this.request.getContextPath());
		c10.setSecure(true);
		response.addCookie(c10);
		
		Cookie c11 = new Cookie("address1", null);
		c11.setMaxAge(0);
		c11.setPath("/" + this.request.getContextPath());
		c11.setSecure(true);
		response.addCookie(c11);

		Cookie c12 = new Cookie("address2", null);
		c12.setMaxAge(0);
		c12.setPath("/" + this.request.getContextPath());
		c12.setSecure(true);
		response.addCookie(c12);
		
		Cookie c13 = new Cookie("homePhone", null);
		c13.setMaxAge(0);
		c13.setPath("/" + this.request.getContextPath());
		c13.setSecure(true);
		response.addCookie(c13);

		Cookie c14 = new Cookie("totalAuth", null);
		c14.setMaxAge(0);
		c14.setPath("/" + this.request.getContextPath());
		c14.setSecure(true);
		response.addCookie(c14);
		
		Cookie c15 = new Cookie("ceoName", null);
		c15.setMaxAge(0);
		c15.setPath("/" + this.request.getContextPath());
		c15.setSecure(true);
		response.addCookie(c15);
	}

	private String getTokenValue(String Column, String del)
	{
		StringTokenizer st = new StringTokenizer(Column, del);
		String haha = "";
		int count = st.countTokens();

		for( int j=0 ; j<count ; j++ )
		{
			if(j == 1)
				st.nextToken();
			else if(j == 0)
				haha = st.nextToken();
		}
		return haha;	
  	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getKindName() {
		return kindName;
	}

	public void setKindName(String kindName) {
		this.kindName = kindName;
	}

	public String getCorpRegNo() {
		return corpRegNo;
	}

	public void setCorpRegNo(String corpRegNo) {
		this.corpRegNo = corpRegNo;
	}

	public String getdKey() {
		return dKey;
	}

	public void setdKey(String dKey) {
		this.dKey = dKey;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getTotalAuth() {
		return totalAuth;
	}

	public void setTotalAuth(String totalAuth) {
		this.totalAuth = totalAuth;
	}

}
