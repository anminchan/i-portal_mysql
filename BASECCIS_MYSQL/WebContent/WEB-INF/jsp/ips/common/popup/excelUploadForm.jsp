<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<script type="text/javascript">
<!--
$(function() {
	if("${param.outResult}" != null && "${param.outResult}" != ""){
		if("${param.outResult}" == "SUCCESS"){
			alert("업로드에 성공했습니다.");
		}else if("${param.outResult}" != "SUCCESS"){
			alert("${param.outResult}");
		}
		window.opener.location.reload();
		self.close();
	}

	if("${outResult}" != null && "${outResult}" != ""){
		if("${outResult}" == "SUCCESS"){
			alert("업로드에 성공했습니다.");
		}else if("${outResult}" != "SUCCESS"){
			alert("${outResult}");
		}
		
		window.opener.location.reload();
		self.close();
	}
	
});

function fnExcelUpload(){
	if(cuManager.getTotalFileCount() == 0){
		alert("업로드 파일을 선택하세요.");
		return false;
	}
	
	if( confirm("업로드시 데이타량에 따라 1~5분정도 소요됩니다.\n업로드 하시겠습니까?") ) {
		cuManager.startUpload();
    }
}

//-->
</script>

<div id="popupContent">
<form id="uploadForm" name="uploadForm" action="" method="POST" >
<!-- 나모첨부파일 사용경우 START -->
<!-- 파일 정보를 저장할 폼 데이터 -->
<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
<!-- 나모첨부파일 사용경우 END -->
	<fieldset>
		<legend></legend>
		<table class="tstyle_view">
			<caption>
			</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tr>
				<th>업로드파일</th>
				<td>
					<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
			        <div id="flashContentManager" style="display: none;">
			            <p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
			            <script type="text/javascript"> 
			                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
			                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
			                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			            </script> 
			        </div>
				</td>
			</tr>
		</table>
	</fieldset>
</form>
</div>

<div class="btn_area">
	<button type="button" class="btn_type01" id="btnExcelAdd" onClick="javascript:fnExcelUpload();">일괄등록</button>
</div>

<script type="text/javascript">
//나모첨부파일 시작
$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('BASE'); //파일Init : 대표이미지, 첨부파일
	// 파일정보파라메타
	actionfrom = $("#uploadForm");
	formaction = "${actionUrl}";
	filePath = "${contextPath }/namoFileUpload?fileGubun=common&fileMenuId=excelUpload";
	fileMaxSize = "${rtnSetting.fileMaxSize}" * 1024 * 1024;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = 1;
	/*나모 End*/
	
});

</script>
