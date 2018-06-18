<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<form id="sform" name="sform" method="get" class="search_form" action="${contextPath }/mgr/authMgr">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId }" />
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="siteId">사이트</label>
				<select name="siteId" id="siteId"></select>		
					
				<label for="groupid">그룹</label>
				<select name="groupid" id="groupid">
					<option value="">그룹 선택</option>
				</select>	
				<span class="float_right">
					<input type="submit" id="btnSearch" class="btn btn_type02" value="검색">
				</span>
			</div>
		</div>
		
	</fieldset>
</form>
<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/authMgr/insert" method="post" role="form">	
	<input type="hidden" id="siteId" name="siteId" value="${siteId}"/>
	<input type="hidden" id="groupid" name="groupid" value="${groupid}"/>
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId }" />
	<input type="hidden" id="inputGRVal" name="inputGRVal" value=""/>
			
	<c:if test="${!empty result }">
		<div class="float_wrap txt_right">
			<button type="button" class="btn btn_basic" id="btnSave"><i class="xi-diskette"></i> 저장</button>
		</div>
	</c:if>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				그룹별 권한 리스트 - 메뉴, 권한(관리, 등록, 수정, 삭제, 읽기)
			</caption>
			<colgroup>
				<col />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
				  <th colspan="1" rowspan="2" scope="row">메뉴</th>
	  			  <th colspan="5" rowspan="1" scope="col">권한</th>  
				</tr>
				<tr>
					<th scope="col"><input id="allChk1" type="checkbox" title="관리 전체선택" /> 관리</th>
					<th scope="col"><input id="allChk2" type="checkbox" title="등록 전체선택" /> 등록</th>
					<th scope="col"><input id="allChk3" type="checkbox" title="수정 전체선택" /> 수정</th>
					<th scope="col"><input id="allChk4" type="checkbox" title="삭제 전체선택" /> 삭제</th>
					<th scope="col"><input id="allChk5" type="checkbox" title="읽기 전체선택" /> 읽기</th>
				</tr>
			</thead>
			<tbody>
			<c:set var="chkAll_1" value="Y" />
			<c:set var="chkAll_2" value="Y" />
			<c:set var="chkAll_3" value="Y" />
			<c:set var="chkAll_4" value="Y" />
			<c:set var="chkAll_5" value="Y" />
			<c:choose>
				<c:when test="${!empty result }">
					<c:forEach items="${result }" var="data" varStatus="loop">
					<tr>
						<td class="txt_left">
							<c:forEach begin="1" end="${data.depth}" varStatus="emptyLoop"><c:if test="${emptyLoop.index > 1}">&nbsp;&nbsp;&nbsp;&nbsp;</c:if></c:forEach> ${data.KName}
						</td>
						<td>
						<input id="roleids" class="roleid_1 chk_${loop.count }" onchange="javascript:fnChkAdminChagne(this.checked, 'chk_${loop.count }');" name="roleids[]" value="${data.roleid_1 }" type="checkbox" title="선택" <c:if test="${data.checkyn_1 == 'Y'}">checked="checked"</c:if> />
						</td>
						<td>
						<input id="roleids" class="roleid_2 chk_${loop.count }" name="roleids[]" value="${data.roleid_2 }" type="checkbox" title="선택" <c:if test="${data.checkyn_2 == 'Y'}">checked="checked"</c:if> />
						</td>
						<td>
						<input id="roleids" class="roleid_3 chk_${loop.count }" name="roleids[]" value="${data.roleid_3 }" type="checkbox" title="선택" <c:if test="${data.checkyn_3 == 'Y'}">checked="checked"</c:if> />
						</td>
						<td>
						<input id="roleids" class="roleid_4 chk_${loop.count }" name="roleids[]" value="${data.roleid_4 }" type="checkbox" title="선택" <c:if test="${data.checkyn_4 == 'Y'}">checked="checked"</c:if> />
						</td>
						<td>
						<input id="roleids" class="roleid_5 chk_${loop.count }" name="roleids[]" value="${data.roleid_5 }" type="checkbox" title="선택" <c:if test="${data.checkyn_5 == 'Y'}">checked="checked"</c:if> />
						</td>
					</tr>
					<c:if test="${chkAll_1 eq 'Y' && data.checkyn_1 ne 'Y'}"><c:set var="chkAll_1" value="N" /></c:if>
					<c:if test="${chkAll_2 eq 'Y' && data.checkyn_2 ne 'Y'}"><c:set var="chkAll_2" value="N" /></c:if>
					<c:if test="${chkAll_3 eq 'Y' && data.checkyn_3 ne 'Y'}"><c:set var="chkAll_3" value="N" /></c:if>
					<c:if test="${chkAll_4 eq 'Y' && data.checkyn_4 ne 'Y'}"><c:set var="chkAll_4" value="N" /></c:if>
					<c:if test="${chkAll_5 eq 'Y' && data.checkyn_5 ne 'Y'}"><c:set var="chkAll_5" value="N" /></c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
				<c:set var="chkAll_1" value="N" />
				<c:set var="chkAll_2" value="N" />
				<c:set var="chkAll_3" value="N" />
				<c:set var="chkAll_4" value="N" />
				<c:set var="chkAll_5" value="N" />
				<tr>
					<td colspan="6"> 조회된 데이터가 없습니다. </td>
				</tr>
				
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
</spform:form>

