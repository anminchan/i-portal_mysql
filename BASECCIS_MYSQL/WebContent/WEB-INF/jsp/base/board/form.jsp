<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<spform:form id="insertForm" name="insertForm" action="${contextPath }/board/actBoard" method="post">
	<input type="hidden" id="link" name="link" value="${link }" />
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnSetting.boardId) ? rtnSetting.boardId : '-' }" />
	
	<!-- 나모첨부파일 사용경우 START -->
	<!-- 파일 정보를 저장할 폼 데이터 -->
	<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
	<!-- 나모첨부파일 사용경우 END -->
	
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
	
	<c:if test="${fn:split(obj.inDMLUserId, '@')[0] == 'guest' and USER.kind eq 'N'}">
	<input type="hidden" id="guestName" name="guestName" value="${USER.userName }" />
	<input type="hidden" id="key1" name="key1" value="-" />
	<input type="hidden" id="key2" name="key2" value="-" />
	<input type="hidden" id="key3" name="key3" value="-" />
	<input type="hidden" id="dKey" name="dKey" value="${USER.dKey }" />
	</c:if>
	<input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
	<input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" readonly="readonly" />
        
	<input type="hidden" id="noticeYN" name="noticeYN" value="N" />
	<input type="hidden" id="openYN" name="openYN" value="Y" />
	<input type="hidden" id="KHtml" name="KHtml" value="" />
    		                        
	<fieldset>
		<legend>상세등록</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<div class="table">
			<table class="tstyle_view" >
				<caption>
				 게시판 등록/수정 기능 으로 제목, 등록자, 키워드, <c:if test="${rtnSetting.categoryYN == 'Y' }">카테고리,</c:if><c:if test="${rtnSetting.secretYN == 'Y' }">비밀글,</c:if> <c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }"><c:out value="${rtnSetting.addField1}" />,</c:if><c:if test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }"><c:out value="${rtnSetting.addField2}" />,</c:if><c:if test="${!empty(rtnSetting.addField3) && fn:length(rtnSetting.addField3) > 0 && rtnSetting.addField3 != '-' }"><c:out value="${rtnSetting.addField3}" />,</c:if><c:if test="${rtnSetting.boardKind ne 'LINK' }">내용, 첨부파일</c:if> 등록
				</caption>
				<colgroup>
					<col class="col-sm-3"/>
		            <col />
				</colgroup>	
				<tbody>
					<tr>
						<th scope="row"><span class="point01_bold">*</span> <label for="KName">제목</label></th>
						<td colspan="3">
	                    <c:choose>
				            <c:when test="${!empty(rtnContent.STARTTIME)}">
							<!-- 글 수정 -->
	                        <input type="text" id="KName" name="KName" value="${rtnContent.KNAME }" class="input_long"/>
	                        </c:when>
	                        <c:otherwise>
							<!-- 글 입력/답글 -->
	                        <input type="text" id="KName" name="KName" value="${title}" class="input_long"/>
	                        </c:otherwise>
	                    </c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01_bold">*</span> <label for="">등록자</label></th>
						<td colspan="3">
							<c:choose>  
								<c:when test="${USER.kind eq 'C'}">
									<!-- 회사이름등록자 -->
		                        	<c:out value="${companyUserName.chargeName}"/>
		                        </c:when>
		                        <c:otherwise>
		                        	<c:out value="${!empty(rtnContent.USERNAME) ? rtnContent.USERNAME : USER.userName  }" />
		                        </c:otherwise>
	                        </c:choose>
						</td>
					</tr>
					<%-- <tr>
						<th scope="row">키워드</th>
						<td colspan="3">                        
							<input type="text" id="keyword1" name="keyword1" title="키워드1 입력" value="${rtnContent.KEYWORD1}" />
	                        <input type="text" id="keyword2" name="keyword2" title="키워드2 입력" value="${rtnContent.KEYWORD2}" />
	                        <input type="text" id="keyword3" name="keyword3" title="키워드3 입력" value="${rtnContent.KEYWORD3}" />
	                        <input type="text" id="keyword4" name="keyword4" title="키워드4 입력" value="${rtnContent.KEYWORD4}" />
	                        <input type="text" id="keyword5" name="keyword5" title="키워드5 입력" value="${rtnContent.KEYWORD5}" />
	                        <input type="text" id="keyword6" name="keyword6" title="키워드6 입력" value="${rtnContent.KEYWORD6}" />
	                        <input type="text" id="keyword7" name="keyword7" title="키워드7 입력" value="${rtnContent.KEYWORD7}" />
	                        <input type="text" id="keyword8" name="keyword8" title="키워드8 입력" value="${rtnContent.KEYWORD8}" />
	                        <input type="text" id="keyword9" name="keyword9" title="키워드9 입력" value="${rtnContent.KEYWORD9}" />
	                        <input type="text" id="keyword10" name="keyword10" title="키워드10 입력" value="${rtnContent.KEYWORD10}" />
						</td>
					</tr> --%>
	                <%-- <tr>
	                    <th scope="row"><label for="name">공개여부</label></th>
	                    <td colspan="3">
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
	                </tr> --%>
	                
					<c:if test="${rtnSetting.categoryYN == 'Y' }">
						<tr>
						    <th scope="row"><label for="categoryId">카테고리</label></th>
						    <td colspan="3">
						        <select id="categoryId" name="categoryId">
						        </select>
						    </td>
						</tr>
					</c:if>
					
					<!-- ▼ 비밀글유무 -->
	                <c:if test="${rtnSetting.secretYN == 'Y' }">
		                <tr>
		                    <th scope="row"><span class="point01_bold">*</span> <label for="secretTitleYN">비밀글</label></th>
		                    <td colspan="3">
		                    	<input type="radio" id="secretTitleY" name="secretTitleYN" value="Y" ${rtnContent.SECRETTITLEYN == 'Y' ? 'checked="checked"' : ''} <c:if test="${empty rtnContent.SECRETTITLEYN}">checked="checked"</c:if> />
		                        <label for="secretTitleY">적용</label>
		                        <input type="radio" id="secretTitleN" name="secretTitleYN" value="N" ${rtnContent.SECRETTITLEYN == 'N' ? 'checked="checked"' : ''} />
		                        <label for="secretTitleN">미적용</label>
		                    </td>
		                </tr>
	                </c:if>
	                
	                <!-- ▼ 국가필드유무 -->
	                <c:if test="${rtnSetting.countryYN == 'Y' }">
	                <tr>
	                    <th scope="row">국가정보</th>
	                    <td colspan="3" id="tdCountry">
	                    	<select id="continent" name="continent" title="대륙 선택">
	                    		<option>대륙 선택</option>
	                    	</select>
	                        <select id="country" name="country" class="selCountry" title="국가 선택">
	                      		<option>국가 선택</option>
	                        </select>
	                    </td>
	                </tr>
	                </c:if>
	                
	                <!-- // 추가 필드가 있을 시 -->
	                <c:if test="${!empty(rtnSetting.addField1) }">
		                <tr>
		                    <th scope="row"><label for="contents1"><c:out value="${rtnSetting.addField1}" /></label></th>
		                    <td colspan="3">
								<input type="text" id="contents1" name="contents1" maxlength="42" value="${rtnContent.CONTENTS1 }" class="input_long" />
		                    </td>
		                </tr>
	                </c:if>
	                
	                <c:if test="${!empty(rtnSetting.addField2) }">
	                	<tr>
	                    	<th scope="row"> <label for="contents2"><c:out value="${rtnSetting.addField2}" /></label></th>
	                    	<td colspan="3">
		                		<input type="text" id="contents2" name="contents2" maxlength="42" value="${rtnContent.CONTENTS2 }" class="input_long" />
	               	 		</td>
	               		</tr>
	                </c:if>
	                
	                <c:if test="${!empty(rtnSetting.addField3) }">
		                <tr>
		                    <th scope="row"><label for="contents3"><c:out value="${rtnSetting.addField3}" /></label></th>
		                    <td colspan="3">
	                   			<input type="text" id="contents3" name="contents3" maxlength="42" value="${rtnContent.CONTENTS3 }" class="input_long" />
		                    </td>
		                </tr>
	                </c:if>
	                
	                <c:if test="${!empty(rtnSetting.addField4) }">
	                <tr>
	                    <th scope="row"><label for="contents4"><c:out value="${rtnSetting.addField4}" /></label></th>
	                    <td colspan="3"><input type="text" id="contents4" name="contents4" value="<fmt:formatDate value="${rtnContent.CONTENTS4 }" pattern="yyyy-MM-dd"/>" /></td>
	                </tr>
	                </c:if>
	                
	                <c:if test="${!empty(rtnSetting.addField5) }">
	                <tr>
	                    <th scope="row"><label for="contents5"><c:out value="${rtnSetting.addField5}" /></label></th>
	                    <td colspan="3"><input type="text" id="contents5" name="contents5" value="<fmt:formatDate value="${rtnContent.CONTENTS5 }" pattern="yyyy-MM-dd"/>" /></td>
	                </tr>
	                </c:if>
	                
	                <c:if test="${!empty(rtnSetting.addField6) }">
	                <tr>
	                    <th scope="row"><label for="contents6"><c:out value="${rtnSetting.addField6}" /></label></th>
	                    <td colspan="3"><input type="text" id="contents6" name="contents6" value="<fmt:formatDate value="${rtnContent.CONTENTS6 }" pattern="yyyy-MM-dd"/>" /></td>
	                </tr>
	                </c:if>
	                
	                <!-- // 추가 필드가 있을 시 -->
	                <c:if test="${rtnSetting.boardKind eq 'LINK' }"><%//링크형게시판 : 내용, 첨부파일 사용안함, url 사용 %>
		                <tr>
		                    <th scope="row"><span class="point01">*</span>링크 URL</th>
		                    <td colspan="3"><input type="text" id="linkUrl" name="linkUrl" class="input_long" maxlength="200" value="${rtnContent.LINKURL }" /></td>                    
		                </tr>
	                </c:if>
	                <c:if test="${rtnSetting.boardKind ne 'LINK' }"><%//링크형게시판 이외 : 내용, 첨부파일 사용%>
						<tr>
							<th scope="row"><span class="point01_bold">*</span> 내용</th>
							<td colspan="3">
								<textarea name="KHtmlTextArea" id="KHtmlTextArea" cols="45" rows="5" class="txtarea" title="내용 입력" ><c:out value="${fn:replace(rtnContent.KHTML, '<br/>', newLine) }" escapeXml="false" /></textarea>
							</td>
						</tr>
						<!-- ▼ 파일 업로드 에디터  -->    
		                <tr>
			                <th scope="row">첨부파일</th>
			                <td colspan="3">
						        <!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
						        <div id="flashContentManager" style="display: none;">
						            <p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
						            <script type="text/javascript"> 
						                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
						                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
						                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );
						                
						                <c:if test="${!empty(rtnFileList) && fn:length(rtnFileList) > 0 }">
						                	<c:forEach items="${rtnFileList }" var="fileList" varStatus="status">
				                         		var strOldFileInfo = new Object();
				                         		strOldFileInfo.fileId = "board@@${param.menuId}@@${fileList.SYSTEMFILENAME}@@${fileList.FILEID}@@${fileList.FILEPATH}";
				                                strOldFileInfo.fileName = "${fileList.USERFILENAME}";
				                                strOldFileInfo.fileSName = "${fileList.SYSTEMFILENAME}";
				                                strOldFileInfo.filePath = "${fileList.FILEPATH}";
				                                strOldFileInfo.fileSize = ${fileList.FILESIZE};
				                                strOldFileInfoArray.push(strOldFileInfo);
			                                </c:forEach>
						                </c:if>
						            </script> 
						        </div>
						        <!-- NamoCrossUploader의 Monitor 객체가 위치할 HTML Id와 Monitor Layer Id-->
								<div id="monitorLayer" style="display: none;">
									<div id="flashContentMonitor" style="display:none;"></div>
								</div>
								<!-- NamoCrossUploader의 Monitor 창이 출력될 때 화면의 백그라운드 Layer Id -->
								<div id="monitorBgLayer" style="display: none;"></div>
			                </td>
			            </tr>
						<!-- ▲ 파일 업로드 에디터  -->
	                </c:if>
				</tbody>
			</table>
		</div>
	</fieldset>
