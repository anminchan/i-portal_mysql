<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/sampleMgr/act" method="post" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="${obj.menuId}"/>
	<input type="hidden" id="sampleId" name="sampleId" value="${result.SAMPLEID > 0 ? result.SAMPLEID : 0}"/>
	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${obj.pageNum }">
	<input type="hidden" name="schType" value="${obj.schType }">
	<input type="hidden" name="schText" value="${obj.schText }">	
	
	<fieldset>
		<legend>사이트 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<div class="table">
		     <table class="tstyle_view">
				<caption>
					사이트 상세 정보 입력 - 제목, 내용, 첨부파일
				</caption>
				<colgroup>
					<col class="col-sm-3"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="sampleTitle">제목</label></th>
						<td><input type="text" name="sampleTitle" id="sampleTitle" value="${result.SAMPLETITLE}" class="input_long" title="제목"/></td>
					</tr>
					<tr>
			            <th scope="row"><label for="sampleContent">내용</label></th>
			            <td>
			            	<textarea id="sampleContent" name="sampleContent" rows="" cols="" style="display: none;"><c:out value="${result.SAMPLECONTENT }" escapeXml="true" /></textarea>
			            	<c:if test="${editor eq 'Namo'}">		            
					            <!-- ▼ 에디터 -->  
					          	<script type="text/javascript">         
					            var CrossEditor = new NamoSE('namoEditor');
					            //에디터 업로드 용량
					           	CrossEditor.params.UploadFileSizeLimit = "movie:524288000, image:20971520";
					            CrossEditor.params.Width = "100%";
					            CrossEditor.EditorStart();
					            function OnInitCompleted(e){
					            	e.editorTarget.SetBodyValue(document.getElementById("sampleContent").value);
					            }
					          	</script>
					           	<!-- ▲ 에디터  -->
				           	</c:if>
				           	<c:if test="${editor eq 'Daum'}">
				            	<!-- ▼ 에디터 -->  
					          	<script type="text/javascript">
					          		gfnInitEditor("sampleContent", 'self');
					          	</script>
				           		<div id="editor_frame"></div>
				           	</c:if>
			        	</td>
			        </tr>		         
			        <!-- ▼ 파일 업/다운로드 에디터  -->
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
							<c:if test="${!empty(resultFile) && fn:length(resultFile) > 0 }">
								<c:forEach items="${resultFile }" var="fileList" varStatus="status">
									<input type="hidden" name="fileId" id="fileId${status.count }" value="${fileList.USERFILENAME}@@${fileList.SYSTEMFILENAME}@@${fileList.FILESIZE}@@${fileList.FILEPATH}@@${fileList.FILEEXTENSION}" />
									<div id="fileView${status.count }" style="margin-bottom: 10px;">
										<a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }">${fileList.USERFILENAME}&nbsp;(${fileList.FILESIZE} byte)<i class="xi-download"></i></a> 
										<a href="javascript:fn_delete_onefile('${status.count }');"><i class="xi-file-remove"></i><span class="hidden">삭제</span></a>
									</div>
								</c:forEach>
							</c:if> 
							<input type="file" id="file_upload" name="file_upload" class="input_mid" /> 
							<input type="button" value="파일추가" class="input_smallBlack" onClick="javascript:gfnFileTagAdd($(this));" />
						</td>
					</tr>
					<!-- ▲ 파일 업로드 에디터  -->
				</tbody>
			</table>
		</div>
	</fieldset>
	<div class="btn_area">	
		<button type="button" class="btn btn_type02" id="btnSave">저장</button>
		 <button type="button" class="btn btn_type01" id="btnCancel">취소</button>
	</div>
</spform:form>							
<script type="text/javascript">
$(function() {
	// 파일업로드종류 Init
	if("${fileUploadType}" == "Uploadify"){
		// uploadify Init funtion : form, action, uploadUrl
		uploadifyInit($("#insertForm"), '${ctxMgr }/sampleMgr/act', 'fileGubun=function&fileMenuId=sampleMgr');
	}
	
	$("#btnSave").click(function(){
		if($("#sampleTitle").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#sampleTitle").focus();
			return false;
		}
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#sampleContent").val(Editor.getContent());
		}else{
			$("#sampleContent").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End
		
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		
		$("#insertForm").attr('action', '${ctxMgr }/sampleMgr/act');
		$("#insertForm").submit();
	
	});

	//취소
    $("#btnCancel").click(function(){
    	if(!confirm("취소하시겠습니까?")) {
			return false;
		}
    	$("#insertForm").attr('action', '${ctxMgr }/sampleMgr');
		$("#insertForm").submit();
    });
    
});

//첨부파일 삭제
function fn_delete_onefile(num){
	$("#fileId"+num).remove();
	$("#fileView"+num).remove();
}

</script>
