<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/groupMgr/act" method="post" role="form">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<input type="hidden" id="groupId" name="groupId" value="${rtnGroup.GROUPID}"/>
	<input type="hidden" id="state" name="state" value="${rtnGroup.STATE}"/>
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnGroup.INBEFOREDATA}"/>
	<input type="hidden" id="inputMember" name="inputMember" value=""/>
	
	<!-- 검색파라메터 -->
	<input type="hidden" id="searchType" name="searchType" value="${obj.searchType}"/>
	<input type="hidden" id="searchText" name="searchText" value="${obj.searchText}"/>
	<input type="hidden" id="pageNum" name="pageNum" value="${obj.pageNum}"/>
	
	<fieldset>
		<legend>그룹 정보 입력</legend>
		<div class="talbe">
			<table class="tstyle_view">
				<caption>
					그룹 상세 정보 입력
				</caption>
				<colgroup>
					<col class="col-sm-2"/>
					<col />
				</colgroup>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="KName">그룹이름</label></th>
					<td><input type="text" id="KName" name="KName" value="${rtnGroup.KNAME}" class="input_long" title="그룹이름" maxlength="30" /></td>			
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="groupType">그룹유형</label></th>
					<td>
						<select name="groupType" id="groupType" title="그룹유형">
							<option value="">전체</option>
							<option value="T">전체관리자</option>
							<option value="S">사이트관리자</option>
							<option value="G">일반회원</option>
						</select>
					</td>						
				</tr>
				<tr>
					<th scope="row"><label for="KDesc">그룹상세업무</label></th>
					<td><input type="text" id="KDesc" name="KDesc" value="${rtnGroup.KDESC}" class="input_long" title="그룹상세업무" /></td>			
				</tr>
			</table>
		</div>
		<div class="btn_area">
			<button type="button" id="btnSave" class="btn btn_type02">저장</button>
			<button type="button" id="btnList" class="btn btn_type01">목록</button>
		</div>
	</fieldset>	
	<c:choose>
		<c:when test="${!empty rtnGroup}">
		<fieldset>
			<legend>그룹 회원등록</legend>
			<h2 class="depth2_title">그룹 회원 등록</h2>
			<div class="float_wrap">		
				<%-- <c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
				<p class="articles float_left">전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/> </p> --%>
				<div class="float_right">	    
					<button type="button" class="btn btn_basic" onclick="gfnMemberPopupList('T','id','M')">그룹 회원 등록</button>
				    <button type="button" id="btnUserDel" class="btn btn_basic">그룹 회원 삭제</button>
				</div>
			</div>
			<div class="table">
				<table class="tstyle_list">
					<caption>
						그룹회원 목록 - 번호, 회원구분, 아이디, 이름, 가입일
					</caption>
					<colgroup>
						<col class="allChk"/>
						<col class="num" />
						<col class="" span="2" />
						<col class="name" />
						<col class="date"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
							<th scope="col">번호</th>
							<th scope="col">회원구분</th>
							<th scope="col">아이디</th>
							<th scope="col">이름</th>
							<th scope="col">가입일</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>			
						<c:when test="${!empty rtnUser}">
							<c:forEach items="${rtnUser}" var="data" varStatus="loop">
								<tr>							
									<td><input type="checkbox" id="chkMember" name="chkMember" class="listCheck" title="선택" value="${data.USERID}"/></td>
									<td>${data.RNUM}</td>
									<td>${data.KIND_NAME}</td>
									<td>${data.USERID}</td>
									<td>${data.KNAME}</td>
									<td>${data.JOINDATE}</td>								
								</tr>				
							</c:forEach>
						</c:when>
						<c:otherwise>		
							<tr>
								<td colspan="6"> 조회된 데이터가 없습니다. </td>
							</tr>				
						</c:otherwise>				
					</c:choose>				
					</tbody>		
				</table>
			</div>
		</fieldset>
		</c:when>
	</c:choose>
	<div id="dialog" class="selector table" style="display: none;"> 
		<table class="tstyle_list">
			<caption>
			사유
			</caption>
			<tbody>
				<tr>
					<th scope="col">사유</th>
				</tr>
				<tr>
					<td id="codeNameTr">
						<textarea id="reason" name="reason" style="width:100%; height:70px;"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</spform:form>
				
