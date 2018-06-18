<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/familySiteMgr/act" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<!-- FamilySiteHiddenData -->
	<input type="hidden" id="siteId" name="siteId" value="${rtnFamilySite.siteId}"/>
	<input type="hidden" id="siteLinkId" name="siteLinkId" value="${rtnFamilySite.siteLinkId}"/>
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnFamilySite.inBeforeData}"/>
	<!-- 목록 이동용 검색조건 모두 표시 -->
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<input type="hidden" name="schSiteId" value="${param.schSiteId }">
	<input type="hidden" name="schKName" value="${param.schKName }">
	
	<fieldset>
	<legend>추천사이트 정보 입력</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<div class="table">	
		<table class="tstyle_view">
			<caption>
				사이트 상세 정보 입력
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
				<th scope="row"><span class="point01">*</span> <label for="KName">추천사이트명</label></th>
				<td><input type="text" id="KName" name="KName" value="${rtnFamilySite.KName}" class="input_mid02" maxlength="30" title="추천사이트명" /></td>
			</tr>		
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="state">사용여부</label></th>
				<td>
					<input name="state" id="stateY" value="T" type="radio" title="사용여부" checked/>
					<label for="stateY">사용</label>
					<input name="state" id="stateN" value="F" type="radio" title="사용여부" />
					<label for="stateN">미사용</label>
				</td>
			</tr>	
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="sort">순서</label></th>
				<td><input type="text" id="sort" name="sort" value="${rtnFamilySite.sort}" class="input_Num" maxlength="8" title="순서" /></td>
			</tr>			
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="newWindowYn">새창여부</label></th>
				<td>
					<select name="newWindowYn" id="newWindowYn"></select>
				</td>
			</tr>	
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="linkURL">링크URL</label></th>
				<td><input type="text" name="linkURL" id="linkURL" value="<c:if test="${empty rtnFamilySite.linkURL }">http://</c:if><c:if test="${!empty rtnFamilySite.linkURL }">${rtnFamilySite.linkURL}</c:if>" class="input_long" title="링크URL"/></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="KDesc">내용(대체텍스트)</label></th>
				<td><input type="text" name="KDesc" id="KDesc" value="${rtnFamilySite.KDesc}" class="input_long" title="대체텍스트 입력"/></td>
			</tr>
			</tbody>
		</table>
	</div>
	</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
	<c:if test="${!empty rtnFamilySite.siteLinkId}">
		<button type="button" class="btn btn_type01" id="btnDelete">삭제</button>
	</c:if>
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>

							
<script type="text/javascript">
$(function() {

	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${rtnFamilySite.siteId}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
	gfnCodeComboList($("#newWindowYn"), "NewWindowYN", "0", "코드 선택", "0"); // 새창여부 코드조회
	$('#newWindowYn').on("change", function() { // 새창여부 이벤트
		
	});
	
	// 새창 기본세팅
	<c:if test="${!empty rtnFamilySite.siteLinkId }">
		$("#newWindowYn").val("${rtnFamilySite.newWindowYn }").prop("selected", "selected");
	</c:if>
	<c:if test="${empty rtnFamilySite.siteLinkId }">
		$("#newWindowYn").val("N").prop("selected", "selected");
	</c:if>
	
	$("input:radio[name='state']:radio[value='${rtnFamilySite.state}']").attr("checked",true);
	
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
			alert("추천사이트명을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		if($("#sort").val().length <= 0) {
			alert("순서를 입력하세요.");
			$("#sort").focus();
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

		$("#insertForm").attr('action', '${ctxMgr }/familySiteMgr/act');
		$("#insertForm").submit();
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr }/familySiteMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/familySiteMgr');
		$("#insertForm").submit(); */
		
		location.href="${contextPath}/mgr/familySiteMgr?${link}";
	});
	
});

</script>
