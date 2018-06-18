<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<article class="news_view">
	<h1  class="newsTitle"><c:out value="${rtnContent.KNAME }" /></h1>
	<table class="tstyle_view" summary="제목, 작성자, 키워드, 내용에 따른 게시물상세 안내">
		<caption>
		게시글 상세 보기
		</caption>
		<colgroup>
			<col width="15%" />
			<col width="40%" />
			<col width="15%" />
			<col width="40%" />
		</colgroup>	
		<tbody>
			<tr>
			    <th scope="row">Writer</th>
			    <td>
			        <c:out value="${rtnContent.USERNAME }" />
			    </td>
			    <th scope="row">KeyWord</th>
			    <td>
			        <c:if test="${!empty(rtnContent.KEYWORD1) and  rtnContent.KEYWORD1 ne '-'}">${rtnContent.KEYWORD1}
			         <c:if test="${!empty(rtnContent.KEYWORD2) and  rtnContent.KEYWORD2 ne '-' }">,${rtnContent.KEYWORD2}
			             <c:if test="${!empty(rtnContent.KEYWORD3) and  rtnContent.KEYWORD3 ne '-' }">,${rtnContent.KEYWORD3}
			             </c:if>
			         </c:if>
			        </c:if>
			    </td>
			</tr>
			<tr>
			    <th scope="row">Date</th>
			    <td><dateFormat:dateFormat addPattern="-" value="${rtnContent.INSTIME}" /></td>
			    <th scope="row">Views</th>
			    <td><fmt:formatNumber value='${rtnContent.HITCOUNT }' pattern='#,###'/></td>
			</tr>
			<c:if test="${rtnSetting.categoryYN == 'Y' }">
			<tr>
			    <th scope="row">Category</th>
			    <td colspan="3">${rtnContent.CATEGORYNAME }</td>
			</tr>
			</c:if>
			<!-- 
			<tr>
			    <c:if test="${rtnSetting.noticeYN == 'Y' }">
			    <th scope="row">공지글지정</th>
			    <td ${rtnSetting.secretYN == 'Y' ? '' : 'colspan="3"' }>${rtnContent.NOTICETITLEYN == 'Y' ? '공지' : '비공지' }</td>
			    </c:if>
				<c:if test="${rtnSetting.secretYN == 'Y' }">
			    <th scope="row">공개여부</th>
			    <td ${rtnSetting.categoryYN == 'Y' ? '' : 'colspan="3"' }>${rtnContent.secretYN == 'Y' ? '공개' : '비공개' }</td>
			    </c:if>
			</tr>
			 -->
			 
			<!-- ▼ 추가 필드가 있을 시 -->
			<c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
			<tr>
			    <th scope="row"><c:out value="${rtnSetting.addField1}" /></th>
			    <td colspan="3">${rtnContent.CONTENTS1 }</td>
			</tr>
			</c:if>
			<c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
			<tr>
			    <th scope="row"><c:out value="${rtnSetting.addField2}" /></th>
			    <td colspan="3">${rtnContent.CONTENTS2 }</td>
			</tr>
			</c:if>
			<c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }">
			<tr>
			    <th scope="row"><c:out value="${rtnSetting.addField3}" /></th>
			    <td colspan="3">${rtnContent.CONTENTS3 }</td>
			</tr>
			</c:if>
			<!-- ▲ 추가 필드가 있을 시 --> 
			<c:if test="${rtnSetting.boardKind eq 'VOD'}"><%//동영상형게시판%>
                <tr>
                    <th scope="row">Link URL</th>
                    <td colspan="3"><a href="${rtnContent.LINKURL }" title="새창으로 열림" target="_blank">${rtnContent.LINKURL }</a></td>
                </tr> 
			</c:if>
			
			<c:if test="${rtnSetting.boardKind eq 'VOD' && !empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
			<tr>
			    <th scope="row">Link URL</th>
                <td colspan="3">
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
				        	<li> <a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }" >
				        	${fileList.USERFILENAME } <c:if test="${fileSize != 0}">(<fmt:formatNumber value='${fileSize}' pattern='#,###.##'/> ${fileGubun})</c:if> <span>내려받기</span></a></li>
				        </c:forEach>
					</ul>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<div class="viewContent">
		<c:if test="${rtnSetting.boardKind ne 'VOD' && !empty(rtnFileList) && fn:length(rtnFileList) > 0 }">		
		<div class="slide_photo">
			<c:if test="${fn:length(rtnFileList) > 5 }">
			<button type="button" id="btnLeft" class="btn_left">Previous Photo See</button>
			<button type="button" id="btnRight" class="btn_rightOn">Next Photo See</button>
			</c:if>
			<div class="list_photo">
				<ul>
					<c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
					<c:if test="${status.count eq 1 }"><c:set var="firstImg" value="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }"/></c:if>
					<li <c:if test="${status.count > 5 }">style="display:none;"</c:if>><a href="#;" class="thumb viewImageA"><img alt="${fileList.ALTINFO }" src="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }"><span></span></a>
						<a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }" class="icon_download">Download</a>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="img_area"><img id="viewPort" src="${firstImg }" alt="" width="100%"/></div>
		</c:if>
		<c:if test="${rtnSetting.boardKind eq 'VOD'}"><%//동영상형게시판%>
			<c:choose> 
				<c:when test="${!empty(rtnContent.LINKURL)}">
					<embed id="vodPort"  width="100%" height="500px;" src="${rtnContent.LINKURL}"/>
				</c:when>
				<c:otherwise>
					<embed id="vodPort" width="100%" height="500px;" src="${rtnFileList[0].FILEPATH}${rtnFileList[0].SYSTEMFILENAME}"/>
				</c:otherwise>	                    	
			</c:choose>
		</c:if>
		<p>${rtnContent.KHTML }</p>
	</div>
