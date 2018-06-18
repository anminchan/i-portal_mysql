<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.lang.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%@page import ="javax.xml.parsers.DocumentBuilder"%>
<%@page import ="javax.xml.parsers.ParserConfigurationException"%>
<%@page import ="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import ="org.xml.sax.SAXException"%>
<%@page import ="org.w3c.dom.Document"%>
<%@page import ="org.w3c.dom.Element"%>
<%@page import ="org.w3c.dom.Node"%>
<%@page import ="org.w3c.dom.NodeList"%>
<%@page import ="org.xml.sax.SAXParseException"%>
<%!
public boolean isImageValid(String typeCheck,String fileCheck )
{
	String appExtensions ="";
	
	boolean value = false;
	  
	if(typeCheck.equals("flash"))
	{
		appExtensions = "swf,wmv,avi,mp4,ogg,webm";
	}
	else if(typeCheck.equals("file"))
	{
		appExtensions = "zip,doc,docx,xls,xlsx,txt,pdf";
	}
	else
	{
		appExtensions = "gif,jpeg,jpg,png,bmp";
	}
	
	String app[] =  appExtensions.split(",");

	for(int i=0;i<app.length;i++)
	{
		if(app[i].equals(fileCheck)){value = true;}
	}
	
	return value;
}
  
public String getImageKind(String typeCheck)
{
	if(typeCheck.equals("flash"))
	{
		return "swf, wmv, avi, mp4, ogg, webm";	
	}
	else if(typeCheck.equals("file"))
	{
		return "zip, doc, docx, xls, xlsx, txt, pdf";
	}
	else
	{
		return "gif, jpeg, jpg, png, bmp";
	}
}

public boolean IsArray(String appExtensions, String fileCheck)
{
	String app[] =  appExtensions.split(",");
	boolean value = false;

	for (int i=0;i<app.length;i++) {
		if(app[i].equals(fileCheck)){value = true;}
	}
	
	return value;
}

public String getChildDirectory(String path, String maxCount)
{
	
	if(maxCount.equals("")){maxCount = "100";}
	
	boolean childFlag = false;
	int childNum = 0;
	String childName = "";
	int fileInt = 0;
	
	File dir = new File(path);
	if(!dir.exists()){return childName = "";}
	int listLength = 0;
	if (dir != null) {
		listLength = dir.list().length;
	}
	
	for(int i=0;i<listLength;i++)
	{
		File tmpFile = new File(path + File.separator + dir.list()[i]);
		try{
			if(tmpFile.isDirectory())
			{
				fileInt =  Integer.parseInt(tmpFile.getName());
				childFlag = true;
				if(fileInt > childNum)
				{		
					childNum = fileInt;
					childName = tmpFile.getName();
				}
			}
		}
		catch(NumberFormatException e)
		{
			continue;
		}
	}

	if(!childFlag)
	{
		childNum++;
		childName = "000000" + Integer.toString(childNum);
		childName = childName.substring(childName.length() - 6);
		File dirNew = new File(path+File.separator+childName);
		dirNew.mkdir();
	}

	String childPath = path + File.separator + childName;
	
	File dir3 = new File(childPath);
	int cCount = 0;
	if (dir3 != null) {
		listLength = dir3.list().length;
	}
	for(int i=0;i<listLength;i++)
	{
		File tmpFiles = new File(childPath+File.separator+dir3.list()[i]);
		if(tmpFiles.isFile())
		{
			cCount++;
		}
	}
	if(cCount >= Integer.parseInt(maxCount))
	{
		childNum++;
		childName = "000000" + Integer.toString(childNum);
		childName = childName.substring(childName.length() - 6);
		File dir4 = new File(path+File.separator+childName);
		dir4.mkdir();
	}
	return childName;
}

public String checkFileUniqueName(String realFileName, String image_physical_path ,String fileCheck)
{
	String strFileName = realFileName + "." + fileCheck;
	boolean due_check = true;
	String strFileWholePath = image_physical_path + File.separator + strFileName;
	int due_File_Count = 0;

	while(due_check)
	{
		if(new File(strFileWholePath).exists())
		{
			due_File_Count += 1;
			strFileName = realFileName + "_" + due_File_Count + "." + fileCheck;
			strFileWholePath = image_physical_path + File.separator + strFileName;
		}
		else
		{
			due_check = false;
		}
	}
	return strFileName;
}

