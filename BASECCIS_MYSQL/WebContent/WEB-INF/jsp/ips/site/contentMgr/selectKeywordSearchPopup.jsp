<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="searchForm" name="searchForm" method="get" action="${contextPath }/mgr/contentMgr/selectKeywordSearchPopup">
<input type="hidden" name="menuId" value="${obj.menuId}">

<fieldset>
    <legend>검색조건</legend>
    <div class="form_group txt_center">
		<div class="row">
			<label for="schText"">키워드</label>
			<input type="text" name="schText" id="schText" class="input_mid" value="${obj.schText }" title="검색어"/>
			
         	<input type="button" id="btnSearch" class="btn btn_type02" value="검색">
		</div>
	</div>
</fieldset>
</spform:form>
<spform:form id="listForm" name="listForm" action="${contextPath }/mgr/contentMgr/selectKeywordSearchPopup" method="POST">
<input type="hidden" name="menuId" value="${obj.menuId }" />
	<div class="table">
	    <table class="tstyle_list">
	        <caption>
	            키워드 목록
	        </caption>
	        <colgroup>
	            <col width="5%" />
	            <col width="5%" />
	            <col />
	            <col width="10%" />
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col"><input id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
	                <th scope="col">순위</th>
	                <th scope="col">키워드명</th>
	                <th scope="col">키워드건수</th>
	            </tr>
	        </thead>
	        <tbody>	        
	        <c:choose>          
	            <c:when test="${!empty result && fn:length(result) > 0 }">
	                <c:forEach items="${result }" var="data" varStatus="loop">
		            <tr class="<c:if test="${(loop.count%2) == 0 }">row_bg</c:if>">
		                <td>
		                    <input type="checkbox" id="chkKeywords" name="chkKeywords" class="listCheck" value="${data.KEYWORD }" title="선택" />
		                </td>
		                <td>${data.NUM  }</td>
		                <td class="txt_left"><c:out value="${data.KEYWORD }" /></td>
		                <td><c:out value="${data.KEYWORDCNT }" /></td>
		            </tr>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	            <tr>
	                <td colspan="3">조회된 데이터가 없습니다.</td>
	            </tr>
	            </c:otherwise>
	        </c:choose>
	        </tbody>
	    </table>	
	</div>
	<div class="txt_right">
		   <button type="button" class="btn btn_type02" id="btnAdd">등록</button>
	</div>
</spform:form>

<script type="text/javascript">
$(function() {

	$("#btnSearch").click(function(){
		$('#searchForm').submit();
	});
	
	$("#btnAdd").click(function(){
		//선택 개수 체크
		$nCnt = $("input:checkbox[name=chkKeywords]:checked").length;
		if($nCnt <= 0){
			alert("하나이상 선택하시기 바랍니다.");
			return;
		}
		$(".keyword", opener.document).val(''); // 작성폼 키워드 초기화 
		
		// 작성폼 키워드에 추가
		$("input[name=chkKeywords]:checked").each(function(i){
			$(".keyword", opener.document).eq(i).val($(this).val());
		});
		
		alert("키워드가 등록되었습니다.");
		self.close();
	});
	
	$('#allChk').click(function(){
        $(".listCheck").prop("checked", this.checked);
    }); 
	
});

</script>