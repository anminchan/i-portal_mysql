<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- 메뉴 조회 레이어 팝업 -->

<fieldset>
	<div class="treeMenu_area">
		<!-- 트리메뉴 -->
		<div class="tree_nav">
		<!-- ▼ 사이트 콤보  -->
		<select name="siteIdSel" id="siteIdSel"></select>
		<!-- ▲ 사이트 콤보  -->
		<!-- <span class="siteIdSel_view"><a href="javascript: deptTree.openAll();"><i class="xi-folder-add-o"></i>전체보기</a> <a href="javascript: deptTree.closeAll();"><i class="xi-folder-remove-o"></i>전체닫기</a></span> -->
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
					deptTreeSecond.add('${data.menuId }', '${data.higherId == "-" ? 0 : data.higherId }', '${data.menu_Name }', "javascript:setContentLink('${data.menuId}', '${data.menu_Name}', '${data.depth}', '${data.boardKind}', '${data.menuType}', '${data.namePath}', '${data.parent_cnt}', '${data.child_cnt}');",'','','${strImg }');
				</c:if>
				<c:if test="${strChk eq 'F'}">
					deptTreeSecond.add('${data.menuId }', '${data.higherId == "-" ? 0 : data.higherId }', '${data.menu_Name }', "",'','','${strImg }');
				</c:if>
				
				//deptTreeSecond.add('${data.menuId }', <c:if test="${data.higherId == '-' }">0</c:if><c:if test="${data.higherId != '-' }">'${data.higherId }'</c:if>, '${data.menu_Name }', "javascript:setContentLink('${data.menuId}', '${data.menu_Name}', '${data.depth}', '${data.boardKind}', '${data.menuType}', '${data.namePath}', '${data.parent_cnt}', '${data.child_cnt}');", '', '', '${strImg }');	
			</c:forEach>
			
			//dTree 화면 출력
			document.write(deptTreeSecond);
			
			//-->
		</script>
		</div>
		<div class="tree_list">
			
		<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentTransMgr/act" method="post" role="form">
			<input type="hidden" id="siteId" name="siteId"  value="${obj.siteId }"/>
			<input type="hidden" id="menuId" name="menuId"  value="${obj.menuId }"/>
			<input type="hidden" id="transMenuId" name="transMenuId"  value="${param.transMenuId }"/>
			<input type="hidden" id="transTargetMenuId" name="transTargetMenuId"  value="${param.transTargetMenuId }"/>
			<input type="hidden" id="boardKind" name="boardKind"  value="${param.boardKind }"/>
			<input type="hidden" id="transGubun" name="transGubun"  value="${TransGubun }"/>
			<input type="hidden" id="state" name="state"  value="T"/>
			
			<h2 class="depth2_title">선택된 메뉴</h2>
			<div class="float_wrap txt_right">
				<button type="button" class="btn btn_basic roleWRITE" id="btnTransMenuDel">삭제</button>
			</div>
			<div class="table">
				<table id="trans_table" class="tstyle_list">
					<caption>
						메뉴명
					</caption>
					<colgroup>
						<col style="width:10px" />
						<col style="width:200px" />
						<col style="width:*" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">선택</th>
							<th scope="col">메뉴명</th>
							<th scope="col">메뉴경로</th>
						 </tr>
					</thead>
					<tbody>
					<c:if test="${!empty resultTransMenu }">
					<c:forEach var="data" items="${resultTransMenu }" varStatus="loop">
						<tr>
							<td>
								<c:if test="${data.MENUTYPE eq 'C'}">
								<input type="checkbox" class="TRANSID_ARR" name="TRANSID_ARR" id="TRANSID_ARR" value="${TransGubun eq 'trans' ? data.TARGETMENUID : data.MENUID }"/>
								</c:if>
								<c:if test="${data.MENUTYPE ne 'C'}">
								<input type="hidden" class="TRANSID_ARR" name="TRANSID_ARR" id="TRANSID_ARR" value="${TransGubun eq 'trans' ? data.TARGETMENUID : data.MENUID }"/>
								</c:if>
							</td>
							<td>${data.MENU_NAME }</td>
							<td>${data.NAMEPATH }</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty resultTransMenu }">
						<tr>
							<td colspan="3"> 조회된 데이터가 없습니다. </td>
						</tr>
					</c:if>
					<%-- ${tableHtml } --%>
					</tbody>
				</table>			
			</div>
		</spform:form>
			
		<div class="btn_area txt_right">
			<button type="button" class="btn btn_type01 roleWRITE" id="btnTransMenuAdd">등록</button>
		</div>
						
		</div>
	</div>
</fieldset>

<script type="text/javascript">

