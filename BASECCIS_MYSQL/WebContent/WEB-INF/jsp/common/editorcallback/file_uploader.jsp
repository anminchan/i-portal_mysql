<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.commons.fileupload.FileUploadException" %>
<%@page import="org.springframework.web.multipart.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
	<script src="${contextPath }/resources/component/daumeditor-7.4.27/js/popup.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
	// <![CDATA[
		
		function done() {
			if (typeof(execAttach) == 'undefined') { //Virtual Function
		        return;
		    }
			
			var _mockdata = {
				'imageurl': '${filePath}',
				'filename': '${fileName}',
				'filesize': '${fileSize}',
				'imagealign': 'C',
				'originalurl': '${filePath}',
				'thumburl': '${filePath}'
			};
			execAttach(_mockdata);
			closeWindow();
		}
	
		function initUploader(){
		    var _opener = PopupUtil.getOpener();
		    if (!_opener) {
		        alert('잘못된 경로로 접근하셨습니다.');
		        return;
		    }
		    
		    var _attacher = getAttacher('image', _opener);
		    registerAction(_attacher);
		    
		    done();
		}
		
	// ]]>
	</script>		
	</head>
	<body onload="initUploader();">
	</body>
</html>
