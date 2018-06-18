<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- 메뉴 조회 레이어 팝업 -->
<fieldset>
	<!-- 트리메뉴 -->
	<div class="tree_nav">		
		<!-- ▼ 사이트 콤보  -->
		<select name="siteIdSel" id="siteIdSel"></select>
		<!-- ▲ 사이트 콤보  -->
		<span class="siteIdSel_view"><a href="javascript: deptTree.openAll();"><i class="xi-folder-add-o"></i>전체보기</a> <a href="javascript: deptTree.closeAll();"><i class="xi-folder-remove-o"></i>전체닫기</a></span>
		<script type="text/javascript">
			<!--
			deptTreeSecond = new dTree('deptTreeSecond', '${contextPath }'); //dTree 생성
			
			//add(id, pid, name, url, title, target, icon, iconOpne, open)
			
			//트리 root고정 
			deptTreeSecond.add(0, -1, '${resultSite}');
			
			<c:forEach items="${result }" var="data" varStatus="loop">
				<c:set var="strImg" value="" />
				<c:set var="strChk" value="F" />
				
				<c:if test="${data.state eq 'T' }">
					<c:if test="${data.boardKind eq 'CONTENTS' }">
						<c:set var="strImg" value="${contextPath }/resources/images/common/tree/H.gif"/>
						<c:set var="strChk" value="T" />
					</c:if>
					<c:if test="${data.boardKind eq 'NOTICE' || data.boardKind eq 'FREE' || data.boardKind eq 'THUMBNAIL' || 
						data.boardKind eq 'LINK' || data.boardKind eq 'VOD' || data.boardKind eq 'APPEAL' || data.boardKind eq 'REPLY' || 
						data.boardKind eq 'CLIPPING' || data.boardKind eq 'CARD'}">
						<c:set var="strImg" value="${contextPath }/resources/images/common/tree/B.gif"/>
						<c:set var="strChk" value="T" />
					</c:if>
				</c:if>
					
				<c:if test="${data.menuType eq 'L' || data.menuType eq 'P'}">
					<c:set var="strImg" value="${contextPath }/resources/images/common/tree/${data.menuType}.gif"/>
				</c:if>
				
				<c:if test="${strChk eq 'T'}">
					deptTreeSecond.add('${data.menuId }', '${data.higherId == "-" ? 0 : data.higherId }', '${data.menu_Name }', "javascript:setContentLink('${data.menuId}', '${data.menu_Name}', '${data.depth}', '${data.boardKind}', '${data.state}');",'','','${strImg }');
				</c:if>
				<c:if test="${strChk eq 'F'}">
					deptTreeSecond.add('${data.menuId }', '${data.higherId == "-" ? 0 : data.higherId }', '${data.menu_Name }', "",'','','${strImg }');
				</c:if>
			</c:forEach>
			
			//dTree 화면 출력
			document.write(deptTreeSecond);
			
			//-->
		</script>
	</div>
</fieldset>
	
<script type="text/javascript">

$(function() {
	
	gfnSiteComboList($("#siteIdSel"), "", "", "${pSiteId}"); // 사이트 select세팅	
});

$('#siteIdSel').on("change", function() { // 사이트 이벤트
	location.href = "${ctxMgr}/contentMgr/selectContentMenuPopup?menuId=${obj.menuId}&siteId="+$(this).val();
});

function setContentLink(id, name, depth, boardKind, state){
	if("${param.menuId}" == id){
		alert("같은 메뉴를 선택하셨습니다.");
		return;
	}
	if(state == 'F'){
		alert("이관할 수 없는 메뉴입니다.");
		return;
	}
	if(boardKind == ''){
		alert("게시판이 아닌 메뉴입니다.");
		return;
	}
	
	if("CONTENTS" != boardKind){
		alert("콘텐츠 유형이 다릅니다.");
		return;
	}
	
	if(!confirm("저장하시겠습니까?")) {
		return;
	}else{
		$.ajax({
			url: gContextPath+"/mgr/contentMgr/actListContentLink",
			data: {'menuId' : $(opener.document).find('#menuId').val(), 'linkId' : $(opener.document).find('#linkId').val(), 'copyMenuId' : id, 'titleId' : $(opener.document).find('#titleId').val(), "condition" : "입력"},
			async: false,
	 		success:function(result, textStatus, jqXHR) {
	 			if(result != null) {
					if(result.outResult == "SUCCESS"){
						opener.parent.document.all.contentArea.src="${ctxMgr}/contentMgr?menuId=${param.menuId}&boardKind=CONTENTS";
						window.close();
					}
	 			}
	 		}
		}); 
	}
}
</script>