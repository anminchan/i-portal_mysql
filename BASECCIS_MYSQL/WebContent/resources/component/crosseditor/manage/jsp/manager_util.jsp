<%@page import="java.util.*"%>
<%@page import="java.util.regex.PatternSyntaxException"%>
<%@page import="java.io.*"%>
<%@page import ="javax.xml.parsers.*"%>
<%@page import ="javax.xml.parsers.DocumentBuilder"%>
<%@page import ="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import ="org.w3c.dom.Document"%>
<%@page import ="org.w3c.dom.Element"%>
<%@page import ="org.w3c.dom.Node"%>
<%@page import ="org.w3c.dom.NodeList"%>
<%@page import ="org.xml.sax.SAXException"%>
<%@page import ="org.xml.sax.SAXParseException"%>
<%@page import ="org.xml.sax.SAXException"%>
<%@page import ="java.security.*"%>
<%@include file="../../websource/jsp/Util.jsp"%>
<%@include file="../../websource/jsp/SecurityTool.jsp"%>
<%!

public String rootFolderPath(String urlPath)
{
	String fileRealFolder = "";
	fileRealFolder = urlPath.substring(0, urlPath.lastIndexOf("/") + 1);

	return fileRealFolder;
}

public String xmlUrl(String urlPPath)
{
	return urlPPath + "config" + File.separator + "xmls" + File.separator + "Config.xml";
}

//xml data load
public static Element configXMlLoad(String configValue)
{
	File severXml = new File(configValue);
	
	Document doc = null;
	try{
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		doc = db.parse(severXml);
		Element root = doc.getDocumentElement();
		root.normalize();
		return root;
	}catch (SAXParseException err) {
		System.out.println("System Error 1");
	} catch (SAXException e) {
		System.out.println("System Error 2");
	} catch (java.net.MalformedURLException mfx) {
		System.out.println("System Error 3");
	} catch (java.io.IOException e) {
		System.out.println("System Error 4");
	} catch (javax.xml.parsers.ParserConfigurationException e) {
		System.out.println("System Error 5");
	}
	return null;
}

public Hashtable childValueList(Element root)
{
	Hashtable settingValue = new Hashtable();
	List addMenuList = new ArrayList();
	
	NodeList nodeList = root.getChildNodes();
	Node node;
	Node cNode;
	NodeList childNodes;
	settingValue.put("AddMenuCheck", "false");
	

	try{
			for(int i=0; i<nodeList.getLength(); i++){
				
				node = nodeList.item(i);
				if(node.getNodeType() == Node.ELEMENT_NODE){
					
					childNodes = node.getChildNodes();
					for(int j=0; j<childNodes.getLength();j++){
						
						cNode = childNodes.item(j);
						if(cNode.getNodeType() == Node.ELEMENT_NODE){
							
							if(cNode.getNodeName().equals("AddMenu")) settingValue.put("AddMenuCheck", "true");
							
							if(cNode.getFirstChild() != null){
								if(cNode.getNodeName().equals("AddMenu")){
									addMenuList.add(cNode.getFirstChild().getNodeValue());
									settingValue.put(cNode.getNodeName(),addMenuList);	
								}
								else {
									settingValue.put(cNode.getNodeName(),cNode.getFirstChild().getNodeValue());
								}
							}
							else{
								if(cNode.getNodeName().equals("AddMenu")){
									addMenuList.add("");
									settingValue.put(cNode.getNodeName(),addMenuList);	
								}else{
									settingValue.put(cNode.getNodeName(),"");
								}
							}
						}
					}
				}
			}
			
			return settingValue;
	} 
	catch (RuntimeException e) {
			System.out.println("System Error 6");
			return settingValue;
	}
}

