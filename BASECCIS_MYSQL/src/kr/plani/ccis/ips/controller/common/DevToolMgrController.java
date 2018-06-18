package kr.plani.ccis.ips.controller.common;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.service.common.CommonService;

@Controller
@RequestMapping(value="/mgr/devToolMgr")
public class DevToolMgrController extends BaseController{
	private static final Logger logger = LoggerFactory.getLogger(DevToolMgrController.class);

	/** 공통기능 서비스   */
	@Resource
	private CommonService commonService;
	
	/** DB OWNER   */
	@Value("#{jdbc['username']}")
	private String dbOwner;
	
	/** 프로젝트 경로   */
	@Value("#{config['project.dir']}")
	private String projectDir;
	
	private String baseacttable = null;
	/*****************************************************************
	* list 목록 조회
	* @param Sample
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/codeSetForm")
	public ModelAndView codeSetForm(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		defaultDomain.setInParam(request);
		
		//세션값 가져오기
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		
		// 사용자 메뉴조회
		defaultDomain.setMySiteId(this.getSiteId());
		defaultDomain.setMyId(sc.getUserId());
		
		DefaultDomain objMenu = (DefaultDomain)commonService.listUserMenu(defaultDomain);
		
		defaultDomain.setDbOwner(dbOwner); // dbOwner
		List<?> tableList = commonService.selectTableList(defaultDomain);
		
		// 사용자 메뉴 return
		model.addAttribute("rtnUserMenu", objMenu.getOutUserMenuCursor());
		// 테이블 정보
		model.addAttribute("rtnTableList", tableList);
		// 프로젝트경로
		model.addAttribute("projectPath", projectDir);
		
		defaultDomain.setJsp("common/devTool/codeSetForm");
		return new ModelAndView("ips.main.layout", "obj", defaultDomain);
	}
	
	@RequestMapping(value="/codeSetAct")
	public ModelAndView codeSetAct(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		defaultDomain.setInParam(request);
		
		String siteKey = request.getParameter("siteKey"); // 사이트키
		String fnName = request.getParameter("fnName"); // 기능명
		String[] arrPosition = null;
		arrPosition = request.getParameterValues("position"); //관리자&사용자
		String ipsPkgPath = request.getParameter("ipsPkgPath").replace("{#siteKey#}", siteKey); // 관리자패키지경로
		String sitePkgPath = request.getParameter("sitePkgPath").replace("{#siteKey#}", siteKey); // 사용자패키지경로
		String ipsJspPath = request.getParameter("ipsJspPath").replace("{#siteKey#}", siteKey); // 관리자jsp경로
		String siteJspPath = request.getParameter("siteJspPath").replace("{#siteKey#}", siteKey); // 사용자jsp경로
		String realPath = ""; // 실제생성파일경로
		List<?> tablecrudList = null; // 테이블컬럼조회리스트
		
		baseacttable = defaultDomain.getTableName();
		defaultDomain.setDbOwner(dbOwner); // dbOwner
		tablecrudList = commonService.selectTableDetailList(defaultDomain);
		
		for(int i=0; i<arrPosition.length; i++){
			if(arrPosition[i].toString().equals("admin")){
				realPath = projectDir+File.separator+ipsPkgPath+File.separator+StringUtil.getUpper1stChar(fnName.toLowerCase()); // 관리자 패키지 경로
				// java, xml
				generateController(realPath, fnName, siteKey, "A"); //컨트롤생성
				generateDomain(realPath, fnName, siteKey, tablecrudList); //도메인생성
				generateService(realPath, fnName, siteKey, "A"); // 서비스생성
				generateMapper(realPath, fnName, siteKey, "A"); // 맵퍼생성
				
				realPath = projectDir+File.separator+ipsPkgPath+File.separator+siteKey+"."+fnName.toLowerCase(); // 관리자 패키지 경로
				generateSqlmap(realPath, fnName, siteKey, tablecrudList, "A"); // sqlmap생성
				
				// jsp
				realPath = projectDir+File.separator+ipsJspPath+File.separator; // 관리자 패키지 경로
				generateList(realPath, fnName, siteKey, tablecrudList, "A"); // list생성
				generateView(realPath, fnName, siteKey, tablecrudList, "A"); // view생성
				generateForm(realPath, fnName, siteKey, tablecrudList, "A"); // form생성
			}
			if(arrPosition[i].toString().equals("user")){
				realPath = projectDir+File.separator+sitePkgPath+File.separator+StringUtil.getUpper1stChar(fnName.toLowerCase()); // 사용자 패키지 경로
				generateController(realPath, fnName, siteKey, "U"); //컨트롤생성
				generateDomain(realPath, fnName, siteKey, tablecrudList); //도메인생성
				generateService(realPath, fnName, siteKey, "U"); // 서비스생성
				generateMapper(realPath, fnName, siteKey, "U"); // 맵퍼생성
				generateSqlmap(realPath, fnName, siteKey, tablecrudList, "U"); // sqlmap생성
				
				realPath = projectDir+File.separator+sitePkgPath+File.separator+fnName.toLowerCase(); // 관리자 패키지 경로
				generateSqlmap(realPath, fnName, siteKey, tablecrudList, "U"); // sqlmap생성
				
				// jsp
				realPath = projectDir+File.separator+siteJspPath+File.separator; // 사용자 패키지 경로
				generateList(realPath, fnName, siteKey, tablecrudList, "U"); // list생성
				generateView(realPath, fnName, siteKey, tablecrudList, "U"); // view생성
				generateForm(realPath, fnName, siteKey, tablecrudList, "U"); // form생성
			}
		}
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		rv.setUrl(request.getContextPath().concat("/mgr/devToolMgr/codeSetForm"));
		
		return new ModelAndView(rv);
	}
	
	private void generateController(String realpath, String fnName, String siteKey, String gubun) throws Exception{
		//파일이 이미 존재하는경우 삭제한다.
		//deleteFile(realpath);
		
		// Controller Dir replace
		realpath = realpath.replace("{#mvcDir#}", "controller")+(gubun.equals("A") ? "Mgr" : "")+"Controller.java";
		logger.info(File.separator);
		
		File pathdir = new File(realpath.substring(0, realpath.lastIndexOf(File.separator)));
		if(!pathdir.exists())
			pathdir.mkdirs();
		
		StringBuffer sb_ = new StringBuffer();
		
		// 템플릿 파일을 로드한다.
		String tmplfilepath = projectDir+File.separator+"template_src"+File.separator+"java"+File.separator+"controller"+(gubun.equals("U") ? "_usr" : "")+".tmpl";
		//String actprefix = "";
		
		FileReader tmplfile = new FileReader(new File(tmplfilepath));
		
		int ch;
		while((ch = tmplfile.read()) >= 0)
		{
			sb_.append((char)ch);
		}
		tmplfile.close();
		
		// 템플릿 파일에서 필요한 내용을 새로 생성되는 내용에 맞게 치환한다.
		if(gubun.equals("A")){
			StringUtil.replaceAllSB(sb_, "{##IMPT_DOMAIN##}", "kr.plani.ccis.ips.domain."+siteKey+"."+StringUtil.getUpper1stChar(fnName));
			StringUtil.replaceAllSB(sb_, "{##IMPT_SERVICE##}", "kr.plani.ccis.ips.service."+siteKey+"."+StringUtil.getUpper1stChar(fnName)+"MgrService");
		}
		if(gubun.equals("U")){
			StringUtil.replaceAllSB(sb_, "{##IMPT_DOMAIN##}", "kr.plani.ccis.ips.domain."+siteKey+"."+StringUtil.getUpper1stChar(fnName));
			StringUtil.replaceAllSB(sb_, "{##IMPT_SERVICE##}", "kr.plani.ccis."+siteKey+".service."+StringUtil.getUpper1stChar(fnName)+"Service");
		}
		StringUtil.replaceAllSB(sb_, "{##SITEKEY##}", siteKey.toLowerCase());
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_UP##}", StringUtil.getUpper1stChar(fnName));
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_LO##}", fnName.toLowerCase());

		try {
			
			File file = new File(realpath);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath),"UTF-8"));

			out.write(sb_.toString()); 
			out.newLine();
			out.close();
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}
	
	private void generateService(String realpath, String fnName, String siteKey, String gubun) throws Exception{
		//파일이 이미 존재하는경우 삭제한다.
		//deleteFile(realpath);
		
		// Service Dir replace
		realpath = realpath.replace("{#mvcDir#}", "service")+(gubun.equals("A") ? "Mgr" : "")+"Service.java";
		logger.info(File.separator);
		
		File pathdir = new File(realpath.substring(0, realpath.lastIndexOf(File.separator)));
		if(!pathdir.exists())
			pathdir.mkdirs();
		
		StringBuffer sb_ = new StringBuffer();
		
		// 템플릿 파일을 로드한다.
		String tmplfilepath = projectDir+File.separator+"template_src"+File.separator+"java"+File.separator+"service"+(gubun.equals("U") ? "_usr" : "")+".tmpl";
		String actprefix = "";
		
		FileReader tmplfile = new FileReader(new File(tmplfilepath));
		
		int ch;
		while((ch = tmplfile.read()) >= 0)
		{
			sb_.append((char)ch);
		}
		tmplfile.close();
		
		// 템플릿 파일에서 필요한 내용을 새로 생성되는 내용에 맞게 치환한다.
		if(gubun.equals("A")){
			StringUtil.replaceAllSB(sb_, "{##IMPT_MAPPER##}", "kr.plani.ccis.ips.mapper."+siteKey+"."+StringUtil.getUpper1stChar(fnName)+"MgrMapper");
		}
		if(gubun.equals("U")){
			StringUtil.replaceAllSB(sb_, "{##IMPT_MAPPER##}", "kr.plani.ccis."+siteKey+".mapper."+StringUtil.getUpper1stChar(fnName)+"Mapper");
		}
		StringUtil.replaceAllSB(sb_, "{##SITEKEY##}", siteKey.toLowerCase());
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_UP##}", StringUtil.getUpper1stChar(fnName));
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_LO##}", fnName.toLowerCase());

		try {
			
			File file = new File(realpath);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath),"UTF-8"));

			out.write(sb_.toString()); 
			out.newLine();
			out.close();
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}
	
	private void generateMapper(String realpath, String fnName, String siteKey, String gubun) throws Exception{
		//파일이 이미 존재하는경우 삭제한다.
		//deleteFile(realpath);
		
		// Mapper Dir replace
		realpath = realpath.replace("{#mvcDir#}", "mapper")+(gubun.equals("A") ? "Mgr" : "")+"Mapper.java";
		logger.info(File.separator);
		
		File pathdir = new File(realpath.substring(0, realpath.lastIndexOf(File.separator)));
		if(!pathdir.exists())
			pathdir.mkdirs();
		
		StringBuffer sb_ = new StringBuffer();
		
		// 템플릿 파일을 로드한다.
		String tmplfilepath = projectDir+File.separator+"template_src"+File.separator+"java"+File.separator+"mapper"+(gubun.equals("U") ? "_usr" : "")+".tmpl";
		FileReader tmplfile = new FileReader(new File(tmplfilepath));
		
		int ch;
		while((ch = tmplfile.read()) >= 0)
		{
			sb_.append((char)ch);
		}
		tmplfile.close();
		
		StringUtil.replaceAllSB(sb_, "{##SITEKEY##}", siteKey.toLowerCase());
		// 템플릿 파일에서 필요한 내용을 새로 생성되는 내용에 맞게 치환한다.
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_UP##}", StringUtil.getUpper1stChar(fnName));
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_LO##}", fnName.toLowerCase());

		try {
			
			File file = new File(realpath);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath),"UTF-8"));

			out.write(sb_.toString()); 
			out.newLine();
			out.close();
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}
	
	private void generateDomain(String realpath, String fnName, String siteKey, List<?> tablecrudList) throws Exception{
		//파일이 이미 존재하는경우 삭제한다.
		//deleteFile(realpath);
		
		// Domain Dir replace
		realpath = realpath.replace("{#mvcDir#}", "domain")+".java";
		logger.info(File.separator);
		
		File pathdir = new File(realpath.substring(0, realpath.lastIndexOf(File.separator)));
		if(! pathdir.exists())
			pathdir.mkdirs();
		
		StringBuffer sb_ = new StringBuffer();
		
		sb_.append("package kr.plani.ccis.ips.domain."+siteKey+";\n");
		sb_.append("\n");
		sb_.append("import java.io.Serializable;\n");
		sb_.append("\n");
		sb_.append("import org.apache.ibatis.type.Alias;\n");
		sb_.append("\n");
		sb_.append("import kr.plani.ccis.ips.domain.DefaultDomain;\n");
		sb_.append("\n");
		sb_.append("@Alias(\""+fnName.toLowerCase()+"\")\n");
		sb_.append("public class " + StringUtil.getUpper1stChar(fnName) + " extends DefaultDomain implements Serializable {\n");
		sb_.append("\n");
		sb_.append("\tprivate static final long serialVersionUID = -8941057334164625127L;\n");
		sb_.append("\n");
		
		StringBuffer getsetStr = new StringBuffer();
		
		for(int i = 0; i < tablecrudList.size(); i++){
			HashMap item = (HashMap) tablecrudList.get(i);
			
			String colName = item.get("COLUMN_NAME").toString().toLowerCase();
			if("state".equals(colName) || "insuserid".equals(colName) || "insip".equals(colName) || "instime".equals(colName)
					|| "dmluserid".equals(colName) || "dmlip".equals(colName) || "dmltime".equals(colName)
					 || "siteid".equals(colName) || "menuid".equals(colName))
				continue;
			
			String getter = "\tpublic String get" + StringUtil.getUpper1stChar(item.get("COLUMN_NAME").toString().toLowerCase()) + "(){\n";
			String setter = "\tpublic void set" + StringUtil.getUpper1stChar(item.get("COLUMN_NAME").toString().toLowerCase()) + "(String " + item.get("COLUMN_NAME").toString().toLowerCase() + "){\n";
			
			if("DATE|DATATIME|TIMESTAMP".indexOf(item.get("DATA_TYPE").toString().toUpperCase()) >= 0)
			{
				sb_.append("\t/** " + item.get("COMMENTS").toString() + " */\n");
				sb_.append("\tprivate String " + item.get("COLUMN_NAME").toString().toLowerCase() + ";\n");	
			}
			else if("NUMBER|INT|TINYINT".indexOf(item.get("DATA_TYPE").toString().toUpperCase()) >= 0)
			{
				sb_.append("\t/** " + item.get("COMMENTS").toString() + " */\n");
				sb_.append("\tprivate int " + item.get("COLUMN_NAME").toString().toLowerCase() + " = 0;\n");	
				getter = "\tpublic int get" + StringUtil.getUpper1stChar(item.get("COLUMN_NAME").toString().toLowerCase()) + "(){\n"; 
				setter = "\tpublic void set" + StringUtil.getUpper1stChar(item.get("COLUMN_NAME").toString().toLowerCase()) + "(int " + item.get("COLUMN_NAME").toString().toLowerCase() + "){\n";
			}
			else if("CLOB|TEXT|BLOB".indexOf(item.get("DATA_TYPE").toString().toUpperCase()) >= 0)
			{
				sb_.append("\t/** " + item.get("COMMENTS").toString() + " */\n");
				sb_.append("\tprivate String " + item.get("COLUMN_NAME").toString().toLowerCase() + ";\n");	
			}
			else
			{
				sb_.append("\t/** " + item.get("COMMENTS").toString() + " */\n");
				sb_.append("\tprivate String " + item.get("COLUMN_NAME").toString().toLowerCase() + ";\n");	
			}
			sb_.append("\n");
			
			getter += "\t\t return " + item.get("COLUMN_NAME").toString().toLowerCase() + ";\n";
			getter += "\t}\n\n";
			setter += "\t\t this." + item.get("COLUMN_NAME").toString().toLowerCase() + " = " + item.get("COLUMN_NAME").toString().toLowerCase() + ";\n";
			setter += "\t}\n\n";
			
			getsetStr.append(getter);
			getsetStr.append(setter);
			
		}

		sb_.append(getsetStr);
		sb_.append("}\n");
		
		try {
			
			File file = new File(realpath);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath),"UTF-8"));
			
			out.write(sb_.toString()); 
			out.newLine();
			out.close();
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}
	
	private void generateSqlmap(String realpath, String fnName, String siteKey, List<?> tablecrudList, String gubun) throws Exception{
		//파일이 이미 존재하는경우 삭제한다.
		//deleteFile(realpath);
		if(gubun.equals("A")){
			realpath = realpath.replace("{#mvcDir#}\\"+siteKey, "{#mvcDir#}").replace("{#mvcDir#}", "sqlmap")+"Mgr.mapper.xml";
		}
		if(gubun.equals("U")){
			realpath = realpath.replace("{#mvcDir#}", "sqlmap")+".mapper.xml";
		}
		
		File pathdir = new File(realpath.substring(0, realpath.lastIndexOf(File.separator)));
		if(! pathdir.exists())
			pathdir.mkdirs();

		String inscols_iter = "";
		String insvals_iter = "";
		String pk_cond = "";
		String select_iter = "";
		String update_iter = "";
		String resultmap_iter = "";
				
		for(int i = 0; i < tablecrudList.size(); i++){
			HashMap item = (HashMap) tablecrudList.get(i);
			String colnm = item.get("COLUMN_NAME").toString();
			
			if("DATE".equals(item.get("DATA_TYPE").toString().toUpperCase())){
				inscols_iter += colnm;
				insvals_iter += "SYSDATE";
				update_iter += colnm + " = SYSDATE";
				select_iter += colnm;
			}else{
				select_iter += colnm;
				inscols_iter += colnm;

				if("CLOB".equals(item.get("DATA_TYPE").toString().toUpperCase())){
					resultmap_iter += "<result property=\"" + colnm.toLowerCase() + "\" column=\"" + colnm.toLowerCase() + "\"  jdbcType=\"CLOB\" javaType=\"java.lang.String\" />";
				}
				insvals_iter += "#{" + colnm.toLowerCase() + "}";
				update_iter += colnm + " = #{" + colnm.toLowerCase() + "}";
			}
			
			inscols_iter += (i == (tablecrudList.size() - 1) ? "" : ",\n\t\t\t"); 
			insvals_iter += (i == (tablecrudList.size() - 1) ? "" : ",\n\t\t\t");
			update_iter += (i == (tablecrudList.size() - 1) ? "" : ",\n\t\t\t");
			select_iter += (i == (tablecrudList.size() - 1) ? "" : ",\n\t\t\t\t");
			resultmap_iter += (i == (tablecrudList.size() - 1) ? "" : "\n\t\t\t\t");
			
    		if("PK".equals(item.get("CONSTRAINT_TYPE").toString())){
    			pk_cond += (pk_cond.equals("")) ? "" : " AND\n";
    			pk_cond += "\t\t\t" + colnm + " = #{" + colnm.toLowerCase() + "}"; 
    		}
		}
		
		StringBuffer sb_ = new StringBuffer();

		// 템플릿 파일을 읽어온다.
		String tmplfilepath = projectDir+File.separator+"template_src"+File.separator+"java"+File.separator+"sqlmap.tmpl";
		FileReader tmplfile = new FileReader(new File(tmplfilepath));
		int ch;
		while((ch = tmplfile.read()) >= 0)
		{
			sb_.append((char)ch);
		}
		tmplfile.close();
		
		if(gubun.equals("A")){
			StringUtil.replaceAllSB(sb_, "{##PKG_MAPPER##}", "kr.plani.ccis.ips.mapper."+siteKey+"."+StringUtil.getUpper1stChar(fnName)+"MgrMapper");
		}
		if(gubun.equals("U")){
			StringUtil.replaceAllSB(sb_, "{##PKG_MAPPER##}", "kr.plani.ccis."+siteKey+".mapper."+StringUtil.getUpper1stChar(fnName)+"Mapper");
		}		
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_UP##}", fnName.toUpperCase());
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_LO##}", fnName.toLowerCase());
		StringUtil.replaceAllSB(sb_, "{##SQL_RESULTMAP_ITER##}", resultmap_iter);
		StringUtil.replaceAllSB(sb_, "{##SQL_SELCOLS##}", select_iter);
		StringUtil.replaceAllSB(sb_, "{##SQL_TBL_NM##}", baseacttable);
		StringUtil.replaceAllSB(sb_, "{##SQL_INSCOLS_ITER##}", inscols_iter);
		StringUtil.replaceAllSB(sb_, "{##SQL_INSVALS_ITER##}", insvals_iter);
		StringUtil.replaceAllSB(sb_, "{##SQL_UPDTCOLS##}", update_iter);
		StringUtil.replaceAllSB(sb_, "{##SQL_KEYS##}", "WHERE\n" + pk_cond);
		
		try {
			
			File file = new File(realpath);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath),"UTF-8"));
			
			out.write(sb_.toString()); 
			out.newLine();
			out.close();		
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}
	
	private void generateList(String realpath, String fnName, String siteKey, List<?> tablecrudList, String gubun) throws Exception{
		//파일이 이미 존재하는경우 삭제한다.
		//deleteFile(realpath);
		if(gubun.equals("A")){
			realpath = realpath.replace("{#mvcDir#}", fnName+"Mgr")+"list.jsp";
		}
		if(gubun.equals("U")){
			realpath = realpath.replace("{#mvcDir#}", fnName)+"list.jsp";
		}
		
		File pathdir = new File(realpath.substring(0, realpath.lastIndexOf(File.separator)));
		if(! pathdir.exists())
			pathdir.mkdirs();

		StringBuffer sb_ = new StringBuffer();

		// 템플릿 파일을 읽어온다.
		String tmplfilepath = projectDir+File.separator+"template_src"+File.separator+"jsp"+File.separator+"list"+(gubun.equals("U") ? "_usr" : "")+".tmpl";
		FileReader tmplfile = new FileReader(new File(tmplfilepath));
			
		int ch;
		while((ch = tmplfile.read()) >= 0)
		{
			sb_.append((char)ch);
		}
		tmplfile.close();
		
		String caption_iter = "";
		String colgroup_iter = "";
		String thead_iter = "";
		String tr_iter = "";
		//String hidden_pk_iter = "";
		String pkparams = "";
		
		int tbCnt = tablecrudList.size() > 5 ? 5 : tablecrudList.size(); 
		colgroup_iter += "<col class=\"num\"/>";
		tr_iter += "<td>${totalCnt - data.RNUM+1}</td>";
		
		for(int i = 0; i < tbCnt; i++){
			HashMap item = (HashMap) tablecrudList.get(i);
			
			caption_iter += ("".equals(caption_iter) ? "" : ",") + item.get("COMMENTS");
			colgroup_iter += "<col width=\"10%\"/>" + ((i == (tbCnt - 1)) ? "" : "\n\t\t\t\t\t");
			thead_iter += "<th scope=\"col\">" + item.get("COMMENTS") + "</th>" + ((i == (tbCnt - 1)) ? "" : "\n\t\t\t\t\t\t");
			
			if(i == 0){
				tr_iter += "<td><a href=\"${ctxMgr }/"+fnName.toLowerCase()+"/view?{##PK_PARAMS##}${link}\"><c:out value=\"${data." + item.get("COLUMN_NAME").toString() +"}\" /></a></td>"  + ((i == (tbCnt - 1)) ? "" : "\n\t\t\t\t\t\t");
			}else{
				if("DATE".equals(item.get("DATA_TYPE").toString().toUpperCase())){
					tr_iter += "<td><fmt:formatDate value=\"${data." + item.get("COLUMN_NAME").toString() +"}\" pattern=\"yyyy-MM-dd\"/></td>"  + ((i == (tbCnt - 1)) ? "" : "\n\t\t\t\t\t\t");
				}else{
					tr_iter += "<td><c:out value=\"${data." + item.get("COLUMN_NAME").toString() +"}\" /></td>"  + ((i == (tbCnt - 1)) ? "" : "\n\t\t\t\t\t\t");
				}
			}
			
			if("PK".equals(item.get("CONSTRAINT_TYPE").toString())){
				pkparams += ("".equals(pkparams) ? "" : "&") + item.get("COLUMN_NAME").toString().toLowerCase()+"${data." + item.get("COLUMN_NAME") + "}";
    		}
			
		}

		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_LO##}", fnName.toLowerCase());
		StringUtil.replaceAllSB(sb_, "{##CAPTION_ITER##}", caption_iter);
		StringUtil.replaceAllSB(sb_, "{##COLGROUP_ITER##}", colgroup_iter);
		StringUtil.replaceAllSB(sb_, "{##THEAD_ITER##}", thead_iter);
		StringUtil.replaceAllSB(sb_, "{##TR_ITER##}", tr_iter);
		StringUtil.replaceAllSB(sb_, "{##COLSPAN##}", new Integer(tbCnt + 1).toString());
		StringUtil.replaceAllSB(sb_, "{##PK_PARAMS##}", pkparams);
		
		try {

			File file = new File(realpath);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath),"UTF-8"));
			
			out.write(sb_.toString()); 
			out.newLine();
			out.close();
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}

	private void generateView(String realpath, String fnName, String siteKey, List<?> tablecrudList, String gubun) throws Exception{
		if(gubun.equals("A")){
			realpath = realpath.replace("{#mvcDir#}", fnName+"Mgr")+"view.jsp";
		}
		if(gubun.equals("U")){
			realpath = realpath.replace("{#mvcDir#}", fnName)+"view.jsp";
		}
		
		File pathdir = new File(realpath.substring(0, realpath.lastIndexOf(File.separator)));
		if(! pathdir.exists())
			pathdir.mkdirs();

		StringBuffer sb_ = new StringBuffer();

		// 템플릿 파일을 읽어온다.
		String tmplfilepath = projectDir+File.separator+"template_src"+File.separator+"jsp"+File.separator+"view"+(gubun.equals("U") ? "_usr" : "")+".tmpl";
		FileReader tmplfile = new FileReader(new File(tmplfilepath));
		
		int ch;
		while((ch = tmplfile.read()) >= 0)
		{
			sb_.append((char)ch);
		}
		tmplfile.close();
		
		int tbCnt = tablecrudList.size() > 5 ? 5 : tablecrudList.size();
		String value_tr_iter = "";
		String hidden_pk_iter = "";
		for(int i = 0; i < tbCnt; i++){
			HashMap item = (HashMap) tablecrudList.get(i);
			
			value_tr_iter += "\t\t\t\t<tr>\n";
			value_tr_iter += "\t\t\t\t\t<th scope=\"row\"><label for=\"" + item.get("COLUMN_NAME").toString().toLowerCase() + "\">" + item.get("COMMENTS") + "</label></th>\n";
			value_tr_iter += "\t\t\t\t\t<td class = \"left\">\n";
			value_tr_iter += "\t\t\t\t\t\t<c:out value=\"${result." + item.get("COLUMN_NAME").toString() + "}\"/>\n";
			value_tr_iter += "\t\t\t\t\t</td>\n";
			value_tr_iter += "\t\t\t\t</tr>";			
			value_tr_iter += ((i == (tablecrudList.size() - 1)) ? "" : "\n");
			
			if("PK".equals(item.get("CONSTRAINT_TYPE").toString())){
				hidden_pk_iter += "<input type=\"hidden\" id=\"" + item.get("COLUMN_NAME").toString().toLowerCase() + "\" name=\"" + item.get("COLUMN_NAME").toString().toLowerCase() + "\" value=\"${result." + item.get("COLUMN_NAME").toString().toUpperCase() + "}\"/>\n\t";
    		}
		}
		
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_LO##}", fnName.toLowerCase());
		StringUtil.replaceAllSB(sb_, "{##SCRIPT_PK_PARAMS##}", hidden_pk_iter);
		StringUtil.replaceAllSB(sb_, "{##VALUE_TR_ITER##}", value_tr_iter);
		
		try {

			File file = new File(realpath);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath),"UTF-8"));
			
			out.write(sb_.toString()); 
			out.newLine();
			out.close();
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}
	
	private void generateForm(String realpath, String fnName, String siteKey, List<?> tablecrudList, String gubun) throws Exception{
		if(gubun.equals("A")){
			realpath = realpath.replace("{#mvcDir#}", fnName+"Mgr")+"form.jsp";
		}
		if(gubun.equals("U")){
			realpath = realpath.replace("{#mvcDir#}", fnName)+"form.jsp";
		}
		
		File pathdir = new File(realpath.substring(0, realpath.lastIndexOf(File.separator)));
		if(! pathdir.exists())
			pathdir.mkdirs();

		StringBuffer sb_ = new StringBuffer();

		// 템플릿 파일을 읽어온다.
		String tmplfilepath = projectDir+File.separator+"template_src"+File.separator+"jsp"+File.separator+"form"+(gubun.equals("U") ? "_usr" : "")+".tmpl";
		FileReader tmplfile = new FileReader(new File(tmplfilepath));
			
		int ch;
		while((ch = tmplfile.read()) >= 0)
		{
			sb_.append((char)ch);
		}
		tmplfile.close();
		
		int tbCnt = tablecrudList.size() > 5 ? 5 : tablecrudList.size();
		String input_tr_iter = "";
		String hidden_pk_iter = "";
		String clobcolumn_name = "";
		for(int i = 0; i < tbCnt; i++){
			HashMap item = (HashMap) tablecrudList.get(i);
			
			input_tr_iter += "\t\t\t\t<tr>\n";
			
			if("N".equals(item.get("NULLABLE")))
				input_tr_iter += "\t\t\t\t\t<th scope=\"row\"><span class=\"point01\">*</span> <label for=\"" + item.get("COLUMN_NAME").toString().toLowerCase() + "\">" + item.get("COMMENTS") + "</label></th>\n";
			else
				input_tr_iter += "\t\t\t\t\t<th scope=\"row\"><label for=\"" + item.get("COLUMN_NAME").toString().toLowerCase() + "\">" + item.get("COMMENTS") + "</label></th>\n";
			
			input_tr_iter += "\t\t\t\t\t<td>\n"; 
			input_tr_iter += "\t\t\t\t\t\t<input type=\"text\" name=\"" + item.get("COLUMN_NAME").toString().toLowerCase() + "\" class=\"input_long\" title=\"" + item.get("COMMENTS") + "\"/>\n";
			input_tr_iter += "\t\t\t\t\t</td>\n";
			input_tr_iter += "\t\t\t\t</tr>";			
			input_tr_iter += ((i == (tablecrudList.size() - 1)) ? "" : "\n");
			
			if("PK".equals(item.get("CONSTRAINT_TYPE").toString())){
				hidden_pk_iter += "<input type=\"hidden\" id=\"" + item.get("COLUMN_NAME").toString().toLowerCase() + "\" name=\"" + item.get("COLUMN_NAME").toString().toLowerCase() + "\" value=\"${result." + item.get("COLUMN_NAME").toString().toUpperCase() + " > 0 ? result."+item.get("COLUMN_NAME").toString().toUpperCase()+" : 0}\"/>\n\t";
    		}
			
		}
		
		StringUtil.replaceAllSB(sb_, "{##PROGRAMNM_LO##}", fnName.toLowerCase());
		StringUtil.replaceAllSB(sb_, "{##SCRIPT_PK_PARAMS##}", hidden_pk_iter);
		StringUtil.replaceAllSB(sb_, "{##INPUT_TR_ITER##}", input_tr_iter);
		
		try {

			File file = new File(realpath);
			if(file.exists())
				file.delete();
			
			BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(realpath),"UTF-8"));
			
			out.write(sb_.toString()); 
			out.newLine();
			out.close();
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		}
	}
	
	/*****************************************************************
	* 이미지 파일 list 목록 조회
	* @param Sample
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/imagesList")
	public ModelAndView imagesList(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		defaultDomain.setInParam(request);
		
		//세션값 가져오기
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		
		// 사용자 메뉴조회
		defaultDomain.setMySiteId(this.getSiteId());
		defaultDomain.setMyId(sc.getUserId());
		
		DefaultDomain objMenu = (DefaultDomain)commonService.listUserMenu(defaultDomain);
		
		File f= new File(projectDir+File.separator+"WebContent"+File.separator+"resources"+File.separator+"images"+File.separator); 
		ArrayList<File> subFiles= new ArrayList<File>();
		ArrayList<HashMap<String, String>> imgFileList = new ArrayList<HashMap<String,String>>();

		if(!f.exists()){ 
		    logger.info("디렉토리가 존재하지 않습니다"); 
		    return null; 
		  
		}
		findSubFiles(f, subFiles); 
		 
		for(File file : subFiles){
			HashMap<String, String> map = new HashMap<>();
			if(file.isFile()){
				map.put("type", "FILE");
		        map.put("name", file.getName());
		        map.put("path", file.getCanonicalPath().toString().replaceAll("\\\\",  "/"));
		        imgFileList.add(map);
		    }else if(file.isDirectory()){
		    	map.put("type", "DIRECTORY");
		        map.put("name", file.getName());
		        map.put("path", file.getCanonicalPath().toString().replaceAll("\\\\",  "/"));
		        imgFileList.add(map);
		    } 
		}
        
    	// 사용자 메뉴 return
		model.addAttribute("rtnUserMenu", objMenu.getOutUserMenuCursor());
		model.addAttribute("imgFileList", imgFileList);
		
		defaultDomain.setJsp("common/devTool/imgForm");
		return new ModelAndView("ips.main.layout", "obj", defaultDomain);
	}
	
	public static void findSubFiles(File parentFile, ArrayList<File> subFiles){ 
		if (parentFile.isFile()) {
			subFiles.add(parentFile);
		} else if (parentFile.isDirectory()) {
			subFiles.add(parentFile);
			File[] childFiles = parentFile.listFiles();
			for (File childFile : childFiles) {
				findSubFiles(childFile, subFiles);
			}
		}
	} 
	
}
