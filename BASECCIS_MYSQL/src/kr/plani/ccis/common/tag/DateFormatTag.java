package kr.plani.ccis.common.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class DateFormatTag extends BodyTagSupport {
	
	private static final long serialVersionUID = 1204305950441191610L;
	
	/*getStrDate 변수*/
	private String value;
	private String addPattern;
	private int gapSize;
	
    public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getAddPattern() {
		return addPattern;
	}
	
	public void setAddPattern(String addPattern) {
		this.addPattern = addPattern;
	}
	
	public int getGapSize() {
		return gapSize;
	}

	public void setGapSize(int gapSize) {
		this.gapSize = gapSize;
	}
	
	
	@Override
    public int doStartTag() throws JspException {
        return SKIP_BODY;//바디부를 생략
    }
    
	/*
    @Override
    public int doAfterBody() throws JspException {
        logger.info("doAfterBody()");
       //return EVAL_BODY_INCLUDE; //한번 실행하고 넘어가기

      //return EVAL_BODY_AGAIN; //반복 문 사용시
       return super.doAfterBody();
    }
	 */    

	@Override
    public int doEndTag() throws JspException {
        JspWriter out = pageContext.getOut();
        
        try {
            out.write(getStrDate(value, addPattern, gapSize));
        } catch (IOException e) {
        	//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
        }
        return EVAL_PAGE; //계속해서 다음에 있는 페이지 안의 소스 실행해라
       //return SKIP_PAGE; //태그 다음에 있는  page 안의 소스 다무시 
    }
	
	/**
	 * 8자리 Date를 넘길 시 pattern 추가
	 * @param date
	 * @param pattern
	 * @return
	 * @throws Exception
	 */
	private static String getStrDate(String value, String pattern, int gapSize) throws JspException {
		
		String rtnDate = null;
		List<String> arrPattern = new ArrayList<String>();
		
		String gap = "";
		
		for(int i=0; i<gapSize; i++){
			gap = gap + " ";
		}
		
		
		if(value.length() == 8){
			
			if(pattern.length() == 3){
				arrPattern.add(pattern.substring(0, 1));
				arrPattern.add(pattern.substring(1, 2));
				arrPattern.add(pattern.substring(2, 3));
				rtnDate = value.substring(0, 4)+arrPattern.get(0)+gap+value.substring(4, 6)+arrPattern.get(1)+gap+value.substring(6, 8)+arrPattern.get(2);
			}else{
				rtnDate = value.substring(0, 4)+pattern+gap+value.substring(4, 6)+pattern+gap+value.substring(6, 8);
			}
		
		}else{
			rtnDate = "";
		}
		
		return rtnDate;
	}

}
