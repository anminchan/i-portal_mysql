<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<article class="news_view">
	<h1  class="newsTitle">${rtnContent.KNAME }</h1>
	<table class="tstyle_view">
		<caption>
		${rtnContent.KNAME } : 작성일, 조회수<c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }"><c:out value="${rtnSetting.addField1}" />,</c:if><c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }"><c:out value="${rtnSetting.addField2}" />,</c:if><c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }"><c:out value="${rtnSetting.addField3}" />,</c:if><c:if test="${rtnSetting.boardKind eq 'VOD' and !empty(rtnContent.LINKURL) and rtnContent.LINKURL ne '-'}">, 링크 URL</c:if> 정보 제공
		</caption>
		<colgroup>
			<col class="col-sm-2"/>
			<col class="col-sm-4"/>
			<col class="col-sm-2"/>
			<col class="col-sm-4"/>
		</colgroup>	
		<tbody>			
			<tr>
			    <th scope="row">작성일</th>
			    <td><dateFormat:dateFormat addPattern="-" value="${rtnContent.INSTIME}" /></td>
			    <th scope="row">조회수</th>
			    <td><fmt:formatNumber value='${rtnContent.HITCOUNT }' pattern='#,###'/></td>
			</tr>	
			
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
			<c:if test="${rtnSetting.boardKind eq 'VOD' and !empty(rtnContent.LINKURL) and rtnContent.LINKURL ne '-'}"><%//동영상형게시판%>
                <tr>
                    <th scope="row">링크 URL</th>
                    <td colspan="3"><a href="${rtnContent.LINKURL }" title="새창으로 열림" target="_blank">${rtnContent.LINKURL }</a></td>
                </tr> 
			</c:if>
		</tbody>
	</table>
	<p class="cardnews_option"><a href="javascript:fnViewChoice('pass');" class="vertical">넘겨보기</a> <a href="javascript:fnViewChoice('open');" class="horizon">펼쳐보기</a></p>
		
	<div class="viewContent cardNews_view" id="passView">		
		<c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
			<button type="button" id="btnLeftImg" class="btn_left">이전 포토 보기</button>
			<button type="button" id="btnRightImg" class="btn_right">다음 포토 보기</button>
			<div class="img_area"><img id="viewPort" src="${contextPath}/fileDownload?titleId=${rtnFileList[0].TITLEID }&fileId=${rtnFileList[0].FILEID }" alt="${rtnFileList[0].ALTINFO != '' ? rtnFileList[0].ALTINFO : rtnFileList[0].USERFILENAME }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" /></div>
			<%-- <div class="img_area"><img id="viewPort" src="${firstImg }" alt="${altInfo }" width="100%"  onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" /></div> --%>
			<div class="slide_photo cardnews_slide">
				<c:if test="${fn:length(rtnFileList) > 5 }">
				<button type="button" id="btnLeft" class="btn_left">이전 포토 보기</button>
				<button type="button" id="btnRight" class="btn_rightOn">다음 포토 보기</button>
				</c:if>
				<div class="list_photo">
					<ul>
						<c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
							<c:if test="${status.count eq 1 }">
								<c:set var="altInfo" value="${fileList.ALTINFO != '' ? fileList.ALTINFO : fileList.USERFILENAME }"/>
								<c:set var="firstImg" value="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }"/>
							</c:if>
							<%-- <li><img class="viewImage" alt="${fileList.ALTINFO }" src="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }"></li> --%>
							<li <c:if test="${status.count > 5 }">style="display:none;"</c:if>><a href="javascript:;" class="thumb viewImageA"><img src="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" alt="${rtnContent.KNAME} 이미지${status.count}" /><span></span></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
		<p>${rtnContent.KHTML }</p>
	</div>
	
	<div class="viewContent cardNews_view" id="openView" style="display: none;">
		<c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
			<div class="img_area">
				<img src="${contextPath}/fileDownload?titleId=${fileList.TITLEID }&fileId=${fileList.FILEID }" alt="${fileList.ALTINFO != '' ? fileList.ALTINFO : fileList.USERFILENAME }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" />
			</div>
		</c:forEach>
		<p>${rtnContent.KHTML }</p>
	</div>
