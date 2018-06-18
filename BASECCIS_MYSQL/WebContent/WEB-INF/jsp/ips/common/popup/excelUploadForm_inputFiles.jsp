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
	if($("#file_upload").val() == ""){
		alert("첨부파일을 하나 이상 등록하세요.");
		$("#file_upload").focus();
		return true;
	}

	if( confirm("업로드시 데이타량에 따라 1~5분정도 소요됩니다.\n업로드 하시겠습니까?") ) {
		$("#uploadForm").prop('action', '${actionUrl}')
    }
}

//-->
</script>

<spform:form id="uploadForm" name="uploadForm" action="" method="post" enctype="multipart/form-data">
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
					<input type="file" id="file_upload" name="file_upload" class="input_mid" /> 
				</td>
			</tr>
		</table>
	</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button" class="btn_type01" id="btnExcelAdd" onClick="javascript:fnExcelUpload();">일괄등록</button>
</div>
