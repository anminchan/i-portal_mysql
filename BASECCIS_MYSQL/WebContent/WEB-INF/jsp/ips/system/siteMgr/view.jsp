<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
    
<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentMgr/actNoticeBoard" method="post" >
	<input type="hidden" id="link" name="link" value="${link }" />	
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnSetting.boardId) ? rtnSetting.boardId : '-' }" />	
	<input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
	<input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />	
	<input type="hidden" name="fileYN" id="fileYN" value="Y"/>
	
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
       <!-- ▼ 등록페이지  -->
	<fieldset>
		<legend>상세보기</legend>
			<article class="news_view">
				<h1  class="newsTitle"><c:out value="${rtnContent.KNAME }" /></h1>
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
					<c:if test="${rtnSetting.noticeYN == 'Y' }">
						<dt>공지글지정</dt>
						<dd>${rtnContent.NOTICETITLEYN == 'Y' ? '공지' : '비공지' }
							<c:if test="${rtnContent.NOTICETITLEYN == 'Y' }">
								<c:if test="${!empty rtnContent.NOTICESTARTTIME }">
								[공지기간 : <fmt:formatDate value="${rtnContent.NOTICESTARTTIME }" pattern="yyyy-MM-dd HH"/> ~ <fmt:formatDate value="${rtnContent.NOTICEENDTIME }" pattern="yyyy-MM-dd HH"/>시]
								</c:if>
							</c:if>
						</dd>
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
                    <!-- // 비밀글유무 -->
                    <!-- ▼ 국가필드유무 -->
	                <c:if test="${rtnSetting.countryYN == 'Y' }">
		               <dt>국가정보</dt>
		               <dd>${rtnContent.CONTINENTNAME } ${!empty rtnContent.COUNTRYNAME ? '>' : ''} ${!empty rtnContent.COUNTRYNAME ? rtnContent.COUNTRYNAME : ''}</dd>
	                </c:if>                
	                <!-- ▼ 추가 필드가 있을 시 -->
	                <c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
		                <dt><c:out value="${rtnSetting.addField1}" /></dt>
		                <dd id="addField1">${rtnContent.CONTENTS1 }</dd>
	                </c:if>                
	                <c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
		               <dt><c:out value="${rtnSetting.addField2}" /></dt>
		               <dd  id="addField2">${rtnContent.CONTENTS2 }</dd>
	                </c:if>	                
	                <c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }">
		                <dt><c:out value="${rtnSetting.addField3}" /></dt>
		                <dd id="addField3">${rtnContent.CONTENTS3 }</dd>
	                </c:if>	                
					<c:if test="${!empty(rtnSetting.addField4) && fn:length(rtnSetting.addField4) > 0 && rtnSetting.addField4 != '-' }">
						<dt><c:out value="${rtnSetting.addField4}" /></dt>
						<dd><fmt:formatDate value="${rtnContent.CONTENTS4 }" pattern="yyyy-MM-dd"/>
								<c:if test="${!empty(rtnSetting.addField5) && fn:length(rtnSetting.addField5) > 0 && rtnSetting.addField5 != '-' }">
									<c:if test="${rtnSetting.addField4 eq rtnSetting.addField5}">
										~ <fmt:formatDate value="${rtnContent.CONTENTS5 }" pattern="yyyy-MM-dd"/>
									</c:if>
								</c:if>
						 </dd>
					</c:if>		
					<c:if test="${!empty(rtnSetting.addField5) && fn:length(rtnSetting.addField5) > 0 && rtnSetting.addField5 != '-' }">
						<c:if test="${rtnSetting.addField4 ne rtnSetting.addField5}">
						<dt><c:out value="${rtnSetting.addField5}" /></dt>
						<dd><fmt:formatDate value="${rtnContent.CONTENTS5 }" pattern="yyyy-MM-dd"/></dd>
					</c:if>
					</c:if>
	                <c:if test="${!empty(rtnContent.PROGRESS)}">
		                <dt>진행상태</dt>
		                <dd id="addProgress">${rtnContent.PROGRESS }</dd>
	                </c:if>                
	                <c:if test="${!empty(rtnSetting.addField6) && fn:length(rtnSetting.addField6) > 0 && rtnSetting.addField6 != '-' }">
		                <dt><c:out value="${rtnSetting.addField6}" /></dt>
		                <dd id="addField6"><fmt:formatDate value="${rtnContent.CONTENTS6 }" pattern="yyyy-MM-dd"/></dd>
	                </c:if>
	                <!-- ▲ 추가 필드가 있을 시 -->	                
	                <%-- <c:if test="${rtnSetting.imageYN eq 'Y' }">             
	                    <dt>대표이미지</dt>
	                    <dd>
	                    <c:set var="imageCheck" value="${rtnContent.FILEPATH }" />    
						<c:choose>
						    <c:when test="${fn:containsIgnoreCase(imageCheck, 'imagePoolMgr')}">
								<a href="${contextPath}/fileDownload?fileGubun=common&menuId=imagePoolMgr&userFileName=${rtnContent.IMAGEFILENAME }&systemFileName=${rtnContent.IMAGESFILENAME }" alt="${rtnContent.ALTINFO }"><c:out value="${rtnContent.IMAGEFILENAME }" /></a> 
						        <br />
						    </c:when>    
						    <c:otherwise>
								<a href="${contextPath}/fileDownload?fileGubun=board&menuId=${param.menuId}&userFileName=${rtnContent.IMAGEFILENAME }&systemFileName=${rtnContent.IMAGESFILENAME }" alt="${rtnContent.ALTINFO }"><c:out value="${rtnContent.IMAGEFILENAME }" /></a>
						        <br />
						    </c:otherwise>
						</c:choose>                    
	                    </dd>              
	                	<dt>대표이미지설명</dt>
	                	<dd>${rtnContent.ALTINFO }</dd>
	                </c:if> --%> 
                </dl>
				<div class="viewContent">
					<%-- ${rtnContent.KHTML } --%>
                    <c:out escapeXml = "false" value="${fn:replace(rtnContent.KHTML, newLine, '<br>')}"/>
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
					        		<img src='${contextPath}/resources/images/common/icon/icon_zip.gif' alt='ZIP파일'/>
					        	</c:if>
					        	<c:if test="${fileExt eq 'hwp' or fileExt eq 'HWP'}">
					        		<img src='${contextPath}/resources/images/common/icon/icon_hwp.gif' alt='HWP파일'/>
					        	</c:if>
					        	<c:if test="${fileExt eq 'txt' or fileExt eq 'TXT'}">
					        		<img src='${contextPath}/resources/images/common/icon/icon_txt.gif' alt='TXT파일'/>
					        	</c:if>
					        	<c:if test="${fileExt eq 'pdf' or fileExt eq 'PDF'}">
					        		<img src='${contextPath}/resources/images/common/icon/icon_pdf.gif' alt='PDF파일'/>
					        	</c:if>
					        	<c:if test="${fileExt eq 'doc' or fileExt eq 'docx' or fileExt eq 'DOC' or fileExt eq 'DOCX'}">
					        		<img src='${contextPath}/resources/images/common/icon/icon_doc.gif' alt='DOC파일'/>
					        	</c:if>
					        	<c:if test="${fileExt eq 'xls' or fileExt eq 'xlsx' or fileExt eq 'XLS' or fileExt eq 'XLSX'}">
					        		<img src='${contextPath}/resources/images/common/icon/icon_xls.gif' alt='XLS파일'/>
					        	</c:if>
					        	<c:if test="${fileExt eq 'ppt' or fileExt eq 'pptx' or fileExt eq 'PPT' or fileExt eq 'pptX'}">
					        		<img src='${contextPath}/resources/images/common/icon/icon_ppt.gif' alt='PPT파일'/>
					        	</c:if>
					        	<c:if test="${fileExt eq 'jpg' or fileExt eq 'JPG' or fileExt eq 'gif' or fileExt eq 'GIF' or fileExt eq 'jpeg' or fileExt eq 'JPEG' or fileExt eq 'png' or fileExt eq 'PNG' or fileExt eq 'bmp' or fileExt eq 'BMP'}">
					        		<img src='${contextPath}/resources/images/common/icon/icon_img.gif' alt='IMG파일'/>
					        	</c:if>					        	
					        	${fileList.USERFILENAME } <c:if test="${fileSize != 0}">(<fmt:formatNumber value='${fileSize}' pattern='#,###.##'/> ${fileGubun})</c:if> <span><i class="xi-file-download"></i>  내려받기</span></a></li>
				        </c:forEach>
					</ul>
                </c:if>
                <!-- ▲ 파일 다운로드  -->
			</article>
       </fieldset>
   	<!-- ▲ 등록페이지  -->    
