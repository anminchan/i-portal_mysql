<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentSetMgr/act" method="post">
	<input type="hidden" id="boardId" name="boardId"  value=""/>
	<input type="hidden" id="siteId" name="siteId"  value=""/>
	<input type="hidden" id="menuId" name="menuId"  value="${param.menuId}"/>
	<input type="hidden" id="menu_Name" name="menu_Name"  value=""/>
	<input type="hidden" id="paramMenuId" name="paramMenuId"  value=""/>
	
	<input type="hidden" id="categoryYN" name="categoryYN"  value=""/>
	<input type="hidden" id="customizingYN" name="customizingYN"  value=""/>
	<input type="hidden" id="noticeYN" name="noticeYN"  value=""/>
	<input type="hidden" id="commentYN" name="commentYN"  value=""/>
	<input type="hidden" id="secretYN" name="secretYN"  value=""/>
	<input type="hidden" id="rssYN" name="rssYN"  value=""/>
	<input type="hidden" id="newYN" name="newYN"  value=""/>
	<input type="hidden" id="imageYN" name="imageYN"  value=""/>
	<input type="hidden" id="snsYN" name="snsYN"  value=""/>
	<input type="hidden" id="pageCount" name="pageCount"  value=""/>
	<input type="hidden" id="fileMaxCount" name="fileMaxCount"  value=""/>
	<input type="hidden" id="fileMaxSize" name="fileMaxSize"  value=""/>
	<input type="hidden" id="boardListKind" name="boardListKind"  value=""/>
	<input type="hidden" id="countryYN" name="countryYN"  value=""/>
	<input type="hidden" id="appYN" name="appYN"  value=""/>
	
	<input type="hidden" id="addField1" name="addField1"  value=""/>
	<input type="hidden" id="addField2" name="addField2"  value=""/>
	<input type="hidden" id="addField3" name="addField3"  value=""/>
	<input type="hidden" id="addField4" name="addField4"  value=""/>
	<input type="hidden" id="addField5" name="addField5"  value=""/>
	<input type="hidden" id="addField6" name="addField6"  value=""/>
	<input type="hidden" id="addField7" name="addField7"  value=""/>
	<input type="hidden" id="addField8" name="addField8"  value=""/>
	<input type="hidden" id="addField9" name="addField9"  value=""/>
	<input type="hidden" id="addField10" name="addField10"  value=""/>
	
	<!-- 카테고리 파라메타 hidden -->
	<input type="hidden" id="pCategoryCount" name="pCategoryCount" value=""/>
	<input type="hidden" id="pCategoryId" name="pCategoryId" value=""/>
	<input type="hidden" id="pCategoryName" name="pCategoryName" value=""/>
	
	<input type="hidden" id="pCustomizingCount" name="pCustomizingCount" value=""/>
	<input type="hidden" id="pCustomizingInfo" name="pCustomizingInfo" value=""/>
	
	<!-- 메뉴특성체크 위한 파라메타 hidden -->
	<input type="hidden" id="pChkMenu" name="pChkMenu" value=""/>
	
	<!-- 상태값 사용으로 전달 -->
	<input type="hidden" id="state" name="state" value="T" />
	<article class="treeMenu_area">
		<!-- 트리메뉴 -->
		<div class="tree_nav">		
			<!-- ▼ 사이트 콤보  -->
			<select name="siteIdSel" id="siteIdSel"></select>
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
					<c:if test="${data.menuId == pMenuId}">$("#menu_Name").val('${data.menu_Name}')</c:if>

					<c:set var="strImg" value="" />
					//기본 트리 구성
					<c:if test="${data.menuType eq 'L' || data.menuType eq 'P' || data.menuType eq 'C'}">
						<c:set var="strImg" value="${contextPath }/resources/images/common/tree/${data.menuType}.gif"/>
					</c:if>
					<c:if test="${data.state eq 'T' }">
						<c:if test="${data.boardKind eq 'CONTENTS' }">
							<c:set var="strImg" value="${contextPath }/resources/images/common/tree/H.gif"/>
						</c:if>
						<c:if test="${data.boardKind eq 'NOTICE' || data.boardKind eq 'FREE' || data.boardKind eq 'THUMBNAIL' || data.boardKind eq 'CARD' || 
							data.boardKind eq 'LINK' || data.boardKind eq 'VOD' || data.boardKind eq 'APPEAL' || data.boardKind eq 'CLIPPING' || data.boardKind eq 'REPLY'}">
							<c:set var="strImg" value="${contextPath }/resources/images/common/tree/B.gif"/>
						</c:if>
					</c:if>
					
					var chkMenuIdPath = "${data.namePath}";

					//기본 트리 구성 
					deptTree.add('${data.menuId }', '${data.higherId == "-" ? 0 : data.higherId }', '${data.menu_Name }', <c:choose><c:when test="${data.menuType == 'C' }">"javascript:clickDept('${data.menuId}', '${data.menu_Name}', '${data.siteId}', false);"</c:when><c:otherwise>"javascript:clickDeptMenuType('${data.menu_Name}');"</c:otherwise></c:choose>,'','','${strImg }');
				</c:forEach>
				
				//dTree 화면 출력
				document.write(deptTree);	

				//-->
			</script>
		</div>
		<!-- //트리메뉴 -->
		<!-- 트리메뉴 생성 -->
		<div class="tree_cont">
			<p><span class="point01">*</span> 필수입력항목 입니다.</p>
			<div class="table">
				<table id="tableContentSet" class="tstyle_view">
					<caption>
						콘텐츠설정 상세 정보 입력 - 콘텐츠설정ID, 콘텐츠설정명, 콘텐츠설정설명, 탭콘텐츠설정여부, 정렬순서, 상위콘텐츠설정, 프로그램 URL, 담당자, 고객만족도 여부, 사용여부
					</caption>
					<colgroup>
	                <col class="col-sm-2"/>
					<col class="col-sm-10"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="menu_NameText">메뉴 명</label></th>
							<td><span id="menu_NameText" title="메뉴 명" class="point02"></span></td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="KName">콘텐츠명</label></th>
							<td><input type="text" id="KName" name="KName" value="" class="input_mid02" maxlength="50" title="콘텐츠명" /></td>
						</tr>
						
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="KDesc">콘텐츠 설명</label></th>
							<td><input type="text" id="KDesc" name="KDesc" value="" class="input_long" title="콘텐츠 설명" /></td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="boardKind">콘텐츠 유형</label></th>
							<td>
								<select id="boardKind" name="boardKind" title="콘텐츠 유형" onchange="javascript:fnBoardKindChk();"></select>
							</td>
						</tr>
						<tr  id="trboardListKind" style="display: none;">
							<th scope="row"><label for="boardListKindR">게시판리스트 유형</label></th>
							<td>
								<select id="boardListKindR" name="boardListKindR" title="게시판리스트 유형"></select>
							</td>
						</tr>
						<tr>
							<th scope="row">카테고리 사용여부</th>
							<td>
								<input name="categoryRYN" id="categoryY" value="Y" type="radio" title="사용"/>
								<label for="categoryY">사용</label>
								<input name="categoryRYN" id="categoryN" value="N" type="radio" title="미사용"/>
								<label for="categoryN">미사용</label>
								<button type="button" id="categoryMgr" class="btn btn_small" style="display: none;">카테고리 관리</button>
								<div id="dialog" class="dialog_area" style="display: none;">
									<div id="category_wrap" class="category_wrap">
										<div class="search_area">
											<label>카테고리 명</label>
											<input type="text" name="schText" id="schText" value="" title="검색어"/>
											<input type="hidden" name="schTextHidden" id="schTextHidden" value="" title="검색어 태그 id"/>
											<span class="">
												<input type="button" id="categoryBtnSave" class="btn btn_black" value="저장">
												<input type="button" id="categoryBtnDelete" class="btn btn_black" value="삭제">
											</span>
										</div>
										<div class="table" style="height: 192px; overflow:auto;">
											<table id="categoryTable" class="tstyle_list">
												<caption>
												카테고리
												</caption>
												<colgroup>
													<col class="col-sm-2"/>
													<col class="col-sm-10"/>
												</colgroup>
												<thead>
													<tr>
														<th scope="col" class="none">카테고리 코드</th>
														<th scope="col">카테고리 명</th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="pageCountR">게시글 목록수</label></th>
							<td>
								<select id="pageCountR" name="pageCountR" title="게시글목록수">
									<option value="0">0</option>
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="30">30</option>
									<option value="40">40</option>
									<option value="50">50</option>
									<option value="999999">무제한</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">공지글허용여부</th>
							<td>
								<input name="noticeRYN" id="noticeY" value="Y" type="radio" title="허용"/>
								<label for="noticeY">허용</label>
								<input name="noticeRYN" id="noticeN" value="N" type="radio" title="미허용" />
								<label for="noticeN">미허용</label>
							</td>
						</tr>
						<tr>
							<th scope="row">댓글허용여부</th>
							<td>
								<input name="commentRYN" id="commentY" value="Y" type="radio" title="허용"/>
								<label for="commentY">허용</label>
								<input name="commentRYN" id="commentN" value="N" type="radio" title="미허용" />
								<label for="commentN">미허용</label>
							</td>
						</tr>
						<tr>
							<th scope="row">비밀글허용여부</th>
							<td>
								<input name="secretRYN" id="secretY" value="Y" type="radio" title="허용"/>
								<label for="secretY">허용</label>
								<input name="secretRYN" id="secretN" value="N" type="radio" title="미허용" />
								<label for="secretN">미허용</label>
							</td>
						</tr>
						<tr style="display: none;">
							<th scope="row">RSS적용여부</th>
							<td>
								<input name="rssRYN" id="rssY" value="Y" type="radio" title="적용"/>
								<label for="rssY">적용</label>
								<input name="rssRYN" id="rssN" value="N" type="radio" title="미적용" />
								<label for="rssN">미적용</label>
							</td>
						</tr>
						<tr style="display: none;" id="trImageYN">
							<th scope="row">썸네일형적용</th>
							<td>
								<input name="imageRYN" id="imageY" value="Y" type="radio" title="적용"/>
								<label for="imageY">적용</label>
								<input name="imageRYN" id="imageN" value="N" type="radio" title="미적용" />
								<label for="imageN">미적용</label>
							</td>
						</tr>
						<tr id="trSnsYN" style="display: none;">
							<th scope="row">SNS적용</th>
							<td>
								<input name="snsRYN" id="snsY" value="Y" type="radio" title="적용"/>
								<label for="snsY">적용</label>
								<input name="snsRYN" id="snsN" value="N" type="radio" title="미적용" />
								<label for="snsN">미적용</label>
							</td>
						</tr>
						<tr>
							<th scope="row">신규글표시여부</th>
							<td>
								<input name="newRYN" id="newY" value="Y" type="radio" title="적용"/>
								<label for="newY">적용</label>
								<input name="newRYN" id="newN" value="N" type="radio" title="미적용" />
								<label for="newN">미적용</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="fileMaxCountR">첨부파일최대갯수</label></th>
							<td>
								<select id="fileMaxCountR" name="fileMaxCountR" title="첨부파일최대갯수">
									<option value="0">0</option>
									<option value="1">1</option>
									<option value="3">3</option>
									<option value="5">5</option>
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20">20</option>
									<option value="50">50</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for=fileMaxSizeR>첨부파일최대사이즈</label></th>
							<td><input type="text" id="fileMaxSizeR" name="fileMaxSizeR" value="" class="input_Num" maxlength="8" title="첨부파일최대사이즈" /> MB</td>
						</tr>
						<tr>
							<th scope="row"><label for="countryYN">국가필드적용여부</label></th>
							<td>
								<input name="countryRYN" id="countryY" value="Y" type="radio" title="적용"/>
								<label for="Y">적용</label>
								<input name="countryRYN" id="countryN" value="N" type="radio" title="미적용" />
								<label for="N">미적용</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="appYN">승인기능적용여부</label></th>
							<td>
								<input name="appRYN" id="appY" value="Y" type="radio" title="적용"/>
								<label for="Y">적용</label>
								<input name="appRYN" id="appN" value="N" type="radio" title="미적용" />
								<label for="N">미적용</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR1">텍스트형 추가필드1</label></th>
							<td><input type="text" id="addFieldR1" name="addFieldR1" value="" class="input_mid02" maxlength="10" title="추가필드1" /> 예)필드명 : 요약필드</td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR2">텍스트형 추가필드2</label></th>
							<td><input type="text" id="addFieldR2" name="addFieldR2" value="" class="input_mid02" maxlength="10" title="추가필드2" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR3">텍스트형 추가필드3</label></th>
							<td><input type="text" id="addFieldR3" name="addFieldR3" value="" class="input_mid02" maxlength="10" title="추가필드3" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR7">텍스트형 추가필드4</label></th>
							<td><input type="text" id="addFieldR7" name="addFieldR7" value="" class="input_mid02" maxlength="10" title="추가필드4" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR8">텍스트형 추가필드5</label></th>
							<td><input type="text" id="addFieldR8" name="addFieldR8" value="" class="input_mid02" maxlength="10" title="추가필드5" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR9">텍스트형 추가필드6</label></th>
							<td><input type="text" id="addFieldR9" name="addFieldR9" value="" class="input_mid02" maxlength="10" title="추가필드6" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR10">텍스트형 추가필드7</label></th>
							<td><input type="text" id="addFieldR10" name="addFieldR10" value="" class="input_mid02" maxlength="10" title="추가필드7" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR4">날짜형 추가필드1</label></th>
							<td><input type="text" id="addFieldR4" name="addFieldR4" value="" class="input_mid02" maxlength="10" title="날짜형추가필드1" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR5">날짜형 추가필드2</label></th>
							<td><input type="text" id="addFieldR5" name="addFieldR5" value="" class="input_mid02" maxlength="10" title="날짜형추가필드2" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="addFieldR6">날짜형 추가필드3</label></th>
							<td><input type="text" id="addFieldR6" name="addFieldR6" value="" class="input_mid02" maxlength="10" title="날짜형추가필드3" /></td>
						</tr>
						<!-- <tr id="trConfirmUser" style="display: none;">
							<th scope="row" rowspan="4"><label for="addFieldR3">경영공시 / 사전정보공표</label></th>
							<th scope="row"><label for="addFieldR3">확인자</label></th>
							<td>
								<div id="confirmUserDiv"></div>
								<div class="btn_area_form">
									<span class="float_right">
										<input type="button" id="confirmUserSearchBtn" name="confirmUserSearchBtn" value="검색" class="input_smallBlack" onclick="gfnMemberPopupMultiList('K', 'all', 'S', 'confirmUser');" style="display: none;"/>
									</span>
								</div>
							</td>
						</tr>
						<tr id="trChargeUser" style="display: none;">
							<th scope="row"><label for="addFieldR3">감독자</label></th>
							<td>
								<div id="chargeUserDiv"></div>
								<div class="btn_area_form">
									<span class="float_right">
										<input type="button" id="chargeUserSearchBtn" name="chargeUserIDSearchBtn" value="검색" class="input_smallBlack" onclick="gfnMemberPopupMultiList('K', 'all', 'S', 'chargeUser');" style="display: none;"/>
									</span>
								</div>
							</td>
						</tr>
						<tr id="trWriteUser" style="display: none;">
							<th scope="row"><label for="addFieldR3">작성자</label></th>
							<td>
								<div id="writeUserDiv"></div>
								<div class="btn_area_form">
									<span class="float_right">
										<input type="button" id="writeUserSearchBtn" name="writeUserSearchBtn" value="검색" class="input_smallBlack" onclick="gfnMemberPopupMultiList('K', 'all', 'S', 'writeUser');" style="display: none;"/>
									</span>
								</div>
							</td>
						</tr>
						<tr id="trWrite2User" style="display: none;">
							<th scope="row"><label for="addFieldR3">작성자2</label></th>
							<td>
								<div id="writeUser2Div"></div>
								<div class="btn_area_form">
									<span class="float_right">
										<input type="button" id="writeUser2SearchBtn" name="writeUser2SearchBtn" value="검색" class="input_smallBlack" onclick="gfnMemberPopupMultiList('T', 'all', 'S', 'writeUser2');" style="display: none;"/>
									</span>
								</div>
							</td>
						</tr> -->
						<!-- <tr>
							<th scope="row"><label for="stateYN">사용여부</label></th>
							<td>
								<input name="state" id="stateY" value="T" type="radio" title="사용"/>
								<label for="T">사용</label>
								<input name="state" id="stateN" value="F" type="radio" title="미사용"/>
								<label for="F">미사용</label>
							</td>
						</tr> -->
						<tr>
							<th scope="row">콘텐츠추가정보</th>
							<td>							
								<!-- ▼ 내용  -->
								<textarea id="boardHeaderKHtml" name="boardHeaderKHtml" rows="" cols="" style="display: none;"></textarea>
								<textarea id="boardFooterKHtml" name="boardFooterKHtml" rows="" cols="" style="display: none;"></textarea>
								<div id="tableContents" class="board_infoAdd">
									<button type="button" class="btn btn_type01" onClick="javascript:gfnEditorPopup('boardHeaderKHtml');">HEADER</button>
			                    	<button type="button" class="btn btn_type01" onClick="javascript:gfnEditorPopup('boardFooterKHtml');">FOOTER</button>
								<%--<c:if test="${editor eq 'Namo'}">
									<!-- ▼ 에디터 -->  
					                <script type="text/javascript">         
					                    var CrossEditorHeader = new NamoSE('boardHeader');
					                    CrossEditorHeader.params.Width = "100%";
					                    CrossEditorHeader.EditorStart();
					                    function OnInitCompleted(e){
					                        e.editorTarget.SetBodyValue(document.getElementById("boardHeaderKHtml").value);
				                        }
					                </script>
				                    <!-- ▲ 에디터  -->
				                    
				                    <!-- ▼ 에디터 -->  
					                <script type="text/javascript">         
					                    var CrossEditorFooter = new NamoSE('boardFooter');
					                    CrossEditorFooter.params.Width = "100%";
					                    CrossEditorFooter.EditorStart();
					                    function OnInitCompleted(e){
					                        e.editorTarget.SetBodyValue(document.getElementById("boardFooterKHtml").value);
				                        }
					                </script>
				                    <!-- ▲ 에디터  -->
			                    </c:if>
			                    <c:if test="${editor eq 'Daum'}">
			                    	<button type="button" class="btn_colorType01" onClick="javascript:gfnEditorPopup('boardHeaderKHtml');">HEADER</button>
			                    	<button type="button" class="btn_colorType01" onClick="javascript:gfnEditorPopup('boardFooterKHtml');">FOOTER</button>
			                    </c:if> --%>
								</div>							
							</td>
						</tr>	
						<tr>
							<th scope="row">게시판목록 정의사용여부</th>
							<td>
								<input name="customizingRYN" id="customizingY" value="Y" type="radio" title="사용"/>
								<label for="customizingY">사용</label>
								<input name="customizingRYN" id="customizingN" value="N" type="radio" title="미사용"/>
								<label for="customizingN">미사용</label>
								<button type="button" id="customizingMgr" class="btn btn_small" style="display: none;">목록형태 관리</button>
								<div id="customizingDialog" class="selector" style="display: none;">
									<h2>목록 항목 리스트</h2>
									<div class="table">
										<table class="tstyle_list">
											<colgroup>
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">구분</th>
												</tr>
											</thead>
											<tbody class="customizingListBody">
											<tr>
												<td>
													<select id="customizingSelect" name="customizingSelect" style="width: 100%" size="10"></select>
												</td>
											</tr>
											</tbody>
										</table>
										<p><span style="background-color: #FFFFCC">사용</span>&nbsp;&nbsp;
											<span style="background-color: #F8E0E0">미사용</span>&nbsp;&nbsp;
											<span style="background-color: #CCFFCC">변경</span>
										</p>
										<div class="btn_area">
											<input type="button" value="위로" class="btn btn_type01" onclick="fnSortCustomizing('U');" />
											<input type="button" value="아래로" class="btn btn_type01" onclick="fnSortCustomizing('D');" />
										</div>
									</div>
									
									<h2>목록 항목 상세정보</h2>
									<div class="table">
										<table class="tstyle_view">
											<colgroup>
												<col width="15%"/>
												<col />
											</colgroup>
											<tbody class="customizingListBody">
												<tr>
													<th scope="row">목록 항목 명</th>
													<td>
														<input type="text" name="customizingColName" id="customizingColName" />
													</td>
												</tr>
												<tr>
													<th scope="row">사이즈</th>
													<td>
														<input type="text" name="customizingColSize" id="customizingColSize" /> %(100% 인 경우 동적 퍼센트 적용)
													</td>
												</tr>
												<tr>
													<th scope="row">사용여부</th>
													<td>
														<input type="radio" name="customizingColYN" id="customizingColY" value="Y" /> 사용
														<input type="radio" name="customizingColYN" id="customizingColN" value="N" /> 미사용
													</td>
												</tr>
											</tbody>
										</table>
										<div class="btn_area">
											<input type="button" value="변경" class="btn btn_type01" onclick="fnModigyCustomizing();" />
										</div>
									</div>
								</div>
							</td>
						</tr>				
					</tbody>
				</table>
			</div>
			
			<div class="btn_area">
				<button type="button" class="btn btn_type03" id="btnMoveContent">콘텐츠등록관리이동</button>
				<button type="button" class="btn btn_type02" id="btnSave">저장</button>
			</div>		
		</div>
		<!-- //트리메뉴 생성 -->
	</article>

