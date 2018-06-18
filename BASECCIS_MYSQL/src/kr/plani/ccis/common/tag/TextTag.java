package kr.plani.ccis.common.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class TextTag extends BodyTagSupport {
	
	private static final long serialVersionUID = -3901604757995855796L;
	
	/*getStrDate 변수*/
	private String value;
	private int textSize;
	private String tail;
	
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	public int getTextSize() {
		return textSize;
	}

	public void setTextSize(int textSize) {
		this.textSize = textSize;
	}

	public String getTail() {
		return tail;
	}

	public void setTail(String tail) {
		this.tail = tail;
	}

	@Override
    public int doEndTag() throws JspException {
        JspWriter out = pageContext.getOut();
        
        try {
            out.write(getSplitText(value, textSize, tail));
        } catch (IOException e) {
        	//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
        }
        return EVAL_PAGE; //계속해서 다음에 있는 페이지 안의 소스 실행해라
       //return SKIP_PAGE; //태그 다음에 있는  page 안의 소스 다무시 
    }
	
	/**
	 * 문자 넘길시 size 만큼 절단 후, tail 붙임
	 * @param date
	 * @param pattern
	 * @return
	 * @throws Exception
	 */
	private static String getSplitText(String value, int strSize, String tail) throws JspException {
		
		String text = value.replaceAll("\\s", " ");
		text = value.replaceAll("<(/)?([a-zA-Z]*)([0-9]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
		text = text.replaceAll("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>", "");
		text = text.replaceAll("<\\w+\\s+[^<]*\\s*>", "");
		text = text.replaceAll("&nbsp;", " ");
		text = text.replaceAll("&lt;", "<");
		text = text.replaceAll("&gt;", ">");
		text = text.replaceAll("&amp;", "&");
		text = text.replaceAll("&quot;", "'");
		//text = text.replaceAll("&[^;]+;", "");
		//text = text.replaceAll("\r|\n|&nbsp;", "");
		
		String rtnText = null;
		
		if(text.length() > strSize){
			rtnText = text.substring(0, strSize)+tail;
		}else {
			rtnText = text;
		}
		
		return rtnText;
	}

}
