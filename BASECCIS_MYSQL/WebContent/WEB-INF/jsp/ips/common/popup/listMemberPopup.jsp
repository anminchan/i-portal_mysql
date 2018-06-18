<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<form id="sform" name="sform" method="get" action="${contextPath }/mgr/listMemberPopup">
	<input type="hidden" id="schKind" name="schKind"  value="${schKind}"/>
	<input type="hidden" id="kind" name="kind"  value=""/>
	<input type="hidden" id="outDataForm" name="outDataForm" value=""/>
	<input type="hidden" id="type" name="type"  value=""/>
	<input type="hidden" id="parentInputId" name="parentInputId"  value=""/>
	<input type="hidden" id="parentInputName" name="parentInputName"  value=""/>
	<div class="talbe">
		<table class="tstyle_view">
			<caption>
				그룹 상세 정보 입력
			</caption>
			<colgroup>
				<col class="col-sm-2">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="code">회원구분</label></th>
					<td>
						<select id="code" name="code" title="회원구분"></select>
					</td>			
				</tr>
				<tr>
					<th scope="row"><label for="schType">검색구분</label></th>
					<td><select name="schType" id="schType" title="검색구분">
							<option value="0">전체</option>
							<option value="1">이름</option>
							<option value="2">아이디</option>
						</select>				
						<input type="text" name="schText" id="schText" value="${param.searchText}" style="ime-mode:active" title="검색어"/>
					</td>						
				</tr>
			</tbody>
		</table>
	</div>
	<div class="btn_area">
		<input type="button" value="검색" class="btn btn_type02" id="btnSearch"/>
	</div>
</form>
<div class="table">
	<table class="tstyle_list">
		<caption>
			전체, 회원구분, 아이디, 이름, 전화번호
		</caption>
		<colgroup>
			<c:if test="${pType == 'M' }">
				<col class="allChk"/>
			</c:if>
			<col class="name" />
			<col class="" span="2">
		</colgroup>
		<thead>
			<tr>
		        <c:if test="${pType == 'M' }">
					<th scope="col"><input id="allChk" name="allChk" type="checkbox" title="전체선택" /></th>
		        </c:if>
				<th scope="col">회원구분</th>
				<th scope="col">아이디</th>
				<th scope="col">이름</th>
				<!-- <th scope="col">전화번호</th> -->
			</tr>
		</thead>
		<tbody>
		<c:choose>			
			<c:when test="${!empty result }">
				<c:forEach items="${result }" var="data" varStatus="loop">
				<tr id="tr">
				    <c:if test="${pType=='M' }">
					<td><input type="checkbox" id="chkMember" name="chkMember" class="listCheck" title="선택" value="${data.KIND}|${data.KIND_NAME}|${data.USERID}|${data.KNAME}|${data.JOINDATE}"/></td>
				    </c:if>
					<td>${data.KIND_NAME}</td>
					<td><a href="javascript:selectSubmit('${data.KIND}|${data.KIND_NAME}|${data.USERID}|${data.KNAME}|${data.JOINDATE}');">${data.USERID}</a></td>
					<td><a href="javascript:selectSubmit('${data.KIND}|${data.KIND_NAME}|${data.USERID}|${data.KNAME}|${data.JOINDATE}');">${data.KNAME}</a></td>
					<!-- <td></td> -->
				</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5"> 조회된 데이터가 없습니다. </td>
				</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
</div>
<c:if test="${pType=='M' }">
	<div class="btn_area txt_right">
		<button type="button" class="btn btn_type01" id="btnSave">선택</button>
	</div>
</c:if>

