<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- ▼ 등록페이지  -->

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentMgr/actThumbnailBoard" method="post" >
	<input type="hidden" id="link" name="link" value="${link }" />
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnSetting.boardId) ? rtnSetting.boardId : '-' }" />
	
	<c:choose>
		<c:when test="${!empty(rtnContent.STARTTIME)}"> 			
			<!-- 글 수정 -->
			<input type="hidden" id="linkId" name="linkId" value="${obj.linkId }" />
		</c:when>
		<c:otherwise> 			
			<!-- 글 입력/답글 -->
			<input type="hidden" id="linkId" name="linkId" value="${!empty(obj.parentLinkId) && obj.parentLinkId > 0 ? obj.parentLinkId : '-1' }" />
		</c:otherwise>
	</c:choose>
	<input type="hidden" id="inCondition" name="inCondition" value="${!empty(rtnContent.STARTTIME) ? '수정' : '입력' }" />
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnContent.inBeforeData}"/>
	<c:if test="${fn:split(obj.inDMLUserId, '@')[0] == 'guest'}">
		<input type="hidden" id="guestName" name="guestName" value="${obj.myName }" />
		<input type="hidden" id="key1" name="key1" value="${obj.key1 }" />
		<input type="hidden" id="key2" name="key2" value="${obj.key2 }" />
		<input type="hidden" id="key3" name="key3" value="${obj.key3 }" />
		<input type="hidden" id="dKey" name="dKey" value="${obj.dKey }" />
	</c:if>
	<fieldset>
		<legend>상세등록</legend>
		<div class="table">
			<table class="tstyle_view">
				<caption>
				게시물상세 안내
				</caption>
				<colgroup>
	                <col class="col-sm-2"/>
					<col class="col-sm-10"/>
				</colgroup>
				<tbody>
				<tr>
					<th scope="row"><label for="subject">제목</label></th>
					<td>
						<c:choose>
							<c:when test="${!empty(rtnContent.STARTTIME)}"> 
								<!-- 글 수정 -->
								<input type="text" id="KName" name="KName" value="${rtnContent.KNAME }"  class="input_long"/>
							</c:when>
							<c:otherwise> 
								<!-- 글 입력/답글 -->
								<input type="text" id="KName" name="KName" value="${title}"  class="input_long"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="name">작성자</label></th>
					<td><c:out value="${!empty(rtnContent.USERNAME) ? rtnContent.USERNAME : obj.myName  }" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="temp_ocode">키워드</label></th>
					<td><input type="text" id="keyword1" name="keyword1" class="keyword" value="${rtnContent.KEYWORD1}" />
						<input type="text" id="keyword2" name="keyword2" class="keyword" value="${rtnContent.KEYWORD2}" />
						<input type="text" id="keyword3" name="keyword3" class="keyword" value="${rtnContent.KEYWORD3}" />
						<input type="text" id="keyword4" name="keyword4" class="keyword" value="${rtnContent.KEYWORD4}" />
						<input type="text" id="keyword5" name="keyword5" class="keyword" value="${rtnContent.KEYWORD5}" />
						<input type="text" id="keyword6" name="keyword6" class="keyword" value="${rtnContent.KEYWORD6}" />
						<input type="text" id="keyword7" name="keyword7" class="keyword" value="${rtnContent.KEYWORD7}" />
						<input type="text" id="keyword8" name="keyword8" class="keyword" value="${rtnContent.KEYWORD8}" />
						<input type="text" id="keyword9" name="keyword9" class="keyword" value="${rtnContent.KEYWORD9}" />
						<input type="text" id="keyword10" name="keyword10" class="keyword" value="${rtnContent.KEYWORD10}" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="name">공개여부</label></th>
					<td><!-- 입력시 공개가 기본 선택 -->					
						<c:if test="${empty(rtnContent.STARTTIME)}">
							<input type="radio" id="openY" name="openYN" value="Y" checked="checked" />
							<label for="openY">공개</label>
							<input type="radio" id="openN" name="openYN" value="N" />
							<label for="openN">비공개</label>
						</c:if>					
						<!-- 수정시 기본 선택 -->					
						<c:if test="${!empty(rtnContent.STARTTIME)}">
							<input type="radio" id="openY" name="openYN" value="Y" ${rtnContent.OPENYN == 'Y' ? 'checked="checked"' : ''} />
							<label for="openY">공개</label>
							<input type="radio" id="openN" name="openYN" value="N" ${rtnContent.OPENYN == 'N' ? 'checked="checked"' : ''} />
							<label for="openN">비공개</label>
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="temp_ocode">유효기간</label></th>
					<td><input type="text" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" readonly />	~
						<input type="text" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" readonly />
					</td>
				</tr>
				<c:if test="${rtnSetting.noticeYN == 'Y' }">
					<tr>
						<th scope="row"><label for="name">공지글지정</label></th>
						<td><input type="hidden" id="noticeYN" name="noticeYN" /> <input type="checkBox" id="checkNotice" name="checkNotice" ${rtnContent.NOTICETITLEYN == 'Y' ? 'checked="checked"' : ''} /></td>
					</tr>
				</c:if>
				<c:if test="${rtnSetting.categoryYN == 'Y' }">
					<tr>
						<th scope="row"><label for="categoryId">카테고리</label></th>
						<td><select id="categoryId" name="categoryId">
							</select>
						</td>
					</tr>
				</c:if>				
				<!-- ▼ 비밀글유무 -->
				<c:if test="${rtnSetting.secretYN == 'Y' }">
					<tr>
						<th scope="row"><label for="secretTitleYN">비밀글</label></th>
						<td><input type="radio" id="secretTitleY" name="secretTitleYN" value="Y" <c:if test="${empty rtnContent.SECRETTITLEYN}">checked</c:if> ${rtnContent.SECRETTITLEYN == 'Y' ? 'checked="checked"' : ''} />
							<label for="secretTitleY">적용</label>
							<input type="radio" id="secretTitleN" name="secretTitleYN" value="N" ${rtnContent.SECRETTITLEYN == 'N' ? 'checked="checked"' : ''} />
							<label for="secretTitleN">미적용</label></td>
					</tr>
				</c:if>			
				<!-- ▼ 추가 필드가 있을 시 -->
				<c:if test="${!empty(rtnSetting.addField1) }">
					<tr>
						<th scope="row"><c:out value="${rtnSetting.addField1}" /></th>
						<td><input type="text" id="contents1" name="contents1" maxlength="42" class="input_long" value="${rtnContent.CONTENTS1 }" /></td>
					</tr>
				</c:if>
				<c:if test="${!empty(rtnSetting.addField2) }">
					<tr>
						<th scope="row"><c:out value="${rtnSetting.addField2}" /></th>
						<td><input type="text" id="contents2" name="contents2" maxlength="42" class="input_long" value="${rtnContent.CONTENTS2 }" /></td>
					</tr>
				</c:if>
				<c:if test="${!empty(rtnSetting.addField3) }">
					<tr>
						<th scope="row"><c:out value="${rtnSetting.addField3}" /></th>
						<td><input type="text" id="contents3" name="contents3" maxlength="42" class="input_long" value="${rtnContent.CONTENTS3 }" /></td>
					</tr>
				</c:if>
				<!-- ▲ 추가 필드가 있을 시 -->				
				<tr>
					<th scope="row"><label for="viewtxt">내용</label></th>
					<td>
						<textarea id="KHtml" name="KHtml" rows="10" cols="10" style="display: none;"><c:out value="${rtnContent.KHTML }" escapeXml="true" /></textarea>
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
				<!-- ▼ 파일 다운로드 -->
				<c:if test="${rtnSetting.fileMaxCount > 0 }"> 
                <tr>
					<th>첨부파일</th>
					<td colspan="3">
						<c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
		                	<c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
		                		<input type="hidden" name="fileId" id="fileId${status.count }" value="${fileList.USERFILENAME}@@${fileList.SYSTEMFILENAME}@@${fileList.FILESIZE}@@${fileList.FILEPATH}@@${fileList.FILEEXTENSION}" />
		                		<div id="fileView${status.count }" style="margin-bottom: 10px;">
	                              	<a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }">${fileList.USERFILENAME}&nbsp;(${fileList.FILESIZE} byte)</a>
								  	<a href="javascript:fn_delete_onefile('${status.count }');"><i class="xi-file-remove"></i><span class="hidden">삭제</span></a>
							  	</div>
							</c:forEach>
		                </c:if>
						<input type="file" id="file_upload" name="file_upload" class="input_mid"/>
						<input type="button" value="파일추가" class="input_smallBlack" onClick="javascript:gfnFileTagAdd($(this));" />
					</td>
				</tr>
				</c:if>
				<!-- ▲ 파일 업로드 에디터  -->
				</tbody>
			</table>
		</div>
	</fieldset>
