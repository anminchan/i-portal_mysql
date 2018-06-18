<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/menuMgr/act" method="post">
<input type="hidden" id="siteId" name="siteId"  value=""/>
<input type="hidden" id="menuId" name="menuId"  value="${param.menuId}"/>
<input type="hidden" id="depth" name="depth"  value=""/>
<input type="hidden" id="paramMenuId" name="paramMenuId"  value=""/>
<input type="hidden" id="higherID" name="higherID"  value=""/>
<input type="hidden" id="chargeUserID" name="chargeUserID"  value=""/>
<input type="hidden" id="menuType" name="menuType"  value=""/>

<!-- BeforeData -->
<input type="hidden" id="inBeforeData" name="inBeforeData" value=""/>
<fieldset>
	<article class="treeMenu_area">
		<!-- 트리메뉴 -->
		<div class="tree_nav">
			<!-- ▼ 사이트 콤보  -->
			<select name="siteIdSel" id="siteIdSel" class="siteidsel">
			</select>
			<!-- ▲ 사이트 콤보  -->
			<span class="siteIdSel_view"><a href="javascript: deptTree.openAll();"><i class="xi-folder-add-o"></i>전체보기</a> <a href="javascript: deptTree.closeAll();"><i class="xi-folder-remove-o"></i>전체닫기</a></span>
			<script type="text/javascript">
				<!--
				
				deptTree = new dTree('deptTree', '${contextPath }'); //dTree 생성
				
				// 새로고침때 초기화
				if('${pMenuId}' == ""){
					deptTree.clearCookie();
				}
				
				//add(id, pid, name, url, title, target, icon, iconOpne, open)
				
				//트리 root고정 
				deptTree.add(0, -1, '${resultSite}');
				
				<c:forEach items="${result }" var="data" varStatus="loop">
					<c:set var="strImg" value="" />
					//기본 트리 구성
					<c:if test="${data.state eq 'F' }">
							<c:set var="strImg" value="${contextPath }/resources/images/common/tree/file-delete.gif"/>
					</c:if>
					<c:if test="${data.state eq 'T' }">
						<c:if test="${data.menuType ne 'N' }">
							<c:set var="strImg" value="${contextPath }/resources/images/common/tree/${data.menuType}.gif"/>
						</c:if>
					</c:if>
					
					//기본 트리 구성 
					deptTree.add('${data.menuId }', '${data.higherID == "-" ? 0 : data.higherID }', '${data.KName }', "javascript:clickDept('${data.menuId}', '${data.siteId}');",'','','${strImg }');
				</c:forEach>
				
				//dTree 화면 출력
				document.write(deptTree);
				//-->
			</script>
		</div>
		<!-- //트리메뉴 -->
		<div class="tree_list">
		<!-- 트리메뉴 생성 -->
			<p><span class="point01">*</span> 필수입력항목 입니다.</p>
			<div class="table">
				<table  id="tableMenu" class="tstyle_view">
					<caption>
						메뉴ID, 메뉴명, 메뉴설명, 탭메뉴여부, 정렬순서, 상위메뉴, 프로그램 URL, 담당자, 고객만족도 여부, 사용여부
					</caption>
					<colgroup>
						<col class="col-sm-2"/>
						<col class="col-sm-10"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="menuId">메뉴 ID</label></th>
							<td><span id="menuIdText" title="메뉴id" class="point02"></span></td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="KName">메뉴명</label></th>
							<td><input type="text" id="KName" name="KName" value="" class="input_mid02" maxlength="50" title="메뉴명" /></td>
						</tr>
						
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="KDesc">메뉴설명</label></th>
							<td><input type="text" id="KDesc" name="KDesc" value="" class="input_long" title="메뉴설명" /></td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="tabYN">탭메뉴 여부</label></th>
							<td>
								<input name="tabYN" id="tabY" value="Y" type="radio"/>
								<label for="Y">예</label>
								<input name="tabYN" id="tabN" value="N" type="radio"/>
								<label for="N">아니오</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="sort">정렬순서</label></th>
							<td><input type="text" id="sort" name="sort" value="" class="input_Num" maxlength="8" title="정렬순서" /></td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for=higherID_Name>상위메뉴</label></th>
							<td>
								<span id="higherID_Name" title="상위메뉴" ></span>
								<span class="float_right">
									<input type="button" id="higherID_Move" value="변경" class="btn btn_basic" style="display: none;"/>
									<input type="button" id="higherID_TopMove" value="최상위이동" class="btn btn_basic" style="display: none;"/>
								</span>
								
								<!-- 메뉴 조회 레이어 팝업 -->
								<div id ="dialog" style="display: none;">
									<!-- 트리메뉴 -->
									<div class="tree_nav">
									<!-- <p class="btn_area"><a href="javascript: deptTreeSecond.openAll();"><img src="${contextPath }/resources/images/ips/sub/dtree_open.gif" alt="전체보기"/></a> <a href="javascript: deptTreeSecond.closeAll();"><img src="${contextPath }/resources/images/ips/sub/dtree_close.gif" alt="전체닫기"/></a></p> -->
									<script type="text/javascript">
										<!--
										deptTreeSecond = new dTree('deptTreeSecond', '${contextPath }'); //dTree 생성
										
										//add(id, pid, name, url, title, target, icon, iconOpne, open)
										
										//트리 root고정 
										deptTreeSecond.add(0, -1, 'KHIDI');
										
										<c:forEach items="${result }" var="data" varStatus="loop">
											deptTreeSecond.add('${data.menuId }', <c:if test="${data.higherID == '-' }">0</c:if><c:if test="${data.higherID != '-' }">'${data.higherID }'</c:if>, '${data.KName }', "javascript:setHigherID('${data.menuId}', '${data.KName}', '${data.depth}');");	
										</c:forEach>
										
										//dTree 화면 출력
										document.write(deptTreeSecond);
										
										//-->
									</script>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for=menuType>메뉴타입</label></th>
							<td><select id="code" name="code" title="메뉴타입"></select></td>
						</tr>
						<tr>
							<th scope="row"><label for="programURL">프로그램 URL</label></th>
							<td><input type="text" id="programURL" name="programURL" value="" class="input_long" title="프로그램 URL" /></td>
						</tr>
						<tr>
							<th scope="row"><!-- <span class="point01">*</span> --> <label for="chargeUserID_Name">담당자</label></th>
							<td>
								<input type="text" id="chargeUserID_Name" name="chargeUserID_Name" value="" maxlength="30" title="담당자" />
								<input type="button" id="chargeUserIDSearchBtn" name="chargeUserIDSearchBtn" value="검색" class="btn btn_basic" onclick="gfnMemberPopupList('K', 'all', 'S');" style="display: none;"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> 화면표시 여부</th>
							<td>
								<input name="displayYN" id="displayY" value="Y" type="radio"/>
								<label for="displayY">표시</label>
								<input name="displayYN" id="displayN" value="N" type="radio"/>
								<label for="displayN">표시안함</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> 고객만족도 여부</th>
							<td>
								<input name="userGradeYN" id="usergradeY" value="Y" type="radio"/>
								<label for="usergradeY">사용</label>
								<input name="userGradeYN" id="usergradeN" value="N" type="radio"/>
								<label for="usergradeN">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> 사용여부</th>
							<td>
								<input name="state" id="stateY" value="T" type="radio"/>
								<label for="stateY">사용</label>
								<input name="state" id="stateN" value="F" type="radio"/>
								<label for="stateN">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row">NEW메뉴여부</th>
							<td>
								<input name="newMenuYN" id="newMenuY" value="Y" type="radio"/>
								<label for="newMenuY">표시</label>
								<input name="newMenuYN" id="newMenuN" value="N" type="radio"/>
								<label for="newMenuN">표시안함</label>
							</td>
						</tr>
						<tr>
							<th scope="row">메뉴아이콘명칭</th>
							<td>
								<input type="text" id="imgKind" name="imgKind" value="" title="메뉴아이콘명칭" />
								<a href="http://xpressengine.github.io/XEIcon/library-2.3.1.html" class="point02" target="_blank">아이콘찾기</a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn_area">
				<button type="button" class="btn btn_type01" id="btnMenuAdd"><spring:message code="btn.fn.add.msg" /></button>		
				<button type="button" class="btn btn_type02" id="btnSave" style="display: none;"><spring:message code="btn.save.msg" /></button>
				<button type="button" class="btn btn_type03" id="btnMoveContentSet" style="display: none;">콘텐츠설정화면이동</button>
				<button type="button" class="btn btn_type03" id="btnMoveContentReg" style="display: none;" boardKind="">콘텐츠등록화면이동</button>
				<button type="button" class="btn btn_type02" id="btnDelete" style="display: none;"><spring:message code="btn.delete.msg" /></button>
			</div>
		</div>
		<!-- //트리메뉴 생성 -->
	</article>
