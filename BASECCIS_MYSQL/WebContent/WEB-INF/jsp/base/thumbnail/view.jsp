<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<article class="news_view">
	<h1  class="newsTitle">${rtnContent.KNAME }</h1>
		<dl class="info">
		<dt>작성자</dt>
		<dd><c:out value="${rtnContent.USERNAME}" /></dd>
	    <dt>키워드</dt>
	    <dd>
	        <c:if test="${!empty(rtnContent.KEYWORD1) and  rtnContent.KEYWORD1 ne '-'}">${rtnContent.KEYWORD1}
	         <c:if test="${!empty(rtnContent.KEYWORD2) and  rtnContent.KEYWORD2 ne '-' }">,${rtnContent.KEYWORD2}
	             <c:if test="${!empty(rtnContent.KEYWORD3) and  rtnContent.KEYWORD3 ne '-' }">,${rtnContent.KEYWORD3}
	             </c:if>
	         </c:if>
	        </c:if>
	    </dd>					    
		<dt>작성일</dt>
		<dd><dateFormat:dateFormat addPattern="-" value="${rtnContent.INSTIME}" /></dd>
		<dt>조회수</dt>
		<dd><fmt:formatNumber value='${rtnContent.HITCOUNT}' pattern='#,###'/></dd>
		
		<c:if test="${rtnSetting.categoryYN == 'Y'}">			
			<dt>카테고리</dt>
			<dd>${rtnContent.CATEGORYNAME}</dd>
		</c:if>
		
		<c:if test="${rtnSetting.noticeYN == 'Y' }">
		    <dt>공지글지정</dt>
		    <dd>${rtnContent.NOTICETITLEYN == 'Y' ? '공지' : '비공지' }</dd>
	    </c:if>
		<c:if test="${rtnSetting.secretYN == 'Y' }">
		    <dt>공개여부</dt>
		    <dd>${rtnContent.secretYN == 'Y' ? '공개' : '비공개' }</dd>
	    </c:if>
			    
		<!-- ▼ 국가필드유무 -->
		<c:if test="${rtnSetting.countryYN == 'Y'}">			
			<dt>국가정보</dt>
			<dd>${rtnContent.CONTINENTNAME } ${!empty rtnContent.COUNTRYNAME ? '>' : ''} ${!empty rtnContent.COUNTRYNAME ? rtnContent.COUNTRYNAME : ''}</dd>
		</c:if>
		
		<!-- ▼ 추가 필드가 있을 시 -->
		<c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-'}">
			<dt><c:out value="${rtnSetting.addField1}" /></dt>
			<dd>${rtnContent.CONTENTS1 }</dd>
		</c:if>
		<c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-'}">
			<dt><c:out value="${rtnSetting.addField2}" /></dt>
			<dd>${rtnContent.CONTENTS2 }</dd>
		</c:if>
		<c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-'}">
			<dt><c:out value="${rtnSetting.addField3}" /></dt>
			<dd>${rtnContent.CONTENTS3}</dd>
		</c:if>
		<!-- ▲ 추가 필드가 있을 시 --> 
		<c:if test="${rtnSetting.boardKind eq 'VOD' and !empty(rtnContent.LINKURL) and rtnContent.LINKURL ne '-'}"><%//동영상형게시판%>
			<dt>링크 URL</dt>
			<dd><a href="${rtnContent.LINKURL}" title="새창으로 열림" target="_blank">${rtnContent.LINKURL}</a></dd>
		</c:if>	
	</dl>
	<div class="viewContent">
		<c:if test="${rtnSetting.boardKind ne 'VOD' && !empty(rtnFileList) && fn:length(rtnFileList) > 0}">		
			<div class="slide_photo">
				<c:set var="thumbCount" value="5"/>
				<c:if test="${siteInfo.SITEID eq 'SITE00002'}">
					<c:set var="thumbCount" value="7"/>
				</c:if>
				<c:if test="${fn:length(rtnFileList) > thumbCount}">
					<button type="button" id="btnLeft" class="btn_left">이전 포토 보기</button>
					<button type="button" id="btnRight" class="btn_rightOn">다음 포토 보기</button>
				</c:if>
				<div class="list_photo">
					<ul>
						<c:forEach items="${rtnFileList}" var="fileList" varStatus="status">
							<c:if test="${status.count eq 1}">
								<c:set var="altInfo" value="${fileList.ALTINFO != '' ? fileList.ALTINFO : fileList.USERFILENAME}"/>
								<c:set var="firstImg" value="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID}"/>
							</c:if>
							<li <c:if test="${status.count > thumbCount}">style="display:none;"</c:if>><a href="javascript:;" class="thumb viewImageA"><img src="${contextPath}/fileDownload?titleId=${fileList.TITLEID}&fileId=${fileList.FILEID}" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" alt="${fileList.ALTINFO}"/><span></span></a>
								<a href="${contextPath}/fileDownload?titleId=${fileList.TITLEID}&fileId=${fileList.FILEID}&fileDownType=C&paramMenuId=${obj.menuId}" class="icon_download">다운로드</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="img_area"><img id="viewPort" src="${firstImg}" alt="${altInfo}" width="100%" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'"/></div>
		</c:if>
		<c:if test="${rtnSetting.boardKind eq 'VOD'}"><%//동영상형게시판%>
			<c:choose> 
				<c:when test="${!empty(rtnContent.LINKURL) and rtnContent.LINKURL ne '-'}">
					<embed id="vodPort" width="100%" height="500px;" src="${rtnContent.LINKURL}"/>
				</c:when>
				<c:otherwise>
					<c:if test="${fn:length(rtnFileList) > 0 }">
						<object width="100%" height="500px" classid="CLSID:6BF52A52-394A-11D3-B153-00C04F79FAA6">
							<param name="url" value="${rtnFileList[0].FILEPATH}${rtnFileList[0].SYSTEMFILENAME}"/>
							<param name="autostart" value="false" />  
							<param name="transparentAtStart" value="1" /> 
							<param name="wmode" value="window" /> 
							<param name="showcontrols" value="1"/>
							<embed type='application/x-mplayer2' pluginspage='http://microsoft.com/windows/mediaplayer/en/download/' id='mediaPlayer' name='mediaPlayer' width="100%" height="500px" showcontrols="true" src="<c:out value="${fn:replace(rtnFileList[0].FILEPATH, '', '')}"/>${rtnFileList[0].SYSTEMFILENAME}" autostart="false" loop="true">
							</embed>
						</object>					
					</c:if>
				</c:otherwise>	                    	
			</c:choose>
		</c:if>
		<p>${rtnContent.KHTML}</p>
	</div>