public List childrenList(Node root)
{
	NodeList nodeList = root.getChildNodes();
	List childrenList = new ArrayList();
	Node node;
	/*
	try{
		*/
			for(int i=0; i<nodeList.getLength(); i++){
				node = nodeList.item(i);
				if(node.getNodeType() == Node.ELEMENT_NODE){	
					 childrenList.add(node.getNodeName());
				}
			}
			return childrenList;
	/*
	} catch (Exception pce) {
		System.out.println("An internal exception occured!");
		return childrenList ;
	}
	*/
}

public String skinDirectory(String urlPPath,String xmlInfo)
{
	String skinValue = "";
	String skinDirUrl = urlPPath + "template";
	
	File skinDir = new File(skinDirUrl);
	String contents[] = skinDir.list();

	if(contents != null){
		for(int i=0;i<contents.length;i++){
			File dirCheck = new File(skinDirUrl+File.separator+contents[i]);
			try{
				if(dirCheck.isDirectory()){
					if(skinValue.equals("")) skinValue = contents[i]; 
					else skinValue = skinValue + "," + contents[i];
				}
			}
			catch(NumberFormatException e){
				continue;
			}
		}
	}
	//return skinValue;
	String skinValues[] = skinValue.split(",");
	String optionTag = "<select name='Skin' id='Skin' class='inputSelectStyle'>";
	String selectCheck = "";

	for(int i=0; i<skinValues.length; i++){
		if(skinValues[i] != null && skinValues[i].equals("webtree")){
			continue;
		}
		if(xmlInfo.equals(skinValues[i])){
			selectCheck = "selected=\"selected\"";
			optionTag = optionTag + "<option value='"+skinValues[i]+"' "+selectCheck+" >"+skinValues[i]+"</option>";
		}
		else{ 
			optionTag = optionTag + ("<option value='"+skinValues[i]+"'>"+skinValues[i]+"</option>");
		}
		selectCheck = "";
	}
	optionTag = optionTag + "</select>";
	return optionTag ;
}

public boolean xmlCreate(String xmlText, String filenames)
{
	boolean check = true;
	FileWriter fout = null;
	try{
		File f = new File(filenames);
		if(f.canWrite()){
			fout = new FileWriter(f);
			fout.write(detectXSSEx2(xmlText));
		}
		else{
			check = false;
		}
	}
	catch (java.io.IOException e) {
		System.out.println("System Error 8");
	}
	finally{
		try{
				if( fout != null){
					fout.close();
					fout = null;
				}
			}catch(java.io.IOException err1){
				System.out.println("An internal exception occured!!");
			}catch(Exception err){
				System.out.println("An internal exception occured!!");
			}
	}
	return check;
}

public String encrypt(String EncMthd,String strData)
{
	MessageDigest md;
	String strENCData = "";

	try{
			md = MessageDigest.getInstance(EncMthd);
			byte[] byBytes = strData.getBytes();
			md.update(byBytes);
			byte[] digest = md.digest();
			for(int i=0; i<digest.length; i++){
				strENCData = strENCData + Integer.toHexString(digest[i] & 0xFF).toUpperCase();
			}
		
			return strENCData;
	}
	catch(NoSuchAlgorithmException e){
			System.out.println("System Error 9");
			return strENCData = "";
	}
}

public String manageInFo_text(String urlPPath)
{
	String manageInfoPath = urlPPath + "manageInfo.jsp";
	String manageInfoStr = "";
	BufferedReader manageInfoText = null;
	FileReader fr = null;
	try{
		fr = new FileReader(manageInfoPath);
		manageInfoText = new BufferedReader(fr);
//		String line = "";
//		while((line = manageInfoText.readLine()) != null){
//			  manageInfoStr += line;
//		}

		char[] buffer = new char[1024];

		manageInfoText.read(buffer,0,1024);

//		for (char c:buffer)
//        {
//			if(c != (char)0)
//            {
//               manageInfoStr += c;
//            }
//        }

		for (int i=0; buffer.length>i; i++)
        {
			if(buffer[i] != (char)0)
            {
               manageInfoStr += buffer[i];
            }
        }
		manageInfoText.close();
		fr.close();

	}catch(java.io.FileNotFoundException e1){
		System.out.println("System Error 10");		
	}catch(java.io.IOException e2){
		System.out.println("System Error 11");
	}finally{
		try{
			if( manageInfoText != null){
				manageInfoText.close();
				manageInfoText = null;
			}
			if( fr != null){
				fr.close();
				fr = null;
			}
		}catch(java.io.IOException err1){
			System.out.println("An internal exception occured!!!");
		}catch(Exception err){
			System.out.println("An internal exception occured!!!");
		}
	}

	return manageInfoStr;
}

