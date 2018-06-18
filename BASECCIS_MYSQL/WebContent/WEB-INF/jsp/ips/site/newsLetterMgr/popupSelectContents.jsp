<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" method="post" role="form" enctype="multipart/form-data">
	<input type="hidden" id="siteId" name="siteId"  value="${obj.siteId }"/>
	<input type="hidden" id="menuId" name="menuId"  value="${obj.menuId }"/>
	<input type="hidden" id="paramMenuId" name="paramMenuId"  value=""/>

	<input type="hidden" id="subjectId" name="subjectId" value="${param.subjectId}"/>
	<input type="hidden" id="linkId" name="linkId" value="${param.linkId}"/>

	<input type="hidden" id="subject" name="subject" />
	<input type="hidden" id="link" name="link" />

	<div class="float_wrap">
		<h1 class="h1_title float_left">게시글 조회</h1>
		<p class="float_right"></p>
	</div>

	<div id="popup_body">
		<div id="content">
			<div class="float_wrap">
				<div class="float_left">
					<div class="treeMenu_area">
						<!-- 트리메뉴 -->
						<div class="tree_nav">
							<!-- ▼ 사이트 콤보  -->
							<select name="siteIdSel" id="siteIdSel" class="siteidsel"></select>
							<!-- ▲ 사이트 콤보  -->
							<p class="btn_area"><a href="javascript: deptTree.openAll();"><i class="xi-folder-add-o"></i>전체보기</a><a href="javascript: deptTree.closeAll();"><i class="xi-folder-remove-o"></i>전체닫기</a></p>
							<div id="siteNavi">
							<script type="text/javascript">
								deptTree = new dTree('deptTree', '${contextPath}'); //dTree 생성

								//add(id, pid, name, url, title, target, icon, iconOpne, open)

								//트리 root고정
								deptTree.add(0, -1, 'KHIDI');

								<c:forEach items="${result }" var="data" varStatus="loop">
								<c:set var="strImg" value="" />
								<c:set var="strChk" value="F" />
								//기본 트리 구성
								<c:if test="${data.state eq 'T' }">
									<c:if test="${data.boardKind eq 'CONTENTS' }">
										<c:set var="strImg" value="${contextPath }/resources/images/common/tree/H.gif"/>
										<c:set var="strChk" value="T" />
									</c:if>
									<c:if test="${data.boardKind eq 'NOTICE' || data.boardKind eq 'FREE' || data.boardKind eq 'THUMBNAIL' ||
										data.boardKind eq 'LINK' || data.boardKind eq 'VOD' || data.boardKind eq 'APPEAL' || data.boardKind eq 'REPLY' ||
										data.boardKind eq 'ETCNOTICE1' || data.boardKind eq 'ETCREPLY1' || data.boardKind eq 'CLIPPING' || data.boardKind eq 'CARD'}">
										<c:set var="strImg" value="${contextPath }/resources/images/common/tree/B.gif"/>
										<c:set var="strChk" value="T" />
									</c:if>
								</c:if>
								<c:if test="${data.menuType eq 'L' || data.menuType eq 'P'}">
									<c:set var="strImg" value="${contextPath }/resources/images/common/tree/${data.menuType}.gif"/>
								</c:if>

								<c:if test="${strChk eq 'T'}">
									deptTree.add('${data.menuId }', '${data.higherId == "-" ? 0 : data.higherId }', '${data.menu_Name }', "javascript:clickDept('${data.menuId}', '${data.boardKind}');",'','','${strImg }');
								</c:if>

								<c:if test="${strChk eq 'F'}">
									deptTree.add('${data.menuId }', '${data.higherId == "-" ? 0 : data.higherId }', '${data.menu_Name }', "",'','','${strImg }');
								</c:if>
								</c:forEach>

								//dTree 화면 출력
								document.write(deptTree);
							</script>
							</div>
						</div>
					</div>
				</div>

				<div class="float_right" style="width: 520px;">
					<iframe id="contentArea" width="100%" frameBorder="0" style="border:none; min-height: 500px;" scrolling="no"></iframe>
				</div>
			</div>
		</div>
	</div>
</spform:form>

<spform:form id="frmTarget" name="frmTarget" method="post" >
</spform:form>

<script type="text/javascript">
	$(function() {

		//common.js 정의
		gfnSiteAdminComboList($("#siteIdSel"), "", "", "${pSiteId}"); // 사이트 select세팅

		$('#siteIdSel').on("change", function() { // 사이트 이벤트
			location.href = "${ctxMgr}/newsLetterMgr/popupSelectContents?siteId=" + $(this).val() + "&subjectId=" + $("#subjectId").val() + "&linkId=" + $("#linkId").val();
		});

		$("#btnSave").click(function(){
			alert($('#content_detail').contents().find("html").height());
		});

		$("#content_detail").on("load", function () {
			var height = this.contentWindow.document.body.scrollHeight;

			$(this).height(height);
			$('body,html').animate({scrollTop:220}, 500);
		});
	});

	// 메뉴 클릭 이벤트 : 메뉴 컨텐츠 정보 보기
	function clickDept(menuId, boardKind)
	{
		// alert(menuId + '/' + boardKind);

		document.all.contentArea.src="${ctxMgr}/newsLetterMgr/popupContentsList?menuId="+menuId+"&boardKind="+boardKind;
	}

	// 게시물을 선택하면 부모창에 값 전달
	function setSelectedContents()
	{
		$("#"+$("#subjectId").val(), opener.document).val($("#subject").val());
		$("#"+$("#linkId").val(), opener.document).val($("#link").val());

		self.close();
	}
</script>