</fieldset>
</spform:form>
							
<script type="text/javascript">
$(function() {
	// 테이블 전체 disabled / readonly
	$("#tableMenu").prop("disabled", true);
	$("#tableMenu :input").prop("readonly", "readonly");
	
	var pMenuId = "${pMenuId}"; // 파라메터 메뉴id
	var pSiteId = "${pSiteId}"; // 파라메터 사이트id
	var raction = "${action}"; // 저장/수정

	if(pMenuId == ""){
		$("#menuIdText").text("[메뉴추가 버튼을 클릭하여 등록바랍니다.]");
		//$("#menuIdText").text("");
	}
	
	//common.js 정의 
	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${pSiteId}"); // 사이트 select세팅
	
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		location.href = "${ctxMgr}/menuMgr?menuId="+$('#menuId').val()+"&siteId="+$(this).val();
	});
	
	gfnCodeComboList($("#code"), "MenuType", "0", "코드 선택", "0"); // 메뉴타입 select세팅
	$('#code').on("change", function() { // 메뉴타입 이벤트
		$("#menuType").val($(this).val());
	
		// 메뉴타입이 비기능 일 경우
		if($(this).val() == "N"){
			$("#chargeUserID_Name").val("");
			$("#chargeUserID").val("-");
			$("#chargeUserID_Name").prop("disabled", "disabled");
			$("#chargeUserIDSearchBtn").hide();
		}else{
			$("#chargeUserID_Name").prop("disabled", false);
			$("#chargeUserIDSearchBtn").show();
		}
	});
	
	// 사이트 설정
	$("#siteId").val("${pSiteId}");
	
	$("input:radio[name='tabYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='displayYN']:radio[value='Y']").prop("checked", true);
	$("input:radio[name='userGradeYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='state']:radio[value='T']").prop("checked", true);
	$("input:radio[name='newMenuYN']:radio[value='N']").prop("checked", true);
	
	// 담당자 클릭
	/* $("#chargeUserID_Name").click(function(){
		//alert("회원조회 팝업에서 검색바랍니다.");
		gfnMemberPopupList('K', 'all', 'S');
	}); */
	
	// 상위메뉴 레이어 팝업
	$("#higherID_Move").click(function(){
		$("#dialog").dialog({
			width: 318,
			height: 428,
			resizable: false,
			modal: true,
			title: "메뉴조회"
		});
	});
	
	// 상위메뉴 레이어 팝업
	$("#higherID_TopMove").click(function(){
		$("#higherID_TopMove").hide();
		$("#higherID_Name").text("[최상위 메뉴]");
		$("#higherID").val("-");
		$("#depth").val("1");
	});

	// 숫자만입력
	$(".input_Num").keyup(function(){
		if($(this).val().match(/[^0-9]/g) != null){
			alert("<spring:message code='common.number.format.msg' />");	
			$(this).val( $(this).val().replace(/[^0-9]/g, ''));
		}
	});
	
	//저장
	$("#btnSave").click(function(){
		if($("#menuIdText").text() == ""){
			alert("<spring:message code='system.menu.menuIdText.msg' />");
			return false;
		}
		if($("#KName").val().length <= 0) {
			alert("<spring:message code='system.menu.KName.msg' />");
			$("#KName").focus();
			return false;
		}
		if($("#KDesc").val().length <= 0) {
			alert("<spring:message code='system.menu.KDesc.msg' />");
			$("#KDesc").focus();
			return false;
		}
		if($("#sort").val().length <= 0) {
			alert("<spring:message code='system.menu.sort.msg' />");
			$("#sort").focus();
			return false;
		}
		if($("#chargeUserID").val() == "") $("#chargeUserID").val("-");

		if(!confirm("<spring:message code='common.save.msg' />")) {
			return false;
		}
		
		// 전송
		$("#insertForm").submit();
		
	});
	
	//삭제
	$("#btnDelete").click(function(){
		if($("#menuIdText").text() == "[자동생성]"){
			alert("<spring:message code='system.menu.delete.choice.msg' />");
			return false;
		}
		
		if(!confirm("<spring:message code='system.menu.delete.msg' />")) {
			return false;
		}
		
		// 전송
		$("#insertForm").attr('action', '${ctxMgr }/menuMgr/actDel');
		$("#insertForm").submit();
		
	});
	
	// 메뉴추가
	$("#btnMenuAdd").click(function(){
		// 테이블 전체 disabled / readonly
		$("#tableMenu").prop("disabled", false);
		$("#tableMenu :input").prop("readonly", false);
		$("#chargeUserID_Name").prop("readonly", "readonly");
		
		$("#menuIdText").text("[자동생성]"); // 메뉴 ID 초기화
		$("#kName").val(""); // 메뉴명 초기화
		$("#KDesc").val(""); // 메뉴설명 초기화
		$("#sort").val("0"); // 메뉴 정렬순서 초기화
		
		$("#higherID").val($("#paramMenuId").val()); // 상위메뉴 ID 현재 클릭한 메뉴 ID로 세팅
		$("#higherID_Name").text($("#KName").val()); // 상위메뉴명 현재 클릭한 메뉴명으로 세팅		
		$("#depth").val(Number($("#depth").val())+1); // 현재 클릭한 메뉴 depth +1

		$("#code").val("N").prop("selected", "selected"); // 메뉴타입세팅
		$("#menuType").val("N");
		
		$("#programURL").val("-");
		$("#imgKind").val("-");
		
		// 메뉴타입이 비기능 일 경우
		if($("#code option:selected").val() == "N"){
			$("#chargeUserID_Name").prop("disabled", "disabled");
			$("#chargeUserIDSearchBtn").hide();
		}
		
		$("#chargeUserID_Name").val("");
		$("#chargeUserID").val("");
		
		if($("#paramMenuId").val() == ""){	
			$("#higherID_Name").text("[최상위 메뉴]");
			$("#higherID").val("-");
			$("#depth").val("1");
		}
		
		$("#paramMenuId").val("");
		$("#KName").val("");
		
		$("input:radio[name='tabYN']:radio[value='N']").prop("checked", true);
		$("input:radio[name='userGradeYN']:radio[value='N']").prop("checked", true);
		$("input:radio[name='displayYN']:radio[value='Y']").prop("checked", true);
		$("input:radio[name='state']:radio[value='T']").prop("checked", true);
		$("input:radio[name='newMenuYN']:radio[value='N']").prop("checked", true);
		
		$("#higherID_Move").show();
		if($("#higherID").val() != "-") $("#higherID_TopMove").show();
		
		<c:if test="${WRITE eq 'T'}">
			$("#btnSave").show();
			$("#btnDelete").show();
		</c:if>
	});

	// 메뉴 데이터 저장 후 화면에 저장값 세팅
	if(raction == "act"){
		clickDept(pMenuId, pSiteId);
	}
	
	// 게시판설정화면으로 이동
	$("#btnMoveContentSet").click(function(){
		parent.document.location.href = "${ctxMgr}/contentSetMgr?menuId=${contentSetMgrMenu }&siteId="+$('#siteIdSel', parent.document).val()+"&action=move&paramMenuId="+$("#paramMenuId").val();
	});
	
	// 게시판등록화면으로 이동
	$("#btnMoveContentReg").click(function(){
		location.href = "${ctxMgr}/contentMgr?menuId=${contentMgrMenu }&siteId=${pSiteId }&moveMenuId="+$("#paramMenuId").val()+"&moveBoardKind="+$("#btnMoveContentReg").prop('boardKind');
	});
	
});

