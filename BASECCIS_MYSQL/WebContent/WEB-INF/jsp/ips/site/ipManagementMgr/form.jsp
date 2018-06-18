<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/ipManagementMgr/act" method="POST">
<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>

<!-- Data -->
<c:if test="${!empty result[0].SEQ}">
<input type="hidden" id="seq" name="seq" value="${result[0].SEQ}"/>
</c:if>

<input type="hidden" id="state" name="state" value="${result[0].STATE }"/>

<!-- 목록 이동용 검색조건 모두 표시 -->
<input type="hidden" name="pageNum" value="${param.pageNum }">
<input type="hidden" name="schSiteId" value="${param.schSiteId }">
<input type="hidden" name="schKName" value="${param.schKName }">

<fieldset>
	<legend>팝업존 정보 입력</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<table class="tstyle_view">
		<caption>
			사이트 상세 정보 입력
		</caption>
		<colgroup>
			<col class="col-sm-2"/>
			<col class="col-sm-10"/>
		</colgroup>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="KName">IP</label></th>
			<td>
				<input type="text" name="ip_1" id="ip_1" value="${result[0].IP_1 }" class="input_Num"/>.
				<input type="text" name="ip_2" id="ip_2" value="${result[0].IP_2 }" class="input_Num"/>.
				<input type="text" name="ip_3" id="ip_3" value="${result[0].IP_3 }" class="input_Num"/>.
				<input type="text" name="ip_4" id="ip_4" value="${result[0].IP_4 }" class="input_Num"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="allwYN">허용여부</label></th>
			<td>
				<input name="allwYN" id="allwY" value="Y" type="radio" title="사용여부" <c:if test="${result[0].ALLWYN == 'Y' or empty result[0].ALLWYN }">checked="checked"</c:if>/>
				<label for="Y">허용</label>
				<input name="allwYN" id="allwN" value="N" type="radio" title="사용여부" <c:if test="${result[0].ALLWYN == 'N' }">checked="checked"</c:if>/>
				<label for="N">미허용</label>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="KDesc">비고</label></th>
			<td colspan="3"><input type="text" name="remk" id="remk" value="${result[0].REMK}" class="input_long" /></td>
		</tr>
		
	</table>
</fieldset>
</spform:form>

<div class="btn_area txt_right">
		<button type="button" class="btn btn_type01 ${!empty result[0].SEQ ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
		<c:if test="${!empty result[0].SEQ}">
		<button type="button" class="btn btn_type01 roleDELETE" id="btnDelete">삭제</button>
		</c:if>
		<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>

<script type="text/javascript">
$(function() {
    
	$("#btnSave").click(function(){
		if($("#ip_1").val().length <= 0) {
			alert("IP A클래스를 입력하세요.");
			$("#ip_1").focus();
			return false;
		}
		if($("#ip_2").val().length <= 0) {
			alert("IP B클래스를 입력하세요.");
			$("#ip_2").focus();
			return false;
		}
		if($("#ip_3").val().length <= 0) {
			alert("IP C클래스를 입력하세요.");
			$("#ip_3").focus();
			return false;
		}
		if($("#ip_4").val().length <= 0) {
			alert("IP D클래스를 입력하세요.");
			$("#ip_4").focus();
			return false;
		}
		if($("#remk").val().length <= 0) {
			alert("비고를 입력하세요.");
			$("#remk").focus();
			return false;
		}

		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		
		$("#insertForm").attr('action', '${ctxMgr }/ipManagementMgr/act');
		$("#insertForm").submit();
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#state").val("F");
		$("#insertForm").attr('action', '${ctxMgr }/ipManagementMgr/act');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		location.href="${contextPath}/mgr/ipManagementMgr?${link}";
	});
	
	$(".input_Num").keyup(function(e){
		if($(this).val().match(/[^0-9*]/g) != null){
			alert("숫자와'*'만 입력이 가능합니다.");	
			$(this).val( $(this).val().replace(/[^0-9*]/g, ''));
		}
	});
	
});

</script>
