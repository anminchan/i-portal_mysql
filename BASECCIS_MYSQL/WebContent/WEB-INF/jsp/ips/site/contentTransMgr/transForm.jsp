<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="listMenuForm" name="listMenuForm" action="${contextPath }/mgr/contentTransMgr/delete" method="post" role="form">
	<input type="hidden" id="siteId" name="siteId"  value="${obj.siteId }"/>
	<input type="hidden" id="menuId" name="menuId"  value="${obj.menuId }"/>
	<input type="hidden" id="boardKind" name="boardKind"  value="${param.boardKind }"/>
	<input type="hidden" id="paramMenuId" name="paramMenuId"  value=""/>
	<input type="hidden" id="transMenuId" name="transMenuId"  value="${param.transMenuId }"/>
	<input type="hidden" id="transTargetMenuId" name="transTargetMenuId"  value="${param.transTargetMenuId }"/>
	<input type="hidden" id="transGubun" name="transGubun"  value="target"/>

	<h2 class="depth2_title">참조하는 메뉴(게시물을 가져올 대상 메뉴를 지정)</h2>
	<c:if test="${empty resultTransTargetMenu and ADMUSER.totalAuth eq 'Y' }">
		<div class="float_wrap txt_right">
				<button type="button" class="btn btn_basic" id="btnMenuAdd">등록</button>
				<button type="button" class="btn btn_basic" id="btnMenuDel">삭제</button>
		</div>
	</c:if>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				이관 메뉴 
			</caption>
			<colgroup>
				<col class="allChk"/>
		        <col class="num"/>
		        <col span="4"/>
		    	<col class="date"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">선택</th>
					<th scope="col">번호</th>
					<th scope="col">사이트명</th>
					<th scope="col">메뉴명</th>
					<th scope="col">메뉴경로</th>
					<th scope="col">메뉴유형</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty resultTransMenu }">
					<c:forEach items="${resultTransMenu }" var="data" varStatus="loop">
					<tr>
						<td>
		            		<input type="checkbox" name="TRANSID_TARGET_ARR" id="TRANSID_TARGET_ARR" value="${data.TRANSID}"/>
		            	</td>  
						<td>${loop.count }</td>
						<td>${data.SITE_NAME }</td>
						<td>${data.MENU_NAME }</td>
						<td>${data.NAMEPATH }</td>
						<td>${data.BOARDKIND_NAME }</td>
						<td>
							<fmt:parseDate value="${data.INSTIME }" pattern="yyyy-MM-dd" var="insTime"/>
							<fmt:formatDate value="${insTime }" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
				<tr>
					<td colspan="7">참조 되는 메뉴가 없을 경우 등록이 가능합니다.</td>
				</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>	
</spform:form>

<spform:form id="listMenuTransForm" name="listMenuTransForm" action="${contextPath }/mgr/contentTransMgr/delete" method="post" role="form">
	<input type="hidden" id="siteId" name="siteId"  value="${obj.siteId }"/>
	<input type="hidden" id="menuId" name="menuId"  value="${obj.menuId }"/>
	<input type="hidden" id="boardKind" name="boardKind"  value="${param.boardKind }"/>
	<input type="hidden" id="paramMenuId" name="paramMenuId"  value=""/>
	<input type="hidden" id="transMenuId" name="transMenuId"  value="${param.transMenuId }"/>
	<input type="hidden" id="transTargetMenuId" name="transTargetMenuId"  value="${param.transTargetMenuId }"/>
	<input type="hidden" id="transGubun" name="transGubun"  value="trans"/>
	
	<h2 class="depth2_title02">참조 되는 메뉴(현 메뉴에 게시물을 가져갈 타겟을 지정)</h2>
	<c:if test="${empty resultTransMenu and ADMUSER.totalAuth eq 'Y' }">
	<div class="float_wrap txt_right">
			<button type="button" class="btn btn_basic" id="btnTransMenuAdd">등록</button>
			<button type="button" class="btn btn_basic" id="btnTransMenuDel">삭제</button>
	</div>
	</c:if>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				이관 메뉴 
			</caption>
			<colgroup>
				<col class="allChk"/>
		        <col class="num"/>
		        <col span="4"/>
		    	<col class="date"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">선택</th>
					<th scope="col">번호</th>
					<th scope="col">사이트명</th>
					<th scope="col">메뉴명</th>
					<th scope="col">메뉴경로</th>
					<th scope="col">메뉴유형</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>			
				<c:when test="${!empty resultTransTargetMenu }">
					<c:forEach items="${resultTransTargetMenu }" var="data" varStatus="loop">
					<tr>
						<td>
							<c:if test="${data.MENUTYPE eq 'C'}">
		            		<input type="checkbox" name="TRANSID_ARR" id="TRANSID_ARR" value="${data.TRANSID}"/>
		            		</c:if>
		            	</td>  
						<td>${loop.count }</td>
						<td>${data.SITE_NAME }</td>
						<td>${data.MENU_NAME }</td>
						<td>${data.NAMEPATH }</td>
						<td>${data.BOARDKIND_NAME }</td>
						<td>
							<fmt:parseDate value="${data.INSTIME }" pattern="yyyy-MM-dd" var="insTime"/>
							<fmt:formatDate value="${insTime }" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
				<tr>
					<td colspan="7">참조하는 메뉴가 없을 경우 등록이 가능합니다.</td>
				</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
</spform:form>
						
<script type="text/javascript">
$(function() {
	$('#btnMenuAdd').click(function(){
		try{win.focus();}catch(e){}
		win = window.open("${ctxMgr}/contentTransMgr/selectMenuPopup?transGubun=target&transMenuId=${param.transMenuId}&transTargetMenuId=${param.transTargetMenuId}&boardKind=${param.boardKind}&menuId=${obj.menuId}&siteId="+$('#siteIdSel', parent.document).val(),'menu_pop', 'width=1000px,height=600px,scrollbars=yes,status=no');
		
	});
	
	$('#btnMenuDel').click(function(){
		var chkCnt = $("input[name='TRANSID_TARGET_ARR']:checked").length;	
		if( chkCnt <= 0 ){
			alert('삭제 할 메뉴를 선택하세요.');
			return;
		}
		
		$('#listMenuForm').submit();
	});
	
	$('#btnTransMenuAdd').click(function(){
		try{win.focus();}catch(e){}
		win = window.open("${ctxMgr}/contentTransMgr/selectMenuPopup?transGubun=trans&transMenuId=${param.transMenuId}&transTargetMenuId=${param.transTargetMenuId}&boardKind=${param.boardKind}&menuId=${obj.menuId}&siteId="+$('#siteIdSel', parent.document).val(),'menu_pop', 'width=1000px,height=600px,scrollbars=yes,status=no');
		
	});
	
	$('#btnTransMenuDel').click(function(){
		var chkCnt = $("input[name='TRANSID_ARR']:checked").length;	
		if( chkCnt <= 0 ){
			alert('삭제 할 메뉴를 선택하세요.');
			return;
		}
		
		$('#listMenuTransForm').submit();
	});

});
</script>
