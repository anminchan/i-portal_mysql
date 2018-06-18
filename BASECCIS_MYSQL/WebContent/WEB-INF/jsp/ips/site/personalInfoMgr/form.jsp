<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/personalInfoMgr/act" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	
	<!-- PersonalInfoHiddenData -->
	<input type="hidden" id="personalInfoId" name="personalInfoId" value="${rtnPersonalInfo.personalInfoId}"/>
	
	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schKName" value="${param.schKName }">
	
	<fieldset>
		<legend>개인정보처리방침 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<table class="tstyle_view" summary="등록일, 이름, 이메일, 담당부서, 제목, 내용에 따른 게시물상세 안내">
			<caption>
				사이트 상세 정보 입력
			</caption>
			<colgroup>
				<col width="170" />
				<col />
				<col width="170" />
				<col />
			</colgroup>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="KName">제목</label></th>
				<td colspan="3"><input type="text" id="KName" name="KName" value="${rtnPersonalInfo.KName}" class="input_mid02" maxlength="40" title="개인정보처리방침제목" /></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="KDesc">내용</label></th>
<%-- 				<td colspan="3"><input type="text" name="KDesc" id="KDesc" value="${rtnPersonalInfo.KDesc}" class="input_long" title="팝업내용"/></td> --%>
				<td colspan="3">
                    <textarea id="KDesc" name="KDesc" rows="" cols="" style="display: none;"><c:out value="${rtnPersonalInfo.KDesc }" escapeXml="true" /></textarea>
                    <c:if test="${editor eq 'Namo'}">		            
			            <!-- ▼ 에디터 -->  
			          	<script type="text/javascript">         
			            var CrossEditor = new NamoSE('namoEditor');
			            CrossEditor.params.ImageSavePath = "${editorImgPath}";
			            CrossEditor.params.UploadFileExecutePath = "${editorUploadFileExePath}";
			            //에디터 업로드 용량
			           	CrossEditor.params.UploadFileSizeLimit = "movie:524288000, image:20971520";
			            CrossEditor.params.Width = "100%";
			            CrossEditor.EditorStart();
			            function OnInitCompleted(e){
			            	e.editorTarget.SetBodyValue($("#KDesc").val());
			            }
			          	</script>
			           	<!-- ▲ 에디터  -->
		           	</c:if>
		           	<c:if test="${editor eq 'Daum'}">
		            	<!-- ▼ 에디터 -->  
			          	<script type="text/javascript">
			          		gfnInitEditor("KDesc", 'self');
			          	</script>
		           		<div id="editor_frame"></div>
		           	</c:if>
                </td>
			</tr>
			
		</table>
	</fieldset>
</spform:form>

<div class="btn_area">
		<button type="button" class="btn btn_type02 ${!empty rtnPersonalInfo.personalInfoId ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
		<c:if test="${!empty rtnPersonalInfo.personalInfoId}">
		<button type="button" class="btn btn_type01 roleDELETE" id="btnDelete">삭제</button>
		</c:if>
		<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>

<script type="text/javascript">
$(function() {
	
	$("#btnSave").click(function(){
		if($("#KName").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#KDesc").val(Editor.getContent());
		}else{
			$("#KDesc").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End
		
		if($("#KDesc").val().length <= 0) {
			alert("내용을 입력하세요.");
			$("#KDesc").focus();
			return false;
		}
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}

		$("#insertForm").attr('action', '${ctxMgr}/personalInfoMgr/act');
		$("#insertForm").submit();
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr}/personalInfoMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/personalInfoMgr');
		$("#insertForm").submit(); */

		location.href="${contextPath}/mgr/personalInfoMgr?${link}";
	});
	
});

</script>
