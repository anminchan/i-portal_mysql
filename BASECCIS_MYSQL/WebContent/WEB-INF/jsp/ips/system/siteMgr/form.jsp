<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/siteMgr/act" method="post">
<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
<input type="hidden" id="paramSiteId" name="paramSiteId" value="${rtnSite.siteId}"/>
<input type="hidden" id="state" name="state" value="${empty rtnSite.state ? 'T' : rtnSite.state}"/>
<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnSite.inBeforeData}"/>

<input type="hidden" name="siteLanguage" value="K">
<input type="hidden" name="siteType" value="S">

<!-- 목록 이동용 검색조건 모두 표시 -->
<input type="hidden" name="pageNum" value="${param.pageNum }">
<input type="hidden" name="schType" value="${param.schType }">
<input type="hidden" name="schText" value="${param.schText }">	

<fieldset>
	<legend>사이트 정보 입력</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<div class="table">
		<table class="tstyle_view">
			<caption>
				사이트 상세 정보 입력(등록일, 이름, 이메일, 담당부서, 제목, 내용)
			</caption>
			<colgroup>
				<col class="col-sm-2"/>
				<col class="col-sm-10" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="siteId">사이트ID</label></th>
					<td>
						<c:if test="${empty rtnSite.siteId}">자동생성</c:if>
						<c:if test="${!empty rtnSite.siteId}">${rtnSite.siteId}</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="siteKey">사이트구분</label></th>
					<td><input type="text" name="siteKey" id="siteKey" value="${rtnSite.siteKey}" title="각 사이트에 고유키값이 됩니다.(사이트폴더구조/서버Class구조)" class="tooltipsy" maxlength="5" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="KName">사이트명</label></th>
					<td><input type="text" id="KName" name="KName" value="${rtnSite.KName}" class="input_long" maxlength="30" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="url">사이트URL</label></th>
					<td><input type="text" id="url" name="url" value="${rtnSite.url}" class="input_long" maxlength="30" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="ip">사이트IP</label></th>
					<td><input type="text" id="ip" name="ip" value="${rtnSite.ip}" class="input_long" maxlength="20" /></td>
				</tr>
				<%-- <tr>
					<th scope="row"><span class="point01">*</span> <label for="sourcePath">소스경로</label></th>
					<td><input type="text" id="sourcePath" name="sourcePath" value="${rtnSite.sourcePath}" class="input_long" title="사이트URL" /></td>
				</tr> 
				<tr>
					<th scope="row"><label for="subject">사이트언어</label></th>
					<td>
						<select name="siteLanguage" id="siteLanguage" title="사이트언어">
							<option value="K" <c:if test="${rtnSite.siteLanguage == 'K' }">selected</c:if>>한글</option>
							<option value="E" <c:if test="${rtnSite.siteLanguage == 'E' }">selected</c:if>>영문</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="subject">사이트유형</label></th>
					<td>
						<input name="siteType" id="siteTypeS" value="S" type="radio" title="정적사이트" checked/>
						<label for="siteTypeS">정적사이트</label>
						<input name="siteType" id="siteTypeM" value="M" type="radio" title="모바일"/>
						<label for="siteTypeM">모바일</label>
					</td>
				</tr> --%>
				<tr>
					<th scope="row"><label for="KDesc">사이트설명</label></th>
					<td><input type="text" name="KDesc" id="KDesc" value="${rtnSite.KDesc}" class="input_long"/></td>
				</tr>
			</tbody>
		</table>
	</div>
</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button"  id="btnSave" class="btn btn_type02 ${!empty rtnSite.siteId ? 'roleMODIFY' : 'roleWRITE'}">저장</button>
	<c:if test="${!empty rtnSite.siteId}">
	<button type="button" id="btnDelete" class="btn btn_type01">삭제</button>
	</c:if>
	<button type="button" id="btnList" class="btn btn_type01">목록</button>
</div>

							
<script type="text/javascript">
$(function() {
	
	$("#btnSave").click(function(){
		if($("#KName").val().length <= 0) {
			alert("사이트명을 입력하세요");
			$("#KName").focus();
			return false;
		}
		if($("#url").val().length <= 0) {
			alert("사이트URL을 입력하세요");
			$("#url").focus();
			return false;
		}
		if($("#ip").val().length <= 0) {
			alert("사이트IP를 입력하세요");
			$("#ip").focus();
			return false;
		}
		/* if($("#sourcePath").val().length <= 0) {
			alert("소스경로를 입력하세요");
			$("#sourcePath").focus();
			return false;
		} */
		
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr }/siteMgr/act');
		$("#insertForm").submit();
		
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr }/siteMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		$("#insertForm").attr('action', '${ctxMgr }/siteMgr');
		$("#insertForm").submit();
	});
	
	$("#siteKey").keyup(function(){
		var text = $(this).val();
		var numUnicode = text.charCodeAt(0);
		if((44032 <= numUnicode && numUnicode <= 55203) || (12593 <= numUnicode && numUnicode <= 12643) || ($(this).val().match(/[^a-z|^A-Z]/g) != null)){
			alert("영문으로 입력해주세요.");
			$(this).val( $(this).val().replace(/[^a-z]/g, ''));
		}else if((65 <= numUnicode && numUnicode <= 90) || ($(this).val().match(/[^a-z]/g) != null)){
			alert("영문 소문자로 입력해주세요.");
			$(this).val( $(this).val().replace(/[^a-z]/g, ''));
		}
	});
	
	$("#ip").keyup(function(){
		$(this).val($(this).val().replace(/[^0-9.]/g,""));
	});
    
});
</script>