// 메뉴상세보기
function clickDept(paramMenuId, siteId){
	$("#btnMoveContentSet").hide();
	$("#btnMoveContentReg").hide();
	
	$.ajax({
 		url: gContextPath+"/mgr/menuMgr/form",
 		data: {'paramMenuId' : paramMenuId, 'paramSiteId' : siteId},
 		async: false,
 		cache: false,
 		success:function(result) {
 			if(result == "") {
				alert("등록된 메뉴정보가 없습니다.");
 			}else{
 			    // 테이블 전체 disabled / readonly false
 				$("#tableMenu").prop("disabled", false);
 				$("#tableMenu :input").prop("readonly", false);
 				$("#chargeUserID_Name").prop("readonly", "readonly");
 			
 				if(result.paramMenuId == ""){
					$("#menuIdText").text("[자동생성]");
				}else{
					$("#menuIdText").text(result.menuId);
				}

				$("#siteId").val(result.siteId); // hidden siteId : siteId 값세팅
				$("#paramMenuId").val(result.menuId); // hidden paramMenuId : menuId 값세팅
				$("#inBeforeData").val(result.inBeforeData);
				$("#depth").val(result.depth); // hidden depth : depth 값세팅
				
				$("#KName").val(result.kname); //메뉴명 설정				
				$("#KDesc").val(result.kdesc); //메뉴설명 설정
				$("input:radio[name='tabYN']:radio[value='"+ result.tabYN +"']").prop('checked',true); // 탭메뉴 checked설정
				$("#sort").val(result.sort); // 정렬순서 화면출력
				$("#code").val(result.menuType).prop("selected", "selected"); // 메뉴타입 선택
				$("#menuType").val(result.menuType); // hidden menuType : menuType메뉴타입
				
				if(result.higherID_Name != null) $("#higherID_Name").text(result.higherID_Name);
				else $("#higherID_Name").text("[최상위 메뉴]");
				
				$("#higherID").val(result.higherID);
				$("#programURL").val(result.programURL);
				$("#imgKind").val(result.imgKind);
				
				$("#chargeUserID_Name").val(result.chargeUserID_Name);
				$("#chargeUserID").val(result.chargeUserID);
				
				$("#higherID_Move").show();
				$("#higherID_TopMove").hide();
				
				if($("#higherID").val() != "-"){		
					$("#higherID_TopMove").show();
				}else{
					$("#higherID_TopMove").hide();
				}
				
				$("input:radio[name='userGradeYN']:radio[value='"+ result.userGradeYN +"']").prop('checked',true); // 고객만족도여부 checked설정
				$("input:radio[name='displayYN']:radio[value='"+ result.displayYN +"']").prop('checked',true); // 고객만족도여부 checked설정
				$("input:radio[name='state']:radio[value='"+ result.state +"']").prop('checked',true); //사용여부 checked설정
				$("input:radio[name='newMenuYN']:radio[value='"+ result.newMenuYN +"']").prop('checked',true); //사용여부 checked설정
				
				if(result.menuType == "N"){
					$("#chargeUserID_Name").prop("disabled", "disabled");
					$("#chargeUserIDSearchBtn").hide();
					//$("#search_System").hide();
				}else{
					$("#chargeUserID_Name").prop("disabled", false);
					$("#chargeUserIDSearchBtn").show();
				}

				<c:if test="${WRITE eq 'T'}">
					$("#btnSave").show();
					$("#btnDelete").show();
				</c:if>
				
				if(result.menuType == 'C') $("#btnMoveContentSet").show();
				if(result.boardMoveKind != null){
					$("#btnMoveContentReg").show();
					$("#btnMoveContentReg").prop('boardKind', result.boardMoveKind);
				}
 			}
 		}
 	});
}

// 상위메뉴 세팅
function setHigherID(higherId, higherId_Name, depth){
	// 현메뉴 체크
	if($("#paramMenuId").val() == higherId){
		alert("선택하신 메뉴는 현 메뉴입니다.");
		return;
	}

	if(higherId_Name != null) $("#higherID_Name").text(higherId_Name);
	else $("#higherID_Name").text("[최상위 메뉴]");
	
	$("#higherID").val(higherId);
	$("#depth").val(Number(depth)+1);
	
	if($("#higherID").val() != "-") $("#higherID_TopMove").show();
	
	$("#dialog").dialog("close");
}

// 회원세팅 함수
function setMemberList(outputMember){
	var setMemberData = outputMember.split("|");
		$('#chargeUserID').val(setMemberData[2]);
		$('#chargeUserID_Name').val(setMemberData[3]);
}

</script>