</article>	
<c:if test="${empty(obj.no1) || obj.no1 < 9000000000}"><%//공지글은 이전 이후 제외 %>

<c:set var="frevText" value="F" />
<c:set var="nextText" value="F" />
<ul class="nextPrev_list">
	<li>
	<strong class='prev_list'>Previous</strong>
	<c:forEach items="${rtnFrevNext}" var="FrevNext"><%// begin="1" end="8" %>
		<c:if test="${FrevNext.TEXT eq 'F'}">
			<a href="${contextPath}/board/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
			<c:set var="frevText" value="T" />
		</c:if>
	</c:forEach>
	<c:if test="${frevText eq 'F' }">No Previous Data.</c:if>
	</li>
	<li>
	<strong class='next_list'>Next</strong>
	<c:forEach items="${rtnFrevNext}" var="FrevNext"><%// begin="1" end="8" %>
		<c:if test="${FrevNext.TEXT eq 'N'}">
			<a href="${contextPath}/board/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
			<c:set var="nextText" value="T" />
		</c:if>
	</c:forEach>
	<c:if test="${nextText eq 'F' }">No Next Data.</c:if>
	</li>
</ul>
</c:if>

<div class="btn_area_right">	
	<c:if test="${ADMIN eq 'T' or DELETE eq 'T' or USER.userId eq rtnContent.USERID}"><%//관리권한, 삭제권한, 본인글 %>
		<button type="button" class="btn_type01">Delete</button>
	</c:if>
	<c:if test="${ADMIN eq 'T' or MODIFY eq 'T' or USER.userId eq rtnContent.USERID}"><%//관리권한, 수정권한, 본인글 %>
		<button type="button" class="btn_type01" id="btnEdit">Update</button>
	</c:if>
	<c:if test="${rtnSetting.boardKind eq 'FREE' and (ADMIN eq 'T' or WRITE eq 'T') }"><%//자유형게시판이면서 관리권한, 등록권한 %>
		<button type="button" class="btn_type01" id="btnResponse">Reply</button>
	</c:if>
	<button type="button" class="btn_type01" id="btnList">List</button>
</div>

<!-- 댓글 -->
<ul id="reply" class="recmt_list"></ul>
<!-- 댓글 -->

<script type="text/javascript">
var imgFileCnt = "${fn:length(rtnFileList)}";
var imgFileNo = 0;
$(function() {
	
	$('.list_photo ul > li:eq(0)').attr("class", "on");
	
	/* 리플 리스트 */
	gfnReplyList($('#reply'), '${obj.linkId}');

	//이미지에 마우스 업로드시 화면 변경
	$('.viewImageA').on( "click", function( e ) {  //.click(function(){
		
		$('.list_photo ul > li').attr("class", "");
		
		$(this).parent().attr("class", "on");
		
		$('#viewPort').attr("src", $(this).children().attr('src'));
	});
	
	//이미지에 마우스 업로드시 화면 변경
	$('#btnLeft').click(function(){
		//imgFileCnt
		if(imgFileNo <= 0){
			$('#btnLeft').attr("class","btn_left");
			alert("첫번째 이미지입니다.");
			return;
		}
		$('.list_photo ul > li:eq('+(imgFileNo-1)+')').css("display", "");
		$('.list_photo ul > li:eq('+(imgFileNo+5)+')').css("display", "none");
		imgFileNo--;
		$('#btnRight').attr("class","btn_rightOn");
	});
	
	//이미지에 마우스 업로드시 화면 변경
	$('#btnRight').click(function(){

		if(imgFileNo >= imgFileCnt){
			$('#btnRight').attr("class","btn_right");
			alert("마지막 이미지입니다.");
			return;
		}

		if(imgFileNo >= (imgFileCnt-5)){
			$('#btnRight').attr("class","btn_right");
			alert("마지막 이미지입니다.");
			return;
		}
		$('.list_photo ul > li:eq('+imgFileNo+')').css("display", "none");
		$('.list_photo ul > li:eq('+(imgFileNo+5)+')').css("display", "");
		imgFileNo++;
		
		$('#btnLeft').attr("class","btn_leftOn");
	});
	
	//체크 버튼 클릭
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	//수정
	$('#btnEdit').click(function(){
		document.location.href="${contextPath}/board/form?${link}&linkId=${obj.linkId}";
	});
	
    //목록
	$("#btnList").click(function(){
		document.location.href="${contextPath}/board?${link}";
	});
    
	//답글
	$('#btnResponse').click(function(){
		document.location.href="${contextPath}/board/form?${link}&parentLinkId=${obj.linkId}";
	});
	
});
</script>
