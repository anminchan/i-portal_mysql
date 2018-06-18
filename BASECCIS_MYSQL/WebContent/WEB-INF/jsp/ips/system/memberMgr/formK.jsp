<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertTeamForm" name="insertTeamForm" action="${contextPath }/mgr/memberMgr/insertTeam" method="post" role="form">

<input type="hidden" id="userId" name="userId" value="${rtnMember.USERID}"/>
<input type="hidden" id="menuId" name="menuId" value="${obj.menuId}"/>
<input type="hidden" id="paramSiteId" name="paramSiteId" value="${rtnSite.siteId}"/>
<input type="hidden" id="state" name="state" value="${rtnSite.state}"/>
<input type="hidden" id="subYN" name="subYN" value="${rtnSite.subYN}"/>
<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnSite.inBeforeData}"/>
<input type="hidden" id="inputGRVal" name="inputGRVal"  value=""/>

<input type="hidden" id="inCondition" name="inCondition"  value=""/>

<input type="hidden" id="kind" name="kind" value="${rtnMember.KIND}"/>

<!-- 검색파라메타 -->
<input type="hidden" id="siteId" name="siteId" value="${obj.siteId}"/>
<input type="hidden" id="schStartDate" name="schStartDate" value="${obj.schStartDate}"/>
<input type="hidden" id="schEndDate" name="schEndDate" value="${obj.schEndDate}"/>
<input type="hidden" id="schType" name="schType" value="${obj.schType}"/>
<input type="hidden" id="schText" name="schText" value="${obj.schText}"/>

<fieldset>
	<legend>내부회원 상세정보</legend>
	
	<h2 class="depth2_title">기본정보</h2>
	<div class="table">
		<table class="tstyle_view">
			<caption>
				사이트 상세 정보 입력
			</caption>
			<colgroup>
				<col class="col-sm-2" />
	            <col class="col-sm-4" />
	            <col class="col-sm-2" />
	            <col class="col-sm-4" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="userId">아이디</label></th>
					<td><c:out value="${rtnMember.USERID }" /></td>
					<th scope="row"><label for="kind_name">회원구분</label></th>
					<td><c:out value="${rtnMember.KIND_NAME }" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="KName">이름</label></th>
					<td><c:out value="${rtnMember.KNAME }" /></td>
					<th scope="row"><label for="joindate">가입일</label></th>
		            <td>
		                <c:out value="${fn:substring(rtnMember.JOINDATE, 0, 4) }-${fn:substring(rtnMember.JOINDATE, 4, 6) }-${fn:substring(rtnMember.JOINDATE, 6, 8) }" />
		            </td>
				</tr>
				<tr>
					<th scope="row"><label for="namePath">부서</label></th>
					<td colspan="3"><c:out value="${rtnMember.NAMEPATH }" /></td>
				</tr>
			</tbody>
		</table>
	</div>		
	<h2 class="depth2_title">부서정보</h2>
	<div class="table">
		<table class="tstyle_list">
	        <caption>
				내부직원 겸빅부서목록
	        </caption>
	        <colgroup>
	            <col width="200" />
	            <col width="100" span="2"/>
	            <col width="125" />
	            <col width="*" />
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col">부서</th>
	                <th scope="col">직위</th>
	                <th scope="col">직급</th>
	                <th scope="col">전화번호</th>
	                <th scope="col">담당업무</th>
	            </tr>
	        </thead>
	        <tbody>        
	          <c:set var="cnt" value="1" />
	          <c:set var="sizeList" value="${fn:length(rtnMemberTeamList)}" />
	          <c:forEach items="${rtnMemberTeamList }" var="teamList" varStatus="status">                    
	            <tr>
	                <td>
	                <c:choose>
		                <c:when test="${teamList.SORT != 1 }">
			                <a href="javascript:fnAddTeamPopup('${rtnMember.DEPTID}','${teamList.USERID}','${teamList.DEPTID}','${teamList.DEPTSEQ}','${teamList.DUTYID}','${teamList.POSITIONID}','${teamList.PHONE}','${teamList.FAX}','${teamList.CHARGEWORK}','${teamList.SORT}')"> 
			                	<c:out value="${teamList.DEPTNAME }" />
			                </a>
		                </c:when>
		                <c:otherwise>
		                	<c:out value="${teamList.DEPTNAME }" />
						</c:otherwise>                	
	                </c:choose>
	                </td>
	                <td><c:out value="${teamList.DUTYNAME }" /></td>
	                <td><c:out value="${teamList.POSITIONNAME }" /></td>
	                <td><c:out value="${teamList.PHONE }" /></td>
	                <td class="txt_left"><c:out value="${teamList.CHARGEWORK }" /></td>
	            </tr>            
	            <c:if test="${cnt == sizeList}">
	            	<input type="hidden" id="sort" name="sort" value="${teamList.SORT + 1}"/>
	            </c:if>            
	            <c:set var="cnt" value="${cnt + 1 }" />                
	          </c:forEach>                
	        </tbody>
	    </table>
	</div>   
	<h2 class="depth2_title">그룹정보</h2>
	<div class="table">
	    <table class="tstyle_list" >
	        <caption>
	            그룹정보목록
	        </caption>
	        <colgroup>
	            <col width="80" />
	            <col width="*" span="2" />
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col">순번</th>
	                <th scope="col">그룹유형</th>
	                <th scope="col">그룹이름</th>
	            </tr>
	        </thead>
	        <tbody>        
	            <c:choose>
	                <c:when test="${fn:length(rtnGroupList) > 0 }">
	                    <c:forEach items="${rtnGroupList }" var="groupList" varStatus="status">
			            <tr>
			                <td><c:out value="${status.count }" /></td>
			                <td><c:out value="${groupList.groupType_Name }" /></td>
			                <td><c:out value="${groupList.KName }" /></td>
			            </tr>
	                    </c:forEach>
	                </c:when>
	                <c:otherwise>
		            <tr>
		                <td colspan="3">등록된 그룹이 없습니다.</td>
		            </tr>
	                </c:otherwise>
	            </c:choose>
	            
	        </tbody>
	    </table>
	</div>	  