public int fileCopy(String path, String savePath)
{
	int check = 0; 

	FileInputStream inputStream = null;
	FileOutputStream outputStream = null;
	BufferedInputStream bin = null;
	BufferedOutputStream bout = null;
	
	try{
		inputStream = new FileInputStream(path);         
		outputStream = new FileOutputStream(savePath);

		bin = new BufferedInputStream(inputStream);
		bout = new BufferedOutputStream(outputStream);

		int bytesRead = 0;
		byte[] buffer = new byte[1024];

		while ((bytesRead = bin.read(buffer, 0, 1024)) != -1) {
			bout.write(buffer, 0, bytesRead);
		}
		check = 1;
	}
	catch(IOException ioe)
	{
		check = 0;
	}
	finally
	{
		try
		{
			if(bout != null){
				bout.close();
			}
			if(bin != null){
				bin.close();
			}
			if(outputStream != null){
				outputStream.close();
			}
			if(inputStream != null){
				inputStream.close();
			}
		}
		catch(IOException e)
		{
			System.out.println("1:An internal exception occured!");
		}
	}
	return check;
}

public String getEditorAuth(String filename, String conn, String conval)
{
	String result = "false";
	String str = "";
	HttpURLConnection con = null;
	InputStreamReader reader = null;
	BufferedReader br = null;

	try
	{
		URL url = new URL(filename);
		con = (HttpURLConnection)url.openConnection();
		reader = new InputStreamReader(con.getInputStream());

		br = new BufferedReader(reader);
		char[] buffer = new char[1024];
				
//		String data = "";
//		while((data=br.readLine()) != null ){
//			str += data;
//		}

		br.read(buffer,0,1024);

//		for (char c : buffer)
//        {
//			if(c != (char)0)
//            {
//               str += c;
//            }
//        }
//       }

		for (int i=0; buffer.length>i; i++)
        {
			if(buffer[i] != (char)0)
            {
               str += buffer[i];
            }
        }

		if (str.equals("valid")){
			result = "true";
		}else if (str.equals("expire_invalid")){
			result = "expire";
		}else{
			result = "false";
		}
	}
	catch(IOException e)
	{
		System.out.println("2:An internal exception occured!");
	}
	finally
	{
		try
		{
			if(br != null){
				br.close();
			}
			if(reader != null){
				reader.close();
			}
			if(con != null){
				con.disconnect();
			}	
		}
		catch(IOException e)
		{
			System.out.println("3:An internal exception occured!");
		}
	}
	return result;
}

public String createEncodeEditorKey(String genkey)
{
	sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
	byte[] keyByte = genkey.getBytes();
	String base64_encodeText = encoder.encode(keyByte);
	
	int str_length = base64_encodeText.length();
	String strLeft = base64_encodeText.substring(0,str_length/2);
	String strRight = base64_encodeText.substring(str_length/2,str_length);

	int strLeft_length = strLeft.length();
	String strLeftSubLeft = strLeft.substring(0,strLeft_length/2);
	String strLeftSubRight = strLeft.substring(strLeft_length/2,strLeft_length);

	int strRight_length = strRight.length();
	String strRightSubLeft = strRight.substring(0,strRight_length/2);
	String strRightSubRight = strRight.substring(strRight_length/2,strRight_length);
	
	genkey = strLeftSubLeft + strRightSubLeft + strRightSubRight + strLeftSubRight;

	return genkey;
}

public long getDateDiff(String targetDate)
{
	long dateDiff = 1;

	try{
		Calendar gCal = Calendar.getInstance();
		gCal.setTime(new Date());
		int cur_year = gCal.get(Calendar.YEAR);
		int cur_month = gCal.get(Calendar.MONTH)+1;
		int cur_day = gCal.get(Calendar.DATE);
		
		String[] exp_arr = targetDate.split("-");
		int target_year = Integer.parseInt(exp_arr[0]);
		int target_month = Integer.parseInt(exp_arr[1]);
		int target_day = Integer.parseInt(exp_arr[2]);

		Calendar ca1 = Calendar.getInstance();
        Calendar ca2 = Calendar.getInstance();

        ca1.set(target_year, target_month, target_day);
        ca2.set(cur_year, cur_month, cur_day);

        long milisecond1 = ca1.getTimeInMillis();
        long milisecond2 = ca2.getTimeInMillis();

        long diffInMSec = milisecond2 - milisecond1;

        dateDiff = diffInMSec / (24 * 60 * 60 * 1000);
	}catch(RuntimeException e){
		System.out.println("4:An internal exception occured!");
	}

	return dateDiff;
}