<script type="text/javascript">
$(function() {
	if("${rtnGroup.GROUPTYPE}" != "" ){
		$('#groupType').val("${rtnGroup.GROUPTYPE}");		
	}
	
	$("#btnSave").click(function(){
		
		if($("#KName").val().length <= 0) {
			alert("그룹이름을 입력하세요.");
			$("#KName").focus();
			return false;
		}
		
		if($("#groupType").val().length <= 0) {
			alert("그룹유형을 선택하세요.");
			$("#groupType").focus();
			return false;
		}
		
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}
		$("#state").val("T");				
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		document.location.href = "${contextPath}/mgr/groupMgr?${link }";
	});
	
	$("#btnUserDel").click(function(){
		
		if(!confirm("선택된 회원을 삭제하시겠습니까?")) {
			return false;
		}

		$("#dialog").dialog({
			width: 350,
			height: 310,
			resizable: false,
			modal: true,
			title: "삭제사유입력",
			buttons:{
				"저장": function(){
					deleteMemberList();	
				},
				"취소": function(){
					$(this).dialog("close");
				}
			}
		});
	
	});
	
	$('#allChk').click(function(){
		var tbl = $(".tstyle_list");
		
		if( $(this).is(":checked") )
            $(":checkbox", tbl).prop("checked", true);
        else
            $(":checkbox", tbl).prop("checked", false);
	}); 
	
});

function setMemberList(inputMember){
	$('#inputMember').val(inputMember);		
	
	$("#dialog").dialog({
			width: 350,
			height: 310,
			resizable: false,
			modal: true,
			title: "등록사유입력",
			buttons:{
				"저장": function(){
					saveMemberList();	
				},
				"취소": function(){
					$(this).dialog("close");
				}
			}
	});
}

function deleteMemberList(){
	
	var reason = $('#reason').val().trim();
	
	if(reason == "" || reason == null){
		
		alert("그룹회원 삭제 사유를 입력하세요:");
		return;
		
	}else{
	
		var chklen = $("input[name='chkMember']:checked").length-1;				
		
		if(chklen < 0) {
			alert("선택한 대상이 없습니다.");
		} else {
						
			$("input[name='chkMember']:checked").each(function () {			
				var paramData = {groupId:"${rtnGroup.GROUPID}",userId:$(this).val(),state:"F",condition:"del", menuId:"${param.menuId}",reason:reason , KName: "${rtnGroup.KNAME}", fileGubun: "${rtnGroup.FILEGUBUN}"};
				$.ajax({
					type: "POST",
					async:false,
					url: "${contextPath }/mgr/groupMgr/actUser",
					data: paramData,
					success: function(){						
					}
				});
		    });			
		}
		window.location.reload();	
	}
}

//그룹회원저장
function saveMemberList(){
	var reason = $('#reason').val().trim();
	if(reason == "" || reason == null){
		alert("그룹회원 등록 사유를 입력하세요");
		return;
		
	}else{
		var inputMember = $('#inputMember').val();
		var outputMember = inputMember.split(",");
		$.each(outputMember, function(i){
			var syncChk=0;
			<c:forEach items="${rtnUser}" var="data" varStatus="loop">				
				if(outputMember[i] == "${data.userId}"){
					syncChk++;
					alert("등록된 회원입니다.(" + outputMember[i] + ")");
				}										
			</c:forEach>
			if(syncChk == 0){
				var paramData = {groupId:"${rtnGroup.GROUPID}",userId:outputMember[i],state:"T",condition:"ins", menuId:"${param.menuId}",reason:reason , KName: "${rtnGroup.KNAME}", fileGubun: "${rtnGroup.FILEGUBUN}"};
				
				$.ajax({
					type: "POST",
					async:false,
					url: "${contextPath }/mgr/groupMgr/actUser",
					data: paramData,
					success: function(){
					}
				});						
			}
		});
		window.location.reload();	
	}
}

</script>
