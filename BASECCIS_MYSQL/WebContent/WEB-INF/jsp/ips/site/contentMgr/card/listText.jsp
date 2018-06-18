<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="searchForm" name="searchForm" method="get" action="${contextPath }/mgr/contentMgr" class="search_form">
	<input type="hidden" name="menuId" value="${obj.menuId}">
	<input type="hidden" name="boardKind" value="${obj.boardKind}">
	<fieldset>
		<legend>검색조건</legend>
		<div class="form_group">
			<div class="row">
				<label for="schType">검색조건</label>
				 <select name="schType" id="schType" title="검색구분">
		            <option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
                       <option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>작성자</option>
                       <option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>내용</option>
		        </select>
		        <input type="text" name="schText" id="schText" class="input_mid" value="${obj.schText }" title="검색어"/>
			</div>
			<c:if test="${rtnSetting.categoryYN == 'Y' }">			    
				<div class="fow">
					<label>분류</label>
					<select name="categoryId" id="categoryId" title="카테고리">
						<option value="0">카테고리</option>
					</select>
				</div>
			</c:if>
			<c:if test="${rtnSetting.countryYN == 'Y' }">
				<div class="fow">
					<label for="continent">국가</label>
					<select id="continent" name="continent">
						<option value="">대륙 선택</option>
					</select>
					<select id="country" name="country">
						<option value="">국가 선택</option>
					</select>
				</div>
			</c:if>
			<span class="display_block txt_center">
		 		<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
		 	</span>
		</div>
	</fieldset>
</spform:form>
	
<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/contentMgr/actCardBoard" method="POST">
	<input type="hidden" name="inCondition" value="삭제">
	<input type="hidden" name="menuId" value="${obj.menuId }" />
	<input type="hidden" name="boardId" value="${obj.boardId }" />
	<input type="hidden" name="boardKind" value="${obj.boardKind }" />
	<input type="hidden" name="link" value="pageNum=${obj.pageNum }${link }" />
	<input type="hidden" name="startTime" value="11111111" />
	<input type="hidden" name="endTime" value="11111111" />
	<input type="hidden" name="bbsShare" id="bbsShare" value=""/>
	
	<div class="float_wrap">
    	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
	    <div class="float_right">
	        <span class="photo_type">
				<button type="button" id="btnTextStyle" class="list${obj.boardStyle == 'Text' ? '_on' : '' }" alt="목록형">목록형</button> 
				<button type="button" id="btnImageStyle" class="thumb${obj.boardStyle == 'Image' ? '_on' : '' }" alt="썸네일 목록">썸네일 목록</button> 
				<button type="button" id="btnGalleryStyle" class="album${obj.boardStyle == 'Gallery' ? '_on' : '' }" alt="포토형 목록">포토형 목록</button>
			</span>
	       <button type="button" class="btn btn_basic tooltipsy" id="btnBbsSettingMove" title="해당 게시판 컨텐츠설정관리 화면으로 이동함">컨텐츠설정관리이동</button>
			<!-- 콘텐츠 이관 target으로 참조되는 메뉴가 아닐 경우 -->
			<c:if test="${transCnt <= 0 }">
				<button type="button" class="btn btn_basic" id="btnBbsShare" onclick="javascript:fnBbsShare();">공유하기</button>
				<button type="button" class="btn btn_basic" id="btnAdd">등록</button>
				<button type="button" class="btn btn_basic" id="btnDel">삭제</button>
			</c:if>
		</div>
	</div>
	<div class="table">
		<table class="tstyle_list">
			<caption>
				카드형 게시판 - 전체선택, 순번, <c:if test="${rtnSetting.categoryYN == 'Y' }">분류,</c:if>  제목, 작성자, 작성일, 공개여부, 첨부, 조회
			</caption>
			<colgroup>
				<col class="allChk"/>
		        <col class="num"/>
	        	<c:if test="${rtnSetting.categoryYN == 'Y' }">
		        	<col class="category"/>
		        </c:if>
		    	<col class="subject"/>
		        <col class="name"/>
		    	<col class="date"/>
		        <col class="openYN"/>
		    	<col class="file"/>
		        <col class="hit"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
					<th scope="col">순번</th>
	            	<c:if test="${rtnSetting.categoryYN == 'Y' }">
						<th scope="col">분류</th>
					</c:if>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">공개여부</th>
					<th scope="col">첨부</th>
					<th scope="col">조회</th>
				</tr>
			</thead>
			<tbody>		
			<c:choose>			
				<c:when test="${!empty result && fn:length(result) > 0 }">
					<c:forEach items="${result }" var="data" varStatus="loop">
						<tr ${data.NUM1 > 9000000000 ? 'style="background:#eee;"' : ''}>
							<td>
							    <c:if test="${data.NUM1 < 9000000000 }">
							    <input type="checkbox" id="linkId" name="linkId" class="listCheck" value="${data.LINKID }" bbsShareValue="${data.MENUID }§§${data.LINKID }§§${data.TITLEID }" title="선택" />
							    </c:if>
						    </td>							
							<td>
			                	<c:if test="${data.NUM1 > 9000000000}">공지</c:if>
			                	<c:if test="${data.NUM1 < 9000000000}"><fmt:parseNumber value="${data.NUM1}" /></c:if>
		                	</td>							
							<c:if test="${rtnSetting.categoryYN == 'Y' }">
								<td>${data.CATEGORYNAME }</td>
							</c:if>						
							<td class="txt_left">							   
								<a href="${contextPath}/mgr/contentMgr/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&linkId=${data.LINKID }${link}">${data.KNAME }</a>
			                </td>
			                <td><c:out value="${data.USERNAME }" /></td>
							<td><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></td>
							<td>
								<c:if test="${data.OPENYN == 'Y'}">
									<i class="xi-unlock"></i>
									<span class="hidden">공개</span>
								</c:if>
								<c:if test="${data.OPENYN == 'N'}">
									<i class="xi-lock-o"></i>
									<span class="hidden">비공개</span>
								</c:if>
			                </td>
							<td>
								<c:if test="${data.FILEYN == 'Y'}">
									<i class="xi-diskette"></i>
									<span class="hidden">파일첨부</span>
								</c:if>
							</td>
							<td>${data.HITCOUNT }</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="${rtnSetting.categoryYN == 'Y' ? 9 : 8}">조회된 데이터가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>        
			</tbody>
		</table>
	</div>
