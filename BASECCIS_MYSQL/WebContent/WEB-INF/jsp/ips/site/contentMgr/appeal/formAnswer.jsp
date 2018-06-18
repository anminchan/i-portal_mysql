<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- ▼ 등록페이지  -->
<article class="news_view">
	<h1  class="newsTitle"><c:out value="${rtnContent.KNAME }"/></h1>
	<dl class="info">
		<dt>작성자</dt>
		<dd><c:out value="${rtnContent.USERNAME }" /></dd>
		<dt>키워드</dt>
		<dd><c:if test="${!empty(rtnContent.KEYWORD1) }">${rtnContent.KEYWORD1}
				<c:if test="${!empty(rtnContent.KEYWORD2) }">,${rtnContent.KEYWORD2}
					<c:if test="${!empty(rtnContent.KEYWORD3) }">,${rtnContent.KEYWORD3}
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${empty(rtnContent.KEYWORD1) || fn:length(rtnContent.KEYWORD1) <= 0 }">
				등록된 키워드가 없습니다.
			</c:if>
 		</dd>
 		<dt>공개여부</dt>
 		<dd>${rtnContent.OPENYN == 'Y' ? '공개' : '비공개' }</dd>
 		<dt>유효기간</dt>
		<dd><fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/></dd>
		<c:if test="${rtnSetting.noticeYN == 'Y' }">         
			<dt>공지글지정</dt>
			<dd>${rtnContent.NOTICETITLEYN == 'Y' ? '공지' : '비공지' }</dd>             
		</c:if>             
		<c:if test="${rtnSetting.categoryYN == 'Y' }">             
			<dt>카테고리</dt>
			<dd>${rtnContent.CATEGORYNAME }</dd>             
		</c:if>
		<!-- ▼ 비밀글유무 -->
		<c:if test="${rtnSetting.secretYN == 'Y' }">
			<dt>비밀글유무</dt>
			<dd><input type="radio" id="secretTitleY" name="secretTitleYN" value="Y" ${rtnContent.SECRETTITLEYN == 'Y' ? 'checked="checked"' : ''} <c:if test="${empty rtnContent.SECRETTITLEYN}">checked="checked"</c:if> />
                    <label for="secretTitleY">적용</label>
                    <input type="radio" id="secretTitleN" name="secretTitleYN" value="N" ${rtnContent.SECRETTITLEYN == 'N' ? 'checked="checked"' : ''} />
                    <label for="secretTitleN">미적용</label>
            </dd>
		</c:if>
		 <!-- ▼ 추가 필드가 있을 시 -->
		<c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
			<dt><c:out value="${rtnSetting.addField1}" /></dt>
			<dd>${rtnContent.CONTENTS1 }</dd>
		</c:if>            
		<c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
			<dt><c:out value="${rtnSetting.addField2}" /></dt>
			<dd>${rtnContent.CONTENTS2 }</dd>
		</c:if>            
		<c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }">
			<dt><c:out value="${rtnSetting.addField3}" /></dt>
			<dd>${rtnContent.CONTENTS3 }</dd>
		</c:if>
		<!-- ▲ 추가 필드가 있을 시 -->
	</dl>	
	<div class="viewContent">
		<c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
         	<img id="viewPort" style="display: none;" />
         </c:if>
		 ${rtnContent.KHTML }
	</div>
	 <!-- ▼ 파일 다운로드  -->                                
	<c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
		<ul class="download_list">
	        <c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
	        	<c:set var="fileGubun" value="MB" />
	        	<c:set var="fileSize" value="${fileList.FILESIZE/1024/1024 }" />
	        	<c:if test="${fileSize < 1 }">
	        		<c:set var="fileSize" value="${fileList.FILESIZE/1024 }" />
	        		<c:set var="fileGubun" value="KB" />
	        	</c:if>
	        	<c:if test="${fileSize < 1 }">
	        		<c:set var="fileSize" value="${fileList.FILESIZE }" />
	        		<c:set var="fileGubun" value="B" />
	        	</c:if>
	        	<li><a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }" >        	
					<c:set var="fileExt" value="${fileList.FILEEXTENSION }" />
		        	<c:if test="${fileExt eq 'zip' or fileExt eq 'ZIP'}">
		        		<img src='${contextPath}/resources/images/common/icon/icon_zip.gif' alt="ZIP파일"/>
		        	</c:if>
		        	<c:if test="${fileExt eq 'hwp' or fileExt eq 'HWP'}">
		        		<img src='${contextPath}/resources/images/common/icon/icon_hwp.gif' alt="HWP파일"/>
		        	</c:if>
		        	<c:if test="${fileExt eq 'txt' or fileExt eq 'TXT'}">
		        		<img src='${contextPath}/resources/images/common/icon/icon_txt.gif' alt="TXT파일"/>
		        	</c:if>
		        	<c:if test="${fileExt eq 'pdf' or fileExt eq 'PDF'}">
		        		<img src='${contextPath}/resources/images/common/icon/icon_pdf.gif' alt="PDF파일"/>
		        	</c:if>
		        	<c:if test="${fileExt eq 'doc' or fileExt eq 'docx' or fileExt eq 'DOC' or fileExt eq 'DOCX'}">
		        		<img src='${contextPath}/resources/images/common/icon/icon_doc.gif' alt="DOC파일"/>
		        	</c:if>
		        	<c:if test="${fileExt eq 'xls' or fileExt eq 'xlsx' or fileExt eq 'XLS' or fileExt eq 'XLSX'}">
		        		<img src='${contextPath}/resources/images/common/icon/icon_xls.gif' alt="XLS파일"/>
		        	</c:if>
		        	<c:if test="${fileExt eq 'ppt' or fileExt eq 'pptx' or fileExt eq 'PPT' or fileExt eq 'pptX'}">
		        		<img src='${contextPath}/resources/images/common/icon/icon_ppt.gif' alt="PPT파일"/>
		        	</c:if>
		        	<c:if test="${fileExt eq 'jpg' or fileExt eq 'JPG' or fileExt eq 'gif' or fileExt eq 'GIF' or fileExt eq 'jpeg' or fileExt eq 'JPEG' or fileExt eq 'png' or fileExt eq 'PNG' or fileExt eq 'bmp' or fileExt eq 'BMP'}">
		        		<img src='${contextPath}/resources/images/common/icon/icon_img.gif' alt="IMG파일"/>
		        	</c:if>			        	
		        	${fileList.USERFILENAME } <c:if test="${fileSize != 0}">(<fmt:formatNumber value='${fileSize}' pattern='#,###.##'/> ${fileGubun})</c:if> <i class="xi-file-download"></i></a>
		        </li>
	        </c:forEach>
		</ul>
	</c:if>
    <!-- ▲ 파일 다운로드 -->     
