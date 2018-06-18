<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="deleteForm" name="deleteForm" action="${contextPath }/mgr/contentMgr/actAppealBoard" method="POST">
    <input type="hidden" name="link" value="${link }" />
    <input type="hidden" name="inCondition" value="삭제">
    <input type="hidden" name="menuId" value="${obj.menuId }" />
    <input type="hidden" name="boardId" value="${rtnSetting.boardId }" />
    <input type="hidden" name="linkId" value="${rtnContent.LINKID }" />
    <input type="hidden" name="startTime" value="11111111" />
    <input type="hidden" name="endTime" value="11111111" />
</spform:form>    
 <!-- ▼ 등록페이지  -->
 <fieldset>
	<legend>상세보기</legend>
	<article class="news_view">
		<h1  class="newsTitle"><c:out value="${rtnContent.KNAME }" escapeXml="false"/></h1>
		<dl class="info">
			<dt>작성자</dt>
			<dd><c:out value="${rtnContent.USERNAME }" /></dd>
			<dt>키워드</dt>
			<dd><c:if test="${!empty(rtnContent.KEYWORD1) }">${rtnContent.KEYWORD1}
                     <c:if test="${!empty(rtnContent.KEYWORD2) }">,${rtnContent.KEYWORD2}
						<c:if test="${!empty(rtnContent.KEYWORD3) }">,${rtnContent.KEYWORD3}
 	                        <c:if test="${!empty(rtnContent.KEYWORD4) }">,${rtnContent.KEYWORD4}
 	                        	<c:if test="${!empty(rtnContent.KEYWORD5) }">,${rtnContent.KEYWORD5}
 	                        		<c:if test="${!empty(rtnContent.KEYWORD6) }">,${rtnContent.KEYWORD6}
	  	                        		<c:if test="${!empty(rtnContent.KEYWORD7) }">,${rtnContent.KEYWORD7}
	  	                        			<c:if test="${!empty(rtnContent.KEYWORD8) }">,${rtnContent.KEYWORD8}
		   	                        			<c:if test="${!empty(rtnContent.KEYWORD9) }">,${rtnContent.KEYWORD9}
		    	                        			<c:if test="${!empty(rtnContent.KEYWORD10) }">,${rtnContent.KEYWORD10}</c:if>
			                        			</c:if>
	                        				</c:if>
 	                        			</c:if>
	                        		</c:if>
								</c:if>
 	                        </c:if>
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
		         <dd>${rtnContent.SECRETTITLEYN == 'Y' ? '적용' : '미적용' }</dd>
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
    <!-- ▼ 버튼 -->
    <div class="btn_area">
        <c:if test="${rtnContent.USERID == obj.myId or ADMIN == 'T'}">
          <%-- <c:if test="${rtnContent.PROCESS eq '-'}"> --%>
          <button type="button" class="btn btn_type02" id="btnEdit">수정</button>
          <button type="button" class="btn btn_type01" id="btnDelete">삭제</button>
          <%-- </c:if> --%>
        </c:if>
        <button type="button" class="btn btn_type01" id="btnList">목록</button>
    </div>
    <!-- ▲ 버튼 -->    
    
	<!-- ▼ 이전글/다음글 -->
	<c:if test="${!empty(obj.no1) && obj.no1 < 9000000000 }">    
	    <ul class="nextPrev_list">
	        <c:forEach items="${rtnFrevNext}" var="FrevNext">
	            <c:if test="${!empty(FrevNext)}">
			         <li>
			             <strong><c:out value="${FrevNext.TEXT eq 'F' ? 'Prev' : 'Next' }" /></strong>
			             <a href="${contextPath}/mgr/contentMgr/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
			         </li>
	            </c:if>
	        </c:forEach>
	    </ul>
	</c:if>
	<!-- ▲ 이전글/다음글 --> 
   
	<c:if test="${fn:length(rtnComment) > 0 }">
	<!-- ▼ 답글 -->
	<h2 class="depth2_title02">답변</h2>
	<div class="table">
		<table class="tstyle_view">
		    <caption>
		     답변자, 답변일, 내용
		    </caption>
		    <colgroup>
		        <col class="col-sm-3" />
		        <col />
		    </colgroup>
		    <tr>
		        <th scope="row"><label for="subject">답변자</th>
		        <td><c:out value="${rtnComment.USERNAME }" /></td>
		   </tr>
		   <tr>
		       <th scope="row"><label for="name">답변일</th>
		       <td><c:out value="${fn:substring(rtnComment.DMLTIME, 0, 4) }-${fn:substring(rtnComment.DMLTIME, 4, 6) }-${fn:substring(rtnComment.DMLTIME, 6, 8) }" /></td>
		   </tr>
		   <tr>
		       <th scope="row">내용</th>
		       <td>${rtnComment.KHTML }</td>
		    </tr>
		</table>
	</div>
    <!-- ▲ 답글 -->
    <!-- ▼ 버튼 -->
    <div class="btn_area">
     	<button type="button" class="btn btn_type02" id="btnReplyEdit">답변수정</button>
    </div>
    <!-- ▲ 버튼 -->
   </c:if>

<script type="text/javascript">

$(function() {
	
	//체크 버튼 클릭
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	//답변등록
	$('#btnReplyAdd').click(function(){
		document.location.href="${ctxMgr }/contentMgr/form?${link}&linkId=${obj.linkId}";
	});
	
	//답변수정
	$('#btnReplyEdit').click(function(){
		document.location.href="${ctxMgr }/contentMgr/form?${link}&linkId=${obj.linkId}";
	});
	
	//수정
	$('#btnEdit').click(function(){
		document.location.href="${ctxMgr }/contentMgr/form?${link}&linkId=${obj.linkId}";
	});
	
	// 삭제
    $('#btnDelete').click(function(){
        $('#deleteForm').submit();
    });
	
    //목록
	$("#btnList").click(function(){
		document.location.href="${ctxMgr }/contentMgr?${link}";
	});
	
	//달력 세팅
    $( "#schStartDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/common/calendar/calendar.png"
    });
    
    $( "#schEndDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/common/calendar/calendar.png"
    });
	
});
</script>