</spform:form>
	
<script type="text/javascript">

var contentCnt = 0;
var preBoardKindVal;

$(function() {
	// 테이블 전체 disabled
	$("#tableContentSet").prop("disabled", true);
	
	var pMenuId = "${pMenuId}"; // 파라메터 메뉴id
	var pSiteId = "${pSiteId}"; // 파라메터 사이트id
	var pAction = "${pAction}"; // 저장/수정
	var pChkMenu = "${pChkMenu}"; // 특성메뉴체크

	if(pMenuId == "") $("#menu_NameText").text("[메뉴를 선택하여 등록바랍니다.]");
	/*
	  함수호출
	*/
	//common.js 정의
	gfnSiteAdminComboList($("#siteIdSel"), "", "", "${pSiteId}"); // 사이트 select세팅	
	gfnCodeComboList($("#boardKind"), "BoardKind", "0", "코드 선택", "0"); // 콘테츠유형 select세팅
	gfnCodeComboList($("#boardListKindR"), "BoardListKind", "0", "코드 선택", "0"); // 게시판리스트유형 select세팅

	// 사이트 설정
	$("#siteId").val("${pSiteId}");

	/*
	  함수호출
	*/
	
	/*
	  세팅
	*/
	$("input:radio[name='noticeRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='commentRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='secretRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='rssRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='newRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='countryRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='appRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='imageRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='snsRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='categoryRYN']:radio[value='N']").prop("checked", true);
	$("input:radio[name='customizingRYN']:radio[value='N']").prop("checked", true);
	
	$("#boardListKindR").val("BASE").prop("selected", "selected"); // 게시판리스트유형 갯수
	$("#pageCountR").val("10").prop("selected", "selected"); // 목록 갯수
	$("#fileMaxCountR").val("3").prop("selected", "selected"); // 목록 갯수
	$("#fileMaxSizeR").val("5120");
	
	/*
	  세팅
	*/

	/*
	  체인지이벤트
	*/
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		location.href = "${ctxMgr}/contentSetMgr?menuId="+$('#menuId').val()+"&siteId="+$(this).val();
	});

	$('#boardKind').on("change", function() { // 메뉴타입 이벤트
		if($(this).val() == "CONTENTS"){
			// 현재입력값 세팅
			$("#categoryYN").val($("input[name='categoryRYN']:radio:checked").val());
			$("#customizingYN").val($("input[name='customizingRYN']:radio:checked").val());
 	 		$("#noticeYN").val($("input[name='noticeRYN']:radio:checked").val());
 	 		$("#commentYN").val($("input[name='commentRYN']:radio:checked").val());
 	 		$("#secretYN").val($("input[name='secretRYN']:radio:checked").val());
 	 		$("#rssYN").val($("input[name='rssRYN']:radio:checked").val());
 	 		$("#newYN").val($("input[name='newRYN']:radio:checked").val());
 	 		$("#countryYN").val($("input[name='countryRYN']:radio:checked").val());
 	 		$("#appYN").val($("input[name='appRYN']:radio:checked").val());
 	 		$("#imageYN").val($("input[name='imageRYN']:radio:checked").val());
 	 		$("#snsYN").val($("input[name='snsRYN']:radio:checked").val());
 	 		
 	 		$("#boardListKind").val($("#boardListKindR option:selected").val()); // 게시판리스트유형
 	 		$("#pageCount").val($("#pageCountR option:selected").val()); // 게시글목록갯수
 	 		$("#fileMaxCount").val($("#fileMaxCountR option:selected").val()); // 파일최대갯수
			$('#fileMaxSize').val($("#fileMaxSizeR").val());
			$('#addField1').val($("#addFieldR1").val());
			$('#addField2').val($("#addFieldR2").val());
			$('#addField3').val($("#addFieldR3").val());
			$('#addField4').val($("#addFieldR4").val());
			$('#addField5').val($("#addFieldR5").val());
			$('#addField6').val($("#addFieldR6").val());
			$('#addField7').val($("#addFieldR7").val());
			$('#addField8').val($("#addFieldR8").val());
			$('#addField9').val($("#addFieldR9").val());
			$('#addField10').val($("#addFieldR10").val());
 	 		
			// 공지글허용여부/댓글허용여부/비밀글허용여부/RSS적용여부 기본값 'N'
			$("input:radio[name='categoryRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='customizingRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='noticeRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='commentRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='secretRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='rssRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='newRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='countryRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='appRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='imageRYN']:radio[value='N']").prop("checked", true);
			$("input:radio[name='snsRYN']:radio[value='N']").prop("checked", true);
			//$("input:radio[name='state']:radio[value='T']").prop("checked", true);
			
			$("#boardListKindR").val("0").prop("selected", "selected"); // 게시판리스트유형
			$("#pageCountR").val("0").prop("selected", "selected"); // 목록 갯수
			
			// 첨부파일 세팅
			$("#fileMaxCountR").val("0").prop("selected", "selected"); // 콘텐츠 유형
			$("#fileMaxSizeR").val("5120");
			
			// 추가 필드
			$('#addFieldR1').val("");
			$('#addFieldR2').val("");
			$('#addFieldR3').val("");
			$('#addFieldR4').val("");
			$('#addFieldR5').val("");
			$('#addFieldR6').val("");
			$('#addFieldR7').val("");
			$('#addFieldR8').val("");
			$('#addFieldR9').val("");
			$('#addFieldR10').val("");
			
			// 정적콘텐츠일 경우 태그 disbled
			$("input[name='categoryRYN']").prop("disabled", "disabled");
			$("input[name='customizingRYN']").prop("disabled", "disabled");
			$('#boardListKindR').prop("disabled", "disabled");
			$('#pageCountR').prop("disabled", "disabled");
			$('#fileMaxCountR').prop("disabled", "disabled");
			$('#fileMaxSizeR').prop("disabled", "disabled");
			$("input[name='noticeRYN']").prop("disabled", "disabled");
			$("input[name='commentRYN']").prop("disabled", "disabled");
			$("input[name='secretRYN']").prop("disabled", "disabled");
			$("input[name='rssRYN']").prop("disabled", "disabled");
			$("input[name='newRYN']").prop("disabled", "disabled");
			$("input[name='countryRYN']").prop("disabled", "disabled");
			$("input[name='appRYN']").prop("disabled", "disabled");
			$("input[name='imageRYN']").prop("disabled", "disabled");
			$("input[name='snsRYN']").prop("disabled", "disabled");
			$('#addFieldR1').prop("disabled", "disabled");
			$('#addFieldR2').prop("disabled", "disabled");
			$('#addFieldR3').prop("disabled", "disabled");
			$('#addFieldR4').prop("disabled", "disabled");
			$('#addFieldR5').prop("disabled", "disabled");
			$('#addFieldR6').prop("disabled", "disabled");
			$('#addFieldR7').prop("disabled", "disabled");
			$('#addFieldR8').prop("disabled", "disabled");
			$('#addFieldR9').prop("disabled", "disabled");
			$('#addFieldR10').prop("disabled", "disabled");
			
			// 카테고리관리
			$("#categoryMgr").hide();
			$("#customizingMgr").hide();
			$("#trboardListKind").hide();
			
		}else{
			$("#categoryYN").val($("input[name='categoryRYN']:radio:checked").val());
			$("#customizingYN").val($("input[name='customizingRYN']:radio:checked").val());
			$("#noticeYN").val($("input[name='noticeRYN']:radio:checked").val());
			$("#commentYN").val($("input[name='commentRYN']:radio:checked").val());
			$("#secretYN").val($("input[name='secretRYN']:radio:checked").val());
			$("#rssYN").val($("input[name='rssRYN']:radio:checked").val());
			$("#newYN").val($("input[name='newRYN']:radio:checked").val());
			$("#countryYN").val($("input[name='countryRYN']:radio:checked").val());
			$("#appYN").val($("input[name='appRYN']:radio:checked").val());
			$("#imageYN").val($("input[name='imageRYN']:radio:checked").val());
			$("#snsYN").val($("input[name='snsRYN']:radio:checked").val());
			
			// 과거선택값 세팅 START
			if($("#categoryYN").val() != "") $("input:radio[name='categoryRYN']:radio[value='"+ $("#categoryYN").val() +"']").prop("checked", true);
			if($("#customizingYN").val() != "") $("input:radio[name='customizingRYN']:radio[value='"+ $("#customizingYN").val() +"']").prop("checked", true);
			if($("#noticeYN").val() != "") $("input:radio[name='noticeRYN']:radio[value='"+ $("#noticeYN").val() +"']").prop("checked", true);
			if($("#commentYN").val() != "") $("input:radio[name='commentRYN']:radio[value='"+ $("#commentYN").val() +"']").prop("checked", true);
			if($("#secretYN").val() != "") $("input:radio[name='secretRYN']:radio[value='"+ $("#secretYN").val() +"']").prop("checked", true);
			if($("#rssYN").val() != "") $("input:radio[name='rssRYN']:radio[value='"+ $("#rssYN").val() +"']").prop("checked", true);
			if($("#newYN").val() != "") $("input:radio[name='newRYN']:radio[value='"+ $("#newYN").val() +"']").prop("checked", true);
			if($("#countryYN").val() != "") $("input:radio[name='countryRYN']:radio[value='"+ $("#countryYN").val() +"']").prop("checked", true);
			if($("#appYN").val() != "") $("input:radio[name='appRYN']:radio[value='"+ $("#appYN").val() +"']").prop("checked", true);
			if($("#imageYN").val() != "") $("input:radio[name='imageRYN']:radio[value='"+ $("#imageYN").val() +"']").prop("checked", true);
			if($("#snsYN").val() != "") $("input:radio[name='snsRYN']:radio[value='"+ $("#snsYN").val() +"']").prop("checked", true);
 	 		
 	 		if(($("#boardListKind").val() != "0" && $("#boardListKind").val() != "")) $("#boardListKindR").val($("#boardListKind").val()).prop("selected", "selected"); // 게시판리스트유형
 	 		if(($("#pageCount").val() != "0" && $("#pageCount").val() != "")) $("#pageCountR").val($("#pageCount").val()).prop("selected", "selected"); // 게시글목록갯수
 	 		if(($("#fileMaxCount").val() != "0" && $("#fileMaxCount").val() != ""))	$("#fileMaxCountR").val($("#fileMaxCount").val()).prop("selected", "selected"); // 파일최대갯수
 	 		
			if($("#boardListKind").val() == "") $("#boardListKindR").val("BASE").prop("selected", "selected"); // 게시판리스트유형
			if($("#pageCount").val() == "") $("#pageCountR").val("10").prop("selected", "selected"); // 게시글목록갯수
			if($("#fileMaxCount").val() == "") $("#fileMaxCountR").val("3").prop("selected", "selected"); // 파일최대갯수
 	 		
			if(($("#fileMaxSize").val() != "0" && $("#fileMaxSize").val() != "")) $('#fileMaxSizeR').val($("#fileMaxSize").val());
			if($("#addField1").val() != "") $('#addFieldR1').val($("#addField1").val());
			if($("#addField2").val() != "") $('#addFieldR2').val($("#addField2").val());
			if($("#addField3").val() != "") $('#addFieldR3').val($("#addField3").val());
			if($("#addField4").val() != "") $('#addFieldR4').val($("#addField4").val());
			if($("#addField5").val() != "") $('#addFieldR5').val($("#addField5").val());
			if($("#addField6").val() != "") $('#addFieldR6').val($("#addField6").val());
			if($("#addField7").val() != "") $('#addFieldR7').val($("#addField7").val());
			if($("#addField8").val() != "") $('#addFieldR8').val($("#addField8").val());
			if($("#addField9").val() != "") $('#addFieldR9').val($("#addField9").val());
			if($("#addField10").val() != "") $('#addFieldR10').val($("#addField10").val());
 	 		// 과거선택값 세팅 END
 	 		
			// radio 값 전달
			$("#categoryYN").val($("input[name='categoryRYN']:radio:checked").val());
			$("#customizingYN").val($("input[name='customizingRYN']:radio:checked").val());
			$("#noticeYN").val($("input[name='noticeRYN']:radio:checked").val());
			$("#commentYN").val($("input[name='commentRYN']:radio:checked").val());
			$("#secretYN").val($("input[name='secretRYN']:radio:checked").val());
			$("#rssYN").val($("input[name='rssRYN']:radio:checked").val());
			$("#newYN").val($("input[name='newRYN']:radio:checked").val());
			$("#countryYN").val($("input[name='countryRYN']:radio:checked").val());
			$("#appYN").val($("input[name='appRYN']:radio:checked").val());
			$("#imageYN").val($("input[name='imageRYN']:radio:checked").val());
			$("#snsYN").val($("input[name='snsRYN']:radio:checked").val());
			
			// select 값 전달
			$("#boardListKind").val($("#boardListKindR option:selected").val());
			$("#pageCount").val($("#pageCountR option:selected").val());
			$("#fileMaxCount").val($("#fileMaxCountR option:selected").val());
			$('#fileMaxSize').val($("#fileMaxSizeR").val());
			
			$('#addField1').val($("#addFieldR1").val());
			$('#addField2').val($("#addFieldR2").val());
			$('#addField3').val($("#addFieldR3").val());
			$('#addField4').val($("#addFieldR4").val());
			$('#addField5').val($("#addFieldR5").val());
			$('#addField6').val($("#addFieldR6").val());
			$('#addField7').val($("#addFieldR7").val());
			$('#addField8').val($("#addFieldR8").val());
			$('#addField9').val($("#addFieldR9").val());
			$('#addField10').val($("#addFieldR10").val());

			// 정적콘텐츠 외 태그 show
			$("input[name='categoryRYN']").prop("disabled", false);
			$("input[name='customizingRYN']").prop("disabled", false);
			$('#boardListKindR').prop("disabled", false);
			$('#pageCountR').prop("disabled", false);
			$('#fileMaxCountR').prop("disabled", false);
			$('#fileMaxSizeR').prop("disabled", false);
			$("input[name='noticeRYN']").prop("disabled", false);
			$("input[name='commentRYN']").prop("disabled", false);
			$("input[name='secretRYN']").prop("disabled", false);
			$("input[name='rssRYN']").prop("disabled", false);
			$("input[name='newRYN']").prop("disabled", false);
			$("input[name='countryRYN']").prop("disabled", false);
			$("input[name='appRYN']").prop("disabled", false);
			$("input[name='imageRYN']").prop("disabled", false);
			$("input[name='snsRYN']").prop("disabled", false);
			if($(this).val() == "NOTICE" || $(this).val() == "LINK"){
				//$("#trImageYN").show();
				//$("#trboardListKind").show();
			}else{
				//$("#trImageYN").hide();
				//$("#trboardListKind").hide();
			}
			
			if($(this).val() == "NOTICE" || $(this).val() == "FREE"){
				$("#trboardListKind").show();
			}else{
				$("#trboardListKind").hide();
			}
			
			$('#addFieldR1').prop("disabled", false);
			$('#addFieldR2').prop("disabled", false);
			$('#addFieldR3').prop("disabled", false);
			$('#addFieldR4').prop("disabled", false);
			$('#addFieldR5').prop("disabled", false);
			$('#addFieldR6').prop("disabled", false);
			$('#addFieldR7').prop("disabled", false);
			$('#addFieldR8').prop("disabled", false);
			$('#addFieldR9').prop("disabled", false);
			$('#addFieldR10').prop("disabled", false);
			
			// 카테고리관리
			if($("#categoryYN").val() == "Y") $("#categoryMgr").show();
			else $("#categoryMgr").hide();
			// 게시판목록정의관리
			if($("#customizingYN").val() == "Y") $("#customizingMgr").show();
			else $("#customizingMgr").hide();
		}

	});
	
	// 카테고리 사용여부 이벤트
	$('input[name="categoryRYN"]:radio').on("change", function() {
		if($(this).val() == "Y") $("#categoryMgr").show();
		else $("#categoryMgr").hide();
	});
	
	$('input[name="customizingRYN"]:radio').on("change", function() {
		if($(this).val() == "Y") $("#customizingMgr").show();
		else $("#customizingMgr").hide();
	});
	
	/*
	  체인지이벤트
	*/
	
	// 숫자만입력
	$(".input_Num").keyup(function(){
		if($(this).val().match(/[^0-9]/g) != null){
			alert("숫자만 입력이 가능합니다.");	
			$(this).val( $(this).val().replace(/[^0-9]/g, ''));
		}
	});

	/*
	  클릭이벤트
	*/	
	//저장
	$("#btnSave").click(function(){
		if($("#KName").val().length <= 0) {
			alert("콘텐츠명을 입력해주시기 바랍니다.");
			$("#KName").focus();
			return false;
		}
		if($("#KDesc").val().length <= 0) {
			alert("콘텐츠설명을 입력해주시기 바랍니다.");
			$("#KDesc").focus();
			return false;
		}
		if($("#boardKind option:selected").val() == 0){
			alert("콘텐트유형을 선택해주시기 바랍니다.");
			$("#boardKind").focus();
			return false;
		}
	
		if($("#boardKind option:selected").val() == "CONTENTS"){
			// 저장시 disabled 태그 값 초기화
			$("#categoryYN").val("N");
			$("#noticeYN").val("N");
			$("#commentYN").val("N");
			$("#secretYN").val("N");
			$("#rssYN").val("N");
			$("#newYN").val("N");
			$("#countryYN").val("N");
			$("#appYN").val("N");
			$("#imageYN").val("N");
			$("#snsYN").val("N");
		
			// 저장시 disabled 태그 값 초기화
			$("#pageCount").val("0");
			$("#fileMaxCount").val("0");
			$("#fileMaxSize").val("0");
			
			//추가필드 	 				
			$("#addField1").val("");
			$("#addField2").val("");
			$("#addField3").val("");
			$("#addField4").val("");
			$("#addField5").val("");
			$("#addField6").val("");
			$("#addField7").val("");
			$("#addField8").val("");
			$("#addField9").val("");
			$("#addField10").val("");
			
			// 카테고리 사용여부
			if($("input[name='categoryRYN']:radio:checked").val() == "N"){
				$('#pCategoryCount').val("");
				$("#pCategoryId").val("");
				$("#pCategoryName").val("");
			}
			
			// 카테고리 사용여부
			if($("input[name='customizingRYN']:radio:checked").val() == "N"){
				$('#pCustomizingCount').val("");
				$("#pCustomizingInfo").val("");
			}
			
		}else{
			// radio 값 전달
			$("#categoryYN").val($("input[name='categoryRYN']:radio:checked").val());
			$("#customizingYN").val($("input[name='customizingRYN']:radio:checked").val());
			$("#noticeYN").val($("input[name='noticeRYN']:radio:checked").val());
			$("#commentYN").val($("input[name='commentRYN']:radio:checked").val());
			$("#secretYN").val($("input[name='secretRYN']:radio:checked").val());
			$("#rssYN").val($("input[name='rssRYN']:radio:checked").val());
			$("#newYN").val($("input[name='newRYN']:radio:checked").val());
			$("#countryYN").val($("input[name='countryRYN']:radio:checked").val());
			$("#appYN").val($("input[name='appRYN']:radio:checked").val());
			$("#imageYN").val($("input[name='imageRYN']:radio:checked").val());
			$("#snsYN").val($("input[name='snsRYN']:radio:checked").val());
		
			// select 값 전달
			$("#boardListKind").val($("#boardListKindR option:selected").val());
			$("#pageCount").val($("#pageCountR option:selected").val());
			$("#fileMaxCount").val($("#fileMaxCountR option:selected").val());
			$("#fileMaxSize").val($("#fileMaxSizeR").val());
			
			//추가필드 	 				
			$("#addField1").val($("#addFieldR1").val());
			$("#addField2").val($("#addFieldR2").val());
			$("#addField3").val($("#addFieldR3").val());
			$("#addField4").val($("#addFieldR4").val());
			$("#addField5").val($("#addFieldR5").val());
			$("#addField6").val($("#addFieldR6").val());
			$("#addField7").val($("#addFieldR7").val());
			$("#addField8").val($("#addFieldR8").val());
			$("#addField9").val($("#addFieldR9").val());
			$("#addField10").val($("#addFieldR10").val());
			
			// 카테고리 사용여부
			//if($("input[name='categoryRYN']:radio:checked").val() == "Y"){}
				
			if($(".categoryTr").length != 0){
				var pCategoryId ="";
				var pCategoryName = "";
				var categoryLength = $(".categoryTr").length-1;
				$('.categoryTr').each(function(n){
					
					if(categoryLength > n){
						pCategoryId += $("#categoryId"+n).text()+"#";
						pCategoryName += $("#categoryName"+n).text()+"#";
					}else{
						pCategoryId += $("#categoryId"+n).text();
						pCategoryName += $("#categoryName"+n).text();
					}
				});
				
				$('#pCategoryCount').val($(".categoryTr").length);
				$("#pCategoryId").val(pCategoryId);
				$("#pCategoryName").val(pCategoryName);	
			}
			
			// 게시판 기본 설정 시 목록 수정
			if($("#customizingSelect").html().indexOf('COUNTRYNAME') > -1) if($("input[name='countryRYN']:radio:checked").val() == 'N') $("select[name='customizingSelect'] option[info='COUNTRYNAME']").remove();
			if($("#customizingSelect").html().indexOf('CATEGORYNAME') > -1) if($("input[name='categoryRYN']:radio:checked").val() == 'N') $("select[name='customizingSelect'] option[info='CATEGORYNAME']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS1') > -1) if($("#addFieldR1").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS1']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS2') > -1) if($("#addFieldR2").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS2']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS3') > -1) if($("#addFieldR3").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS3']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS4') > -1) if($("#addFieldR4").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS4']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS5') > -1) if($("#addFieldR5").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS5']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS6') > -1) if($("#addFieldR6").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS6']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS7') > -1) if($("#addFieldR7").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS7']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS8') > -1) if($("#addFieldR7").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS8']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS9') > -1) if($("#addFieldR8").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS9']").remove();
			if($("#customizingSelect").html().indexOf('CONTENTS10')> -1) if($("#addFieldR10").val() == '') $("select[name='customizingSelect'] option[info=CONTENTS10']").remove();
			
			// CLIPPING형 게시판
			if($("#boardKind option:selected").val() != '' && $("#boardKind option:selected").val() != 'CLIPPING'){
				if($("#customizingSelect").html().indexOf('ORIGIN') > -1) $("select[name='customizingSelect'] option[info=ORIGIN']").remove();
				if($("#customizingSelect").html().indexOf('REPORTTIME') > -1) $("select[name='customizingSelect'] option[info=REPORTTIME']").remove();
			}
			
			if($("#customizingSelect option").size() > 0){
				var pCustomizingInfo ="";
				$('#customizingSelect option').each(function(n){
					if($("#customizingSelect option").size() > n+1){
						pCustomizingInfo += $(this).val()+"§§"+$(this).text()+"#";
					}else{
						pCustomizingInfo += $(this).val()+"§§"+$(this).text();
					}
				});
				
				$('#pCustomizingCount').val($("#customizingSelect option").size());
				$("#pCustomizingInfo").val(pCustomizingInfo);
			}
			
			if($("#boardKind option:selected").val() == "NOTICE"){
				if($("#boardListKindR option:selected").val() == 0){
					alert("게시판리스트유형을 선택해주시기 바랍니다.");
					$("#boardListKindR").focus();
					return false;
				}
			}
			
			if($("#pageCountR option:selected").val() == 0){
				alert("게시글 목록 수를 선택해주시기 바랍니다.");
				$("#pageCountR").focus();
				return false;
			}
		}

		// 경영공시 ID세팅 Array 선언
		/* var confirmUserArray = new Array();
		var chargeUserArray = new Array();
		var writeUserArray = new Array();
		var writeUser2Array = new Array();
		
		// 경영공시 UserID 세팅
		$("#confirmUserDiv >div>input").each(function(i){ // 확인자
			confirmUserArray.push($("#"+$(this).prop("id")).val());
		});
		$("#chargeUserDiv >div>input").each(function(j){ // 감독자
			chargeUserArray.push($("#"+$(this).prop("id")).val());
		});
		$("#writeUserDiv div>input").each(function(k){ // 작성자
			writeUserArray.push($("#"+$(this).prop("id")).val());
		});
		$("#writeUser2Div div>input").each(function(k){ // 작성자2
			writeUser2Array.push($("#"+$(this).prop("id")).val());
		}); */
		
		// DB저장 형태 세팅
		/* $("#pConfirmUserId").val(confirmUserArray);
		$("#pChargeUserId").val(chargeUserArray);
		$("#pWriteUserId").val(writeUserArray);
		$("#pWriteUser2Id").val(writeUser2Array); */
		
		// 경영공시 UserCount
		/* $("#pConfirmUserCount").val(confirmUserArray.length);
		$("#pChargeUserCount").val(chargeUserArray.length);
		$("#pWriteUserCount").val(writeUserArray.length);
		$("#pWriteUser2Count").val(writeUser2Array.length); */
		
		/* $("#pConfirmUserId").val($("#pConfirmUserId").val().replace(/,/gi, "#"));
		$("#pChargeUserId").val($("#pChargeUserId").val().replace(/,/gi, "#"));
		$("#pWriteUserId").val($("#pWriteUserId").val().replace(/,/gi, "#"));
		$("#pWriteUser2Id").val($("#pWriteUser2Id").val().replace(/,/gi, "#")); */
		
		//콘텐츠 header/footer
		// 다음에디터, 나모에디터 구분 Start
		/* if("${editor}" == "Namo"){
			$("#boardHeaderKHtml").val(CrossEditorHeader.GetBodyValue());
			$("#boardFooterKHtml").val(CrossEditorFooter.GetBodyValue());
		} */
		// 다음에디터, 나모에디터 구분 End

		// confirm
		if(!confirm("저장하시겠습니까?")) {
			return false;
		}

		// 전송
		$("#insertForm").submit();
		
	});
	
	// 카테고리 관리 클릭
	$("#categoryMgr").click(function(){
		$("#dialog").dialog({
			width: 600,
			height: 500,
			resizable: false,
			modal: true,
			title: "카테고리 관리",
			buttons:{
				"OK": function(){
					$(this).dialog("close");	
				}
			}
		});
	});
	
	// 카테고리 dialog 저장 버튼 이벤트
	$("#categoryBtnSave").click(function(){
		var schTextHidden = $("#schTextHidden").val().split(","); //카테고리 목록에서 클릭하여 수정하는 경우
		
		if(schTextHidden == ""){//신규
			if($("#schText").val() == ""){
				alert("카테고리명을 입력하여 저장바랍니다.");
				$("#schText").focus();
				return false;
			}else{
				var categoryTrlen = $(".categoryTr").length;
				
				if(categoryTrlen == 0){
					$('#categoryTable').append('<tr id="categoryTr'+categoryTrlen+'" class="categoryTr"><td><span id="categoryId'+categoryTrlen+'"></span></td><td><a href="javascript:fnCategory('+"'categoryTr"+categoryTrlen+"', 'categoryName"+categoryTrlen+"'"+');"><span id="categoryName'+categoryTrlen+'"></span></a></td></tr>');

					$("#categoryId"+categoryTrlen).text("0"+(categoryTrlen+1));
					$("#categoryName"+categoryTrlen).text($("#schText").val());
					
					$("#schText").val("");
					$("#schText").focus();
				}else{
					var setCategoryNameTmp = "";
					$('.categoryTr').each(function(n, tmp){
						$(this).find("span").each(function(x){
							if(x == 1){							
								if(categoryTrlen > n) setCategoryNameTmp += $("#"+$(this).prop("id")).text()+"||";
							}
						});
					});					
					setCategoryNameTmp += $("#schText").val(); //모든 카테고리명 정렬
					
					// 카테고리 목록 재 세팅을 위해 현재 tr 태그 삭제
					$(".categoryTr").remove();
					
					var setCategoryNameTmpData = setCategoryNameTmp.split("||");
					$.each(setCategoryNameTmpData, function(m){					
						$('#categoryTable').append('<tr id="categoryTr'+m+'" class="categoryTr"><td><span id="categoryId'+m+'"></span></td><td><a href="javascript:fnCategory('+"'categoryTr"+m+"', 'categoryName"+m+"'"+');"><span id="categoryName'+m+'"></span></a></td></tr>');
						
						if(m < 9) $("#categoryId"+m).text("0"+(m+1));
						else  $("#categoryId"+m).text((m+1));
						
						$("#categoryName"+m).text(setCategoryNameTmpData[m]);
					});
					
					$("#schText").val("");
					$("#schText").focus();
				}
			}
		}else{ // 목록 링크 클릭 하여 수정
			if($("#schText").val() == ""){
				alert("카테고리명을 입력하여 저장바랍니다.");
				$("#schText").focus();
				return false;
			}else{
				$("#"+schTextHidden[1]).text($("#schText").val()); //카테고리 수정
				
				$("#schTextHidden").val("");
				$("#schText").val("");
				$("#schText").focus();
			}
		}
			
	});
	
	// 카테고리 dialog 삭제 버튼 이벤트
	$("#categoryBtnDelete").click(function(){
		var schTextHidden = $("#schTextHidden").val().split(","); //카테고리 목록에서 클릭하여 수정하는 경우
		
		if($("#schText").val() == ""){
			alert("삭제할 카테고리명을 클릭하여 삭제바랍니다.");
			return false;
		}else{
			if(schTextHidden != ""){

				$("#"+schTextHidden[0]).remove();

				var categoryTrlen = $(".categoryTr").length-1;
				var setCategoryNameTmp = "";
				var trlen = "";
				
				if($(".categoryTr").length != 0){
					$('.categoryTr').each(function(n, tmp){
						trlen = $(this).find("span").prop("id").replace("categoryId", '');
						if(categoryTrlen > n) setCategoryNameTmp += $("#categoryName"+trlen).text()+"||";
						else  setCategoryNameTmp += $("#categoryName"+trlen).text();
					});
										
					// 카테고리 목록 재 세팅을 위해 현재 tr 태그 삭제
					$(".categoryTr").remove();
					
					var setCategoryNameTmpData = setCategoryNameTmp.split("||");
					$.each(setCategoryNameTmpData, function(m){					
						$('#categoryTable').append('<tr id="categoryTr'+m+'" class="categoryTr"><td><span id="categoryId'+m+'"></span></td><td><a href="javascript:fnCategory('+"'categoryTr"+m+"', 'categoryName"+m+"'"+');"><span id="categoryName'+m+'"></span></a></td></tr>');
						
						if(m < 9) $("#categoryId"+m).text("0"+(m+1));
						else $("#categoryId"+m).text((m+1));
						
						$("#categoryName"+m).text(setCategoryNameTmpData[m]);
					});
				}
				
				// 카테고리 input focus
				$("#schTextHidden").val("");
				$("#schText").val("");
				$("#schText").focus();
			}else{
				alert("정확히 카테고리명을 클릭하여 삭제바랍니다.");
			}
		}
	});
	
	// 게시판 목록형태 관리 클릭
	$("#customizingMgr").click(function(){
		var beforeHtml = $("#customizingSelect").html();
		$("#customizingSelect").empty();
		if(beforeHtml != ""){
			$("#customizingSelect").append(beforeHtml);
			
			// 목록에 추가
			if(beforeHtml.indexOf('COUNTRYNAME') <= -1) if($("input[name='countryRYN']:radio:checked").val() == 'Y') $("#customizingSelect").append('<option style="background-color: #FFFFCC" info="COUNTRYNAME" value="COUNTRYNAME§§Y§§15">국가</option>');
			if(beforeHtml.indexOf('CATEGORYNAME') <= -1) if($("input[name='categoryRYN']:radio:checked").val() == 'Y') $("#customizingSelect").append('<option style="background-color: #FFFFCC" info="CATEGORYNAME" value="CATEGORYNAME§§Y§§15">분류</option>');
			if(beforeHtml.indexOf('CONTENTS1') <= -1) if($("#addFieldR1").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS1§§N§§10">'+$("#addFieldR1").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS2') <= -1) if($("#addFieldR2").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS2§§N§§10">'+$("#addFieldR2").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS3') <= -1) if($("#addFieldR3").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS3§§N§§10">'+$("#addFieldR3").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS4') <= -1) if($("#addFieldR4").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS4§§N§§10">'+$("#addFieldR4").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS5') <= -1) if($("#addFieldR5").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS5§§N§§10">'+$("#addFieldR5").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS6') <= -1) if($("#addFieldR6").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS6§§N§§10">'+$("#addFieldR6").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS7') <= -1) if($("#addFieldR7").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS7§§N§§10">'+$("#addFieldR7").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS8') <= -1) if($("#addFieldR7").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS8§§N§§10">'+$("#addFieldR8").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS9') <= -1) if($("#addFieldR8").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS9§§N§§10">'+$("#addFieldR9").val()+'</option>');
			if(beforeHtml.indexOf('CONTENTS10') <= -1) if($("#addFieldR10").val() != '') $("#customizingSelect").append('<option style="background-color: #F8E0E0" value="CONTENTS10§§N§§10">'+$("#addFieldR10").val()+'</option>');
			// CLIPPING형 게시판
			if($("#boardKind option:selected").val() != '' && $("#boardKind option:selected").val() == 'CLIPPING'){
				if(beforeHtml.indexOf('ORIGIN') <= -1) customizingHtml += '<option style="background-color: #FFFFCC" value="ORIGIN§§Y§§10">출처</option>';
				if(beforeHtml.indexOf('REPORTTIME') <= -1) customizingHtml += '<option style="background-color: #FFFFCC" value="REPORTTIME§§Y§§10">보도일</option>';
			}
			
			// 목록에서 삭제
			if(beforeHtml.indexOf('COUNTRYNAME') > -1) if($("input[name='countryRYN']:radio:checked").val() == 'N') $("select[name='customizingSelect'] option[info='COUNTRYNAME']").remove();
			if(beforeHtml.indexOf('CATEGORYNAME') > -1) if($("input[name='categoryRYN']:radio:checked").val() == 'N') $("select[name='customizingSelect'] option[info='CATEGORYNAME']").remove();
			if(beforeHtml.indexOf('CONTENTS1') > -1) if($("#addFieldR1").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS1']").remove();
			if(beforeHtml.indexOf('CONTENTS2') > -1) if($("#addFieldR2").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS2']").remove();
			if(beforeHtml.indexOf('CONTENTS3') > -1) if($("#addFieldR3").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS3']").remove();
			if(beforeHtml.indexOf('CONTENTS4') > -1) if($("#addFieldR4").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS4']").remove();
			if(beforeHtml.indexOf('CONTENTS5') > -1) if($("#addFieldR5").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS5']").remove();
			if(beforeHtml.indexOf('CONTENTS6') > -1) if($("#addFieldR6").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS6']").remove();
			if(beforeHtml.indexOf('CONTENTS7') > -1) if($("#addFieldR7").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS7']").remove();
			if(beforeHtml.indexOf('CONTENTS8') > -1) if($("#addFieldR7").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS8']").remove();
			if(beforeHtml.indexOf('CONTENTS9') > -1) if($("#addFieldR8").val() == '') $("select[name='customizingSelect'] option[info='CONTENTS9']").remove();
			if(beforeHtml.indexOf('CONTENTS10')> -1) if($("#addFieldR10").val() == '') $("select[name='customizingSelect'] option[info=CONTENTS10']").remove();
			// CLIPPING형 게시판
			if($("#boardKind option:selected").val() != '' && $("#boardKind option:selected").val() != 'CLIPPING'){
				if(beforeHtml.indexOf('ORIGIN') > -1) $("select[name='customizingSelect'] option[info=ORIGIN']").remove();
				if(beforeHtml.indexOf('REPORTTIME') > -1) $("select[name='customizingSelect'] option[info=REPORTTIME']").remove();
			}
		}else{
			// 신규목록생성
			var customizingHtml = "";			
			customizingHtml += '<option selected style="background-color: #FFFFCC" value="NUM1§§Y§§10">번호</option>';
			if($("input[name='countryRYN']:radio:checked").val() == 'Y') customizingHtml += '<option style="background-color: #FFFFCC" value="COUNTRYNAME§§Y§§15">국가</option>';
			if($("input[name='categoryRYN']:radio:checked").val() == 'Y') customizingHtml += '<option style="background-color: #FFFFCC" value="CATEGORYNAME§§Y§§15">분류</option>';
			customizingHtml += '<option style="background-color: #FFFFCC" value="KNAME§§Y§§100">제목</option>';
			customizingHtml += '<option style="background-color: #FFFFCC" value="USERNAME§§Y§§15">작성자</option>';
			customizingHtml += '<option style="background-color: #FFFFCC" value="INSTIME§§Y§§15">작성일</option>';
			customizingHtml += '<option style="background-color: #FFFFCC" value="HITCOUNT§§Y§§10">조회수</option>';
			customizingHtml += '<option style="background-color: #FFFFCC" value="FILEYN§§Y§§10">첨부파일</option>';
			if($("#addFieldR1").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS1§§N§§10">'+$("#addFieldR1").val()+'</option>';
			if($("#addFieldR2").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS2§§N§§10">'+$("#addFieldR2").val()+'</option>';
			if($("#addFieldR3").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS3§§N§§10">'+$("#addFieldR3").val()+'</option>';
			if($("#addFieldR4").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS4§§N§§10">'+$("#addFieldR4").val()+'</option>';
			if($("#addFieldR5").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS5§§N§§10">'+$("#addFieldR5").val()+'</option>';
			if($("#addFieldR6").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS6§§N§§10">'+$("#addFieldR6").val()+'</option>';
			if($("#addFieldR7").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS7§§N§§10">'+$("#addFieldR7").val()+'</option>';
			if($("#addFieldR7").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS8§§N§§10">'+$("#addFieldR8").val()+'</option>';
			if($("#addFieldR8").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS9§§N§§10">'+$("#addFieldR9").val()+'</option>';
			if($("#addFieldR10").val() != '') customizingHtml += '<option style="background-color: #F8E0E0" value="CONTENTS10§§N§§10">'+$("#addFieldR10").val()+'</option>';
			
			// CLIPPING형 게시판
			if($("#boardKind option:selected").val() != '' && $("#boardKind option:selected").val() == 'CLIPPING'){
				customizingHtml += '<option style="background-color: #FFFFCC" value="ORIGIN§§Y§§10">출처</option>';
				customizingHtml += '<option style="background-color: #FFFFCC" value="REPORTTIME§§Y§§10">보도일</option>';
			}

			$("#customizingSelect").append(customizingHtml);
		}
		
		/* $("#customizingColName").val($("#customizingSelect option:selected").text());
		$("#customizingColSize").val($("#customizingSelect option:selected").val().split('§§')[2]);
		$("input:radio[name='customizingColYN']:radio[value='"+$("#customizingSelect option:selected").val().split('§§')[1]+"']").prop("checked", true); */
		
		$("#customizingDialog").dialog({
			width: 750,
			height: 900,
			resizable: false,
			modal: true,
			title: "목록형태 관리",
			buttons:{
				"OK": function(){
					$(this).dialog("close");	
				}
			}
		});
		$("#customizingDialog").scrollTop(0);
	});
	
	$("#customizingSelect").change(function(){
		$("#customizingColName").val($("#customizingSelect option:selected").text());
		$("#customizingColSize").val($("#customizingSelect option:selected").val().split('§§')[2]);
		$("input:radio[name='customizingColYN']:radio[value='"+$("#customizingSelect option:selected").val().split('§§')[1]+"']").prop("checked", true);
	});
	
	/*
	  클릭이벤트
	*/
	
	/*
	  Action
	*/
	
	// 데이터 저장 후 화면에 저장값 세팅
	if(pAction == "act" || pAction == "move"){
		if(pChkMenu == "Y") clickDept(pMenuId, $("#menu_Name").val(), pSiteId, true);
		else clickDept(pMenuId, $("#menu_Name").val(), pSiteId, false);
	}
	
	// 게시판등록화면으로 이동
	$("#btnMoveContent").click(function(){
		if($("#boardId").val() == ""){
			alert("이동할 컨텐츠를 확인 바랍니다.");
			return;
		}
		
		location.href = "${ctxMgr}/contentMgr?menuId=${contentMgrMenu }&siteId=${pSiteId }&moveMenuId="+$("#paramMenuId").val()+"&moveBoardKind="+$("#boardKind").val();
	});
	
});

// 메뉴 타입이 'C'외에는 콘텐츠 설정 되지 않는다
function clickDeptMenuType(menuName){
	$("#menu_NameText").text(menuName);
	$("#KName").val(""); // 콘텐츠명
	$("#KDesc").val(""); // 콘텐츠 설명
	$("#boardKind").val("0").prop("selected", "selected"); // 콘텐츠 유형
	$("input:radio[name='categoryRYN']").prop("checked", false);
	$("input:radio[name='customizingRYN']").prop("checked", false);
	$("#boardListKindR").val("0").prop("selected", "selected");
	$("#pageCountR").val("0").prop("selected", "selected");
	$("input:radio[name='noticeRYN']").prop("checked", false);
	$("input:radio[name='commentRYN']").prop("checked", false);
	$("input:radio[name='secretRYN']").prop("checked", false);
	$("input:radio[name='rssRYN']").prop("checked", false);
	$("input:radio[name='newRYN']").prop("checked", false);
	$("input:radio[name='countryRYN']").prop("checked", false);
	$("input:radio[name='appRYN']").prop("checked", false);
	$("input:radio[name='imageRYN']").prop("checked", false);
	$("input:radio[name='snsRYN']").prop("checked", false);
	
	$("#fileMaxCountR").val("0").prop("selected", "selected"); // 파일최대갯수
	$('#fileMaxSizeR').val("5120");
	
	//추가필드 	 				
	$("#addFieldR1").val("");
	$("#addFieldR2").val("");
	$("#addFieldR3").val("");
	$("#addFieldR4").val("");
	$("#addFieldR5").val("");
	$("#addFieldR6").val("");
	$("#addFieldR7").val("");
	$("#addFieldR8").val("");
	$("#addFieldR9").val("");
	$("#addFieldR10").val("");
	
    /*************************************************************************************************/
	// 카테고리/게시글목록수/공지글허용여부/댓글허용여부/비밀글허용여부/RSS적용여부/첨부파일최대갯수
	$("#categoryYN").val("");
	$("#pageCount").val("");
	$("#noticeYN").val("");
	$("#commentYN").val("");
	$("#secretYN").val(""); 
	$("#rssYN").val(""); 
	$("#newYN").val(""); 
	$("#countryYN").val(""); 
	$("#appYN").val(""); 
	$("#imageYN").val(""); 
	$("#snsYN").val(""); 
	$("#fileMaxCount").val("");
	
	//추가필드 	 				
	$("#addField1").val("");
	$("#addField2").val("");
	$("#addField3").val("");
	$("#addField4").val("");
	$("#addField5").val("");
	$("#addField6").val("");
	$("#addField7").val("");
	$("#addField8").val("");
	$("#addField9").val("");
	$("#addField10").val("");

	// 경영공시 User 초기화
	/* $('#confirmUserSpan').text("");
	$('#confirmUser').val("");
	$('#chargeUserSpan').text("");
	$('#chargeUser').val("");
	$('#writeUserSpan').text("");
	$('#writeUser').val("");
	$('#writeUser2Span').text("");
	$('#writeUser2').val(""); */
	
	// 정적콘텐츠 외 태그 show
	$("input[name='categoryRYN']").prop("disabled", false);
	$("input[name='customizingRYN']").prop("disabled", false);
	$('#boardListKindR').prop("disabled", false);
	$('#pageCountR').prop("disabled", false);
	$('#fileMaxCountR').prop("disabled", false);
	$('#fileMaxSizeR').prop("disabled", false);
	$("input[name='noticeRYN']").prop("disabled", false);
	$("input[name='commentRYN']").prop("disabled", false);
	$("input[name='secretRYN']").prop("disabled", false);
	$("input[name='rssRYN']").prop("disabled", false);
	$("input[name='newRYN']").prop("disabled", false);
	$("input[name='countryRYN']").prop("disabled", false);
	$("input[name='appRYN']").prop("disabled", false);
	$("input[name='imageRYN']").prop("disabled", false);
	$("input[name='snsRYN']").prop("disabled", false);
	
	$('#addFieldR1').prop("disabled", false);
	$('#addFieldR2').prop("disabled", false);
	$('#addFieldR3').prop("disabled", false);
	$('#addFieldR4').prop("disabled", false);
	$('#addFieldR5').prop("disabled", false);
	$('#addFieldR6').prop("disabled", false);
	$('#addFieldR7').prop("disabled", false);
	$('#addFieldR8').prop("disabled", false);
	$('#addFieldR9').prop("disabled", false);
	$('#addFieldR10').prop("disabled", false);
	
	// 카테고리관리
	$("#categoryMgr").hide();
	$("#customizingMgr").hide();
	
	// 경영공시
	/* $("#trConfirmUser").hide();
	$("#trChargeUser").hide();
	$("#trWriteUser").hide();
	$("#trWriteUser2").hide(); */
	
	// 저장 버튼
	$("#btnSave").hide();
	
	alert("콘텐츠설정을 하실 수 없는 메뉴입니다.");
}

//메뉴 클릭 이벤트 : 메뉴 컨텐츠 정보 보기
function clickDept(paramMenuId, menu_Name, siteId, chkMenu){
	contentCnt = 0;
	/* if(chkMenu){
		$("#trConfirmUser").show();
		$("#trChargeUser").show();
		$("#trWriteUser").show();
		$("#trWrite2User").show();
		
		$("#pChkMenu").val("Y");
	}else{
		$("#trConfirmUser").hide();
		$("#trChargeUser").hide();
		$("#trWriteUser").hide();
		$("#trWrite2User").hide();
		
		$("#pChkMenu").val("N");
	} */
	
	/* if("${editor}" == "Namo"){
		// 콘텐츠 추가 내용 에디터 초기화
		CrossEditorHeader.SetBodyValue("");
		CrossEditorFooter.SetBodyValue("");
	} */

	$.ajax({
 		url: gContextPath+"/mgr/contentSetMgr/form",
 		data: {'paramMenuId' : paramMenuId, 'paramSiteId' : siteId},
 		async: false,
 		cache: false,
 		success:function(result) {
 			if(result == "") {
 				alert("콘텐츠설정 정보를 등록하시기 바랍니다.");

 				// 테이블 전체 disabled false
 				$("#tableContentSet").prop("disabled", false);
 				
 				// 메뉴명 세팅
 				//$("#menu_Name").val(menu_Name);
 				//$("#paramMenuId").val(paramMenuId);
 				
 				/*
 				콘텐츠 정보가 없는경우 태그 초기화
 				*/
 				// 정적콘텐츠 외 태그 show
 				$("input[name='categoryRYN']").prop("disabled", false);
 				$("input[name='customizingRYN']").prop("disabled", false);
 				$('#boardListKindR').prop("disabled", false);
 				$('#pageCountR').prop("disabled", false);
 				$('#fileMaxCountR').prop("disabled", false);
 				$('#fileMaxSizeR').prop("disabled", false);
 				$("input[name='noticeRYN']").prop("disabled", false);
 				$("input[name='commentRYN']").prop("disabled", false);
 				$("input[name='secretRYN']").prop("disabled", false);
 				$("input[name='rssRYN']").prop("disabled", false);
 				$("input[name='newRYN']").prop("disabled", false);
 				$("input[name='countryRYN']").prop("disabled", false);
 				$("input[name='appRYN']").prop("disabled", false);
 				$("input[name='imageRYN']").prop("disabled", false);
 				$("input[name='snsRYN']").prop("disabled", false);
 				
 				$('#addFieldR1').prop("disabled", false);
 				$('#addFieldR2').prop("disabled", false);
 				$('#addFieldR3').prop("disabled", false);
 				$('#addFieldR4').prop("disabled", false);
 				$('#addFieldR5').prop("disabled", false);
 				$('#addFieldR6').prop("disabled", false);
 				$('#addFieldR7').prop("disabled", false);
 				$('#addFieldR8').prop("disabled", false);
 				$('#addFieldR9').prop("disabled", false);
 				$('#addFieldR10').prop("disabled", false);
 				
 				$("#paramMenuId").val(paramMenuId); // 파라메터 메뉴id
	 			$("#menu_NameText").text(menu_Name); // 메뉴명
	 			$("#menu_Name").val(menu_Name); // 메뉴명
	 			
	 			$("#boardId").val(""); // boardid
	 			$("#KName").val(menu_Name); // 콘텐츠명
	 			$("#KDesc").val(menu_Name); // 콘텐츠 설명
	 			$("#boardKind").val("0").prop("selected", "selected"); // 콘텐츠 유형
	 			$("#boardListKindR").val("0").prop("selected", "selected");
	 			$("#pageCountR").val("10").prop("selected", "selected");

	 			// 카테고리/사용여부 공지글허용여부/댓글허용여부/비밀글허용여부
	 			$("input:radio[name='categoryRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='customizingRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='noticeRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='commentRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='secretRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='rssRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='newRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='countryRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='appRYN']:radio[value='N']").prop("checked", true);
	 			$("input:radio[name='snsRYN']:radio[value='N']").prop("checked", true);
	 				
	 			// 파일관련 세팅
	 			$("#fileMaxCountR").val("3").prop("selected", "selected"); // 파일최대갯수
	 			$("#fileMaxSizeR").val("5120"); // 파일최대사이즈

	 			// 추가필드
	 			$("#addFieldR1").val("");
	 			$("#addFieldR2").val("");
	 			$("#addFieldR3").val("");
	 			$("#addFieldR4").val("");
	 			$("#addFieldR5").val("");
	 			$("#addFieldR6").val("");
	 			$("#addFieldR7").val("");
	 			$("#addFieldR8").val("");
	 			$("#addFieldR9").val("");
	 			$("#addFieldR10").val("");
	 			
 				// 신규 정보에 경우 disabled 태그 값 초기화
 				$("#categoryYN").val("");
 				$("#noticeYN").val("");
 				$("#commentYN").val("");
 				$("#secretYN").val("");
 				$("#rssYN").val("");
 				$("#newYN").val("");
 				$("#countryYN").val("");
 				$("#appYN").val("");
 				$("#imageYN").val("");
 				$("#snsYN").val("");
 			
 				// 신규 정보에 경우 disabled 태그 값 초기화
 				$("#pageCount").val("0");
 				$("#fileMaxCount").val("0");
 				$("#fileMaxSize").val("0");
 				
	 			// 추가필드
	 			$("#addField1").val("");
	 			$("#addField2").val("");
	 			$("#addField3").val("");
	 			$("#addField4").val("");
	 			$("#addField5").val("");
	 			$("#addField6").val("");
	 			$("#addField7").val("");
	 			$("#addField8").val("");
	 			$("#addField9").val("");
	 			$("#addField10").val("");
	 			
	 			// 경영공시 User 초기화
				/* $('#confirmUserSpan').text("");
				$('#confirmUser').val("");
				$('#chargeUserSpan').text("");
				$('#chargeUser').val("");
				$('#writeUserSpan').text("");
				$('#writeUser').val("");
				$('#writeUser2Span').text("");
				$('#writeUser2').val(""); */
				
 				// 상태값 세팅
	 			//$("input:radio[name='state']:radio[value='T']").prop("checked", true);
	 			
 				$('.categoryTr').remove(); // 카테고리 값 초기화
 				// 카테고리관리
 	 			$("#categoryMgr").hide();
 	 			$("#customizingMgr").hide();
 	 			
 				/* $('#confirmUserDiv > div').remove(); // 확인자 값 초기화
				$('#chargeUserDiv > div').remove(); // 감독자 값 초기화
				$('#writeUserDiv > div').remove(); // 작성자 값 초기화
				$('#writeUser2Div > div').remove(); // 작성자 값 초기화 */
					
 	 			// 경영공시 User검색
 	 			/* $("#confirmUserSearchBtn").show();
 	 			$("#chargeUserSearchBtn").show();
 	 			$("#writeUserSearchBtn").show();
 	 			$("#writeUser2SearchBtn").show(); */

 				// 저장버튼
 				<c:if test="${WRITE eq 'T'}">
					$("#btnSave").show();
				</c:if>
 				
 			}else{
 				contentCnt = result.cnt;
 				
 				// 테이블 전체 disabled false
 				$("#tableContentSet").prop("disabled", false);
 				
 				if(result.boardKind == "CONTENTS"){ // 콘텐츠 유형 체크 : 정적콘텐츠 일 경우 
 					// 태그값 세팅
 					$("#paramMenuId").val(paramMenuId); // 파라메터 메뉴id
 					$("#menu_NameText").text(menu_Name); // 메뉴명
 	 				$("#menu_Name").val(menu_Name); // 메뉴명
 	 				
 	 				$("#boardId").val(result.boardId); // boardid
 	 				$("#KName").val(result.kname); // 콘텐츠명
 	 				$("#KDesc").val(result.kdesc); // 콘텐츠 설명

 	 				$("#boardKind").val(result.boardKind).prop("selected", "selected"); // 콘텐츠 유형

 	 				//카테고리
 	 				$("input:radio[name='categoryRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='customizingRYN']:radio[value='N']").prop("checked", true);
 	 				
 	 				$("#boardListKindR").val(result.boardListKind).prop("selected", "selected");
 	 				$("#pageCountR").val(result.pageCount).prop("selected", "selected");
 	 				
 	 				$("input:radio[name='noticeRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='commentRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='secretRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='rssRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='newRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='countryRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='appRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='imageRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='snsRYN']:radio[value='N']").prop("checked", true);
 	 				$("input:radio[name='customizingRYN']:radio[value='N']").prop("checked", true);
 	 				
 	 				$("#fileMaxCountR").val(result.fileMaxCount).prop("selected", "selected");
 	 				$("#fileMaxSizeR").val(result.fileMaxSize); // 파일최대사이즈
 	 				
 	 				//추가필드 	 				
 	 				$("#addFieldR1").val(result.addField1);
 	 				$("#addFieldR2").val(result.addField2);
 	 				$("#addFieldR3").val(result.addField3);
 	 				$("#addFieldR4").val(result.addField4);
 	 				$("#addFieldR5").val(result.addField5);
 	 				$("#addFieldR6").val(result.addField6);
 	 				$("#addFieldR7").val(result.addField7);
 	 				$("#addFieldR8").val(result.addField8);
 	 				$("#addFieldR9").val(result.addField9);
 	 				$("#addFieldR10").val(result.addField10);
 	 				
 	 				//카테고리/게시글목록수/공지글허용여부/댓글허용여부/비밀글허용여부/RSS적용여부/첨부파일최대갯수
 	 				$("#categoryYN").val("");
 	 				$("#pageCount").val("");
 	 				$("#noticeYN").val("");
 	 				$("#commentYN").val("");
 	 				$("#secretYN").val(""); 
 	 				$("#rssYN").val(""); 
 	 				$("#newYN").val(""); 
 	 				$("#countryYN").val(""); 
 	 				$("#appYN").val(""); 
 	 				$("#imageYN").val(""); 
 	 				$("#snsYN").val(""); 
 	 				
 	 				$("#fileMaxCount").val("");
 	 				$("#fileMaxSize").val(""); // 파일최대사이즈
 	 				
 	 				//추가필드 	 				
 	 				$("#addField1").val("");
 	 				$("#addField2").val("");
 	 				$("#addField3").val("");
 	 				$("#addField4").val("");
 	 				$("#addField5").val("");
 	 				$("#addField6").val("");
 	 				$("#addField7").val("");
 	 				$("#addField8").val("");
 	 				$("#addField9").val("");
 	 				$("#addField10").val("");

 	 				// 경영공시 User값 세팅
 					/* if(result.manageUser != ""){
 						$('#confirmUserDiv > div').remove(); // 확인자 값 초기화
 						$('#chargeUserDiv > div').remove();  // 감독자 값 초기화
 						$('#writeUserDiv > div').remove();   // 작성자 값 초기화
 						$('#writeUser2Div > div').remove();  // 작성자 값 초기화

 						var setManageUser = result.manageUser.split("||");
 						$.each(setManageUser, function(n){
 							var setManageUserType = setManageUser[n].split(",");
 							$.each(setManageUserType, function(i){
 								if(n == 0 && setManageUser[0] != ""){
	 								$("#confirmUserDiv").append('<div id="confirmUserRow'+i+'" class="confirmUserRow"><span id="confirmUserSpan'+i+'"></span>'
															  + '<input type="hidden" id="confirmUser'+i+'" name="confirmUser'+i+'" value="" class="input_mid02" title="확인자" />'
															  + '<span style="float: right;"><a href="javascript:manageUserDel('+"'confirmUserRow"+i+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="confirmUserDel'+i+'" class="confirmUserDel" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
 								}else if(n == 1 && setManageUser[1] != ""){
		 							$("#chargeUserDiv").append('<div id="chargeUserRow'+i+'" class="chargeUserRow"><span id="chargeUserSpan'+i+'"></span>'
															 + '<input type="hidden" id="chargeUser'+i+'" name="chargeUser'+i+'" value="" class="input_mid02" title="감독자" />'
															 + '<span style="float: right;"><a href="javascript:manageUserDel('+"'chargeUserRow"+i+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="chargeUserDel'+i+'" class="chargeUserDel" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
 								}else if(n == 2 && setManageUser[2] != ""){
		 							$("#writeUserDiv").append('<div id="writeUserRow'+i+'" class="writeUserRow"><span id="writeUserSpan'+i+'"></span>'
															+ '<input type="hidden" id="writeUser'+i+'" name="writeUser'+i+'" value="" class="input_mid02" title="작성자" />'
															+ '<span style="float: right;"><a href="javascript:manageUserDel('+"'writeUserRow"+i+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="writeUserDel'+i+'" class="writeUserDel" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
 								}else if(n == 3 && setManageUser[3] != ""){
		 							$("#writeUser2Div").append('<div id="writeUser2Row'+i+'" class="writeUser2Row"><span id="writeUser2Span'+i+'"></span>'
											+ '<input type="hidden" id="writeUser2'+i+'" name="writeUser2'+i+'" value="" class="input_mid02" title="작성자2" />'
											+ '<span style="float: right;"><a href="javascript:manageUserDel('+"'writeUser2Row"+i+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="writeUserDel'+i+'" class="writeUserDel" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
								}
 								
 								var setManageUserName = setManageUserType[i].split("#");
 	 							
 								if(n == 0){
 									$('#confirmUserSpan'+i).text(setManageUserName[0]);
 									$('#confirmUser'+i).val(setManageUserName[1]);
 								}else if(n == 1){
 	 	 							$('#chargeUserSpan'+i).text(setManageUserName[0]);
 	 	 							$('#chargeUser'+i).val(setManageUserName[1]);
 	 		 					
 	 	 						}else if(n == 2){
 	 	 							$('#writeUserSpan'+i).text(setManageUserName[0]);
 	 	 							$('#writeUser'+i).val(setManageUserName[1]);
 	 	 						}else if(n == 3){
 	 	 							$('#writeUser2Span'+i).text(setManageUserName[0]);
 	 	 							$('#writeUser2'+i).val(setManageUserName[1]);
 	 	 						}
 							});
 						});
 					} */
 	 				/* if(result.boardKind == "REFERENCE"){
 	 					// 참조형 메뉴 타겟 START
 	 					var refMenus = result.referenceMenus.split("||"); // row 구분
						var refMenuArr = new Array();
	 					var refMenuInfo = "";
	 					var refMenuTag = "<ul>";
 						$.each(refMenus, function(i){ // i : 0 ~	
 							var tmp = refMenus[i].split("#");
	 						
 							refMenuArr.push(tmp[0]);
	 						if(i > 0) refMenuInfo += "§§";
	 						refMenuInfo += tmp[1] + "#" + tmp[2];	
	 						
	 						if(i%2 == 0) refMenuTag += "<li><span style='display: inline-block; background: #FFD8D8;'>" + tmp[2] + "</span></li>";
	 						else refMenuTag += "<li><span style='display: inline-block; background: #D9E5FF;'>" + tmp[2] + "</span></li>";
 						});
 	 					
 	 					$("#refMenuIds").val(refMenuArr);
 	 					$("#refMenuIds").prop('menuInfo', refMenuInfo);
 	 					
 	 					refMenuTag += "</ul>";
 	 					$("#referenceMenus >").remove(); // 참조메뉴 태그초기화
 	 					$("#referenceMenus").append(refMenuTag); // 참조메뉴 태그삽입
	 	 				// 참조형 메뉴 타겟 END
	 					
	 					$("#trBoardReference").show();
	 					
 	 				}else{
 	 					$("#trBoardReference").hide();
 	 				} */
 	 				
 	 				//상태값 세팅
 	 				//$("input:radio[name='state']:radio[value='"+ result.state +"']").prop("checked", true);
 	 				
 	 				// 콘텐츠 추가 내용 에디터
 	 				$("#boardHeaderKHtml").val(result.boardHeaderKHtml);
 	 				$("#boardFooterKHtml").val(result.boardFooterKHtml);
 	 				
 	 				/****************************************************************/
 					// 정적콘텐츠일 결우 일부 태그 disabled
 					$("input[name='categoryRYN']").prop("disabled", "disabled");
 					$("input[name='customizingRYN']").prop("disabled", "disabled");
 					$('#boardListKindR').prop("disabled", "disabled");
 					$('#pageCountR').prop("disabled", "disabled");
 					$('#fileMaxCountR').prop("disabled", "disabled");
 					$('#fileMaxSizeR').prop("disabled", "disabled");
 					$("input[name='noticeRYN']").prop("disabled", "disabled");
 					$("input[name='commentRYN']").prop("disabled", "disabled");
 					$("input[name='secretRYN']").prop("disabled", "disabled");
 					$("input[name='rssRYN']").prop("disabled", "disabled");
 					$("input[name='newRYN']").prop("disabled", "disabled");
 					$("input[name='countryRYN']").prop("disabled", "disabled");
 					$("input[name='appRYN']").prop("disabled", "disabled");
 					$("input[name='imageRYN']").prop("disabled", "disabled");
 					$("input[name='snsRYN']").prop("disabled", "disabled");
 					$('#addFieldR1').prop("disabled", "disabled");
 					$('#addFieldR2').prop("disabled", "disabled");
 					$('#addFieldR3').prop("disabled", "disabled");
 					$('#addFieldR4').prop("disabled", "disabled");
 					$('#addFieldR5').prop("disabled", "disabled");
 					$('#addFieldR6').prop("disabled", "disabled");
 					$('#addFieldR7').prop("disabled", "disabled");
 					$('#addFieldR8').prop("disabled", "disabled");
 					$('#addFieldR9').prop("disabled", "disabled");
 					$('#addFieldR10').prop("disabled", "disabled");
 					/****************************************************************/
 	 				
 					// 카테고리관리
 	 				$("#categoryMgr").hide();
 	 				$("#customizingMgr").hide();
 	 				$("#contentLink").show();
 					
 	 				// 경영공시 User검색
 	 				/* $("#confirmUserSearchBtn").show();
 	 				$("#chargeUserSearchBtn").show();
 	 				$("#writeUserSearchBtn").show();
 	 				$("#writeUser2SearchBtn").show(); */
 	 			
 	 				// 게시판리스트 유형관리
					$("#trboardListKind").hide();
					
 					// 저장
 					<c:if test="${WRITE eq 'T'}">
						$("#btnSave").show();
					</c:if>
 				}else{ // 콘텐츠 유형 체크 : 정적콘텐츠 외
 					// 정적콘텐츠 외 태그 show
 					$("input[name='categoryRYN']").prop("disabled", false);
 					$("input[name='customizingRYN']").prop("disabled", false);
 					$('#boardListKindR').prop("disabled", false);
 					$('#pageCountR').prop("disabled", false);
 					$('#fileMaxCountR').prop("disabled", false);
 					$('#fileMaxSizeR').prop("disabled", false);
 					$("input[name='noticeRYN']").prop("disabled", false);
 					$("input[name='commentRYN']").prop("disabled", false);
 					$("input[name='secretRYN']").prop("disabled", false);
 					$("input[name='rssRYN']").prop("disabled", false);
 					$("input[name='newRYN']").prop("disabled", false);
 					$("input[name='countryRYN']").prop("disabled", false);
 					$("input[name='appRYN']").prop("disabled", false);
 					$("input[name='imageRYN']").prop("disabled", false);
 					$("input[name='snsRYN']").prop("disabled", false);
 					
 					if(result.boardKind == "NOTICE" || result.boardKind == "LINK"){
 						//$("#trImageYN").show();
 						//$("#trboardListKind").show();
 					}else{
 						//$("#trImageYN").hide();
 						//$("#trboardListKind").hide();
 					}
 					
 					if(result.boardKind == "NOTICE" || result.boardKind == "FREE"){
 						$("#trboardListKind").show();
 					}else{
 						$("#trboardListKind").hide();
 					}
 					
 					$('#addFieldR1').prop("disabled", false);
 					$('#addFieldR2').prop("disabled", false);
 					$('#addFieldR3').prop("disabled", false);
 					$('#addFieldR4').prop("disabled", false);
 					$('#addFieldR5').prop("disabled", false);
 					$('#addFieldR6').prop("disabled", false);
 					$('#addFieldR7').prop("disabled", false);
 					$('#addFieldR8').prop("disabled", false);
 					$('#addFieldR9').prop("disabled", false);
 					$('#addFieldR10').prop("disabled", false);
 					
 					$("#paramMenuId").val(paramMenuId); // 파라메터 메뉴id
 	 				$("#menu_NameText").text(menu_Name); // 메뉴명
 	 				$("#menu_Name").val(menu_Name); // 메뉴명

 	 				$("#boardId").val(result.boardId); // boardid
 	 				$("#KName").val(result.kname); // 콘텐츠명
 	 				$("#KDesc").val(result.kdesc); // 콘텐츠 설명
 	 				$("#boardKind").val(result.boardKind).prop("selected", "selected"); // 콘텐츠 유형
 	 				
 	 				$("#contentLink").show();
 	 				
 	 				//카테고리
 	 				$("input:radio[name='categoryRYN']:radio[value='"+ result.categoryYN +"']").prop("checked", true);
 	 				$("#categoryYN").val(result.categoryYN);
 	 				
 	 				$("input:radio[name='customizingRYN']:radio[value='"+ result.customizingYN +"']").prop("checked", true);
 	 				$("#customizingYN").val(result.customizingYN);
 	 				
 	 				//카테고리
 					if(result.category != ""){ //카테고리 값 존재할 경우 화면에 출력
 						$('.categoryTr').remove(); // 카테고리 값 초기화
	 	 				var setCategoryData = result.category.split("#");
	 	 				$.each(setCategoryData, function(i){
	 	 					var setCategoryDataDetail = setCategoryData[i].split("||");
	 	 					$('#categoryTable').append('<tr id="categoryTr'+i+'" class="categoryTr"><td><span id="categoryId'+i+'"></span></td><td><a href="javascript:fnCategory('+"'categoryTr"+i+"', 'categoryName"+i+"'"+');"><span id="categoryName'+i+'"></span></a></td></tr>');
		 	 					$.each(setCategoryDataDetail, function(j){
		 	 						if(j==0){
		 	 							if(i < 9) $('#categoryId'+i).text("0"+(i+1));
		 	 							else $('#categoryId'+i).text(i+1);
		 	 						}else if(j==1) $('#categoryName'+i).text(setCategoryDataDetail[j]);
		 	 					});
	 	 				});
 					}else{
 						$('.categoryTr').remove(); // 카테고리 값 초기화
 					}
 	 				
 					//게시판목록형태
 					if(result.customizingInfo != ""){ //게시판목록형태 값 존재할 경우 화면에 출력
 						$("#customizingSelect").empty(); // select 값 초기화
	 	 				var setCustomizingData = result.customizingInfo.split("||");
 	 					var customizingData = "";
 	 					var color = "";
	 	 				$.each(setCustomizingData, function(i){
	 	 					if(setCustomizingData[i].split("§§")[1] == 'Y') color = "#FFFFCC";
	 	 					else color = "#F8E0E0";
	 	 					customizingData += '<option info="'+setCustomizingData[i].split("§§")[0]+'" style="background-color: '+color+'" value="'+setCustomizingData[i].substring(0, setCustomizingData[i].lastIndexOf('§§'))+'">'+setCustomizingData[i].split("§§")[3]+'</option>';
	 	 				});

	 	 				$("#customizingSelect").append(customizingData);
 					}else{
 						$('.categoryTr').remove(); // 카테고리 값 초기화
 					}
 	 				
 	 				$("#boardListKindR").val(result.boardListKind).prop("selected", "selected");
 	 				$("#boardListKind").val(result.boardListKind);
 	 				$("#pageCountR").val(result.pageCount).prop("selected", "selected");
 	 				$("#pageCount").val(result.pageCount);
 	 				
 	 				// 공지글허용여부/댓글허용여부/비밀글허용여부
 	 				$("input:radio[name='noticeRYN']:radio[value='"+ result.noticeYN +"']").prop("checked", true);
 	 				$("input:radio[name='commentRYN']:radio[value='"+ result.commentYN +"']").prop("checked", true);
 	 				$("input:radio[name='secretRYN']:radio[value='"+ result.secretYN +"']").prop("checked", true);
 	 				$("input:radio[name='rssRYN']:radio[value='"+ result.rssYN +"']").prop("checked", true);
 	 				$("input:radio[name='newRYN']:radio[value='"+ result.newYN +"']").prop("checked", true);
 	 				$("input:radio[name='countryRYN']:radio[value='"+ result.countryYN +"']").prop("checked", true);
 	 				$("input:radio[name='appRYN']:radio[value='"+ result.appYN +"']").prop("checked", true);
 	 				$("input:radio[name='imageRYN']:radio[value='"+ result.imageYN +"']").prop("checked", true);
 	 				$("input:radio[name='snsRYN']:radio[value='"+ result.snsYN +"']").prop("checked", true);
 	 				$("input:radio[name='customizingRYN']:radio[value='"+ result.customizingYN +"']").prop("checked", true);
 	 				
 	 				$("#noticeYN").val(result.noticeYN);
 	 				$("#commentYN").val(result.commentYN);
 	 				$("#secretYN").val(result.secretYN); 	 				
 	 				$("#rssYN").val(result.rssYN);
 	 				$("#newYN").val(result.newYN);
 	 				$("#countryYN").val(result.countryYN);
 	 				$("#appYN").val(result.appYN);
 	 				$("#imageYN").val(result.imageYN); 	 				
 	 				$("#snsYN").val(result.snsYN); 	 				
 	 				$("#customizingYN").val(result.customizingYN); 	 				
 	 				
 	 				// 파일관련 세팅
 	 				$("#fileMaxCountR").val(result.fileMaxCount).prop("selected", "selected"); // 파일최대갯수
 	 				$("#fileMaxCount").val(result.fileMaxCount);
 	 				$("#fileMaxSizeR").val(result.fileMaxSize); // 파일최대사이즈
 	 				$("#fileMaxSize").val(result.fileMaxSize); // 파일최대사이즈
 	 				
 	 				//추가필드
 	 				$("#addFieldR1").val(result.addField1);
 	 				$("#addFieldR2").val(result.addField2);
 	 				$("#addFieldR3").val(result.addField3);
 	 				$("#addFieldR4").val(result.addField4);
 	 				$("#addFieldR5").val(result.addField5);
 	 				$("#addFieldR6").val(result.addField6);
 	 				$("#addFieldR7").val(result.addField7);
 	 				$("#addFieldR8").val(result.addField8);
 	 				$("#addFieldR9").val(result.addField9);
 	 				$("#addFieldR10").val(result.addField10);
 	 				
 	 				//추가필드 	 				
 	 				$("#addField1").val(result.addField1);
 	 				$("#addField2").val(result.addField2);
 	 				$("#addField3").val(result.addField3);
 	 				$("#addField4").val(result.addField4);
 	 				$("#addField5").val(result.addField5);
 	 				$("#addField6").val(result.addField6);
 	 				$("#addField7").val(result.addField7);
 	 				$("#addField8").val(result.addField8);
 	 				$("#addField9").val(result.addField9);
 	 				$("#addField10").val(result.addField10);
 	 				
 	 				// 경영공시 User값 세팅
 					/* if(result.manageUser != ""){
 						$('#confirmUserDiv > div').remove(); // 확인자 값 초기화
 						$('#chargeUserDiv > div').remove(); // 감독자 값 초기화
 						$('#writeUserDiv > div').remove(); // 작성자 값 초기화
 						$('#writeUser2Div > div').remove(); // 작성자 값 초기화
 						
 						var setManageUser = result.manageUser.split("||");
 						$.each(setManageUser, function(n){
 							
 							var setManageUserType = setManageUser[n].split(",");							
 							$.each(setManageUserType, function(i){
 								if(n == 0 && setManageUser[0] != ""){
	 								$("#confirmUserDiv").append('<div id="confirmUserRow'+i+'" class="confirmUserRow"><span id="confirmUserSpan'+i+'"></span>'
															  + '<input type="hidden" id="confirmUser'+i+'" name="confirmUser'+i+'" value="" class="input_mid02" title="확인자" />'
															  + '<span style="float: right;"><a href="javascript:manageUserDel('+"'confirmUserRow"+i+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="confirmUserDel'+i+'" class="confirmUserDel" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
 								}else if(n == 1 && setManageUser[1] != ""){
		 							$("#chargeUserDiv").append('<div id="chargeUserRow'+i+'" class="chargeUserRow"><span id="chargeUserSpan'+i+'"></span>'
															 + '<input type="hidden" id="chargeUser'+i+'" name="chargeUser'+i+'" value="" class="input_mid02" title="감독자" />'
															 + '<span style="float: right;"><a href="javascript:manageUserDel('+"'chargeUserRow"+i+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="chargeUserDel'+i+'" class="chargeUserDel" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
 								}else if(n == 2 && setManageUser[2] != ""){
		 							$("#writeUserDiv").append('<div id="writeUserRow'+i+'" class="writeUserRow"><span id="writeUserSpan'+i+'"></span>'
															+ '<input type="hidden" id="writeUser'+i+'" name="writeUser'+i+'" value="" class="input_mid02" title="작성자" />'
															+ '<span style="float: right;"><a href="javascript:manageUserDel('+"'writeUserRow"+i+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="writeUserDel'+i+'" class="writeUserDel" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
 								}else if(n == 3 && setManageUser[3] != ""){
		 							$("#writeUser2Div").append('<div id="writeUser2Row'+i+'" class="writeUser2Row"><span id="writeUser2Span'+i+'"></span>'
											+ '<input type="hidden" id="writeUser2'+i+'" name="writeUser2'+i+'" value="" class="input_mid02" title="작성자2" />'
											+ '<span style="float: right;"><a href="javascript:manageUserDel('+"'writeUser2Row"+i+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="writeUserDel'+i+'" class="writeUserDel" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
								}
 								
 								var setManageUserName = setManageUserType[i].split("#");
 	 							
 								if(n == 0){
 									$('#confirmUserSpan'+i).text(setManageUserName[0]);
 									$('#confirmUser'+i).val(setManageUserName[1]);
 								}else if(n == 1){
 	 	 							$('#chargeUserSpan'+i).text(setManageUserName[0]);
 	 	 							$('#chargeUser'+i).val(setManageUserName[1]);
 	 		 					
 	 	 						}else if(n == 2){
 	 	 							$('#writeUserSpan'+i).text(setManageUserName[0]);
 	 	 							$('#writeUser'+i).val(setManageUserName[1]);
 	 	 						}else if(n == 3){
 	 	 							$('#writeUser2Span'+i).text(setManageUserName[0]);
 	 	 							$('#writeUser2'+i).val(setManageUserName[1]);
 	 	 						}
 							});
 						});
 					} */
 					
 	 				// 콘텐츠 추가 내용 에디터
 	 				//CrossEditorHeader.SetBodyValue(result.boardHeaderKHtml);
 	 				//CrossEditorFooter.SetBodyValue(result.boardFooterKHtml);
 	 				$("#boardHeaderKHtml").val(result.boardHeaderKHtml);
 	 				$("#boardFooterKHtml").val(result.boardFooterKHtml);
 	 				
 	 				//상태값 세팅
 	 				//$("input:radio[name='state']:radio[value='"+ result.state +"']").prop("checked", true);
 	 				
 	 				// 카테고리관리
 	 				if(result.categoryYN == "Y") $("#categoryMgr").show();
 	 				else $("#categoryMgr").hide();
 	 				// 게시판목록정의관리
 	 				if(result.customizingYN == "Y") $("#customizingMgr").show();
 	 				else $("#customizingMgr").hide();
 	 				
 	 	 			// 경영공시 User검색
 	 	 			/* $("#confirmUserSearchBtn").show();
 	 	 			$("#chargeUserSearchBtn").show();
 	 	 			$("#writeUserSearchBtn").show();
 	 	 			$("#writeUser2SearchBtn").show(); */
 	 			
 	 				// 저장
 	 				<c:if test="${WRITE eq 'T'}">
						$("#btnSave").show();
					</c:if>
 				}
 			}
 		}
 	});
	
	preBoardKindVal = $('#boardKind option:selected').val();

}

//회원세팅 함수
function setMemberList(outputMember, pParentInputId){
	var setMemberDetail = outputMember.split("|");
	var rowCnt = $("#"+pParentInputId+"Div >div").length;
	var chkIdFlag = true;
	
	$("#"+pParentInputId+"Div >div>input").each(function(n){
		if(setMemberDetail[2] == $("#"+$(this).prop("id")).val()){
			alert("등록된 ID입니다.");
			chkIdFlag = false;
		}
	});
	if(chkIdFlag){
		$("#"+pParentInputId+"Div").append('<div id="'+pParentInputId+'Row'+rowCnt+'" class="'+pParentInputId+'Row"><span id="'+pParentInputId+'Span'+rowCnt+'"></span>'
										   + '<input type="hidden" id="'+pParentInputId+rowCnt+'" name="'+pParentInputId+rowCnt+'" value="" class="input_mid02" title="확인자" />'
										   + '<span style="float: right;"><a href="javascript:manageUserDel('+"'"+pParentInputId+'Row'+rowCnt+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="'+pParentInputId+'Del'+rowCnt+'" class="'+pParentInputId+'Del" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
		
		$("#"+pParentInputId+rowCnt).val(setMemberDetail[2]);
		$("#"+pParentInputId+"Span"+rowCnt).text("[직급/"+setMemberDetail[3]+"/"+setMemberDetail[2]+"/전화번호]");
	}
}

// 카테고리 링크 함수
function fnCategory(categoryTrId, categorySpanId){
	$("#schTextHidden").val(categoryTrId+","+categorySpanId);
	$("#schText").val($("#"+categorySpanId).text());
	$("#schText").focus();
}

// 경영공시 삭제 클릭
/* function manageUserDel(delId){
	var parentId = $("#"+delId).parents().prop("id");
	var cheldrens = parentId.replace("Div", "");
	var setManageUserId = new Array(); 
	var setManageUserInfo = new Array();
	
	
	$("#"+delId).remove(); // 경영공시 row 삭제

		
	$("#"+parentId+" >div").each(function(n){
		setManageUserId.push($("#"+$("#"+$(this).prop("id")+" >input").prop("id")).val());
		setManageUserInfo.push($("#"+$("#"+$(this).prop("id")+" >span").prop("id")).text());
	});
	
	// DivRow 삭제
	$("#"+parentId+" >div").remove();
	  
	$.each(setManageUserId, function(m){
		$("#"+parentId).append('<div id="'+cheldrens+'Row'+m+'" class="'+cheldrens+'Row"><span id="'+cheldrens+'Span'+m+'"></span>'
				   			 + '<input type="hidden" id="'+cheldrens+m+'" name="'+cheldrens+m+'" value="" class="input_mid02" title="확인자" />'
				             + '<span style="float: right;"><a href="javascript:manageUserDel('+"'"+cheldrens+'Row'+m+"'"+');"><img src="${contextPath }/resources/images/ips/common/btn_delete.gif" id="'+cheldrens+'Del'+m+'" class="'+cheldrens+'Del" alt="삭제" style="border: solid 1px #e1e1e1; vertical-align:middle"/></a></span></div>');
		
		$("#"+cheldrens+"Span"+m).text(setManageUserInfo[m]);
		$("#"+cheldrens+m).val(setManageUserId[m]);
	});
} */

/* function fnBoardKindChk(){
	if(contentCnt > 0){
		alert("콘텐츠가 등록되어 있어 수정할 수 없습니다.");
		$('#boardKind').val(preBoardKindVal);
	}
} */

//순서 변경
function fnSortCustomizing(clss) {
	var sortkeys = document.getElementById('customizingSelect');
	var idx = sortkeys.selectedIndex;
	if ( idx < 0 ) { return; }
	var optlen = sortkeys.options.length;
	var newidx = -1;

	switch(clss) {
	case 'U': newidx = idx-1; break;
	case 'D': newidx = idx+1; break;
	}

	if ( newidx > optlen-1 || idx == newidx || newidx == -1 ) {
	return;
	}
	
	var oldtext = sortkeys.options[idx].text;
	var oldvalue = sortkeys.options[idx].value;


	sortkeys.options[idx].text = sortkeys.options[newidx].text;
	sortkeys.options[idx].value = sortkeys.options[newidx].value;


	sortkeys.options[newidx].text = oldtext;
	sortkeys.options[newidx].value = oldvalue;
	sortkeys.selectedIndex = newidx;
}

function fnModigyCustomizing(){
	$("#customizingSelect option:selected").text($("#customizingColName").val());
	var customizingValue = $("#customizingSelect option:selected").val().split('§§')[0]+"§§"+$("input[name='customizingColYN']:radio:checked").val()+"§§"+$("#customizingColSize").val();
	$("#customizingSelect option:selected").val(customizingValue);
	$("#customizingSelect option:selected").css('background-color', "#CCFFCC");
	$("#customizingSelect option").prop("selected", false);
	
}

</script>
