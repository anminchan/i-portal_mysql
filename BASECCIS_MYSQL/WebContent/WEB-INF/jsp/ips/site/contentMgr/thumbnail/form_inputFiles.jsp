<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- ▼ 등록페이지  -->
<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentMgr/actThumbnailBoard" method="post" enctype="multipart/form-data">
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
    <input type="hidden" id="altInfoArr" name="altInfoArr" value="" />
    <input type="hidden" id="altInfoFirst" name="altInfoFirst" value="" />
    
    <input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>"/>
    <input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" />

    <fieldset>
        <legend>상세등록</legend>
        <div class="table">
	        <table class="tstyle_view" >
	            <caption>
	                게시물상세 안내
	            </caption>
	            <colgroup>
	                <col class="col-sm-3" />
	                <col />
	            </colgroup>
	            <tr>
	                <th scope="row"><span class="point01">*</span> <label for="KName">제목</label></th>
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
	                <th scope="row">작성자</th>
	                <td><c:out value="${!empty(rtnContent.USERNAME) ? rtnContent.USERNAME : obj.myName  }" /></td> 
	            </tr>
	            <tr>           
	                <th scope="row"><label for="temp_ocode">키워드</label></th>
	                <td>
	                    <input type="text" id="keyword1" name="keyword1" value="${rtnContent.KEYWORD1}" maxlength="30"/>
	                    <input type="text" id="keyword2" name="keyword2" value="${rtnContent.KEYWORD2}" maxlength="30"/>
	                    <input type="text" id="keyword3" name="keyword3" value="${rtnContent.KEYWORD3}" maxlength="30"/>
	                    <input type="text" id="keyword4" name="keyword4" value="${rtnContent.KEYWORD4}" maxlength="30"/>
	                    <input type="text" id="keyword5" name="keyword5" value="${rtnContent.KEYWORD5}" maxlength="30"/>
	                    <input type="text" id="keyword6" name="keyword6" value="${rtnContent.KEYWORD6}" maxlength="30"/>
	                    <input type="text" id="keyword7" name="keyword7" value="${rtnContent.KEYWORD7}" maxlength="30"/>
	                    <input type="text" id="keyword8" name="keyword8" value="${rtnContent.KEYWORD8}" maxlength="30"/>
	                    <input type="text" id="keyword9" name="keyword9" value="${rtnContent.KEYWORD9}" maxlength="30"/>
	                    <input type="text" id="keyword10" name="keyword10" value="${rtnContent.KEYWORD10}" maxlength="30"/>
	                    
	                    <input type="button" value="키워드검색" class="btn btn_basic" onClick="javascript:gfnKeywordSearch('${obj.menuId}');" />
	                </td>
	            </tr>
	            <tr>
	                <th scope="row">공개여부</th>
	                <td>
	                    <!-- 입력시 공개가 기본 선택 -->
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
				<c:if test="${rtnSetting.noticeYN == 'Y' }">
					<tr>
					    <th scope="row"><label for="name">공지글지정</label></th>
					    <td>
					        <input type="hidden" id="noticeYN" name="noticeYN" />
					        <input type="checkBox" id="checkNotice" name="checkNotice" ${rtnContent.NOTICETITLEYN == 'Y' ? 'checked="checked"' : ''} />
					    </td>
					</tr>
				</c:if>    
				<c:if test="${rtnSetting.categoryYN == 'Y' }">
					<tr>
					    <th scope="row"><span class="point01">*</span> <label for="categoryId">카테고리</label></th>
					    <td>
					        <select id="categoryId" name="categoryId">
					        </select>
					    </td>
					</tr>
				</c:if>    
	            <!-- ▼ 비밀글유무 -->
	            <c:if test="${rtnSetting.secretYN == 'Y' }">
		            <tr>
		                <th scope="row"><label for="secretTitleYN">비밀글</label></th>
		                <td>
		                	<input type="radio" id="secretTitleY" name="secretTitleYN" value="Y" <c:if test="${empty rtnContent.SECRETTITLEYN or rtnContent.SECRETTITLEYN eq 'Y'}">checked="checked"</c:if> />
		                    <label for="secretTitleY">적용</label>
		                    <input type="radio" id="secretTitleN" name="secretTitleYN" value="N" ${rtnContent.SECRETTITLEYN == 'N' ? 'checked="checked"' : ''} />
		                    <label for="secretTitleN">미적용</label>
		                </td>
		            </tr>
	            </c:if>            
	            <!-- ▼ 국가필드유무 -->
	            <c:if test="${rtnSetting.countryYN == 'Y' }">
		            <tr>
		                <th scope="row"><span class="point01">*</span> <label for="country">국가정보</label></th>
		                <td>
		                	<select id="continent" name="continent"><option>선택</option></select>
		                    <select id="country" name="country"><option>선택</option></select>
		                </td>
		            </tr>
	            </c:if>
	            <!-- ▼ 추가 필드가 있을 시 -->
	            <c:if test="${!empty(rtnSetting.addField1) }">
		            <tr>
		                <th scope="row"><label><c:out value="${rtnSetting.addField1}" /></label></th>
		                <td><input type="text" id="contents1" name="contents1" maxlength="42" class="input_long" value="${rtnContent.CONTENTS1 }" /></td>
		            </tr>
	            </c:if>
	            <c:if test="${!empty(rtnSetting.addField2) }">
		            <tr>
		                <th scope="row"><label><c:out value="${rtnSetting.addField2}" /></label></th>
		                <td><input type="text" id="contents2" name="contents2" maxlength="42" class="input_long" value="${rtnContent.CONTENTS2 }" /></td>
		            </tr>
	            </c:if>
	            <c:if test="${!empty(rtnSetting.addField3) }">
		            <tr>
		                <th scope="row"><label><c:out value="${rtnSetting.addField3}" /></label></th>
		                <td><input type="text" id="contents3" name="contents3" maxlength="42" class="input_long" value="${rtnContent.CONTENTS3 }" /></td>
		            </tr>
	            </c:if>
	            <!-- ▲ 추가 필드가 있을 시 -->            
	            <tr>
	                <th scope="row">내용</th>
	                <td>                
		                <textarea id="KHtml" name="KHtml" rows="100" cols="10" class="input_long" style="display: none;"><c:out value="${rtnContent.KHTML }" escapeXml="true" /></textarea>
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
	            <!-- ▼ 파일 업/다운로드 에디터  -->              
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
						<input type="file" id="file_upload" name="file_upload" class="input_mid" accept="image/*" />
						<input type="button" value="파일추가" class="input_smallBlack" onClick="javascript:gfnFileTagAdd($(this));" />
					</td>
				</tr>
				</c:if>        
				<!-- ▲ 파일 업로드 에디터  -->                    
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
	gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리선택', '${rtnContent.CATEGORYID != null ? rtnContent.CATEGORYID : ""}');

	gfnCodeComboList($("#continent"), "country", "", "대륙 선택", "${rtnContent.CONTINENT}", ""); // 대륙 코드조회
	$('#continent').on("change", function() { // 대륙 이벤트
		if($("#continent").val() != ""){
			gfnCodeComboList($("#country"), $("#continent").val(), "", "국가 선택", "", ""); // 국가 코드조회
		}else{
			$("#country").find('option').remove();
			$("#country").append("<option value=''>국가 선택</option>");
		}
	});
	
	<c:if test="${!empty rtnContent.COUNTRY}">
		gfnCodeComboList($("#country"), "${rtnContent.CONTINENT }", "", "국가 선택", "${!empty rtnContent.COUNTRY ? rtnContent.COUNTRY : ''}", ""); // 국가 코드조회
	</c:if>
		
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
	
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	// 저장
	$('#btnSave').click(function(){
		if($('#KName').val() == ""){
			alert("제목을 입력하세요");
			$('#KName').focus();
			return true;
		}
		if($('#categoryId').length){
			if($('#categoryId').val() == ""){
				alert("카테고리를 선택하세요");
				return true;
			}
		}
		
		<c:if test="${rtnSetting.countryYN == 'Y' }">
			if($('#continent').length){
				if($('#continent').val() == ""){
					alert("대륙을 선택하세요");
					$('#continent').focus();
					return true;
				}
			}
			
			if($('#country').length){
				if($('#country').val() == ""){
					alert("국가를 선택하세요");
					$('#country').focus();
					return true;
				}
			}
		</c:if>
		
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
		
		// 유해어 검출 스크립트
 		if(gfnTabooWordCheck('KName§§KHtml')[1] > 0){
 			alert(gfnTabooWordCheck('KName§§KHtml')[0]);
 			return false;
 		}
		
 		if($("#file_upload").val() == "" && ($("#fileId").val() == undefined || $("#fileId").val() == "")){
			alert("이미지 첨부파일을 하나 이상 등록하세요.");
			$("#file_upload").focus();
			return true;
 		}
 		
 		if($("#file_upload").val() != ""){
			var thumbext = document.getElementById('file_upload').value; //파일을 추가한 input 박스의 값
			thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
	
			if(thumbext != "jpg" && thumbext != "png" &&  thumbext != "gif" &&  thumbext != "bmp"){ //확장자를 확인합니다.
				alert('썸네일은 이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
				$("#file_upload").focus();
				return;
			}
 		}
		
 		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		
 		$("#insertForm").attr('action', '${ctxMgr }/contentMgr/actThumbnailBoard');
		$("#insertForm").submit();
		
	});

	// 삭제
	$("#btnDelete").click(function(){
		$("#inCondition").val("삭제");
		
		$('#insertForm').submit();
	});
	
	//취소
	$("#btnCancel").click(function(){
		if('${obj.linkId}' != null && '${obj.linkId}' != '0'){
		    document.location.href="${contextPath}/mgr/contentMgr/view?${link}&linkId=${obj.linkId}";
		}else {
		    document.location.href="${contextPath}/mgr/contentMgr?${link}";
		}
	});
	
	//입력시 달력 기본 셋팅
	$('#startTime').val('<fmt:formatDate value="${DATE }" pattern="yyyy-MM-dd"/>');
	$('#endTime').val(<fmt:formatDate value="${DATE }" pattern="yyyy"/>+10+'<fmt:formatDate value="${DATE }" pattern="-MM-dd"/>');
	
	//달력 세팅
   /*  $( "#startTime" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    });
    
    $( "#endTime" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    }); */
	
});

// 첨부파일 삭제
function fn_delete_onefile(num){
	$("#fileId"+num).remove();
	$("#fileView"+num).remove();
}
	
</script>
