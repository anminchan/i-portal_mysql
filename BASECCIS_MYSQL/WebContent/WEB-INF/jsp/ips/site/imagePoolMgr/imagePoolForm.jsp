<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/imagePoolMgr/act" method="POST">
<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
<input type="hidden" id="state" name="state" value="${empty rtnImagePool.state ? 'T' : rtnImagePool.state }"/>

<!-- ImagePoolHiddenData -->
<input type="hidden" id="siteId" name="siteId" value="${rtnImagePool.siteId}"/>
<input type="hidden" id="imagePoolId" name="imagePoolId" value="${rtnImagePool.imagePoolId}"/>

<!-- BeforeData -->
<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnImagePool.inBeforeData}"/>

<!-- 목록 이동용 검색조건 모두 표시 -->
<input type="hidden" name="pageNum" value="${param.pageNum}">
<input type="hidden" name="schSiteId" value="${param.schSiteId}">
<input type="hidden" name="schType" value="${param.schType}">
<input type="hidden" name="schText" value="${param.schText}">

<!-- 나모첨부파일 사용경우 START -->
<!-- 파일 정보를 저장할 폼 데이터 -->
<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
<!-- 나모첨부파일 사용경우 END -->

<fieldset>
	<legend>이미지풀정보 입력</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<table class="tstyle_view">
		<caption>
			이미지명, 이미지경로, 내용, 키워드에 따른 게시물상세 안내
		</caption>
		<colgroup>		
			<col class="col-sm-2"/>
			<col class="col-sm-4"/>
			<col class="col-sm-2"/>
			<col class="col-sm-4"/>
		</colgroup>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="KName">이미지명</label></th>
			<td colspan="3"><input type="text" id="KName" name="KName" value="${rtnImagePool.KName}" class="input_mid02" maxlength="40" title="이미지제목" /></td>
		</tr>		
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="imageUserFileName">이미지</label></th>
			<td colspan="3">
				<c:if test="${!empty rtnImagePool.imageFileName }">
					<ul class="download_list">
			        	<li><a href="${contextPath}/fileDownload?fileGubun=common&menuId=imagePoolMgr&userFileName=${rtnImagePool.imageFileName }&systemFileName=${rtnImagePool.imageSFileName }"><c:out value="${rtnImagePool.imageFileName }" /> <span>내려받기</span></a></li>
					</ul>
				</c:if>
				<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
		        <div id="flashContentManagerImages" style="display: none;">
		            <p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
		            <script type="text/javascript"> 
		                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
		                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
		                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );
		                
		                <c:if test="${!empty(rtnImagePool.imageFileName)}">
                 		var strOldImgFileInfo = new Object();
                 		strOldImgFileInfo.fileId = "${rtnImagePool.imagePoolId}";
                        strOldImgFileInfo.fileName = "${rtnImagePool.imageFileName}";
                        strOldImgFileInfo.fileSName = "${rtnImagePool.imageSFileName}";
                        strOldImgFileInfo.filePath = "${rtnImagePool.filePath}";
                        strOldImgFileInfo.fileSize = 0;
                        strOldImgFileInfoArray.push(strOldImgFileInfo);
	                </c:if>
		            </script> 
		        </div>
			</td>
		</tr>
		<%-- <tr>
			<th scope="row"><span class="point01">*</span> <label for="keyword">키워드</label></th>
			<td>
				<input type="text" id="keyword1" name="keyword1" value="${rtnImagePool.keyword1}" class="input_nomal" title="키워드1" />
				<input type="text" id="keyword2" name="keyword2" value="${rtnImagePool.keyword2}" class="input_nomal" title="키워드2" />
				<input type="text" id="keyword3" name="keyword3" value="${rtnImagePool.keyword3}" class="input_nomal" title="키워드3" />
				<input type="text" id="keyword4" name="keyword4" value="${rtnImagePool.keyword4}" class="input_nomal" title="키워드4" />
				<input type="text" id="keyword5" name="keyword5" value="${rtnImagePool.keyword5}" class="input_nomal" title="키워드5" />
			</td>
		</tr> --%>	
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="KDesc">내용</label></th>
			<td colspan="3"><input type="text" name="KDesc" id="KDesc" value="${rtnImagePool.KDesc}" class="input_long" title="이미지내용"/></td>
		</tr>
	</table>
</fieldset>
</spform:form>

<div class="btn_area_form">
	<span class="float_right">
		<button type="button" class="btn_colorType01 ${!empty rtnImagePool.imagePoolId ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
		<c:if test="${!empty rtnImagePool.imagePoolId}">
		<button type="button" class="btn_colorType01 roleDELETE" id="btnDelete">삭제</button>
		</c:if>
		<button type="button" class="btn_colorType01" id="btnList">목록</button>
	</span>
</div>

							
<script type="text/javascript">
$(function() {
	$("input:radio[name='state']:radio[value='${rtnImagePool.state}']").attr("checked",true);

	$("#btnSave").click(function(){
		if($("#KName").val().length <= 0) {
			alert("이미지명을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		if($("#divFileView >span").length <= 0){
			if($("#imageUserFileName").val().length <= 0) {
				alert("이미지를 입력하세요.");
				$("#imageUserFileName").focus();
				return false;
			}
		}
		if($("#KDesc").val().length <= 0) {
			alert("내용을 입력하세요.");
			$("#KDesc").focus();
			return false;
		}
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}

		// 전송할 파일이 없으면 바로 폼데이터를 전송하고, 전송할 파일이 있으면 파일을 먼저 전송한다.
		if(cuManagerImages.getTotalFileCount() == 0){
			$("#insertForm").attr('action', '${ctxMgr }/imagePoolMgr/act');
			$("#insertForm").submit();
		}else{
			cuManagerImages.startUpload();
		}
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr }/imagePoolMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/imagePoolMgr');
		$("#insertForm").submit(); */
		
		location.href="${contextPath}/mgr/imagePoolMgr?${link}";
	});
	
});

$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('IMG'); //파일Init : 이미지만
	// 파일정보파라메타
	actionfrom = $("#insertForm");
	formaction = "${ctxMgr}/imagePoolMgr/act";
    filePath = "${contextPath}/namoFileUpload?fileGubun=common&fileMenuId=imagePoolMgr";
	fileMaxSize = 5120 * 1024 * 1024 * 10;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = 1;
	/*나모 End*/
	
});

</script>

