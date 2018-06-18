package kr.plani.ccis.ips.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.ui.Model;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.service.common.CommonService;

public class BaseController implements MessageSourceAware{

	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);

	/** 파일업로드 경로   */
	@Value("#{config['upload.dir']}")
	private String uploadDir;
	
	/** 프로젝트 경로   */
	@Value("#{config['project.dir']}")
	private String projectDir;

	private String siteId = "SITE00001";
	
	public String getSiteId() {
		return siteId;
	}
	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	/** 메세지 설정  */
	public MessageSource messageSource;
	
	@Override
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	/*****************************************************************
	* setCommon 기본값 세팅용
	* @param commonService
	* @param model
	* @param obj
	* @throws Exception
	*******************************************************************/
	public void setCommon(CommonService commonService, HttpServletRequest request, Model model, Object obj ) throws Exception {
		// 기본 
		DefaultDomain objRtn = (DefaultDomain)commonService.readLocation(obj);
		
		//세션값 가져오기
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		logger.info("objRtn.getUserId()>>"+sc.getUserId());
		
		// 사용자 메뉴조회
		DefaultDomain objParam = (DefaultDomain)obj;
		objParam.setMySiteId(objRtn.getMySiteId());
		objParam.setMyId(sc.getUserId());
		
		//DefaultDomain objMenu = (DefaultDomain)commonService.listUserMenu(objParam);
		List<?> aList = (List<?>)commonService.listUserMenu(objParam);

		model.addAttribute("rtnLoction", objRtn.getNavigation());
		model.addAttribute("rtnMenuName", objRtn.getMenuName());
		
		// 사용자 메뉴 return
		//model.addAttribute("rtnUserMenu", objMenu.getOutUserMenuCursor());
		model.addAttribute("rtnUserMenu", aList);
		
	}

	/*****************************************************************
	* setAutonomy 경영공시 담당자 셋팅
	* @param commonService
	* @param model
	* @param obj
	* @throws Exception
	*******************************************************************/
	/*public void setAutonomy(CommonService commonService, Model model, Object obj ) throws Exception {
		// 경영공시 담당자
		model.addAttribute("rtntAutonomy", commonService.selectAutonomyPersonList(obj));
	}*/

	/*****************************************************************
	* resultLog 패키지 호출 실행결과 로깅
	* @param commonService
	* @param model
	* @param obj
	* @throws Exception
	*******************************************************************/
	public void resultLog(DefaultDomain obj) throws Exception {
		if(logger.isDebugEnabled()){
			logger.debug("ObjectName : " + obj.getOutObjectName());
			logger.debug("Result     : " + obj.getOutResult());
			logger.debug("RowCount   : " + obj.getOutRowCount());
			logger.debug("Notice     : " + obj.getOutNotice());
			logger.debug("Cursor     : " + obj.getOutCursor());	
		}
	}
	
	/*****************************************************************
	* Message 메세지 처리 공통
	* @param DefaultDomain
	* @throws Exception
	*******************************************************************/
	public void setMessage(HttpServletRequest request, DefaultDomain obj) throws Exception {
		String strMsg = obj.getOutNotice();
		String[] strNotice = null;
		if(strMsg.lastIndexOf("]") > 0) {
			strNotice = StringUtil.getStringSplit(strMsg, "]");
			strMsg = strNotice[1];
        }
		
		FlashMap fm = RequestContextUtils.getOutputFlashMap(request);  
	    fm.put("msgFlag", "Y");  
	    fm.put("result", obj.getOutResult());  
	    fm.put("message", strMsg); 

	}
	
	/*****************************************************************
	* 폴더 등록 처리 공통
	* @param DefaultDomain
	* @throws Exception
	*******************************************************************/
	public void mkdirsAdd(String reqPath) throws Exception {
		String path = projectDir+File.separator+reqPath;

		//파일 객체 생성
        File file = new File(path);
        //!표를 붙여주어 파일이 존재하지 않는 경우의 조건을 걸어줌
        if(!file.exists()){
            //디렉토리 생성 메서드
            file.mkdirs();
            logger.info("created directory successfully!");
        }
	}
	
	public void generateSource(String realpath, String siteKey, String srcName, String srcGubun) throws Exception{
		String path = projectDir+File.separator+realpath+File.separator+srcName.replace("§§SITEKEY§§", StringUtil.getUpper1stChar(siteKey))+"."+srcGubun;
		StringBuffer sb_ = new StringBuffer();
		
		// 템플릿 파일을 로드한다.
		String tmplfilepath = projectDir+File.separator+"template_siteSet"+File.separator+srcGubun+File.separator+srcName.replace("§§SITEKEY§§", "")+".tmpl";
		
		FileReader tmplfile = new FileReader(new File(tmplfilepath));
		
		int ch;
		while((ch = tmplfile.read()) >= 0)
		{
			sb_.append((char)ch);
		}
		tmplfile.close();
		
		StringUtil.replaceAllSB(sb_, "{##SITEKEY_UP##}", StringUtil.getUpper1stChar(siteKey));
		StringUtil.replaceAllSB(sb_, "{##SITEKEY_LO##}", siteKey);

		try {
			
			File file = new File(path);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path),"UTF-8"));

			out.write(sb_.toString()); 
			out.newLine();
			out.close();
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}

}
