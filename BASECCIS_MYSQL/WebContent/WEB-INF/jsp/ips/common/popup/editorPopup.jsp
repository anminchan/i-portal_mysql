<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<fieldset>
	<legend>정보 입력</legend>
	<div class="table">
		<table class="tstyle_view">
			<caption>정보 입력</caption>
			<tr>
				<td>
				<c:if test="${editor eq 'Namo'}">		            
		            <!-- ▼ 에디터 -->  
		          	<script type="text/javascript">         
		          	var CrossEditor = new NamoSE('namoEditor');
					CrossEditor.params.ImageSavePath = "${editorImgPath}";
					CrossEditor.params.UploadFileExecutePath = "${editorUploadFileExePath}";
					CrossEditor.params.Width = "100%";
					CrossEditor.EditorStart();
					
					function OnInitCompleted(e){
						CrossEditor.SetBodyValue(opener.document.getElementById("${editorId}").value);
		           	}
		          	</script>
		           	<!-- ▲ 에디터  -->
		         </c:if>
		         <c:if test="${editor eq 'Daum'}">
		       		<!-- ▼ 에디터 -->  
		         	<script type="text/javascript">
		         		gfnInitEditor("sampleContent", 'opener');
		         	</script>
		         	<div id="editor_frame"></div>
		         	<!-- ▲ 에디터  -->
		        </c:if>
				</td>
			</tr>
		</table>
	</div>
</fieldset>

<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
</div>	

<script type="text/javascript">
$(function() {
	// 등록 이벤트
	$("#btnSave").click(function(){
		var bodyValue = "";
		//var eId = "${editorId}";
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			bodyValue = Editor.getContent();
		}else{
			bodyValue = CrossEditor.GetBodyValue();
		}
		// 다음에디터, 나모에디터 구분 End
		
		// 호출한 부모에 값전달
		//$(opener.location).attr("href", "javascript:setEditorValue('${editorId}', '"+bodyValue+"');");
		
		//opener.setEditorValue(eId, bodyValue);
		window.opener.document.getElementById("${editorId}").value = bodyValue;
		
		self.close(); // 팝업닫기
	});
	
});

</script>