public String executeFileScript(HttpServletResponse response, String result, String addmsg, String useExternalServer, String userDomain, String image_editor_flag)
{
	String param = "";
	String result_sc = "";

	userDomain = userDomain.trim();
	if (!userDomain.equals(""))
		userDomain = "document.domain=\"" + userDomain + "\";";
	else
		userDomain = "";

	if (image_editor_flag.equals("flashPhoto")) {
		param = "{";
		param += "\"result\":\"" + result + "\",";
		param += "\"imageURL\":\"\",";
		param += "\"addmsg\":\"" + addmsg + "\"";
		param += "}";

		result_sc = param; 
	} else {
		if (addmsg != null)
			param = "'" + result + "','" + addmsg + "'";
		else
			param = "'" + result + "'";

		if (!useExternalServer.equals("")) {
			try {
				result_sc = "?userdomain=" + URLEncoder.encode(userDomain, "UTF-8");
				result_sc += "&funcname=" + URLEncoder.encode("setInsertFile", "UTF-8");
				result_sc += "&param=" + URLEncoder.encode(param, "UTF-8");

				response.sendRedirect(useExternalServer + result_sc);
				return "";
			} catch (IOException e) {
				System.out.println("5:An internal exception occured!");
			}
		} else {
			result_sc = "<script language='javascript' type='text/javascript'>";
			result_sc += userDomain;
			result_sc += "parent.window.setInsertFile(" + param + ");</script>";
		}
	}

	return result_sc;
}

public String executeScript(HttpServletResponse response, String result, String addmsg, String useExternalServer, String userDomain, String image_editor_flag, String checkPlugin)
{
	String param = "";
	String result_sc = "";

	userDomain = userDomain.trim();
	if (!userDomain.equals(""))
		userDomain = "document.domain=\"" + userDomain + "\";";
	else
		userDomain = "";

	if (image_editor_flag.equals("flashPhoto")) {
		param = "{";
		param += "\"result\":\"" + result + "\",";
		param += "\"imageURL\":\"\",";
		param += "\"addmsg\":\"" + addmsg + "\"";
		param += "}";

		result_sc = param; 
	} else {
		
		if(checkPlugin.equals("false")) {
			// 20141118 image drag&drop event
			if (addmsg != null) {
				param = "{";
				param += "\"result\":\"" + result + "\",";
				param += "\"addmsg\":[" + addmsg + "]";
				param += "}";
			} else {
				param = "{";
				param += "\"result\":\"" + result + "\"";
				param += "}";
			}
		} else {
			if (addmsg != null)
				param = "'" + result + "','" + addmsg + "'";
			else
				param = "'" + result + "'";
		}

		if (checkPlugin.equals("false")) {
			// 20141118 image drag&drop event
			result_sc = param;
		} else if(!useExternalServer.equals("")) {	
			try {
				result_sc = "?userdomain=" + URLEncoder.encode(userDomain, "UTF-8");
				result_sc += "&funcname=" + URLEncoder.encode("setInsertImageFile", "UTF-8");
				result_sc += "&param=" + URLEncoder.encode(param, "UTF-8");

				response.sendRedirect(useExternalServer + result_sc);
				return "";
			} catch (IOException e) {
				System.out.println("6:An internal exception occured!");
			}
		} else {
			result_sc = "<script language='javascript' type='text/javascript'>";
			result_sc += userDomain;
			result_sc += "parent.window.setInsertImageFile(" + param + ");</script>";
		}
	}

	return result_sc;
}


