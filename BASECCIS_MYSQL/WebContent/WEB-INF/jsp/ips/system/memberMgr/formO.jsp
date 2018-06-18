<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/siteMgr/act" method="post" role="form">
<fieldset>
	<legend>탈퇴회원 정보</legend>	
	<h2 class="depth2_title">기본정보</h2>
	<table class="tstyle_view">
		<caption>
			탈퇴회원 상세정보 - 아이디, 회원구분, 이름, 탈퇴일, 가입일
		</caption>
		<colgroup>
			<col class="col-sm-2" />
            <col class="col-sm-4" />
            <col class="col-sm-2" />
            <col class="col-sm-4" />
		</colgroup>
		<tr>
			<th scope="row"><label for="userId">아이디</label></th>
			<td><c:out value="${rtnMember.USERID }" /></td>
			<th scope="row"><label for="kind_Name">회원구분</label></th>
			<td>탈퇴회원</td>
		</tr>
		<tr>
			<th scope="row"><label for="kname">이름</label></th>
			<td><c:out value="${rtnMember.KNAME }" /></td>
			<th scope="row"><label for="outDate">탈퇴일</label></th>
			<td>
                <c:out value="${fn:substring(rtnMember.OUTDATE, 0, 4) }-${fn:substring(rtnMember.OUTDATE, 4, 6) }-${fn:substring(rtnMember.OUTDATE, 6, 8) }" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="joinDate">가입일</label></th>
			<td colspan="3">
                <c:out value="${fn:substring(rtnMember.JOINDATE, 0, 4) }-${fn:substring(rtnMember.JOINDATE, 4, 6) }-${fn:substring(rtnMember.JOINDATE, 6, 8) }" />
            </td>
		</tr>
	</table>	
</fieldset>
</spform:form>
<div class="btn_area">
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>							
<script type="text/javascript">
$(function() {
	
	$("#btnList").click(function(){
        location.href="${contextPath}/mgr/memberMgr?${link}";
    });
});
</script>
