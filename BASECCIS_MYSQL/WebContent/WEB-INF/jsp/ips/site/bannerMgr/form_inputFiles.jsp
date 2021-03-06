<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/bannerMgr/act" method="POST" enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>	
	<!-- BannerHiddenData -->
	<input type="hidden" id="siteId" name="siteId" value="${rtnBanner.siteId}"/>
	<input type="hidden" id="bannerId" name="bannerId" value="${rtnBanner.bannerId}"/>	
	<!-- BeforeData -->
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnBanner.inBeforeData}"/>	
	<!--  파일 hidden -->
	<input type="hidden" name="imageFileName" id="imageFileName" value="${rtnBanner.imageFileName }"/>
	<input type="hidden" name="imageSFileName" id="imageSFileName" value="${rtnBanner.imageSFileName }"/>
	<input type="hidden" name="filePath" id="filePath" value="${rtnBanner.filePath }"/>
	<input type="hidden" name="fileGubun" id="fileGubun" value="ips"/>	
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schSiteId" value="${param.schSiteId }">
	<input type="hidden" name="schKName" value="${param.schKName }">
	
	<fieldset>
		<legend>베너 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<div class="table">
			<table class="tstyle_view">
				<caption>
					배너등록 - 사이트, 배너명, 사용여부, 순서, 새창여부, 이미지, 링크URL, 내용 입력
				</caption>
				<colgroup>
	                <col class="col-sm-2"/>
					<col class="col-sm-10"/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="siteIdSel">사이트</label></th>
						<td><select name="siteIdSel" id="siteIdSel"></select></td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="KName">배너명</label></th>
						<td><input type="text" id="KName" name="KName" value="${rtnBanner.KName}" class="input_mid02" maxlength="40" title="베너제목" /></td>
					</tr>		
					<tr>
						<th scope="row"><span class="point01">*</span> 사용여부</th>
						<td>
							<input name="state" id="stateY" value="T" type="radio" title="사용여부" checked/>
							<label for="stateY">사용</label>
							<input name="state" id="stateN" value="F" type="radio" title="사용여부" />
							<label for="stateN">미사용</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="sort">순서</label></th>
						<td><input type="number" id="sort" name="sort" value="${rtnBanner.sort}" maxlength="8" title="순서" /></td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="newWindowYn">새창여부</label></th>
						<td><select name="newWindowYn" id="newWindowYn">
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> 이미지</th>
						<td colspan="3">
							<c:if test="${!empty(rtnBanner.imageFileName) && rtnBanner.imageFileName ne '-' }">
		                		<input type="hidden" name="fileImgId" id="fileImgId" value="${rtnBanner.imageFileName}@@${rtnBanner.imageSFileName}@@0@@${rtnBanner.filePath}@@img" />
		                		<div id="fileView" style="margin-bottom: 10px;">
		                			${rtnBanner.imageFileName}
	                              	<a href="${contextPath}/fileDownload?fileGubun=common&menuId=bannerMgr&userFileName=${rtnBanner.imageFileName }&systemFileName=${rtnBanner.imageSFileName }">
	                              		<i class="xi-download"></i>
                              		</a>
							  	</div>
			                </c:if>
							<input type="file" id="fileImg_upload" name="fileImg_upload" class="input_mid" accept="image/*" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="linkURL">링크URL</label></th>
						<td>
							<input type="text" name="linkURL" id="linkURL" value="<c:if test="${empty rtnBanner.linkURL }">http://</c:if><c:if test="${!empty rtnBanner.linkURL }">${rtnBanner.linkURL}</c:if>" class="input_long" title="링크URL"/>
							<p>※ 링크URL이 없을 경우 #을 입력하시기 바랍니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="point01">*</span> <label for="KDesc">내용(대체텍스트)</label></th>
						<td><input type="text" name="KDesc" id="KDesc" value="${rtnBanner.KDesc}" class="input_long" title="대체텍스트 입력"/></td>
					</tr>			
				</tbody>
			</table>
		</div>
	</fieldset>
	<div class="btn_area">
		<button type="button"  id="btnSave" class="btn btn_type02">저장</button>
		<c:if test="${!empty rtnBanner.bannerId}">
			<button type="button" id="btnDelete" class="btn btn_type01">삭제</button>
		</c:if>
		<button type="button" id="btnList" class="btn btn_type01">목록</button>
	</div>
</spform:form>

							
<script type="text/javascript">
$(function() {
	
	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${rtnBanner.siteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
	gfnCodeComboList($("#newWindowYn"), "NewWindowYN", "0", "코드 선택", "0"); // 새창여부 코드조회
	$('#newWindowYn').on("change", function() { // 새창여부 이벤트
		
	});
	
	// 새창 기본세팅
	<c:if test="${!empty rtnBanner.bannerId }">
		$("#newWindowYn").val("${rtnBanner.newWindowYn }").prop("selected", "selected");
	</c:if>
	<c:if test="${empty rtnBanner.bannerId }">
		$("#newWindowYn").val("N").prop("selected", "selected");
	</c:if>
	
	$("input:radio[name='state']:radio[value='${rtnBanner.state}']").attr("checked",true);
	
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
			alert("베너명을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		if($("#sort").val().length <= 0) {
			alert("순서를 입력하세요.");
			$("#sort").focus();
			return false;
		}
		if($("#fileImg_upload").val() == "" && ($("#fileImgId").val() == undefined || $("#fileImgId").val() == "")){
			alert("이미지 첨부파일을 하나 이상 등록하세요.");
			$("#file_upload").focus();
			return true;
 		}
 		
 		if($("#fileImg_upload").val() != ""){
			var thumbext = document.getElementById('fileImg_upload').value; //파일을 추가한 input 박스의 값
			thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
	
			if(thumbext != "jpg" && thumbext != "png" &&  thumbext != "gif" &&  thumbext != "bmp"){ //확장자를 확인합니다.
				alert('썸네일은 이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
				$("#file_upload").focus();
				return;
			}
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

		$("#insertForm").attr('action', '${ctxMgr }/bannerMgr/act');
		$("#insertForm").submit();
		
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('enctype', '');
		$("#insertForm").attr('action', '${ctxMgr }/bannerMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/bannerMgr');
		$("#insertForm").submit(); */
		
		location.href="${contextPath}/mgr/bannerMgr?${link}";
	});
	
});

</script>
