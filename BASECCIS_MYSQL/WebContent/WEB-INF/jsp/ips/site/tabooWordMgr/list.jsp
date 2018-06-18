<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<!-- 콘텐츠영역 --> 
<p class="tabooWord_info">아래 정보를 통한 <span class="point02_bold">게시글 유해어 차단을 도와드립니다.</span> <button type="button" class="btn btn_type01" id="btnAdd">등록</button></p>

<spform:form id="searchForm" name="searchForm" class="search_form" method="POST" action="${contextPath}/mgr/tabooWordMgr">
	<input type="hidden" name="menuId" value="${obj.menuId}">
	<fieldset>
		<legend>용어검색</legend>
		<div class="form_group">
			<div class="row">
				<label for="schText">검색어 입력</label>
				<input id="schText" name="schText" type="text" class="input_mid" placeholder="검색어를 입력해 주세요" value="${obj.schText }"  maxlength="50"/>				
				<span class="float_right">
					<button type="button" class="btn btn_type02" id="btnSearch">검색</button>
				</span>
			</div>
		</div>
	</fieldset>
</spform:form>
	
<spform:form id="searchKeyBoardForm" name="searchKeyBoardForm" method="POST" action="${contextPath}/mgr/tabooWordMgr">
	<input type="hidden" name="menuId" value="${obj.menuId}">
	<input type="hidden" name="keyBoard" id="keyBoard" value="${param.keyBoard}">
	<input type="hidden" name="keyBoardVal" id="keyBoardVal" value="${param.keyBoardVal}">
	
	<div class="keyboard">
		<span class="btnAll"><button type="button">전체</button></span>
		<span class="korkey">
			<button type="button">ㄱ</button>
			<button type="button">ㄴ</button>
			<button type="button">ㄷ</button>
			<button type="button">ㄹ</button>
			<button type="button">ㅁ</button>
			<button type="button">ㅂ</button>
			<button type="button">ㅅ</button>
			<button type="button">ㅇ</button>
			<button type="button">ㅈ</button>
			<button type="button">ㅊ</button>
			<button type="button">ㅋ</button>
			<button type="button">ㅌ</button>
			<button type="button">ㅍ</button>
			<button type="button">ㅎ</button>
		</span>	
		<span class="engkey">
			<button type="button">A</button>
			<button type="button">B</button>
			<button type="button">C</button>
			<button type="button">D</button>
			<button type="button">E</button>
			<button type="button">F</button>
			<button type="button">G</button>
			<button type="button">H</button>
			<button type="button">I</button>
			<button type="button">J</button>
			<button type="button">K</button>
			<button type="button">L</button>
			<button type="button">M</button>
			<button type="button">N</button>
			<button type="button">O</button>
			<button type="button">P</button>
			<button type="button">Q</button>
			<button type="button">R</button>
			<button type="button">S</button>
			<button type="button">T</button>
			<button type="button">U</button>
			<button type="button">V</button>
			<button type="button">W</button>
			<button type="button">X</button>
			<button type="button">Y</button>
			<button type="button">Z</button>
		</span>
	</div>	
</spform:form>	
<spform:form id="listForm" name="listForm" method="POST" action="${contextPath}/mgr/tabooWordMgr">
	<input type="hidden" name="menuId" value="${obj.menuId}">
	<input type="hidden" name="keyBoard" id="keyBoard" value="${param.keyBoard}">
	<input type="hidden" name="keyBoardVal" id="keyBoardVal" value="${param.keyBoardVal}">
	<input type="hidden" name="seq" id="seq" value="0" />
	<p class="dropdown_list">
		<c:choose>
			<c:when test="${fn:length(result) > 0 }">
				<c:forEach items="${result }" var="list" varStatus="loop">
					<span>
						<a href="javascript:fnTabooWordView('${list.SEQ }', '${list.KNAME }');"><c:out value="${list.KNAME }" /></a>
						<a href="javascript:fnTabooWordDel('${list.SEQ }');" class="btn_delete"><i class="xi-close-min"></i><span class="hidden">삭제</span></a>
					</span>
				</c:forEach>
			</c:when>
			<c:otherwise>
				▶ 검색된 용어가 없습니다.
			</c:otherwise>
		</c:choose>
	</p>
</spform:form>

<div class="board_pager">
	<paging:PageFooter totalCount="${ totalCnt }" rowCount="${ rowCnt }">
		<Previous><AllPageLink><Next>
	</paging:PageFooter>
</div>

<div id ="tabooWordDialog" style="display: none;">
	<div class="form_group txt_center">
		<label for="KName">유해어</label>
		<input type="text" name="KName" id="KName" value="" class="input_mid" />
		<input type="button" id="tabooWordBtnSave" class="btn btn_type02" value="저장">		
	</div>
</div>

<script type="text/javascript">
$(function() {	
	$(".keyboard button").each(function(){
		if($("#keyBoardVal").val() == $(this).text()){
			$(this).prop('class', 'on');
		}
	});
	
	// 검색 클릭시
	$('#btnSearch').click(function(){
		if($("#schText").val().length <= 0){
			alert("검색어를 입력해주세요.");
			$("#schText").focus();
			return;
		}
		
        $('#searchForm').submit();
    }); 
    
 	// keyboard 클릭시
    $(".keyboard button").click(function(){
    	$("#pageNum").val(1);
    	
    	// keyboard 클릭시 search값 세팅
    	$("#keyBoard").val($(this).parent().prop('class'));
    	$("#keyBoardVal").val($(this).text());

    	$('#searchKeyBoardForm').submit();
    });
 	
	$("#btnAdd").click(function(){
		$("#tabooWordDialog").dialog({
			width: 490,
			height: 170,
			resizable: false,
			modal: true,
			title: "유해어관리",
			buttons:{
				"close": function(){
					$(this).dialog("close");
				}
			}
		});
	});
	
	$("#tabooWordBtnSave").click(function(){
		$.ajax({
	 		url: gContextPath+"/mgr/tabooWordMgr/act",
	 		data: {'KName' : $("#KName").val(), 'seq' : $("#seq").val()},
	 		async: false,
	 		type: "POST",
	 		success:function(result) {
	 			if(result > 0) {
	 				alert("저장되었습니다.");
					document.location.href="${ctxMgr }/tabooWordMgr?menuId=${obj.menuId}";
					//$(this).dialog("close");
	 			}
	 		}
 		});
	});
	
});

function fnTabooWordView(seq, KName){
	$("#seq").val(seq);
	$("#KName").val(KName);
	
	$("#tabooWordDialog").dialog({
		width: 490,
		height: 170,
		resizable: false,
		modal: true,
		title: "유해어관리",
		buttons:{
			"close": function(){
				$(this).dialog("close");
			}
		}
	});
}

function fnTabooWordDel(seq){
	$("#seq").val(seq);
	$("#listForm").prop('action', '${ctxMgr }/tabooWordMgr/delete');
	$("#listForm").submit();
}

</script>
