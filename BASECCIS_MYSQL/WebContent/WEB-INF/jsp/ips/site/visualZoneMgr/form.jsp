<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/visualZoneMgr/act" method="POST">
<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>

<!-- VisualZoneHiddenData -->
<input type="hidden" id="siteId" name="siteId" value="${rtnVisualZone.siteId}"/>
<input type="hidden" id="visualZoneId" name="visualZoneId" value="${rtnVisualZone.visualZoneId}"/>

<!-- BeforeData -->
<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnVisualZone.inBeforeData}"/>

<!--  파일 hidden -->
<input type="hidden" name="imageFileName" id="imageFileName" value="${rtnVisualZone.imageFileName }"/>
<input type="hidden" name="imageSFileName" id="imageSFileName" value="${rtnVisualZone.imageSFileName }"/>
<input type="hidden" name="filePath" id="filePath" value="${rtnVisualZone.filePath }"/>
<input type="hidden" name="fileGubun" id="fileGubun" value="ips"/>

<!-- 목록 이동용 검색조건 모두 표시 -->
<input type="hidden" name="pageNum" value="${param.pageNum }">
<input type="hidden" name="schSiteId" value="${param.schSiteId }">
<input type="hidden" name="schKName" value="${param.schKName }">

<!-- 나모첨부파일 사용경우 START -->
<!-- 파일 정보를 저장할 폼 데이터 -->
<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
<!-- 나모첨부파일 사용경우 END -->

<fieldset>
	<legend>비주얼존 정보 입력</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<table class="tstyle_view">
		<caption>
			사이트 상세 정보 입력
		</caption>
		<colgroup>
			<col class="col-sm-2" />
			<col class="col-sm-4" />
			<col class="col-sm-2" />
			<col class="col-sm-4" />
		</colgroup>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="siteIdSel">사이트</label></th>
			<td colspan="3"><select name="siteIdSel" id="siteIdSel"></select></td>
		</tr>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="KName">비주얼존명</label></th>
			<td colspan="3"><input type="text" id="KName" name="KName" value="${rtnVisualZone.KName}" class="input_mid02" maxlength="40" title="비주얼존제목" /></td>
		</tr>		
		<tr>
			<th scope="row"><span class="point01">*</span> 사용여부</th>
			<td>
				<input name="state" id="stateY" value="T" type="radio" title="사용여부" checked/>
				<label for="stateY">사용</label>
				<input name="state" id="stateN" value="F" type="radio" title="사용여부" />
				<label for="stateN">미사용</label>
			</td>
			<th scope="row"><span class="point01">*</span> <label for="sort">순서</label></th>
			<td><input type="num" id="sort" name="sort" value="${rtnVisualZone.sort}" maxlength="8" title="순서" /></td>
		</tr>
		
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="newWindowYn">새창여부</label></th>
			<td colspan="3">
				<select name="newWindowYn" id="newWindowYn"></select>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="imageUserFileName">이미지</label></th>
			<td colspan="3">
				<c:if test="${!empty rtnVisualZone.imageFileName }">
					<ul class="download_list">
			        	<li><a href="${contextPath}/fileDownload?fileGubun=common&menuId=visualZoneMgr&userFileName=${rtnVisualZone.imageFileName }&systemFileName=${rtnVisualZone.imageSFileName }"><c:out value="${rtnVisualZone.imageFileName }" /> <span>내려받기</span></a></li>
					</ul>
				</c:if>
				<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
		        <div id="flashContentManagerImages" style="display: none;">
		            <p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
		            <script type="text/javascript"> 
		                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
		                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
		                                + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );
		                
		                <c:if test="${!empty(rtnVisualZone.imageFileName)}">
	                 		var strOldImgFileInfo = new Object();
	                 		strOldImgFileInfo.fileId = "${rtnVisualZone.visualZoneId}";
	                        strOldImgFileInfo.fileName = "${rtnVisualZone.imageFileName}";
	                        strOldImgFileInfo.fileSName = "${rtnVisualZone.imageSFileName}";
	                        strOldImgFileInfo.filePath = "${rtnVisualZone.filePath}";
	                        strOldImgFileInfo.fileSize = 0;
	                        strOldImgFileInfoArray.push(strOldImgFileInfo);
		                </c:if>
		            </script> 
		        </div>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="linkURL">링크URL</label></th>
			<td colspan="3">
			<input type="text" name="linkURL" id="linkURL" value="<c:if test="${empty rtnVisualZone.linkURL }">http://</c:if><c:if test="${!empty rtnVisualZone.linkURL }">${rtnVisualZone.linkURL}</c:if>" class="input_long" title="링크URL"/>
			<div>※ 링크URL이 없을 경우 #을 입력하시기 바랍니다.</div>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="KDesc">내용</label></th>
			<td colspan="3"><input type="text" name="KDesc" id="KDesc" value="${rtnVisualZone.KDesc}" class="input_long" title="팝업내용"/></td>
		</tr>
	</table>