</article>
<!-- ▲ 등록페이지  -->
    
    <spform:form id="editForm" name="editForm" action="${contextPath }/mgr/contentMgr/actAppealBoard" method="post" >
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
        
        <input type="hidden" id="inCondition" name="inCondition" value="${rtnContent.PROCESS == 'C' ? '수정' : '입력'}" />
        <input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnContent.inBeforeData}"/>
        
        <c:if test="${fn:split(obj.inDMLUserId, '@')[0] == 'guest'}">
        <input type="hidden" id="guestName" name="guestName" value="${obj.myName }" />
        <input type="hidden" id="key1" name="key1" value="${obj.key1 }" />
        <input type="hidden" id="key2" name="key2" value="${obj.key2 }" />
        <input type="hidden" id="key3" name="key3" value="${obj.key3 }" />
        <input type="hidden" id="dKey" name="dKey" value="${obj.dKey }" />
        </c:if>
        
		<input type="hidden" id="KName" name="KName" value="${rtnContent.KNAME }"  class="input_long"/>
		<input type="hidden" id="keyword1" name="keyword1" value="${rtnContent.KEYWORD1}" />
		<input type="hidden" id="keyword2" name="keyword2" value="${rtnContent.KEYWORD2}" />
		<input type="hidden" id="keyword3" name="keyword3" value="${rtnContent.KEYWORD3}" />
                    
        <c:if test="${rtnSetting.secretYN == 'Y' }">
        <input type="hidden" id="openYN" name="openYN" value="${rtnContent.OPENYN}" />
        </c:if>
        <input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>"/>
        <input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" />
                        
        <c:if test="${rtnSetting.noticeYN == 'Y' }">
        <input type="hidden" id="noticeYN" name="noticeYN" value="${rtnContent.NOTICETITLEYN }" />
        </c:if>
        
        <c:if test="${rtnSetting.categoryYN == 'Y' }">
        <input type="hidden" id="categoryId" name="categoryId" value="${rtnContent.CATEGORYID }">
        </c:if>
                
		<!-- ▼ 추가 필드가 있을 시 -->
		<c:if test="${!empty(rtnSetting.addField1) }">
	    <td colspan="3"><input type="hidden" id="contents1" name="contents1" maxlength="42" value="${rtnContent.CONTENTS1 }" /></td>
	    <td colspan="3"><input type="hidden" id="contents2" name="contents2" maxlength="42" value="${rtnContent.CONTENTS2 }" /></td>
	    <td colspan="3"><input type="hidden" id="contents3" name="contents3" maxlength="42" value="${rtnContent.CONTENTS3 }" /></td>
		</c:if>
		<!-- ▲ 추가 필드가 있을 시 -->
        <textarea id="KHtml" name="KHtml" rows="" cols="" style="display: none;"><c:out value="${rtnContent.KHTML }" escapeXml="true" /></textarea>
    
    <!-- ▼ 담당자 지정 -->
    <fieldset>
    	<legend>담당자 지정</legend>
    	<h2 class="depth2_title">담당자 지정</h2>
    	<div class="table">
        <table class="tstyle_view">
        	<caption>
            담당자 지정
            </caption>
            <colgroup>
            	<col class="col-sm-3" />
                <col />
			</colgroup>
			<tbody>
	            <tr>
		            <th>담당자</th>
		            <td>
			            <input type="hidden" id="appealUserId" name="appealUserId" value="${rtnContent.APPEALUSERID}" />
			            <span id="appealName">${rtnContent.APPEALUSERNAME}</span>
			            <span class="float_right">
			            	<input type="button" id="btnSearch" class="input_smallBlack" value="검색">
			            </span>
		            </td>
		    	</tr>
	    	</tbody>
		</table>
		</div>
    </fieldset>
    <!-- ▲ 담당자 지정 -->
    </spform:form>
    
    <c:if test="${rtnContent.PROCESS != '-' && (rtnContent.APPEALUSERID == obj.myId or ADMIN == 'T') }">
	<!-- ▼ 답글 -->
    <spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentMgr/actAppealBoard" method="post" >
    	<input type="hidden" id="data" name="data" />
        <input type="hidden" id="link" name="link" value="${link }" />
        <input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
        <input type="hidden" id="boardId" name="boardId" value="${!empty(rtnSetting.boardId) ? rtnSetting.boardId : '-' }" />
        <c:choose>
            <c:when test="${!empty(rtnContent.STARTTIME)}">
		        <!-- 글 수정 -->
		        <input type="hidden" id="linkId" name="linkId" value="${empty rtnComment ? obj.linkId : rtnComment.LINKID }" />
		        <input type="hidden" id="parentId" name="parentId" value="${obj.linkId }" />
            </c:when>
            <c:otherwise>
		        <!-- 글 입력/답글 -->
		        <input type="hidden" id="linkId" name="linkId" value="${!empty(obj.parentLinkId) && obj.parentLinkId > 0 ? obj.parentLinkId : '-1' }" />
		        <input type="hidden" id="parentId" name="parentId" value="${obj.parentLinkId}" />
            </c:otherwise>
        </c:choose>
        <input type="hidden" id="inCondition" name="inCondition" value="${rtnContent.PROCESS == 'R' ? '입력' : '수정'}" />
        <input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnContent.inBeforeData}"/>
        
        <c:if test="${fn:split(obj.inDMLUserId, '@')[0] == 'guest'}">
        <input type="hidden" id="guestName" name="guestName" value="${obj.myName }" />
        <input type="hidden" id="key1" name="key1" value="${obj.key1 }" />
        <input type="hidden" id="key2" name="key2" value="${obj.key2 }" />
        <input type="hidden" id="key3" name="key3" value="${obj.key3 }" />
        <input type="hidden" id="dKey" name="dKey" value="${obj.dKey }" />
        </c:if>
        
        <input type="hidden" id="keyword1" name="keyword1" value="${rtnContent.KEYWORD1}" />
        <input type="hidden" id="keyword2" name="keyword2" value="${rtnContent.KEYWORD2}" />
        <input type="hidden" id="keyword3" name="keyword3" value="${rtnContent.KEYWORD3}" />
        
        <input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" />
        <input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" />
    	
    	<!-- 나모첨부파일 사용경우 START -->
		<!-- 파일 정보를 저장할 폼 데이터 -->
		<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
		<!-- 나모첨부파일 사용경우 END -->
		
    <fieldset>
        <legend>답변</legend>
        <h2 class="depth2_title">답변</h2>
        <div class="table">
        <table class="tstyle_view">
            <caption>
                게시물상세 안내
            </caption>
            <colgroup>
                <col class="col-sm-2" />
              	<col class="col-sm-4" />
                <col class="col-sm-2" />
             	<col class="col-sm-4" />
            </colgroup>
            <tbody>
	            <tr>
	                <th scope="row"><label for="subject">답변자</label></th>
	                <td><c:out value="${fn:length(rtnComment) > 0 ? rtnComment.USERNAME : obj.myName  }" /></td>
	                <th scope="row"><label for="name">답변일</label></th>
	                <td>
	                    <c:choose>
	                        <c:when test="${fn:length(rtnComment) > 0}">
	                    		<c:out value="${fn:substring(rtnComment.DMLTIME, 0, 4) }-${fn:substring(rtnComment.DMLTIME, 4, 6) }-${fn:substring(rtnComment.DMLTIME, 6, 8) }" />
	                        </c:when>
	                        <c:otherwise>
	                    		<fmt:formatDate value="${DATE }" pattern="yyyy-MM-dd" />
	                        </c:otherwise>
	                    </c:choose>
	                </td>
	            </tr>
	            <tr>
	                <th scope="row"><label for="viewtxt">내용</label></th>
	                <td colspan="3" style="min-height: 300px; vertical-align: top;">
	                    <textarea id="comKHtml" name="KHtml" rows="" cols="" style="display: none;"><c:out value="${fn:length(rtnComment) > 0 ? rtnComment.KHTML : '' }" escapeXml="true" /></textarea>
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
				            	e.editorTarget.SetBodyValue($("#comKHtml").val());
				            }
				          	</script>
				           	<!-- ▲ 에디터  -->
			           	</c:if>
			           	<c:if test="${editor eq 'Daum'}">
			            	<!-- ▼ 에디터 -->  
				          	<script type="text/javascript">
				          		gfnInitEditor("comKHtml", 'self');
				          	</script>
			           		<div id="editor_frame"></div>
			           	</c:if>
	                </td>
	            </tr>
            </tbody>
        </table>
        </div>
    </fieldset>
    <!-- ▲ 답글 -->
    </spform:form>
    </c:if>
    
   <!-- ▼ 버튼 -->
    <div class="btn_area">  
       	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
        <c:if test="${fn:length(rtnComment) > 0}">
         <button type="button" class="btn btn_type01" id="btnDelete">답변삭제</button>
        </c:if>
        <button type="button" class="btn btn_type01" id="btnCancel">취소</button>
    </div>
    <!-- ▲ 버튼 -->

