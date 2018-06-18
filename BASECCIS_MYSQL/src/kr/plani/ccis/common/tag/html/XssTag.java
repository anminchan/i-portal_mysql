package kr.plani.ccis.common.tag.html;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.plani.ccis.ips.controller.BaseController;


/**
 * <pre>
 * XSS 보안체크. script, iframe등의 위험태그를 제거하도록 함.
 * 대상태그 혹은 문자열: script, iframe, script, object, embed, document.cookie
 * 예)
 * <html:xss><c:out value='${EO.CONTENT}' escapeXml="false" /></html:xss>
 * </pre>
 * @author 안민찬
 * @version 2015.01.13
 *
 */
public class XssTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
    
    private String text;
	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);
    

    public int doAfterBody() {
        BodyContent body = getBodyContent();
        if (body != null) {
            text = body.getString();
        }
        if (text != null) {
            try {
                JspWriter out = getPreviousOut();

        		String ret = text;
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

        		ret = ret.replaceAll("<(I|i)(F|f)(R|r)(A|a)(M|m)(E|e)", "&lt;iframe");
        		ret = ret.replaceAll("</(I|i)(F|f)(R|r)(A|a)(M|m)(E|e)", "&lt;iframe");
        		
                String outText = ret.replaceAll("(?i)alert", "a_lert");
                outText = outText.replaceAll("(?i)\"", "");
                
                /*
                String outText = text.
                	replaceAll("(?i)<script", "<s_cript").
                	replaceAll("(?i)<iframe", "<i_frame").
                	replaceAll("(?i)</script", "</s_cript").
                	replaceAll("(?i)</iframe", "</i_frame").
                	replaceAll("(?i)<object", "<o_bject").
                	replaceAll("(?i)<embed", "<e_mbed").
                	replaceAll("(?i)document.cookie", "d_ocument.c_ookie")
                	;
                */
                
                out.print(outText);
            } catch (Exception e) {
                //logger.info(e.toString());
            	System.out.println("처리 중 오류가 발생했습니다.");
            }
        }
        return SKIP_BODY;
    }
   
    

}