<script type="text/javascript">
//$(document).ready(function() {
$(function() {

	$('#btnSearch').click(function(){
		var siteId = $("#siteId").val().length;
		var groupId = $("#groupid").val().length;

		if (siteId == 0){
			alert("사이트를 선택하세요");
			$("#siteId").focus();
			return false;
		}
	
		if (groupId == 0){
			alert("그룹을 선택하세요");
			$("#groupid").focus();
			return false;
		}
		
		$('#sform').submit();
	}); 
	
	// 사이트콤보
	gfnSiteAdminComboList($("#siteId"), "", "사이트 선택", "${param.siteId}"); 
	//common.js 정의 
	gfnGroupComboList($("#groupid"), "", "그룹 선택", "${param.groupid}");
	
	$("#groupid").val("${param.groupid}");
	
	//권한별 전체 선택되어 있을 경우 권한변 전체선택 체크 
	$('#allChk1').prop("checked", ${chkAll_1 eq 'Y' ? 'true' : 'false' });
	$('#allChk2').prop("checked", ${chkAll_2 eq 'Y' ? 'true' : 'false' });
	$('#allChk3').prop("checked", ${chkAll_3 eq 'Y' ? 'true' : 'false' });
	$('#allChk4').prop("checked", ${chkAll_4 eq 'Y' ? 'true' : 'false' });
	$('#allChk5').prop("checked", ${chkAll_5 eq 'Y' ? 'true' : 'false' });
	
	//관리 전체선택
	$('#allChk1').click(function(){
		$("#allChk2").prop("checked", this.checked);
		$("#allChk3").prop("checked", this.checked);
		$("#allChk4").prop("checked", this.checked);
		$("#allChk5").prop("checked", this.checked);
		$(".roleid_1").prop("checked", this.checked);
		$(".roleid_2").prop("checked", this.checked);
		$(".roleid_3").prop("checked", this.checked);
		$(".roleid_4").prop("checked", this.checked);
		$(".roleid_5").prop("checked", this.checked);
	});
	//등록 전체선택
	$('#allChk2').click(function(){
		$(".roleid_2").prop("checked", this.checked);
	});
	//수정 전체선택
	$('#allChk3').click(function(){
		$(".roleid_3").prop("checked", this.checked);
	});
	//삭제 전체선택
	$('#allChk4').click(function(){
		$(".roleid_4").prop("checked", this.checked);
	});
	//읽기 전체선택
	$('#allChk5').click(function(){
		$(".roleid_5").prop("checked", this.checked);
	});
	
	$("#btnSave").click(function(){
		var form =$("#insertForm");
		var chlen = $("input[name='roleids[]']:checkbox:checked", form).length;
		
		if (chlen == 0){
			if(!confirm("아무 권한도 선택되지 않았습니다. 계속하겠습니까?")) {
				return false;
			}
		}
		
		var inputGRVal = new Array();
		//inputGRVal.push("${siteId}"+"|"+"${groupid}"+"|"+"0"); //삭제하기 위한 파라미터
		
		$("input[name='roleids[]']:checked", "form[name=insertForm]").each(function() {
			inputGRVal.push("${siteId}"+"|"+"${groupid}"+"|"+$(this).val());
		});
		
		$('#inputGRVal').val(inputGRVal);
		
		if(!confirm("저장하시겠습니까?")) {
			return false;
		}
		
		$("#insertForm").submit();

	}); 
    
});

function fnChkAdminChagne(val, objId){
	$('.'+objId).prop("checked", val);
}

</script>