</article>
	
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

<div class="btn_area_right">	
	<c:if test="${(ADMIN eq 'T' or MODIFY eq 'T') and USER.userId eq rtnContent.USERID}"><%//관리권한, 삭제권한, 본인글 %>
		<button type="button" class="btn_colorType02" id="btnDelete">삭제</button>
	</c:if>
	<c:if test="${(ADMIN eq 'T' or MODIFY eq 'T') and USER.userId eq rtnContent.USERID}"><%//관리권한, 수정권한, 본인글 %>
		<button type="button" class="btn_colorType02" id="btnEdit">수정</button>
	</c:if>
	<%-- <c:if test="${rtnSetting.boardKind eq 'FREE' and (ADMIN eq 'T' or WRITE eq 'T') }"><%//자유형게시판이면서 관리권한, 등록권한 %>
		<button type="button" class="btn_colorType02" id="btnResponse">답글</button>
	</c:if> --%>
	<button type="button" class="btn_colorType01" id="btnList">목록</button>
</div>

<form id="insertForm" name="insertForm" action="${contextPath }/board/actBoard" method="POST">
	<input type="hidden" id="inCondition" name="inCondition" value="${!empty(rtnContent.STARTTIME) ? '수정' : '입력' }" />
	<input type="hidden" id="link" name="link" value="${link }" />
	<input type="hidden" id="linkId" name="linkId" value="${obj.linkId }" />
	
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnContent.boardId) ? rtnContent.boardId : '-' }" />
	
	<input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
	<input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
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

// 넘겨보기/펼처보기
function fnViewChoice(gubun){
	if(gubun == 'pass'){
		$(".horizon").removeClass("on");
		$(".vertical").addClass("on");
		$("#openView").hide();
		$("#passView").show();
	}else{
		$(".vertical").removeClass("on");
		$(".horizon").addClass("on");
		$("#passView").hide();
		$("#openView").show();
	}
}

// 이미지 객수 세팅
var imgCnt	   		= 5; 
var imgFileCnt 		= "${fn:length(rtnFileList)}";
var imgFileNo	 	= 0;
// 임의로 클릭된 아이템
var imgClickIdx 	= 0;
$(function() {
	
	$(".vertical").addClass("on"); // 넘겨보기 활성화 체크
	
	$('.list_photo ul > li:eq(0)').attr("class", "on");
	imgClickIdx = 0;

	//이미지에 마우스 업로드시 화면 변경
	$('.viewImageA').on( "click", function( e ) {  //.click(function(){
		
		$('.list_photo ul > li').attr("class", "");
		$(this).parent().attr("class", "on");
		// 임의의 이미지 클릭 시 변수 초기화
		imgClickIdx = $(this).parent().index();
		imgFileNo   = $(this).parent().index(); 
		leftImageCheck();
		rightImageCheck();
		$('#viewPort').attr("src", $(this).children().attr('src'));
	});
	
	//이미지에 마우스 업로드시 화면 변경
	$('#btnLeft').click(function(){
		imageMoveCheck('left');
		leftImageCheck();
	});
	
	//이미지에 마우스 업로드시 화면 변경
	$('#btnRight').click(function(){
		imageMoveCheck('right');
		rightImageCheck();
	});
	
	//체크 버튼 클릭
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	//수정
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
	
    //목록
	$("#btnList").click(function(){
		document.location.href="${contextPath}/board?${link}";
	});
	//답급
	/* $('#btnResponse').click(function(){
		document.location.href="${contextPath}/board/form?${link}&parentLinkId=${obj.linkId}";
	}); */
	
	$('#btnLeftImg').click(function(){
		imageMoveCheck('left');
		if(imgFileNo == 0){
			$('#btnLeft').attr("class","btn_left");
			alert("첫번째 이미지입니다.");
			return;
		}
	});
	
	$('#btnRightImg').click(function(){
		imageMoveCheck('right');
		if((imgFileNo+1) == imgFileCnt){
			$('#btnRight').attr("class","btn_right");
			alert("마지막 이미지입니다.");
			return;
		}
	});
	
});

</script>