</fieldset>
</spform:form>

<input type="hidden" id="inputGRVal" name="inputGRVal" value=""/>
<div class="btn_area">
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
</div>
							
<script type="text/javascript">
$(function() {
	
	$("#btnList").click(function(){
        location.href="${contextPath}/mgr/memberMgr?${link}";
    });
	
	$("#btnSave").click(function(){
		if($("#KName").val().length <= 0) {
			alert("사이트명을 입력하세요");
			$("#KName").focus();
			return false;
		}
		
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		
		$("#insertForm").submit();
	});
});


function fnAddTeamPopup(mainDeptId,userId, deptId, deptSeq, dutyId, positionId, phone, fax,chargeWork ,esort){
	
	var sort = $("#sort").val(); //새로입력하기 위해 겸직리스트에서 sort max값을 가져온다.
	
	 //겸직등록 팝업
	 window.open(gContextPath+"/mgr/memberMgr/addTeamForm?mainDeptId="+mainDeptId+"&userId="+userId+"&deptId="+deptId+"&deptSeq="+deptSeq+"&dutyId="+dutyId+"&positionId="+positionId+"&phone="+phone+"&fax="+fax+"&chargeWork="+chargeWork+"&sort="+sort, "겸직정보", "width=700, height=300");
}

function fnInsertTeam(userId, deptId, deptSeq, dutyId, positionId, phone, fax,chargeWork ,sort){
	
 	var inputGRVal = userId+"|"+deptId+"|"+deptSeq+"|"+dutyId+"|"+positionId+"|"+phone+"|"+fax+"|"+chargeWork+"|"+sort;
	$('#inputGRVal').val(inputGRVal);
	
	$('#inCondition').val("입력");

	$("#insertTeamForm").submit();
}

function fnDeleteTeam(){
	
	var form =$("#insertTeamForm");
	
	var chlen = $("input[name='invalue[]']:checkbox:checked", form).length;
	
	if (chlen == 0){
		alert("아무것도 선택되지 않았습니다.");
		return;
	}
	
	var inputGRVal = new Array();
	
	$("input[name='invalue[]']:checked", form).each(function() {
		inputGRVal.push($(this).val());
	});

	$('#inputGRVal').val(inputGRVal);
	
	if(!confirm("삭제하시겠습니까?")) {
		return false;
	}
	
	$('#inCondition').val("삭제");
	$("#insertTeamForm").submit();
	
}

</script>