</spform:form>
<!-- ▼ 버튼 -->
<div class="btn_area">
	<%-- <span class="float_left">		
		<button type="button" id="btnEvent" class="btn_black roleWRITE">${eventId > 0 ? '행사상세' : '행사등록' }</button>
	</span> --%>	
	<button type="button" class="btn btn_type02" id="btnEdit">수정</button>
	<!-- 콘텐츠 이관 target으로 참조되는 메뉴가 아닐 경우 || 공유 게시글인 경우-->
	<c:if test="${transCnt <= 0 && (!empty rtnContent.STARTTIME ? obj.menuId == rtnContent.MENUID : true) }">
		<button type="button" class="btn  btn_type01" id="btnDelete">삭제</button>
	</c:if>
	<button type="button" class="btn  btn_type01" id="btnList">목록</button>
</div>
<!-- ▲ 버튼 -->
<!-- ▼ 이전글/다음글 -->
<c:if test="${!empty(obj.no1) && obj.no1 < 9000000000 }">    
    <ul class="nextPrev_list">
        <c:forEach items="${rtnFrevNext}" var="FrevNext">
            <c:if test="${!empty(FrevNext)}">
		         <li>
		             <strong><c:out value="${FrevNext.TEXT eq 'F' ? '이전글' : '다음글' }" /></strong>
		             <a href="${contextPath}/mgr/contentMgr/view?${link }&linkId=${FrevNext.LINKID }"><c:out value="${FrevNext.KNAME}" /></a>
		         </li>
            </c:if>
        </c:forEach>
    </ul>