<script type="text/javascript">
function selectSubmit(data){
    //kind|kind_Name|userId|KName|joinDate
	var inData = data;
	var pOutDataForm = "${pOutDataForm}"; // 전달받을 데이터 형태 파라메타
	var pParentInputId = "${pParentInputId}"; // 전달받을 데이터 갯수타입 파라메타
	var pParentInputName = "${pParentInputName}"; // 전달받을 데이터 갯수타입 파라메타
	
    var sDataForm = "";
    var outputMember = new Array();

    if(pOutDataForm == "all" || pOutDataForm == ""){
        outputMember.push(inData);
    
    }else{
		sDataForm = inData.split("|");		
		outputMember.push(sDataForm[2]);
    }
    
    $(opener).find('#data').val(outputMember);
    
    if(pParentInputId == ""){
		// 호출한 부모에 값전달
		$(opener.location).attr("href", "javascript:setMemberList('"+outputMember+"');");
	}else{
		// 호출한 부모에 값전달
		if(pParentInputName == ""){
			$(opener.location).attr("href", "javascript:setMemberList('"+outputMember+"','"+pParentInputId+"');");			
		}else{
			$(opener.location).attr("href", "javascript:setMemberList('"+outputMember+"','"+pParentInputId+"', '"+pParentInputName+"');");			
		}
	}
    
	self.close();
}

$(function() {
	var pKind = "${pKind}"; // 회원구분 파라메타
	var pOutDataForm = "${pOutDataForm}"; // 전달받을 데이터 형태 파라메타
	var pType = "${pType}"; // 전달받을 데이터 갯수타입 파라메타
	var pParentInputId = "${pParentInputId}"; // 전달받을 데이터 갯수타입 파라메타
	var pParentInputName = "${pParentInputNmae}"; // 전달받을 데이터 갯수타입 파라메타
	
	$('#outDataForm').val("${pOutDataForm}");
	$('#type').val("${pType}");
	$('#parentInputId').val("${pParentInputId}");
	$('#parentInputName').val("${pParentInputName}");

	// 회원구분 코드
	gfnCodeComboList($("#code"), "UserKind", "T", "전체", "${empty pKind ? 0 : pKind}");
	
	// 회원구분 이벤트
	$('#code').on("change", function() {
		// 각회원조회 팝업 사용
		if($("#schKind").val() == "K" && $("#schKind").val() != $(this).val()){
			alert("내부회원만 조회 가능합니다");
			$("#code").val(pKind).attr("selected", "selected");
			return false;
		}
		$("#kind").val($(this).val());
	});

	$("#code").val(pKind).attr("selected", "selected"); // 회원구분 선택
	$("#kind").val(pKind); // hidden kind : kind 회원구분
	
	// 검색 이벤트
	$('#btnSearch').click(function(){
		$('#sform').submit();
	});
	
	// 체크박스 전체 선택
	$('#allChk').click(function(){
		var tbl = $(".tstyle_list");
		
		if( $(this).is(":checked") )
            $(":checkbox", tbl).prop("checked", true);
        else
            $(":checkbox", tbl).prop("checked", false);
	}); 
	
	// 등록 이벤트
	$("#btnSave").click(function(){
		//체크박스 선택 갯수
		var tbl = $(".tstyle_list");
		if(pType == "S"){
			if($("input[name='chkMember']:checked").length > 1){
				alert("다중선택이 불가합니다");
				$(":checkbox", tbl).prop("checked", false);
				return false;
			}
		}

		// 배열로 체크된 값 세팅
		var chklen = $("input[name='chkMember']:checked").length-1;
		var chkVal = $("input[name='chkMember']:checked").val();
		var sDataForm = "";
		var outputMember = new Array();

		if(pOutDataForm == "all" || pOutDataForm == ""){
			if(chklen == 0) outputMember.push(chkVal);
			else{
				$(".listCheck:checked").each(function(i){
					outputMember.push($(this).val());
				});
			}	
		}else{
			if(chklen == 0){
				sDataForm = chkVal.split("|");
				outputMember.push(sDataForm[2]);
			}else{
				$(".listCheck:checked").each(function(i){
					sDataForm = $(this).val().split("|");
					outputMember.push(sDataForm[2]);
				});
			}
		}

		if(pParentInputId == ""){
			// 호출한 부모에 값전달
			$(opener.location).attr("href", "javascript:setMemberList('"+outputMember+"');");
		}else{
			// 호출한 부모에 값전달
			if(pParentInputName == ""){
				$(opener.location).attr("href", "javascript:setMemberList('"+outputMember+"','"+pParentInputId+"');");
			}else{
				$(opener.location).attr("href", "javascript:setMemberList('"+outputMember+"','"+pParentInputId+"', '"+pParentInputName+"');");
			}
		}
		self.close(); // 팝업닫기
	});
});

</script>