public String Dompaser(String image_temp)
{
	String imageUrl = image_temp;
	String oContextPath = "";
	String oDocPath = "";
	String oPhygicalPath = "";
	String pathValue = "";

	try {
		if (System.getProperty("catalina.home") != null){

			String filenames=System.getProperty("catalina.home") + "/conf/server.xml";
			File severXml = new File(filenames);
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(severXml);
			
			NodeList nodeLst = doc.getElementsByTagName("Context");
					
			for(int i = 0; i<nodeLst.getLength(); i++)
			{
				pathValue = ((Element)nodeLst.item(i)).getAttribute("path");
				
				try{
					if (pathValue.equals(imageUrl.substring(0,pathValue.length())))
					{
						if(pathValue.length() > oContextPath.length())
						{
							oContextPath = pathValue;
							oDocPath = ((Element)nodeLst.item(i)).getAttribute("docBase");
							
							if(pathValue.lastIndexOf("/") == pathValue.length()-1)
							{
								pathValue = pathValue.substring(0,pathValue.lastIndexOf("/"));
							}
							
							oPhygicalPath = oDocPath;
							String pathArr[] = imageUrl.substring(pathValue.length()).split("/");
							for (int t = 0; t < pathArr.length; t++){
								if (!pathArr[t].equals("")){
									oPhygicalPath += File.separator + pathArr[t];
								}
							}
						}
					}
				} catch(RuntimeException e2) {
					//continue;
					System.out.println("7:An internal exception occured!");
				}
			}
		}
	} catch (ParserConfigurationException  e) {
		oPhygicalPath = "";
		System.out.println("8:An internal exception occured!");
	}catch (IOException  e) {
		oPhygicalPath = "";
		System.out.println("9:An internal exception occured!");
	}catch (SAXException  e) {
		oPhygicalPath = "";
		System.out.println("10:An internal exception occured!");
	}

	return oPhygicalPath;
}

public String mediaMimeType(String fileExt) {
		
	String returnValue = "";
	String defaultType = "noContents";
	String flashType = "application/x-shockwave-flash";	
	String quicktimeType = "video/quicktime";			
	String asfType = "video/x-ms-asf";					
	String mpegType = "audio/mpeg";						
	String midType = "audio/x-midi";					
	String rmType = "application/vnd.rn-realmedia";		
	String wavType = "audio/x-wav";						
	String dcrType = "application/x-director";			
	String flvType = "video/x-flv";	
	
	String wmvType = "video/x-ms-wmv";
	String aviType = "video/x-msvideo";
	String mp4Type = "video/mp4";
	String oggType = "video/ogg";
	String webmType = "video/webm";

	fileExt = fileExt.toLowerCase();

	if (fileExt.equals("mov")) {
		returnValue = quicktimeType;
	}
	else if (fileExt.equals("wav")) {
		returnValue = wavType;
	}
	else if (fileExt.equals("swf")) {
		returnValue = flashType;
	}
	else if (fileExt.equals("flv")) {
		returnValue = flvType;
	}
	else if (fileExt.equals("dcr")) {
		returnValue = dcrType;
	}
	else if (fileExt.equals("asf")) {
		returnValue = asfType;
	}
	else if (fileExt.equals("asx")) {
		returnValue = asfType;
	}
	else if (fileExt.equals("mp2")) {
		returnValue = mpegType ;
	}
	else if (fileExt.equals("mp3")) {
		returnValue = mpegType ;
	}
	else if (fileExt.equals("mpga")) {
		returnValue = mpegType;
	}
	else if (fileExt.equals("mid")) {
		returnValue = midType;
	}
	else if (fileExt.equals("midi")) {
		returnValue = midType;
	}
	else if (fileExt.equals("rm")) {
		returnValue = rmType;
	}
	else if (fileExt.equals("ram")) {
		returnValue = rmType;
	}
	else if (fileExt.equals("wmv")) {
		returnValue = wmvType;
	}
	else if (fileExt.equals("avi")) {
		returnValue = aviType;
	}
	else if (fileExt.equals("mp4")) {
		returnValue = mp4Type;
	}
	else if (fileExt.equals("ogg")) {
		returnValue = oggType;
	}
	else if (fileExt.equals("webm")) {
		returnValue = webmType;
	}
	else {
		returnValue = defaultType;
	}


	return returnValue;
}

public int getRandomSeed(String div, String cpath)
{
	
	int returnVal = 0;
	String url1 = xmlUrl1(cpath);
	Element root1 = configXMlLoad1(url1);
	Hashtable settingValue = childValueList1(root1);
	returnVal = Integer.parseInt(settingValue.get(div).toString());

	return returnVal;
}

public String rootFolderPath1(String urlPath)
{
	String fileRealFolder = "";
	fileRealFolder = urlPath.substring(0, urlPath.lastIndexOf("/") + 1);

	return fileRealFolder;
}

