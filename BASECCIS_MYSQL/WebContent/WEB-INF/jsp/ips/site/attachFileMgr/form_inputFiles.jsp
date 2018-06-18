<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- ▼ 등록페이지  -->
 <spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/attachFileMgr" method="post" enctype="multipart/form-data">
	<input type="hidden" id="link" name="link" value="${link }" />
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="attachFileId" name="attachFileId" value="${result.ATTACHFILEID > '0' ? result.ATTACHFILEID : '0'}" />
	
    <fieldset>
	    <legend>상세등록</legend>
	    <div class="table">
			<table class="tstyle_view">
				<caption>
                	첨부파일관리 - 제목, 작성자, 작성일, 내용, 첨부파일
               </caption>
               <colgroup>
	                <col class="col-sm-2"/>
					<col class="col-sm-10"/>
				</colgroup>
               <tbody>
	               <tr>
	                   <th scope="row"><label for="KName">제목</label></th>
	                   <td>
	                   		<input type="text" id="KName" name="KName" value="${result.KNAME }"  class="input_long"/>
	                   </td>
	               </tr>
	               <tr>
	                   <th scope="row">작성자</th>
	                   <td><c:out value="${!empty(result.USERNAME) ? result.USERNAME : obj.myName  }" /></td>
	               </tr>
	               <tr>
	                   <th scope="row"><label for="viewtxt">내용</label></th>
	                   <td>
	                	   <textarea id="KHtml" name="KHtml" rows="" cols="" style="display: none;"><c:out value="${result.KHTML }" escapeXml="true" /></textarea>
		                    <c:if test="${editor eq 'Namo'}">		            
					            <!-- ▼ 에디터 -->  
					          	<script type="text/javascript">         
					            var CrossEditor = new NamoSE('namoEditor');
					            //에디터 업로드 용량
					           	CrossEditor.params.UploadFileSizeLimit = "movie:524288000, image:20971520";
					            CrossEditor.params.Width = "100%";
					            CrossEditor.EditorStart();
					            function OnInitCompleted(e){
					            	e.editorTarget.SetBodyValue($("#KHtml").val());
					            }
					          	</script>
					           	<!-- ▲ 에디터  -->
				           	</c:if>
				           	<c:if test="${editor eq 'Daum'}">
				            	<!-- ▼ 에디터 -->  
					          	<script type="text/javascript">
					          		gfnInitEditor("KHtml", 'self');
					          	</script>
				           		<div id="editor_frame"></div>
				           	</c:if>                
	                   </td>
	               </tr>
				   <tr>
						<th>첨부파일</th>
						<td colspan="3">
							<c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
								<c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
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
				</tbody>
           </table>
    	</div>
	</fieldset>
</spform:form>
<!-- ▲ 등록페이지  -->
   
 <!-- ▼ 버튼 -->
<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
	<button type="button" class="btn btn_type01" id="btnCancel">취소</button>
</div>
<!-- ▲ 버튼 -->

<script type="text/javascript">
$(function() {
	// 저장
	$('#btnSave').click(function(){
		
		if($("#KName").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#KHtml").val(Editor.getContent());
		}else{
			$("#KHtml").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End

		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		
		$("#insertForm").attr('action', '${ctxMgr }/attachFileMgr/act');
		$("#insertForm").submit();

	});

	//취소
    $("#btnCancel").click(function(){
        document.location.href="${contextPath}/mgr/attachFileMgr?${link}";
    });
	
});

//첨부파일 삭제
function fn_delete_onefile(num){
	$("#fileId"+num).remove();
	$("#fileView"+num).remove();
}

</script>