</fieldset>
</spform:form>

<div class="btn_area">
		<button type="button" class="btn btn_type02" id="btnSave">저장</button>
		<c:if test="${!empty rtnVisualZone.visualZoneId}">
			<button type="button" class="btn btn_type01" id="btnDelete">삭제</button>
		</c:if>
		<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>

							
<script type="text/javascript">
$(function() {
	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${rtnVisualZone.siteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
	gfnCodeComboList($("#newWindowYn"), "NewWindowYN", "0", "코드 선택", "0"); // 새창여부 코드조회
		$('#newWindowYn').on("change", function() { // 새창여부 이벤트
	});
	
	// 새창 기본세팅
	<c:if test="${!empty rtnVisualZone.visualZoneId }">
		$("#newWindowYn").val("${rtnVisualZone.newWindowYn }").prop("selected", "selected");
	</c:if>
	<c:if test="${empty rtnVisualZone.visualZoneId }">
		$("#newWindowYn").val("N").prop("selected", "selected");
	</c:if>
	
	$("input:radio[name='state']:radio[value='${rtnVisualZone.state}']").attr("checked",true);
	
	// 숫자만입력
	$(".input_Num").keyup(function(){
		if($(this).val().match(/[^0-9]/g) != null){
			alert("숫자만 입력이 가능합니다.");	
			$(this).val( $(this).val().replace(/[^0-9]/g, ''));
		}
	});
	
	$("#btnSave").click(function(){
		if($("#siteIdSel option:selected").val() == "") {
			alert("사이트를 선택하세요.");
			$("#siteIdSel").focus();
			return false;
		}
		if($("#KName").val().length <= 0) {
			alert("비주얼존명을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		if($("#sort").val().length <= 0) {
			alert("순서를 입력하세요.");
			$("#sort").focus();
			return false;
		}
		if(cuManagerImages.getTotalFileCount() == 0 ) {
			alert("이미지를 입력하세요.");
			return false;
		}
		if($("#linkURL").val().length <= 0) {
			alert("링크URL를 입력하세요.");
			$("#linkURL").focus();
			return false;
		}
		if($("#linkURL").val().indexOf("http://") < 0){
			if(!confirm("프로토콜(http://)이 빠지면 링크에 오류가 생길 수 있습니다.\n저장하시겠습니까?")){
				$("#linkURL").focus();
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
			$("#insertForm").attr('action', '${ctxMgr }/visualZoneMgr/act');
			$("#insertForm").submit();
		}else{
			cuManagerImages.startUpload();
		}
		
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr }/visualZoneMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/visualZoneMgr');
		$("#insertForm").submit(); */
		
		location.href="${contextPath}/mgr/visualZoneMgr?${link}";
	});
	
});

$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('IMG'); //파일Init : 이미지만
	// 파일정보파라메타
	actionfrom = $("#insertForm");
	formaction = "${ctxMgr}/visualZoneMgr/act";
    filePath = "${contextPath}/namoFileUpload?fileGubun=common&fileMenuId=visualZoneMgr";
	fileMaxSize = 5120 * 1024 * 1024 * 10;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = 1;
	/*나모 End*/
});

</script>
