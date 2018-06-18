<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="searchForm" name="searchForm" method="get" action="${contextPath }/mgr/contentMgr" class="search_form">
   	<input type="hidden" name="menuId" value="${obj.menuId}">
   	<input type="hidden" name="boardKind" value="${obj.boardKind}">
 	<fieldset>
		<legend>검색조건</legend>
        <div class="form_group">
        	<div class="row">
        		<label>검색조건</label>
        		<select name="schType" id="schType" title="검색구분">
				    <option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
					<option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>작성자</option>
					<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>내용</option>
				</select>
				<input type="text" name="schText" id="schText" class="input_mid" value="${obj.schText }" title="검색어"/>
        	</div>
			<c:if test="${rtnSetting.categoryYN == 'Y' }">
				<div class="row">
					<label for="categoryId">분류</label>
					<select name="categoryId" id="categoryId" title="카테고리">
						<option value="0">카테고리</option>
					</select>
				</div>
			</c:if>
			<c:if test="${rtnSetting.countryYN == 'Y' }">
				<div class="row">
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
    
<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/contentMgr/actVodBoard" method="POST">
    <input type="hidden" name="inCondition" value="삭제">
    <input type="hidden" name="link" value="pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt}${link }" />
    <input type="hidden" name="menuId" value="${obj.menuId }" />
    <input type="hidden" name="boardId" value="${obj.boardId }" />
    <input type="hidden" name="startTime" value="11111111" />
    <input type="hidden" name="endTime" value="11111111" />
    
    <div class="float_wrap">
    	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
		<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
	    <div class="float_right">
	        <span class="photo_type">
				<button type="button" id="btnTextStyle" class="list${obj.boardStyle == 'Text' ? '_on' : '' }">목록형</button> 
				<button type="button" id="btnImageStyle" class="thumb${obj.boardStyle == 'Image' ? '_on' : '' }">썸네일 목록</button> 
				<button type="button" id="btnGalleryStyle" class="album${obj.boardStyle == 'Gallery' ? '_on' : '' }">포토형 목록</button>
			</span>
			<!-- 콘텐츠 이관 target으로 참조되는 메뉴가 아닐 경우 -->
			<c:if test="${transCnt <= 0 }">
	            <button type="button" class="btn btn_basic tooltipsy" id="btnBbsSettingMove" title="해당 게시판 컨텐츠설정관리 화면으로 이동함">컨텐츠설정관리이동</button>
				<button type="button" class="btn btn_basic tooltipsy" id="btnBbsShare" onclick="javascript:fnBbsShare();" title="이 곳에 등록된 글을 다른게시판에 공유함">공유하기</button>
				<button type="button" class="btn btn_basic" id="btnAdd">등록</button>
				<button type="button" class="btn btn_basic" id="btnDel">삭제</button>
	    	</c:if>
	    </div>
    </div>
    
    <input  id="allChk" name="allChk" type="checkbox" title="전체선택" />
    <ul class="photo_list thumb_type">
        <c:choose>          
            <c:when test="${!empty result && fn:length(result) > 0 }">
                <c:forEach items="${result }" var="data" varStatus="loop">
		            <li><input type="checkbox" id="linkId" name="linkId" class="listCheck" value="${data.LINKID }" bbsShareValue="${data.MENUID }§§${data.LINKID }§§${data.TITLEID }" title="선택" />
		            	<a href="${url }" class="thumb">
		            		<c:if test="${!empty data.IMAGEFILENAME and data.IMAGEFILENAME ne '-' }">
							 	<img alt="${data.ALTINFO }" src="${contextPath}/fileDownloadThumbnails?titleId=${data.TITLEID }" alt="${data.IMAGEFILENAME }"/>
							</c:if>
							<c:if test="${empty data.IMAGEFILENAME or data.IMAGEFILENAME eq '-' }">
								<img src="${contextPath}/resources/images/ips/bbs/noimage.gif" alt="${data.KNAME}"/>
							</c:if>
	            		</a>
		                <div class="headline">
			                <a href="${contextPath}/mgr/contentMgr/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&linkId=${data.LINKID }${link}">
								<c:if test="${data.DEPTH > 1 }">
									<c:forEach var="depth" begin="2" end="${data.DEPTH }">
										<img src="/resources/images/common/tree/icon_replay.gif" alt="답글"/>  
									</c:forEach>
							   </c:if>
			                	<strong class="tit">${data.KNAME }</strong>
			                	<span class="desc"><text:splitText value="${data.KHTML }" tail="..." textSize="95" /></span>
			                </a>
			                <span class="date"><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></span>
	                    </div>
		            </li>
                </c:forEach>
            </c:when>
            <c:otherwise>
	           <li>조회된 데이터가 없습니다.</li>
            </c:otherwise>
        </c:choose>
    </ul>
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
        document.location.href="${contextPath}/mgr/contentMgr?menuId=${obj.menuId}&boardKind=VOD&boardStyle=Text";
    });
    //텍스트 + 이미지 스타일
    $('#btnImageStyle').click(function(){
        document.location.href="${contextPath}/mgr/contentMgr?menuId=${obj.menuId}&boardKind=VOD&boardStyle=Image";
    });
    // 갤러리 스타일
    $('#btnGalleryStyle').click(function(){
        document.location.href="${contextPath}/mgr/contentMgr?menuId=${obj.menuId}&boardKind=VOD&boardStyle=Gallery";
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