public String xmlUrl1(String urlPPath)
{
	return  urlPPath + File.separator +  "config" + File.separator + "xmls" + File.separator + "Config.xml";
}

//xml data load
public static Element configXMlLoad1(String configValue)
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
		System.out.println("internal exception occured!");
	} catch (SAXException e) {
		System.out.println("internal exception occured!");
	} catch (java.net.MalformedURLException mfx) {
		System.out.println("internal exception occured!");
	} catch (java.io.IOException e) {
		System.out.println("internal exception occured!");
	} catch (Exception pce) {
		System.out.println("internal exception occured!");
	}
	return null;
}

public Hashtable childValueList1(Element root)
{
	Hashtable settingValue = new Hashtable();
	List addMenuList = new ArrayList();
	
	NodeList nodeList = root.getChildNodes();
	Node node;
	Node cNode;
	NodeList childNodes;
	settingValue.put("AddMenuCheck", "false");
	
	/*
	try{
	*/
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
	/*
	} catch (Exception pce) {
			System.out.println("internal exception occured!");
			return settingValue;
	}
	*/
}

// filename is Time 
public String fileNameTimeSetting()
{
	String fileNameTime = "";
	Calendar oCalendar = Calendar.getInstance();
	
	StringBuffer buffer = new StringBuffer();
    Random random = new Random();
	String randomValue = "";
	String chars[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9".split(",");
	int count = 8;
	for(int i=0; i<count; i++) {
		// buffer.append(chars[random.nextInt(chars.length)]);
		// buffer.append(chars[random.nextInt(getRandomSeed("randomfilename", path))]);
		int ranVal = random.nextInt();
		if(ranVal < 0){
			ranVal = (ranVal * -1);
		}
		ranVal = (ranVal % chars.length);
		buffer.append(chars[ranVal]);
    }
	randomValue = buffer.toString();
	
	// YYYYMMDDhhmmssxxx_rendom(int+Char)
	String oYear = Integer.toString(oCalendar.get(Calendar.YEAR));
	String oMonth = "0" + Integer.toString(oCalendar.get(Calendar.MONTH) + 1);
	String oDay = "0" + Integer.toString(oCalendar.get(Calendar.DAY_OF_MONTH));
	String oHour = "0" + Integer.toString(oCalendar.get(Calendar.HOUR_OF_DAY));
	String oMin = "0" + Integer.toString(oCalendar.get(Calendar.MINUTE));
	String oSec = "0" + Integer.toString(oCalendar.get(Calendar.SECOND));
	String oMillSec = Integer.toString(oCalendar.get(Calendar.MILLISECOND)) + "00";	

	oMonth = oMonth.substring(oMonth.length() - 2);
	oDay = oDay.substring(oDay.length() - 2);
	oHour = oHour.substring(oHour.length() - 2);
	oMin = oMin.substring(oMin.length() - 2);
	oSec = oSec.substring(oSec.length() - 2);
	oMillSec = oMillSec.substring(0,3);

	fileNameTime = oYear + oMonth + oDay + oHour + oMin + oSec + oMillSec + "_" + randomValue;
	
	return fileNameTime;
}

public String tempFolderCreate(String path)
{
	StringBuffer buffer = new StringBuffer();
	Random random = new Random();
	String chars[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split(",");
	String randomValue = "";
	int count = 10;
	for(int i=0; i<count; i++) {
		// buffer.append(chars[random.nextInt(chars.length)]);
		// buffer.append(chars[random.nextInt(getRandomSeed("randomfoldername", cpath))]);
		int ranVal = random.nextInt();
		if(ranVal < 0){
			ranVal = (ranVal * -1);
		}
		ranVal = (ranVal % chars.length);
		buffer.append(chars[ranVal]);
    }
	randomValue = buffer.toString();

	path = path + randomValue + File.separator;
	File tempSubFolder = new File(path); 
	tempSubFolder.mkdir();

	return path;
}

public void tempFolderDelete(String path)
{
	synchronized(this){
		File tempFolder = new File(path);
		if(tempFolder.exists()){
			tempFolder.delete();
		}
	}
}
 

public static String toString ( String s ) { 
	if ( s == null ) return ""; 
	return s; 
} 
%>