</article>
	
<div class="btn_areat">	
	<c:if test="${(ADMIN eq 'T' or MODIFY eq 'T') and USER.userId eq rtnContent.USERID}"><%//관리권한, 삭제권한, 본인글 %>
		<button type="button" id="btnDelete" class="btn_type02">삭제</button>
	</c:if>
	<c:if test="${(ADMIN eq 'T' or MODIFY eq 'T') and USER.userId eq rtnContent.USERID}"><%//관리권한, 수정권한, 본인글 %>
		<button type="button" class="btn_type02" id="btnEdit">수정</button>
	</c:if>
	<%-- <c:if test="${rtnSetting.boardKind eq 'FREE' and (ADMIN eq 'T' or WRITE eq 'T')}"><%//자유형게시판이면서 관리권한, 등록권한 %>
		<button type="button" class="btn_colorType02" id="btnResponse">답글</button>
	</c:if> --%>
	<button type="button" class="btn_type01" id="btnList">목록</button>
</div>
	
<!-- ▼ 이전글/다음글 -->
<c:if test="${!empty(obj.no1) && obj.no1 < 9000000000 }">    
    <ul class="nextPrev_list">
        <c:forEach items="${rtnFrevNext}" var="FrevNext">
            <c:if test="${!empty(FrevNext)}">
		         <li>
		             <strong><c:out value="${FrevNext.TEXT eq 'F' ? '이전글' : '다음글' }" /></strong>
		             <a href="${contextPath}/board/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
		         </li>
            </c:if>
        </c:forEach>
    </ul>
</c:if>
<!-- ▲ 이전글/다음글 -->

<form id="insertForm" name="insertForm" action="${contextPath}/board/actBoard" method="POST">
	<input type="hidden" id="inCondition" name="inCondition" value="${!empty(rtnContent.STARTTIME) ? '수정' : '입력'}" />
	<input type="hidden" id="link" name="link" value="${link}"/>
	<input type="hidden" id="linkId" name="linkId" value="${obj.linkId}"/>
	
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}"/>
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnContent.boardId) ? rtnContent.boardId : '-'}"/>
	
	<input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly"/>
	<input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly"/>
</form>

<!-- ▼ 댓글 -->
<%@ include file="/includes/bbsReply.jsp" %>
<!-- ▲ 댓글 -->