</c:if>
<!-- ▲ 이전글/다음글 -->    
<!-- ▼ 댓글 -->
<c:if test="${rtnSetting.commentYN eq 'Y'}">   
    <div class="reply_write">
        <div class="cmt_title">     
            <h2 class="title">댓글등록</h2>
            <p class="txt">로그인 또는 본인확인 후 작성 가능합니다.</p>
            <p class="float_right"><strong>0</strong>/250</p>
        </div>
        <fieldset>
            <legend>의견입력영역</legend>
            <textarea name="reply_content" id="replyArea" cols="40" rows="5"></textarea>
            <button id="send" class="input_btn" onclick="javascript:gfnReplyInsert($('#replyArea'), '${obj.linkId}')">입력</button>
        </fieldset>
    </div>
    
    <ul class="recmt_list" id="reply">
	    <li><div class="cmt_control"><strong class="cmt_name">test</strong> <span class="date">2014.09.22</span> <span class="btn"><button type="button">수정</button><button type="button">삭제</button></span></div>
	        <p>홈페이지 너무 좋네요.<br/>
	        특히 메인이 좋습니다. 모두 모두 수고 많으셨습니다.<br/>
	        짝짝짝 짝짝짝 짝짝짝 짝짝짝</p>                     
	    </li>
    </ul>
    <!-- ▲ 댓글 -->
</c:if>
	
<dl class="autonomy-person" id="autonomyPerson" style="display: none;">
	<dt>항목세부 담당자</dt>
</dl>
	
<!-- SNS -->
<c:if test="${rtnSetting.snsYN == 'Y' }">
	<div class="float_wrap">
		<ul class="sns_share">
			<li class="twitter"><a href="#" target="_blank" title="새창으로 열림">트위터</a></li>
			<li class="facebook"><a href="#" target="_blank" title="새창으로 열림">페이스북</a></li>
		</ul>
	</div>	
</c:if>

