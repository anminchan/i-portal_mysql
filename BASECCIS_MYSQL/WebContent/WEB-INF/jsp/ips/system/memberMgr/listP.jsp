<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
   
<ul class="tab_menu">
	<%-- <li class="on"><a href="#" id="btnPer" aria-expanded="true">개인회원(${multiCount[0] > 0 ? multiCount[0] : 0 })</a></li>
	<li><a href="#" id="btnCom" aria-expanded="false">기업회원(${multiCount[1] > 0 ? multiCount[1] : 0 })</a></li> --%>
	<li><a href="#" id="btnEmp" aria-expanded="false">내부직원(${multiCount[2] > 0 ? multiCount[2] : 0 })</a></li>
	<%-- <li><a href="#" id="btnOut">탈퇴회원(${multiCount[3] > 0 ? multiCount[3] : 0 })</a></li> --%>
</ul>

<form id="sform" name="sform" method="get" action="${contextPath }/mgr/memberMgr" class="search_form">
	<fieldset>
	<legend>검색조건</legend>
	<input type="hidden" name="menuId" id="menuId" value="${obj.menuId }" />
	<input type="hidden" name="kind" id="kind" value="${empty obj.kind ? 'P' : obj.kind }" />	
	<div class="form_group">
		<div class="row">
			<label for="schStartDate">가입기간</label>
			<input type="text" name="schStartDate" id="schStartDate" value="${obj.schStartDate}" readonly="readonly" placeholder="YYYY-MM-DD"/> ~ 
			<input type="text" name="schEndDate" id="schEndDate" value="${obj.schEndDate }" readonly="readonly" placeholder="YYYY-MM-DD"/>
		</div>
		<div class="row">
			<label for="siteId">가입경로</label>
			<select name="siteId" id="siteId" title="가입경로">
            </select>
		</div>
		<div class="row">
			<label for="schType">검색조건</label>
			<select name="schType" id="schType" title="검색조건">
				<option value="0">전체</option>
				<option value="1" ${obj.schType == 1 ? 'selected="selected"' : ''}>이름</option>
				<option value="2" ${obj.schType == 2 ? 'selected="selected"' : ''}>아이디</option>
			</select>
			<input type="text" name="schText" id="schText" value="${obj.schText}" class="input_mid" title="검색어"/>
		</div>
		<span class="display_block txt_center">
           	<input type="submit" id="btnSearch" class="btn btn_type02" value="검색">
        </span>
	</div>		
	</fieldset>
</form>
	
<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
<div class="float_wrap">	
	<p class="articles">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p>
	<div class="float_right">
	    <button type="button" id="btnPrint" class="btn btn_basic"><i class="xi-print"></i> Print</button>
		<button type="button" id="btnReg" class="btn btn_basic">등록</button>
	</div>
</div>
<div class="table">	
<table class="tstyle_list">
	<caption>
		회원목록
	</caption>
	<colgroup>		
		<col width="5%" />
		<col width="5%" />
		<col width="20%" />
		<col width="20%" />
		<col width="10%" />
		<col width="10%" />
		<col width="15%" />
		<col width="15%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><input  id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
			<th scope="col">번호</th>
			<th scope="col">아이디</th>
			<th scope="col">이름</th>
			<th scope="col">메일링여부</th>
			<th scope="col">가입일</th>
               <th scope="col">가입경로</th>
			<th scope="col">인증구분</th>
		</tr>
	</thead>
	<tbody>
	<c:choose>			
		<c:when test="${fn:length(rtnMemberList) > 0 }">
			<c:forEach items="${rtnMemberList }" var="memberList" varStatus="loop">
				<tr>
					<td><input type="checkbox" id="chkSiteIds" name="chkSiteIds" class="listCheck" value="${memberList.RNUM1 }" title="선택" /></td>
					<td>${memberList.RNUM1 }</td>
					<td>${memberList.USERID }</td>
					<td><a href="${contextPath}/mgr/memberMgr/form?userId=${memberList.USERID }${link }">${memberList.KNAME }</a></td>
					<td>${memberList.MAILING == 'Y' ? '가입' : '미가입' }</td>
					<td>${fn:substring(memberList.JOINDATE, 0, 4) }-${fn:substring(memberList.JOINDATE, 4, 6) }-${fn:substring(memberList.JOINDATE, 6, 8) }</td>
					<td>${memberList.JOINSITEID_NAME }</td>
					<td>${memberList.CERTIFICATION_NAME }</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="8"> 조회된 데이터가 없습니다. </td>
			</tr>
		</c:otherwise>		
	</c:choose>		
	</tbody>
</table>
</div>
<div class="board_pager">
	<paging:PageFooter totalCount="${ totalCnt }" rowCount="${rowCnt }">
		<Previous><AllPageLink><Next>
	</paging:PageFooter>
</div>

<script type="text/javascript">
$(function() {

	gfnSiteComboList($('#siteId'), "", "전체", "${fn:trim(obj.siteId) == '' ? '' : obj.siteId}");
	
    $('#btnSearch').click(function(){
        if($('#schStartDate').val() == null || $('#schStartDate').val() == "" || $('#schEndDate') == null || $('#schEndDate').val() == ""){
            alert("가입기간을 입력하세요");
            return;
        }
        
        $("#sform").attr('action', '${ctxMgr }/memberMgr');
        $('#sform').submit();
    }); 

	$('#allChk').click(function(){
		var tbl = $(".tstyle_list");
		
		if( $(this).is(":checked") )
            $(":checkbox", tbl).prop("checked", true);
        else
            $(":checkbox", tbl).prop("checked", false);
			
	});
	
	$('#btnReg').click(function(){
	    $('#kind').val("P");
	    
	    $("#sform").attr('action', '${ctxMgr }/memberMgr/regForm');
	    $('#sform').submit();
	});
	
	$('#btnPer').click(function(){
	    $('#kind').val("P");
	    $("#sform").attr('action', '${ctxMgr }/memberMgr');
	    $('#sform').submit();
	});
	$('#btnCom').click(function(){
	    $('#kind').val("C");
	    $("#sform").attr('action', '${ctxMgr }/memberMgr');
	    $('#sform').submit();
	});
	$('#btnEmp').click(function(){
	    $('#kind').val("K");
	    $("#sform").attr('action', '${ctxMgr }/memberMgr');
	    $('#sform').submit();
	});
	
	$('#btnOut').click(function(){
	    $('#kind').val("O");
	    $("#sform").attr('action', '${ctxMgr }/memberMgr');
	    $('#sform').submit();
	});
	
	//달력 세팅
    $( "#schStartDate" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
	
    $( "#schEndDate" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
	
	 // 인쇄
	$('#btnPrint').click(function(){
		printIt("${contextPath}");
	});
	
});
</script>
