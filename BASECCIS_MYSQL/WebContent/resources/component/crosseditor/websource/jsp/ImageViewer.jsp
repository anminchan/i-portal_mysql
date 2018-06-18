<%@include file = "Util.jsp"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
String imgUrl = request.getParameter("imagesrc");

if (imgUrl != null) {
	
	String rename_imgUrl = "";
	String fileRealFolder = "";
	String ContextPath = request.getContextPath();
	String urlPath = "";
	String imgUrlSubValue = "";
	String imageName = "";
	String imageExt = "";
	String imageEncodingSt = "";
	String base64_decodeText_utf8 = "";

	imgUrl = URLDecoder.decode(imgUrl);
	if (imgUrl.indexOf("http://") != -1){
	
		urlPath = imgUrl.substring(7);
		urlPath = urlPath.substring(urlPath.indexOf("/"), urlPath.lastIndexOf("/") + 1);
		imgUrlSubValue = imgUrl.substring(imgUrl.lastIndexOf("/") + 1);

		if (imgUrlSubValue.indexOf("|") != -1) {
			imageEncodingSt = imgUrlSubValue.substring(imgUrlSubValue.indexOf("|") + 1);
			imageName = imgUrlSubValue.substring(0, imgUrlSubValue.indexOf("."));
			imageExt = imgUrlSubValue.substring(imgUrlSubValue.indexOf(".") + 1, imgUrlSubValue.indexOf("|"));
		}
		else {
			imageName = imgUrlSubValue.substring(0,imgUrlSubValue.indexOf("."));
			imageExt = imgUrlSubValue.substring(imgUrlSubValue.indexOf(".") + 1);
		}

		String convertImageName = "";
		for(int i = 0; i < imageName.length(); i++)
		{
			if (imageName.charAt(i) == ' '){
				convertImageName += "+";
			}else{
				convertImageName += imageName.charAt(i);
			}
		}
		imageName = convertImageName;

		if(imageEncodingSt.equals("real")){
			if (imageName.indexOf("==NamOSeSlaSH==") != -1) imageName = imageName.replaceAll("==NamOSeSlaSH==", "/");
			sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
			byte[] domainByte2 = decoder.decodeBuffer(imageName);
			base64_decodeText_utf8 = new String(domainByte2, "UTF8");
		}
		else{
			base64_decodeText_utf8 = imageName;
		}
	
		fileRealFolder = Dompaser(urlPath);
		
		if (fileRealFolder.equals(""))
		{
			ServletContext context = getServletConfig().getServletContext();
			fileRealFolder = context.getRealPath(urlPath);

			//2013.08.26 [2.0.5.23] mwhong tomcat8.0 에서 getRealPath가 null을 리턴하여 수정
			if(fileRealFolder == null && urlPath != null && ContextPath != null){
				fileRealFolder = context.getRealPath(urlPath.substring(ContextPath.length()));
			}

			if (!ContextPath.equals("") && !ContextPath.equals("/")){
				File tempFileRealDIR = new File(fileRealFolder);
				if(!tempFileRealDIR.exists()){
					if (urlPath.indexOf(ContextPath) != -1){
						String rename_image_temp = urlPath.substring(ContextPath.length());
						fileRealFolder = context.getRealPath(rename_image_temp);
					}
				}
			}
		}
		
		if (fileRealFolder.lastIndexOf(File.separator) != fileRealFolder.length() - 1){
			fileRealFolder = fileRealFolder + File.separator;
		}

		if (!IsArray("gif,jpeg,jpg,png,bmp" , imageExt))
		{
			String mediaMimeTypeValue = mediaMimeType(imageExt);

			if(mediaMimeTypeValue != null && mediaMimeTypeValue.equals("noContents")){
				System.out.println("not contents!");
				return;
			}

			response.setContentType(mediaMimeTypeValue);	
		}
		else {
			response.setContentType("image/gif");
		}

		String file = fileRealFolder + base64_decodeText_utf8 + "." +  imageExt;
		//out.println(file);
		
		byte [] buffer = new byte[1024];
		out.clear(); 
        out=pageContext.pushBody();
		ServletOutputStream outFile = response.getOutputStream();
		BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
		try {
			
			int n=0 ;
			while ((n=in.read(buffer, 0, 1024)) != -1) {
				outFile.write(buffer, 0, n);
			}
			//outFile.close();
			//in.close();
		 }
		 catch(IOException e){
			System.out.println("An internal exception occured!");
		 }finally{
			if(outFile != null){
				outFile.close();
			}
			if(in != null){
				in.close();
			}
		 }
		
	}
}

%>