<script type="text/javascript">
$(function() {
	/* 추가 필드 링크 있을 시 */
    if($('#addField1').length > 0){
		var txt = $('#addField1').text();
		
		if(txt.indexOf('http://') != -1){
			$('#addField1').empty();
			$('#addField1').html('<a href="'+txt+'" target="_blank"><img src="/resources/images/common/bbs/btn_url.gif" alt="url 새창"/></a>'
							     + ' <a href="javascript:fnCopy('+"'"+txt+"'"+')"><img src="/resources/images/common/bbs/btn_urlCopy.gif" alt="URL 복사"/></a>');
		}
	}
	if($('#addField2').length > 0){
		var txt = $('#addField2').text();
		
		if(txt.indexOf('http://') != -1){
		    $('#addField2').empty();
		    $('#addField2').html('<a href="'+txt+'" target="_blank"><img src="/resources/images/common/bbs/btn_url.gif" alt="url 새창"/></a>'
				                 + ' <a href="javascript:fnCopy('+"'"+txt+"'"+')"><img src="/resources/images/common/bbs/btn_urlCopy.gif" alt="URL 복사"/></a>');
		}
	}
	if($('#addField3').length > 0){
		var txt = $('#addField3').text();
		
		if(txt.indexOf('http://') != -1){
		    $('#addField3').empty();
		    $('#addField3').html('<a href="'+txt+'" target="_blank"><img src="/resources/images/common/bbs/btn_url.gif" alt="url 새창"/></a>'
				       	         + ' <a href="javascript:fnCopy('+"'"+txt+"'"+')"><img src="/resources/images/common/bbs/btn_urlCopy.gif" alt="URL 복사"/></a>');
		}
	}
	
    /* 
    // 댓글 입력시 글자 수 표시
    $('div.reply_write > .cmt_title > .float_right > strong').text($('#replyArea').val().length);
    */
    
    /* 리플 리스트 */
	gfnReplyList($('#reply'), '${obj.linkId}');
	
	$('#btnSearch').click(function(){
		$('#searchForm').submit();
	}); 
	
	//이미지에 마우스 업로드시 화면 변경
	$('img[name=downImage]').mouseover(function(){
		$('#viewPort').attr("src", $(this).attr('src'));
        $('#viewPort').attr("style", "width:90%;");
	});

	//체크 버튼 클릭
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	// 삭제
    $("#btnDelete").click(function(){
        $("#inCondition").val("삭제");
        
        $("#insertForm").attr('action', '${ctxMgr }/contentMgr/actNoticeBoard');
        $('#insertForm').submit();
    });
	
	//수정
	$('#btnEdit').click(function(){
		document.location.href="${ctxMgr }/contentMgr/form?${link}&linkId=${obj.linkId}";
	});
	
    //목록
	$("#btnList").click(function(){
		document.location.href="${contextPath}/mgr/contentMgr?${link}";
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
    
    //목록
	/* $("#btnEvent").click(function(){
		
		var url = '${contextPath}/mgr/mps/eventMgr/popupForm?titleId=${rtnContent.TITLEID}';
		
		if("${eventId}" == "-1"){
			url = '${contextPath}/mgr/mps/eventMgr/popupForm?titleId=${rtnContent.TITLEID}';
		}else{
			url = '${contextPath}/mgr/mps/eventMgr/popupView?eventId=${eventId}&titleId=${rtnContent.TITLEID}';
		}
		
    	try{win.focus();}catch(e){}
    	win = window.open(url,'event_pop', 'width=800px,height=600px,scrollbars=no,status=no');
	}); */
    
	// 경영공시담당자
	if("${fn:length(rtntAutonomy)}" > 0){
		var cArray = new Array();
		var sArray = new Array();
		var wArray = new Array();
		
		<c:forEach items="${rtntAutonomy}" var="item" varStatus="loop">
			if("${item.MANAGETYPE}" == '01') cArray.push("${item.DUTYNAME}"+" "+"${item.NAME}"+"("+"${item.PHONE}"+" / "+"${item.USERID}"+" / "+"${item.LOGTIME}"+")");
			if("${item.MANAGETYPE}" == '02') sArray.push("${item.DUTYNAME}"+" "+"${item.NAME}"+"("+"${item.PHONE}"+" / "+"${item.USERID}"+" / "+"${item.LOGTIME}"+")");
			if("${item.MANAGETYPE}" == '03') wArray.push("${item.DUTYNAME}"+" "+"${item.NAME}"+"("+"${item.PHONE}"+" / "+"${item.USERID}"+" / "+"${item.LOGTIME}"+")");
		</c:forEach>
		
		$("#autonomyPerson").append('<dd>작성자 : '+wArray+'</dd>');
		$("#autonomyPerson").append('<dd>감독자 : '+sArray+'</dd>');
		$("#autonomyPerson").append('<dd>확인자 : '+cArray+'</dd>');
		
		$("#autonomyPerson").show();
	}
	
});

$(window).load(function(){	
	// SNS 공유하기
	var urlFaceBook = "http://www.facebook.com/sharer.php?u=" + encodeURIComponent("http://210.105.85.4:8080/board/view?menuId=${obj.menuId}&linkId=${obj.linkId }");
	var urlTwitter = "http://twitter.com/share?status=" + encodeURIComponent("http://210.105.85.4:8080/board/view?menuId=${obj.menuId}&linkId=${obj.linkId }");
	$(".facebook a").attr("href", urlFaceBook);
	$(".twitter a").attr("href", urlTwitter);
	
});

</script>