$(function() {
	gfnSiteAdminComboList($("#siteIdSel"), "", "", "${pSiteId}"); // 사이트 select세팅	
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		/* tableHtml="+$('.TRANSID_ARR').parent().parent().parent().html()+"& */
		location.href = "${ctxMgr}/contentTransMgr/selectMenuPopup?transGubun=${TransGubun}&transMenuId=${param.transMenuId}&transTargetMenuId=${param.transTargetMenuId}&menuId=${obj.menuId}&siteId="+$(this).val()+"&boardKind=${param.boardKind}";
	});
	
	$('#btnTransMenuDel').click(function(){
		var chkCnt = $("input[name='TRANSID_ARR']:checked").length;	
		if( chkCnt <= 0 ){
			alert('삭제 할 메뉴를 선택하세요.');
			return;
		}
		
		$('.TRANSID_ARR').each(function(){
			if($(this).is(":checked")){
				$(this).parent().parent().remove();
			}
		});
	});
	
	$('#btnTransMenuAdd').click(function(){
		var chkCnt = $("input[name='TRANSID_ARR']:checked").length;	
		if( chkCnt <= 0 ){
			alert('등록 할 메뉴를 선택하세요.');
			return;
		}
		
		if(!confirm("저장하시겠습니까?")){
			return;
		}
		
		/* $('.TRANSID_ARR').each(function(){
			$(this).attr("checked", true);
		}); */	
		
		$('#insertForm').submit();
		
	});
	
	if("${outResult}" != null && "${outResult}" != ""){
		if("${outResult}" == "SUCCESS"){
			alert("저장했습니다.");
		}else if("${outResult}" != "SUCCESS"){
			alert("${outResult}");
		}

		opener.parent.clickDept("${param.transMenuId}", "${param.boardKind}", "C");
		self.close();
	}
	
});

function setContentLink(id, name, depth, boardKind, menuType, namePath, parent_cnt, child_cnt){
	if(boardKind == "" || menuType != "C"){
		alert("이관할 수 있는 대상 메뉴가 아닙니다.");
		return;
	}else{
		if(boardKind == 'NOTICE' || boardKind == 'FREE' || boardKind == 'LINK' || boardKind == 'THUMBNAIL' || boardKind == 'VOD' || boardKind == 'CLIPPING' || boardKind == 'CARD'){
		}else{
			alert("이관할 수 있는 대상 메뉴가 아닙니다.");
			return;
		}
	}
	
	var addMenu = true;
	var selMenu = 0;
	
	$('.TRANSID_ARR').each(function(){
		selMenu++;
		if($(this).val() == id){
			alert("이미 선택된 메뉴입니다.");
			addMenu = false;
		}
	});
	
	if(!addMenu){
		return;
	}
	
	if("${TransGubun}" == "trans"){
		if(boardKind == 'REPLY' || boardKind == 'APPEAL' || boardKind == 'REFERENCE' || boardKind == 'CONTENTS'){
			alert("이관할 수 있는 대상 메뉴가 아닙니다.");
		}else{
			if(child_cnt > 0){
				alert("이미 참조되는 메뉴는 선택할 수 없습니다.");
				return;
			}
			if(parent_cnt > 0){
				alert("이미 참조되는 메뉴는 선택할 수 없습니다.");
				return;
			}
		}
	}
	
	if("${TransGubun}" == "target"){
		if(boardKind == 'REPLY' || boardKind == 'APPEAL' || boardKind == 'REFERENCE' || boardKind == 'CONTENTS'){
			alert("이관할 수 있는 대상 메뉴가 아닙니다.");
		}else{
			if(parent_cnt > 0){
				alert("이미 참조되는 메뉴는 선택할 수 없습니다.");
				return;
			}
			/* if(selMenu > 0){
				alert("참조할 메뉴는 하나만 선택할 수 있습니다.");
				return;
			} */
		}
	}

	if("${param.transMenuId }" == id){
		alert("자기 자신은 등록할 수 없습니다.");
		return;
	}

	if("${param.boardKind }" != boardKind){
		alert("서로다른 게시판 유형은 이관 할 수없습니다.");
		return;
	}

    var menu;
	menu = "<tr>";
	menu += '<td><input type="checkbox" class="TRANSID_ARR" name="TRANSID_ARR" id="TRANSID_ARR" value="'+id+'"/></td>';
	menu += "<td>"+name+"</td>";
	menu += "<td>"+namePath+"</td>";
	menu += "</tr>";
	
	<c:if test="${empty resultTransMenu }">
		if($('#trans_table > tbody').find('.TRANSID_ARR').length <= 0){
			$('#trans_table > tbody > tr').remove();
		}
	</c:if>
	$('#trans_table > tbody').append(menu);
}

</script>