<script type="text/javascript">
// 이미지 이동 함수
function imageMoveCheck(flag){
	
	// flag : right 오르쪽으로 이동, left 왼쪽으로 이동
	if(flag == 'right'){ 
		if(imgFileNo < (imgFileCnt-1)){
			imgFileNo++;
			if(imgFileNo >= imgCnt ){
				$('.list_photo ul > li:eq('+(imgFileNo-imgCnt)+')').css("display", "none");
				$('.list_photo ul > li:eq('+(imgFileNo)+')').css("display", "");
			}
		}
	}else if(flag == 'left'){
		if(imgFileNo > 0 ){
			var leftIdx = getLeftIndex();
			//if(leftIdx >= imgFileNo) leftIdx = imgFileNo-1;
			if(imgFileNo <= leftIdx){
				$('.list_photo ul > li:eq('+(imgFileNo+imgCnt-1)+')').css("display", "none");
				$('.list_photo ul > li:eq('+(imgFileNo-1)+')').css("display", "");	
			}
			imgFileNo--;
		}
	}
	// 모든 작업 후 변수 동기화
	imgClickIdx = imgFileNo;
	// 임의의 클릭 여부 판정
	if(imgFileNo >= imgClickIdx){
		$('.list_photo ul > li').attr("class", "");
		$('.list_photo ul > li:eq('+imgFileNo+')').attr("class", "on");		
		$('#viewPort').attr("src",$('.list_photo ul > li:eq('+imgFileNo+') img').attr('src'));
		$('#viewPort').attr("alt",$('.list_photo ul > li:eq('+imgFileNo+') img').attr('alt'));
	}
	// 좌측 벽 판정
	if(imgFileNo == 0) 			imgClickIdx = 0;
	// 우측 벽 판정
	if(imgFileNo == imgFileCnt) imgClickIdx = imgFileCnt;
}

// 왼쪽 인덱스 정보 구하기
function getLeftIndex(){
	var idx = 0;
	for(var i = 0 ; i < imgFileCnt ; i++){
		if($('.list_photo ul > li:eq('+i+')').css("display") == "inline-block"){
			idx = i;
			break;
		}
	}
	return idx;
}

//왼쪽 이미지 변환 체크
function leftImageCheck(){
	if(imgFileNo == 0){
		$('#btnLeft').attr("class","btn_left");
		alert("첫번째 이미지입니다.");
		return;
	}
	$('#btnRight').attr("class","btn_rightOn");
}
// 오른쪽 이미지 변환 체크
function rightImageCheck(){
	if((imgFileNo+1) == imgFileCnt){
		$('#btnRight').attr("class","btn_right");
		alert("마지막 이미지입니다.");
		return;
	}
	$('#btnLeft').attr("class","btn_leftOn");
}

// 이미지 갯수 세팅
var imgCnt	   		= 5;

<c:if test="${siteInfo.SITEID eq 'SITE00002'}">
	imgCnt = 7;
</c:if>

var imgFileCnt 		= "${fn:length(rtnFileList)}";
var imgFileNo	 	= 0;

// 임의로 클릭된 아이템
var imgClickIdx 	= 0;

$(function() {
	$('.list_photo ul > li:eq(0)').attr("class", "on");
	imgClickIdx = 0;

	// 이미지에 마우스 클릭 시 화면 변경
	$('.viewImageA').on("click", function(e){
		
		$('.list_photo ul > li').attr("class", "");
		$(this).parent().attr("class", "on");
		// 임의의 이미지 클릭 시 변수 초기화
		imgClickIdx = $(this).parent().index();
		imgFileNo   = $(this).parent().index(); 
		leftImageCheck();
		rightImageCheck();
		$('#viewPort').attr("src", $(this).children().attr('src'));
		$('#viewPort').attr("alt", $(this).children("img").attr("alt"));
	});
	
	// 이미지에 마우스 업로드시 화면 변경
	$('#btnLeft').click(function(){
		imageMoveCheck('left');
		leftImageCheck();
	});
	
	// 이미지에 마우스 업로드시 화면 변경
	$('#btnRight').click(function(){
		imageMoveCheck('right');
		rightImageCheck();
	});
	
	// 체크 버튼 클릭
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	// 수정
	$('#btnEdit').click(function(){
		document.location.href="${contextPath}/board/form?${link}&linkId=${obj.linkId}";
	});
	
	// 삭제
    $("#btnDelete").click(function(){
    	
    	if(!confirm("삭제하시겠습니까?")){
    		return;
    	}
    	
        $("#inCondition").val("삭제");
        
        $("#insertForm").attr('action', '/board/actBoard');
        $('#insertForm').submit();
    });
	
    // 목록
	$("#btnList").click(function(){
		document.location.href="${contextPath}/board?${link}";
	});
    
	// 답글
	/* $('#btnResponse').click(function(){
		document.location.href="${contextPath}/board/form?${link}&parentLinkId=${obj.linkId}";
	}); */
	
});

</script>