</spform:form>

<!-- ▼ 버튼 -->
<div class="btn_area">
		<c:if test="${ADMIN eq 'T' or WRITE eq 'T' or USER.userId eq rtnContent.USERID}"><%//관리권한, 등록권한, 본인글 %>
			<button type="button" class="btn_type01" id="btnSave">저장</button>	
		</c:if>
		<c:if test="${ADMIN eq 'T' or DELETE eq 'T' or USER.userId eq rtnContent.USERID}"><%//관리권한, 삭제권한, 본인글 %>
			<c:if test="${!empty(rtnContent.linkId) }">
				<button type="button" class="btn_type02" id="btnDelete">삭제</button>	
			</c:if>
		</c:if>
		<button type="button" class="btn_type02" id="btnCancel">취소</button>
</div>
<!-- ▲ 버튼 -->

<script type="text/javascript">
$(function() {
	//입력시 달력 기본 셋팅
	$('#startTime').val('<fmt:formatDate value="${DATE }" pattern="yyyy-MM-dd"/>');
	$('#endTime').val(<fmt:formatDate value="${DATE }" pattern="yyyy"/>+10+'<fmt:formatDate value="${DATE }" pattern="-MM-dd"/>');

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
		if($.trim($("#KName").val()) == null || $.trim($("#KName").val()) == ""){
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
		
        <c:if test="${rtnSetting.boardKind eq 'LINK' }">
	        //링크형게시판 : url 필수 체크
			if($.trim($("#linkUrl").val()) == null || $.trim($("#linkUrl").val()) == ""){
				alert("링크 URL을 입력하세요");
				return true;
			}
		</c:if>
		
		$("#KHtml").val($("#KHtmlTextArea").val().replace(/\n/g, "<br/>"));
		
		// 유해어 검출 스크립트
 		if(gfnTabooWordCheck('KName§§KHtml')[1] > 0){
 			alert(gfnTabooWordCheck('KName§§KHtml')[0]);
 			return false;
 		}
		
		if(!confirm("저장하시겠습니까?")) {
			return false;
		}

		<c:if test="${rtnSetting.boardKind ne 'LINK' }">
			// 전송할 파일이 없으면 바로 폼데이터를 전송하고, 전송할 파일이 있으면 파일을 먼저 전송한다.
			if(cuManager.getTotalFileCount() == 0){
				$("#insertForm").submit();
			}else{
				cuManager.startUpload();
			}
		</c:if>
		
	    <c:if test="${rtnSetting.boardKind eq 'LINK' }">
	        //링크형게시판 : 파일 업로드가 없어서 submit 으로 
			$("#insertForm").submit();
		</c:if>
		
	});

	// 삭제
	$("#btnDelete").click(function(){
    	if(!confirm("삭제하시겠습니까?")){
    		return;
    	}
    	
		$("#inCondition").val("삭제");
		$('#insertForm').submit();
	});
	
	//취소
	$("#btnCancel").click(function(){
		if('${obj.linkId}' != null && '${obj.linkId}' != '0'){
		    document.location.href="${contextPath}/board/view?${link}&linkId=${obj.linkId}";
		}else {
		    document.location.href="${contextPath}/board?${link}";
		}
	});
	
	$( "#contents4" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif",
        onClose: function( selectedDate ) { 
			(this).focus();
		}
    });
    
    $( "#contents5" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif",
        onClose: function( selectedDate ) { 
			(this).focus();
		}
    });
    
    $( "#contents6" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif",
        onClose: function( selectedDate ) { 
			(this).focus();
		}
    });
	
});

$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('BASE'); //파일Init : 대표이미지, 첨부파일
	// 파일정보파라메타
	actionfrom = $("#insertForm");
	formaction = "${contextPath }/board/actBoard";
	filePath = "${contextPath }/namoFileUpload?fileGubun=board&fileMenuId=${param.menuId}";
	fileMaxSize = "${rtnSetting.fileMaxSize}" * 1024 * 1024 * 10;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = "${rtnSetting.fileMaxCount}";
	/*나모 End*/
});

</script>