</spform:form>
<div class="board_pager">	
	<paging:PageFooter totalCount="${totalCnt }" rowCount="${obj.rowCnt }">
		<Previous><AllPageLink><Next>
	</paging:PageFooter>	
</div>

<script type="text/javascript">

$(function() {
	
	gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리 선택', '${obj.categoryId}');

	gfnCodeComboList($("#continent"), "country", "", "대륙 선택", "${param.continent}", ""); // 대륙 코드조회
	$('#continent').on("change", function() { // 대륙 이벤트
		if($("#continent").val() != ""){
			gfnCodeComboList($("#country"), $("#continent").val(), "", "국가 선택", "", ""); // 국가 코드조회
		}else{
			$("#country").find('option').remove();
			$("#country").append("<option value=''>국가 선택</option>");
		}
	});
    
    <c:if test="${!empty param.continent}">
	    gfnCodeComboList($("#country"), "${param.continent}", "", "국가 선택", "${!empty param.country ? param.country : ''}", ""); // 국가 코드조회
    </c:if>
	    
	$('#btnSearch').click(function(){
		$('#searchForm').submit();
	}); 

	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	//등록
	$('#btnAdd').click(function(){
		document.location.href="${contextPath}/mgr/contentMgr/form?pageNum=${obj.pageNum}${link}";
	});
	
	//삭제
	$('#btnDel').click(function(){
		if($('input[name="linkId"]').is(":checked")=='false'){
		    alert("삭제할 데이터를 선택해 주세요");
		    return true;
		}
		
	    if(!confirm("선택된 데이터들을 삭제하시겠습니까?")){
	    	return true;
	    }
	    
	    $('#listForm').submit();
	});
	
	//텍스트 스타일
	$('#btnTextStyle').click(function(){
		document.location.href="${contextPath}/mgr/contentMgr?menuId=${obj.menuId}&boardKind=CARD&boardStyle=Text";
	});
	
	//텍스트 + 이미지 스타일
	$('#btnImageStyle').click(function(){
		document.location.href="${contextPath}/mgr/contentMgr?menuId=${obj.menuId}&boardKind=CARD&boardStyle=Image";
	});
	
	// 갤러리 스타일
	$('#btnGalleryStyle').click(function(){
		document.location.href="${contextPath}/mgr/contentMgr?menuId=${obj.menuId}&boardKind=CARD&boardStyle=Gallery";
	});

	//달력 세팅
    $( "#schStartDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/common/calendar/calendar.png"
    });
    
    $( "#schEndDate" ).datepicker({
        showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd',
        showOn: 'both',
        buttonImageOnly: true,
        buttonImage: "${contextPath}/resources/images/common/calendar/calendar.png"
    });
    
    // 게시판설정화면으로 이동
    $("#btnBbsSettingMove").click(function(){
    	parent.document.location.href = "${ctxMgr}/contentSetMgr?menuId=${contentSetMgrMenu }&siteId="+$('#siteIdSel', parent.document).val()+"&action=move&paramMenuId=${obj.menuId}";
    });
	
});

function fnBbsShare(){
	try{win.focus();}catch(e){}
	
	//선택 개수 체크
	$nCnt = $("input:checkbox[name=linkId]:checked").length;
	
	if( $nCnt > 0 ){
		win = window.open("${ctxMgr}/contentMgr/selectBbsShareMenuPopup?menuId=${obj.menuId}&siteId="+$('#siteIdSel', parent.document).val()+"&boardKind=${param.boardKind}",'menu_pop', 'width=350px,height=570px,scrollbars=yes,status=no');
	}else{
		alert('공유 할 데이타를 선택하세요.');
	}
	return false;
	
}

</script>
