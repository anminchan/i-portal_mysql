package kr.plani.ccis.common.tag;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class PageFooterTag extends BodyTagSupport
{
	private static final long serialVersionUID = -3073342393568416172L;
	
	/* 화면에서 입력받는 항목 */
    private int rowCount;//페이지 번호 생성에 사용되는 페이지의 목록건수
    private int totalCount;//페이지 번호 생성에 사용되는 검색 총건수
    private String firstBtn;//첫페이지이동 이미지 URL
    private String prevBtn;//이전페이지 이미지 URL
    private String nextBtn;//다음페이지 이미지 URL
    private String lastBtn;//마지막페이지 이미지 URL
    private String numLine;//페이지번호 사이 이미지 URL
    
    /*
    private double minIndex; //제일 작은 index
    private double maxIndex; //제일 큰 index
     */
    
    /* 내부적으로 사용되는 항목 */
    private int footNo;//페이지 번호 갯수
    private int pageNum;//페이지 번호
    private int gTotalPage;//총페이지(자동계산)
    private String url;//페이지 번호 url
    private String gSearchStr;//페이지 번호 파라미터 link
    
    private String siteGubun;//사이트구분 기본:A(admin), U(사용자)

    public PageFooterTag()
    {
    	rowCount = 10;
   
        firstBtn = "/resources/images/ips/common/btn_first.gif";
        prevBtn = "/resources/images/ips/common/btn_prev.gif";
        nextBtn = "/resources/images/ips/common/btn_next.gif";
        lastBtn = "/resources/images/ips/common/btn_end.gif";
        numLine = "/resources/images/paging/numline.gif";
        siteGubun = "A";
    }

    public void setRowCount(int rowCount)
    {
        if(rowCount != 0)
            this.rowCount = rowCount;
    }

    public void setUrl(String url)
    {
        this.url = url;
    }

    public void setTotalCount(int totalCount)
    {
        this.totalCount = totalCount;
    }

    public void setFirstBtn(String firstBtn)
    {
    	if(firstBtn != null && !firstBtn.trim().equals(""))
    		this.firstBtn = firstBtn;	
    }

    public void setPrevBtn(String prevBtn)
    {
    	if(prevBtn != null && !prevBtn.trim().equals(""))
    		this.prevBtn = prevBtn;
    }

    public void setNextBtn(String nextBtn)
    {
    	if(nextBtn != null && !nextBtn.trim().equals(""))
    		this.nextBtn = nextBtn;
    }

    public void setLastBtn(String lastBtn)
    {
    	if(lastBtn != null && !lastBtn.trim().equals(""))
    		this.lastBtn = lastBtn;
    }

	public void setfootNo(int footNo)
    {
        this.footNo = footNo;
    }
    
    public String getSiteGubun() {
		return siteGubun;
	}

	public void setSiteGubun(String siteGubun) {
    	if(siteGubun != null && !siteGubun.trim().equals(""))
    		this.siteGubun = siteGubun;
	}

	@Override
	public int doAfterBody()
        throws JspException
    {
        try
        {
        	
        	if(siteGubun.equals("M"))	footNo=5;
        	else						footNo=10;
        	        	
            HttpServletRequest req = (HttpServletRequest)pageContext.getRequest();
            pageNum = getParam(req, "pageNum", 1);
            getSearchString(req);
            getURL(req);
            gTotalPage = totalCount / rowCount + (totalCount % rowCount != 0 ? 1 : 0);    
            BodyContent bodyCon = getBodyContent();
            String bodyText = bodyCon.getString();
            bodyCon.clearBody();
            bodyText = replaceString(bodyText, "<SearchCount>", Integer.toString(totalCount));
            bodyText = replaceString(bodyText, "<TotalPageNo>", Integer.toString(gTotalPage));
            bodyText = replaceString(bodyText, "<PageNo>", Integer.toString(pageNum));
            bodyText = replaceString(bodyText, "<First>", getFirst(req));
            bodyText = replaceString(bodyText, "<Previous>", getPrevious(req));
            bodyText = replaceString(bodyText, "<AllPageLink>", getAllPage(req));
            bodyText = replaceString(bodyText, "<Next>", getNext(req));
            bodyText = replaceString(bodyText, "<Last>", getLast(req));
            getPreviousOut().print(bodyText);
        }
        catch(Exception e)
        {
            throw new JspException("FootTag:doAfterBody(): " + e.toString());
        }
        return 0;
    }

    /**
     * 첫페이지 태그<First>
     * @param req HttpServletRequest
     * @return String
     * @throws Exception
     */
    private String getFirst(HttpServletRequest req)
        throws Exception
    {
        StringBuffer sb = new StringBuffer(1024);
        if(gTotalPage != 0)
        {
            sb.append("<a href=\"" + url + "?pageNum=1&rowCnt=").append(rowCount).append(gSearchStr).append("\" class=\"first\"><img src=\"" + req.getContextPath() + firstBtn + "\" alt=\"처음페이지\" /></a>");
        }
        return sb.toString();
    }

    /**
     * 이전페이지 태그<Previous>
     * @param req HttpServletRequest
     * @return String
     * @throws Exception
     */
    private String getPrevious(HttpServletRequest req)
        throws Exception
    {
        if(pageNum > footNo)
        {
            StringBuffer sb = new StringBuffer(1024);
            sb.append("<span><a class=\"prev\" href=\"" + url + "?");
            
            // 이전 버튼 클릭시 마지막 페이지로 이동
            sb.append("pageNum=").append(pageNum % footNo != 0 ? pageNum - (pageNum % footNo) : pageNum - footNo).append("&rowCnt=").append(rowCount).append(gSearchStr);
//            sb.append("pageNum=").append(pageNum % footNo != 0 ? pageNum - (footNo - 1) - pageNum % footNo : pageNum - (footNo + (footNo - 1)) - pageNum % footNo).append("&rowCnt=").append(rowCount).append(gSearchStr);
            sb.append("&upDown=2");
            sb.append("\">");
            sb.append("<img src=\"" + req.getContextPath() + prevBtn + "\" alt=\"이전페이지\" />");
            sb.append("</a>");
            return sb.toString();
        } else
        {
            return "<span>";
        }
    }

    /**
     * 페이지링크 태그<AllPage>
     * @param req HttpServletRequest
     * @return String
     * @throws Exception
     */
    private String getAllPage(HttpServletRequest req)
        throws Exception
    {
        StringBuffer sb = new StringBuffer(1024);
        int t = pageNum / footNo;
        int start = 0;
        int end = 0;
        if(pageNum != 0 && pageNum % footNo == 0)
        {
            start = t * footNo - (footNo - 1);
            end = pageNum;
        } else
        {
            start = t * footNo + 1;
            end = t * footNo + footNo;
            end = gTotalPage >= end ? end : gTotalPage;
        }
        //sb.append("<span>");
        for(int i = start; i <= end; i++)
        {
        	
            if(pageNum == i)
            {
                sb.append("<a class=\"active\">").append(pageNum).append("</a>");
            } else{
                sb.append("<a href=\"" + url + "?");
                sb.append("pageNum=").append(i).append("&rowCnt=").append(rowCount).append(gSearchStr);
                sb.append("&upDown=0").append("\">");
                sb.append(i);
                sb.append("</a>");
            }

        }
        //sb.append("</span>");
        return sb.toString();
    }

    /**
     * 다음페이지<Next>
     * @param req HttpServletRequest
     * @return String
     * @throws Exception
     */
    private String getNext(HttpServletRequest req)
        throws Exception
    {
        //int flag = (gTotalPage - gTotalPage % footNo) + 1;
        pageNum = pageNum % footNo != 0 ? (pageNum - pageNum % footNo) + (footNo + 1) : (pageNum - pageNum % footNo) + 1;
        if(pageNum <= gTotalPage)
        {
            StringBuffer sb = new StringBuffer(1024);
            
            sb.append("<a class=\"next\" href=\"" + url + "?");
            
            sb.append("pageNum=").append(pageNum).append("&rowCnt=").append(rowCount).append(gSearchStr);
            sb.append("&upDown=1");
            sb.append("\">");
            
            sb.append("<img src=\"" + req.getContextPath() + nextBtn + "\" alt=\"다음페이지\" />");
            
            sb.append("</a></span>\n");
            return sb.toString();
        } else
        {
            return "</span>";
        }
    }

    /**
     * 마지막페이지<Last>
     * @param req HttpServletRequest
     * @return String
     * @throws Exception
     */
    private String getLast(HttpServletRequest req)
        throws Exception
    {
        StringBuffer sb = new StringBuffer(1024);
        if(gTotalPage != 0)
        {
            sb.append("<a href=\"" + url + "?");
            sb.append("pageNum=").append(gTotalPage).append("&rowCnt=").append(rowCount).append(gSearchStr);
            sb.append("\" class=\"last\"><img src=\"" + req.getContextPath() + lastBtn + "\" alt=\"마지막페이지\" /></a>");
        }
        return sb.toString();
    }

    /**
     * 페이지번호의 URL생성 - request.setAttribute("link", "&param1=1111&param2=2222");
     * @param req HttpServletRequest
     */
    private void getSearchString(HttpServletRequest req)
    {
        String str = req.getAttribute("link") != null ? (String)req.getAttribute("link") : "";
        gSearchStr = str;
    }
    
    /**
     * 다른 URL로 페이지 링크를 시킬경우 셋팅 - request.setAttribute("url", "http://gpl.icu.ac.kr/GPLCS");
     * @param req
     */
    private void getURL(HttpServletRequest req)
    {
        String str = req.getAttribute("url") != null ? (String)req.getAttribute("url") : "";
        url = str;
    }

    public static String getParam(HttpServletRequest req, String paramName, String initValue)
    {
        String sRet;
        try
        {
            sRet = req.getParameter(paramName).trim();
        }
        catch(Exception npe)
        {
            sRet = initValue;
        }
        return sRet;
    }

    public static int getParam(HttpServletRequest req, String paramName, int initValue)
    {
        int iRet;
        try
        {
            iRet = Integer.parseInt(req.getParameter(paramName).trim());
        }
        catch(Exception npe)
        {
            iRet = initValue;
        }
        return iRet;
    }

    public static String[] getParams(HttpServletRequest req, String paramName)
    {
        String sRet[];
        try
        {
            sRet = req.getParameterValues(paramName);
        }
        catch(Exception npe)
        {
            sRet = new String[0];
        }
        return sRet;
    }


    public static String replaceString(String str, String from, int to)
    {
        return replaceString(str, from, Integer.toString(to));
    }

    public static String replaceString(String str, String from, String to)
    {
        if(str == null || str.equals(""))
            return "";
        int i = 0;
        String rStr = "";
        for(; str.indexOf(from) > -1; str = str.substring(i + from.length()))
        {
            i = str.indexOf(from);
            rStr = rStr + str.substring(0, i) + to;
        }

        return rStr + str;
    }
}