<script type="text/javascript">

$(function() {
	// 저장
	$('#btnSave').click(function(){
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
        
        if($('#appealUserId').val() == null || $('#appealUserId').val() == ""){
        	alert("담당자를 지정하세요");
        	return true;
        }
        	
        if('${rtnContent.APPEALUSERID}' != $('#appealUserId').val()){
            if(confirm("담당자를 ${rtnContent.PROCESS == '-' ? '등록' : '수정'}하시겠습니까?")){
                $('#inCondition').val('담당자지정');
                $('#editForm').submit();
                return true;
            }else{
                return true;
            }
        }
        
        if(!confirm("답변을 등록하시겠습니까?")) {
			return false;
		}
        
     	// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#comKHtml").val(Editor.getContent());
		}else{
			$("#comKHtml").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End
		
        $('#insertForm').submit();
		
	});

	// 삭제
	$('#btnDelete').click(function(){
		 if(!confirm("답변을 삭제하시겠습니까?")){
             return;
         }
		
		$('#inCondition').val('답변삭제');
		$('#insertForm').attr('action', '${ctxMgr}/contentMgr/actAppealBoard');
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
	
});

//담당자 지정함수
function setMemberList(data){
	//kind|kind_Name|userId|KName|joinDate
	var inData = data;
	var arrayData = new Array();
	arrayData = inData.split("|");
	
	$('#appealUserId').val(arrayData[2]);
	$('#appealName').text(arrayData[3]);
}

</script>