public List xmlField_list(Element root){
	
	List parent = childrenList(root);
	List children;
	List xmlField_list = new ArrayList();

	for (int i=0; i<parent.size(); i++){
		NodeList child = root.getElementsByTagName((String)parent.get(i));
		Node node = child.item(0);
		
		children = childrenList(node);
		for (int j=0; j<children.size(); j++){
			xmlField_list.add(children.get(j));
		}
	}

	return xmlField_list;
}

public boolean update_check(String update_xml_url,String before_xml_url){

	boolean update_check = false;
	Element update_xml_root = configXMlLoad(update_xml_url);
	List update_xml = xmlField_list(update_xml_root);
	Element before_xml_root = configXMlLoad(before_xml_url);
	List before_xml= xmlField_list(before_xml_root);
	
	boolean check = false;
	for (int i=0; i<update_xml.size(); i++){

		check = false;
		for (int j=0; j<before_xml.size(); j++){
			if(update_xml.get(i).equals(before_xml.get(j))){
				check = true;
				break;
			}
		}
		if(check == false)
		{
			update_check = true;
			break;
		}
	}

	return update_check;
}

public String update_xml(String update_xml_url,String before_xml_url){

	Element update_xml_root = configXMlLoad(update_xml_url);
	Element before_xml_root = configXMlLoad(before_xml_url);
	
	Hashtable update_xml_settingValue = childValueList(update_xml_root);
	Hashtable before_xml_settingValue = childValueList(before_xml_root);

	String StartTag = update_xml_root.getNodeName();
	String xml_Text = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
	
	xml_Text += "<" + StartTag + ">\n";

	List parent = childrenList(update_xml_root);

	for(int i=0;i<parent.size();i++){
		xml_Text +="	<" + parent.get(i) + ">\n";
		NodeList child = update_xml_root.getElementsByTagName((String)parent.get(i));	
		Node node = child.item(0);
		List children = childrenList(node);

		for(int j=0;j<children.size();j++){
			
			if(children.get(j).equals("AddMenu") && before_xml_settingValue.get("AddMenuCheck").equals("true")) {
				List addMenuListValue = (List)before_xml_settingValue.get("AddMenu");
				for(int k=0; k<addMenuListValue.size(); k++){
					xml_Text += "		<" + children.get(j) + ">" + addMenuListValue.get(k) + "</" + children.get(j) + ">\n";
				}
			}
			else if(before_xml_settingValue.get(children.get(j)) != null){
				xml_Text += "		<" + children.get(j) + ">" + before_xml_settingValue.get(children.get(j)) + "</" + children.get(j) + ">\n";
			}
			else{
				String getXmlSettingValue = " " + update_xml_settingValue.get(children.get(j)) + " ";
				getXmlSettingValue = getXmlSettingValue.trim();
				if(getXmlSettingValue.equals("[]")) getXmlSettingValue = "";
				
				xml_Text += "		<" + children.get(j) + ">" + getXmlSettingValue + "</" + children.get(j) + ">\n";
			}

		}

		xml_Text +="	</" + parent.get(i) + ">\n";
	}
	
	xml_Text += "</" + StartTag + ">\n";
	boolean check_save = xmlCreate(xml_Text,before_xml_url);
	
	if(check_save)return "sucess";
	else return "fail";
	
}

%>