</spform:form>
<!-- ▲ 등록페이지  --> 

<!-- ▼ 버튼 -->
<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
	<button type="button" class="btn btn_type01" id="btnDelete">삭제</button>
	<button type="button" class="btn btn_type01" id="btnCancel">취소</button>
</div>
<!-- ▲ 버튼 --> 

<script type="text/javascript">

$(function() {
	
	gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리선택', '${rtnContent.CATEGORYID != null ? rtnContent.CATEGORYID : ""}');

	$('.keyword').focus(function(i){
		var indexNode = $(this).index()+1;
		var strLength;
		
		if(indexNode > 1){
			for(var i=1; i<indexNode; i++){
				strLength = $.trim($('#keyword'+i).val());
				if(strLength == null || strLength.length <= 0){
					alert("키워드 "+i+"번째 값부터 입력하세요.");
					$('#keyword'+i).focus();
					return true;
				}
			}
		}
	});
	
	// 저장
	$('#btnSave').click(function(){
		if($.trim($("#keyword1").val()) == null || $.trim($("#keyword1").val()) == ""){
			alert("키워드를 입력하세요");
			return true;
		}
		
		if($('#categoryId').length){
			if($('#categoryId').val() == ""){
				alert("카테고리를 선택하세요");
				return true;
			}
		}
		
		if($('#checkNotice').length){
			if($('#checkNotice').checked){
				$('#noticeYN').val('Y');
			}else{
				$('#noticeYN').val('N');
			}
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
		
		$("#insertForm").attr('action', '${ctxMgr }/contentMgr/actAppealBoard');
		$("#insertForm").submit();
		
	});

	// 삭제
	$('#btnDelete').click(function(){
		$('#inCondition').val('삭제');
		
		$('#insertForm').submit();
	});
	
	//취소
	$('#btnCancel').click(function(){
		if('${obj.linkId}' != null && '${obj.linkId}' != '0'){
		    document.location.href="${contextPath}/mgr/contentMgr/view?${link}&linkId=${obj.linkId}";
		}else {
		    document.location.href="${contextPath}/mgr/contentMgr?${link}";
		}
	});
	
	//검색
	$('#btnSearch').click(function(){
        gfnMemberPopupList('K', 'all', 'S');
	});
	
	//입력시 달력 기본 셋팅
	$('#startTime').val('<fmt:formatDate value="${DATE }" pattern="yyyy-MM-dd"/>');
	$('#endTime').val(<fmt:formatDate value="${DATE }" pattern="yyyy"/>+10+'<fmt:formatDate value="${DATE }" pattern="-MM-dd"/>');
	
	//달력 세팅
    $( "#startTime" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
    
    $( "#endTime" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
	
});

// 첨부파일 삭제
function fn_delete_onefile(num){
	$("#fileId"+num).remove();
	$("#fileView"+num).remove();
}

</script> 