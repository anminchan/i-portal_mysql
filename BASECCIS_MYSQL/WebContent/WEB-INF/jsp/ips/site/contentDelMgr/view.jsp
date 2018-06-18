<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- ▼ 등록페이지  -->
<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentDelMgr/view" method="post" >
	<input type="hidden" id="link" name="link" value="${link }" />	
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnSetting.boardId) ? rtnSetting.boardId : '-' }" />	
	<!-- 글 수정 -->
	<input type="hidden" id="linkId" name="linkId" value="${obj.linkId }§§${rtnContent.MENUID }" />
	<input type="hidden" id="inCondition" name="inCondition" value="${!empty(rtnContent.STARTTIME) ? '수정' : '입력' }" />
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnContent.inBeforeData}"/>
	<input type="hidden" name="startTime" value="11111111" />
	<input type="hidden" name="endTime" value="11111111" />
	<input type="hidden" name="fileYN" id="fileYN" value="Y"/>	
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
	            <tr>
	                <th scope="row">제목</th>
	                <td><c:out value="${rtnContent.KNAME }" /></td>
	            </tr>
	            <tr>
	                <th scope="row">작성자</th>
	                <td><c:out value="${rtnContent.USERNAME }" /> </td>
	            </tr>
	            <tr>                
	                <th scope="row">키워드</th>
	                <td>
	                    <c:if test="${!empty(rtnContent.KEYWORD1) }">${rtnContent.KEYWORD1}
	                     <c:if test="${!empty(rtnContent.KEYWORD2) }">,${rtnContent.KEYWORD2}
		                        <c:if test="${!empty(rtnContent.KEYWORD3) }">,${rtnContent.KEYWORD3}
		                        </c:if>
	                     </c:if>
	                    </c:if>
	                    <c:if test="${empty(rtnContent.KEYWORD1) || fn:length(rtnContent.KEYWORD1) <= 0 }">
	                        	등록된 키워드가 없습니다.
	                    </c:if>
	                </td>
	            </tr>
	            <tr>
	                <th scope="row">공개여부</th>
	                <td>${rtnContent.OPENYN == 'Y' ? '공개' : '비공개' }</td>
	            </tr>
	            <tr>
	                <th scope="row">유효기간</th>
	                <td><fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/></td>
	            </tr>
	            <tr>
	            <c:if test="${rtnSetting.noticeYN == 'Y' }">
	                <th scope="row">공지글지정</th>
	                <td>${rtnContent.NOTICETITLEYN == 'Y' ? '공지' : '비공지' }</td>
	            </c:if>
	            <c:if test="${rtnSetting.categoryYN == 'Y' }">
	                <th scope="row">카테고리</th>
	                <td>${rtnContent.CATEGORYNAME }</td>
	            </c:if>
	            </tr>            
	            <!-- ▼ 비밀글유무 -->
	            <c:if test="${rtnSetting.secretYN == 'Y' }">
		            <tr>
		                <th scope="row">비밀글유무</th>
		                <td>${rtnContent.SECRETTITLEYN == 'Y' ? '적용' : '미적용' }</td>
		            </tr>
	            </c:if>            
	            <!-- ▼ 추가 필드가 있을 시 -->
	            <c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
		            <tr>
		                <th scope="row"><c:out value="${rtnSetting.addField1}" /></th>
		                <td>${rtnContent.CONTENTS1 }</td>
		            </tr>
	            </c:if>            
	            <c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
		            <tr>
		                <th scope="row"><c:out value="${rtnSetting.addField2}" /></th>
		                <td>${rtnContent.CONTENTS2 }</td>
		            </tr>
	            </c:if>            
	            <c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }">
		            <tr>
		                <th scope="row"><c:out value="${rtnSetting.addField3}" /></th>
		                <td>${rtnContent.CONTENTS3 }</td>
		            </tr>
	            </c:if>
	            <!-- ▲ 추가 필드가 있을 시 -->            
	            <tr>
	                <th scope="row">대표이미지</th>
	                <td>
	                	<a href="${contextPath}/fileDownload?fileGubun=board&menuId=${param.menuId}&userFileName=${rtnContent.IMAGEFILENAME }&systemFileName=${rtnContent.IMAGESFILENAME }" alt="${rtnContent.ALTINFO }"><c:out value="${rtnContent.IMAGEFILENAME }" /></a>
	                </td>
	            </tr>
	            <tr>
	            	<th scope="row">대표이미지설명</th>
	            	<td>${rtnContent.ALTINFO }</td>
	            </tr>            
	            <tr>
	                <th scope="row">내용</th>
	                <td>
		                <c:choose>
		                	<c:when test="${rtnSetting.boardKind eq 'VOD' }">
				                <c:choose> 
				               		<c:when test="${!empty(rtnContent.LINKURL) and rtnContent.LINKURL ne '-'}">
				               			<embed id="vodPort"  width="80%" height="500px;" src="${rtnContent.LINKURL}"/>
				               		</c:when>
				               		<c:otherwise>
										<div class="media"></div>
										<script type="text/javascript">
										$('.media').media({ 
										    width:     645, 
										    height:    500, 
										    autoplay:  false, 	    
										    src:       '${currentUrl}${contextPath}/fileDownload?titleId=${rtnFileList[0].TITLEID }&fileId=${rtnFileList[0].FILEID }', 	    
										    caption:   false // supress caption text 
										}); 
										</script>
				               		</c:otherwise>	                    	
				                </c:choose>
		                	</c:when>
		                	<c:when test="${rtnSetting.boardKind eq 'THUMBNAIL' }">
				                <c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
				                    <img id="viewPort" style="display: none;" />
				                </c:if>
		                	</c:when>
		                	<c:otherwise>
		                	</c:otherwise>
		                </c:choose>
	                	${rtnContent.KHTML }
	                </td>
	            </tr>                             
	            <c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
		            <tr>
		                <th scope="row">첨부파일</th>
		                <td>
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
						        	<li><a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }" title="${fileList.USERFILENAME }">${fileList.USERFILENAME } <c:if test="${fileSize != 0}">(<fmt:formatNumber value='${fileSize}' pattern='#,###.##'/> ${fileGubun})</c:if> 
						        		<i class="xi-diskette"></i> <span class="hidden">파일첨부</span></a></li>
						        </c:forEach>
						        
							</ul>
		                </td>
		            </tr>
	         	</c:if>
	        </table>
		</div>
    </fieldset>
</spform:form>
<!-- ▲ 등록페이지  -->
    
<!-- ▼ 버튼 -->
<div class="btn_area">	
	<button type="button" class="btn btn_type01" id="btnRestore">복구</button>
	<button type="button" class="btn btn_type02" id="btnDelete">데이터삭제</button>
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>
<!-- ▲ 버튼 -->

<script type="text/javascript">
$(function() {
	$("#btnRestore").on("click", function() {
		if(!confirm("복구하시겠습니까?")) {
			return false;
		}
		
		$("#insertForm").attr('action', '${ctxMgr }/contentDelMgr/act');
		$("#insertForm").submit();
	});
	
	$("#btnDelete").on("click", function() {
		alert("데이터가 영구 삭제 됩니다.\n다시한번 확인 바랍니다.");
		if(!confirm("데이터를 삭제하시겠습니까?")) {
			return false;
		}
		
		$("#insertForm").attr('action', '${ctxMgr }/contentDelMgr/delete');
		$("#insertForm").submit();
	});
	
    //목록
	$("#btnList").click(function(){
		document.location.href="${contextPath}/mgr/contentDelMgr?${link}";
	});
	
});

</script>
