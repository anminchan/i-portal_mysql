<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/codeMgr/act" method="post" role="form">
	<input type="hidden" name="menuId" id="menuId" value="${param.menuId }" />
	<input type="hidden" id="siteId" name="siteId"  value=""/>
	<input type="hidden" id="paramSiteId" name="paramSiteId"  value=""/>
	
	
	<input type="hidden" id="doubleChk" name="doubleChk"  value=""/>
	
	<input type="hidden" id="paramHigherCode_Name" name="paramHigherCode_Name"  value=""/>
	
	<input type="hidden" id="paramCode" name="paramCode"  value=""/>
	<input type="hidden" id="paramHigherCode" name="paramHigherCode"  value=""/>
	
	<input type="hidden" id="higherCode" name="higherCode"  value=""/>
	<input type="hidden" id="state" name="state"  value=""/>
	<input type="hidden" id="depth" name="depth"  value=""/>
	<input type="hidden" id="sort" name="sort"  value=""/>
	<input type="hidden" id="inBeforeData" name="inBeforeData" value=""/>	
	<fieldset>
	<article class="treeMenu_area">
		<!-- 트리메뉴 -->
		<div class="tree_nav">
			<h2 class="hidden">코드관리</h2>			
			<!-- ▼ 사이트 콤보  -->
			<select name="siteIdSel" id="siteIdSel" class="siteidsel"></select>
			<!-- ▲ 사이트 콤보  -->
			<span class="siteIdSel_view"><a href="javascript: deptTree.openAll();"><i class="xi-folder-add-o"></i>전체보기</a> <a href="javascript: deptTree.closeAll();"><i class="xi-folder-remove-o"></i>전체닫기</a></span>
			<script type="text/javascript">
				<!--
				deptTree = new dTree('deptTree', '${contextPath }'); //dTree 생성
				
				// 새로고침때 초기화
				if('${rCode}' == ""){
					deptTree.clearCookie();
				}
				
				//add(id, pid, name, url, title, target, icon, iconOpne, open)
				//트리 root고정
				deptTree.add(0, -1, '${resultSite}');
				
				<c:forEach items="${result }" var="data" varStatus="loop">
					//기본 트리 구성
					deptTree.add('${data.code }', '${data.higherCode == "-" ? 0 : data.higherCode }', '${data.KName }', "javascript:clickCode('${data.siteId}','${data.code}','${data.higherCode}');");	
				</c:forEach>
				
				//dTree 화면 출력
				document.write(deptTree);		
				//-->				
			</script>
		</div>
		<!-- //트리메뉴 -->
		<!-- 트리메뉴 생성 -->
		<div class="tree_list">
			<h2 class="hidden">코드관리 상세</h2>
			<p><span class="point01">*</span> 필수입력항목 입니다.</p>
			<div class="table">
				<table class="tstyle_view">
					<caption>
						코드 상세 정보 입력 - 상위코드, 코드, 코드명(한글), 코드명(영문), 정렬 순서
					</caption>
					<colgroup>
						<col class="col-sm-1"/>
						<col class="col-sm-11"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for=higherCode_Name>상위코드</label></th>
							<td>
								<span id="higherCode_Name" title="상위코드" ></span>
								<span class="float_right">
									<input type="button" id="higherID_TopMove" value="최상위이동" class="btn btn_basic" style="display: none;"/>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="code">코드</label></th>
							<td>
								<input type="text" id="code" name="code" value="" title="코드"  onkeyup="fnCodekeyup();" style="ime-mode:disabled" maxlength="15" />
								<input type="button" value="중복체크" id="btnCodeChk" class="btn btn_basic" onclick="fnDaubleCheck();"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="point01">*</span> <label for="KName">코드명(한글)</label></th>
							<td><input type="text" id="KName" name="KName" value="" class="input_long" title="코드명(한글)" style="ime-mode:active" maxlength="30" /></td>
						</tr>
						<tr>
							<th scope="row"> <label for="EName">코드명(영문)</label></th>
							<td><input type="text" id="EName" name="EName" value="" class="input_long" title="코드명(영문)" style="ime-mode:disabled" maxlength="30" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="sortView">정렬순서</label></th>
							<td><div id="sortView" title="정렬순서" ></div></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn_area">		
				<button type="button" class="btn btn_type01" id="btnSortChg">순서변경</button>
				<button type="button" class="btn btn_type01" id="btnCodeAdd">코드추가</button>	
				<button type="button" class="btn btn_type02" id="btnSave">저장</button>
				<button type="button" class="btn btn_type01" id="btnDelete">삭제</button>
			</div>
		</div>	
	</article>	
	<div id ="dialog" class="selector" style="display: none;">
			<table class="tstyle_list" summary="">
				<caption>
				코드정렬순서변경
				</caption>
				<colgroup>
						<col width="100" />
						<col />
				</colgroup>
				<tr>
					<th scope="col">상위코드</th>
					<td><span id="setCodeHigherName"></span></td>
				</tr>
				<tr align="left">
					<td colspan="2" id="codeNameTr" align="left">
					<select id="codeNameSelect" style="width: 220px;" size= "10">
					</select>
					</td>
				</tr>
			</table>
			<input type="button" value="위로" id = "btnCodeChk" class="input_smallBlack" onclick="fnSortCateogry('U');" />
			<input type="button" value="아래로" id = "btnCodeChk" class="input_smallBlack" onclick="fnSortCateogry('D');" />
		</div>
	<!-- //트리메뉴 생성 -->
	</fieldset>
</spform:form>

<spform:form id="sortChgForm" name="sortChgForm" action="${contextPath }/mgr/codeMgr/sortChg" method="post" role="form">

<input type="hidden" name="menuId" id="menuId" value="${param.menuId }" />
<input type="hidden" id="ParamSortCode" name="ParamSortCode"  value=""/>
<input type="hidden" id="ParamSortHigherCode" name="ParamSortHigherCode"  value=""/>

<input type="hidden" id="inputGRVal" name="inputGRVal" value=""/>
</spform:form>
<script type="text/javascript">	

$(function() {
	var rCode = "${rCode}";
	var rSiteId = "${rSiteId}";
	var rHigherCode = "${rHigherCode}";
	var raction = "${action}";
	
	$("#siteId").val(rSiteId); // hidden siteId : siteId 값세팅
	
	// 메뉴 데이터 저장 후 화면에 저장값 세팅
	if(raction == "act"){
		clickCode(rSiteId, rCode, rHigherCode);
	}else{
		
		$("#btnSave").hide();
		$("#btnDelete").hide();
		$("#btnCodeChk").hide();
		
		deptTree.closeAll();
	}
	
	//common.js 정의 
	gfnSiteAdminComboList($("#siteIdSel"), "", "", "${rSiteId}");
	
	$('#siteIdSel').on("change", function() {
		location.href = "/mgr/codeMgr?menuId="+$('#menuId').val()+"&siteId="+$(this).val();
	});
	
	//코드추가
	$("#btnCodeAdd").click(function(){
		var codeLen = $("#code").val().length;
		if( codeLen != 0){ 
			$("#paramHigherCode").val($("#code").val()); //
			$("#paramHigherCode_Name").val($("#KName").val()); //
			$("#higherCode").val($("#code").val()); //
			$("#higherCode_Name").text($("#KName").val());
		}
		else{ 
			$("#paramHigherCode").val("-"); //
			$("#paramHigherCode_Name").val("[최상위코드]"); //
			$("#higherCode").val("-"); //
			$("#higherCode_Name").text("[최상위코드]");
			$("#depth").val(1);
			$("#state").val("T");
		}
		
		if($("#higherCode").val() != "-") $("#higherID_TopMove").show();

		$("#paramCode").val("");
		$("#code").val("");
		$("#sort").val(0);
		$("#sortView").text("[자동생성]");
		
		$("#KName").val("");		
		$("#EName").val("");
		
		$("#code").val("").removeAttr('disabled').focus();

		<c:if test="${WRITE eq 'T'}">
			$("#btnSave").show();
		</c:if>

		$("#btnCodeChk").show();
		$("#btnDelete").hide();
		$("#doubleChk").val("N");
	});	
	
	//코드삭제
	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}else{
			$("#state").val("F");
		}
		
		$("#insertForm").submit();	
		
	});
	
	// 상위메뉴 레이어 팝업
	$("#higherID_TopMove").click(function(){
		$("#higherID_TopMove").hide();
		$("#paramHigherCode").val("-"); //
		$("#paramHigherCode_Name").val("[최상위코드]"); //
		$("#higherCode").val("-"); //
		$("#higherCode_Name").text("[최상위코드]");
		$("#depth").val(1);
		$("#state").val("T");
	});
	
	//저장
	$("#btnSave").click(function(){
		if($("#code").val().length <= 0) {
			alert("코드를 입력하세요");
			$("#code").focus();
			return false;
		}		
		
		if($("#doubleChk").val() == 'N')
		{
			alert("코드 중복체크를  클릭하세요.");
			$("#code").focus();
			return false;
		}	
		
		if($("#KName").val().length <= 0) {
			alert("코드명을 입력하세요");
			$("#KName").focus();
			return false;
		}
		
		$("#paramCode").val($("#code").val()); // hidden paramCode : code 값세팅
		
		if(!confirm("저장하시겠습니까?")) {
			return false;
		}
		
		$("#insertForm").submit();
	});
	
	
	//순서변경 클릭
	$("#btnSortChg").click(function(){
		var code   = $("#code").val(); // 코드 id
		var siteId = $("#siteId").val(); // 사이트id
		var KName  = $("#KName").val(); // 코드명
		var higherCode = $("#higherCode").val(); // 상위코드id
		
		$("#ParamSortCode").val(code);		
		$("#ParamSortHigherCode").val(higherCode);
		
		if(code.length <= 0) {
			alert("코드를 선택하세요");
			return false;
		}
		
		$.ajax({               
	 		url: gContextPath+"/mgr/codeMgr/codesortlist",
	 		data: {'code' : code, 'siteId' : siteId, 'KName' : KName},
	 		cache: false,
	 		success:function(data) {
	 			var i = 0;
	 			var codeValue; 
	 			
	 			//Code|HigherCode|SiteID|KName|EName|Depth|Sort|State
	 			$("#codeNameSelect > option").remove();
	 			
	 			if(data.length != 0) {                                                                          
	 				$.each(data, function(i, item) {
	 					codeValue = item.code+"|"+item.higherCode+"|"+item.siteId+"|"+item.kname+"|"+item.ename+"|"+item.depth;
	 					
	 					if(i==0){
	 						$("#codeNameSelect").append('<option selected value="'+codeValue+'">'+item.kname+'</option>');
	 					}else{
	 						$("#codeNameSelect").append('<option value="'+codeValue+'">'+item.kname+'</option>');
	 					}
	 					
	 					i++;
	 				});
	 				
	 				$("#setCodeHigherName").text(KName);
	 				
		 			$("#dialog").dialog({
		 				width: 400,
		 				height: 450,
		 				resizable: false,
		 				modal: true,
		 				title: "코드정렬순서변경",
		 				buttons:{
		 					"저장": function(){
		 						fnSave();	
		 					},
		 					"닫기": function(){
		 						$(this).dialog("close");
		 					}
		 				}
		 			});

	 			}else{
	 				alert("하위 코드가 없습니다.");
	 			}
	 		}
	 	});
	});
	
	$("#KName").keyup(function(){
		var text = $(this).val();
		var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	    if(regexp.test(text)) {
	    	alert("한글만 입력가능 합니다.");
	    	$(this).val(text.replace(regexp, ''));
	    }

	});
	
	$("#EName").keyup(function(){
		var text = $(this).val();
		var numUnicode = text.charCodeAt(0);
		if((44032 <= numUnicode && numUnicode <= 55203) || (12593 <= numUnicode && numUnicode <= 12643) || ($(this).val().match(/[^a-z|^A-Z]/g) != null)){
			alert("영문(대소문자)으로 입력해주세요.");
			$(this).val($(this).val().replace(/[^a-z]/g, ''));
		}
	});
	
});

function clickCode(siteId,code,higherCode){
	$.ajax({               
 		url: gContextPath+"/mgr/codeMgr/form",
 		data: {'paramSiteId' : siteId, 'paramCode' : code, 'paramHigherCode' : higherCode},
 		cache: false,
 		success:function(result) {
 			if(result != null) {                   
				$("#code").val(result.code);    
			 	$("#code").attr('disabled','disabled');
				$("#siteId").val(result.siteId); // hidden siteId : siteId 값세팅                     
				$("#paramSiteId").val(result.siteId); // hidden paramSiteId : siteId 값세팅           
				$("#paramCode").val(result.code); // hidden paramCode : code 값세팅               
				$("#paramHigherCode").val(result.higherCode); // hidden paramHigherCode : higherCode 값세팅   
				
				$("#inBeforeData").val(result.inBeforeData);                                          

				$("#KName").val(result.kname); 					                                              
				$("#EName").val(result.ename);
				$("#sortView").text(result.sort); // 정렬순서 화면출력                                     
 							                                                                                      
				if(result.higherCode_Name != null) $("#higherCode_Name").text(result.higherCode_Name);
				else $("#higherCode_Name").text("[최상위 코드]");                                     
				
				if(result.higherCode_Name != null) $("#paramHigherCode_Name").val(result.higherCode_Name);
				else $("#paramHigherCode_Name").val("[최상위 코드]");
 							                                                                                      
				$("#higherCode").val(result.higherCode); // hidden higherCode : higherCode 값세팅
				$("#state").val(result.state); // hidden state : state 값세팅
				$("#depth").val(result.depth); // hidden depth : depth 값세팅
				$("#sort").val(result.sort);// hidden sort : sort 값세팅
				
				$("#higherID_TopMove").hide();

				<c:if test="${WRITE eq 'T'}">
					$("#btnSave").show();
				</c:if>
				<c:if test="${DELETE eq 'T'}">
					$("#btnDelete").show();
				</c:if>
				
				$("#btnCodeChk").hide();
				$("#doubleChk").val("Y");
 			}                 
 		}
 	});
}

function fnDaubleCheck(){
	var code = $("#code").val();
	var higherCode =  $("#paramHigherCode").val(); 
	
	if(code.length <= 0) {
		alert("코드를 입력하세요");
		$("#code").focus();
		return false;
	}
	
	if( code == "-" ) {
		alert("코드값으로 [-]값을 사용할 수 없습니다.");
		$("#code").val("");
		$("#code").focus();
		return false;
	}
	
	if( code == higherCode ) {
		alert("입력한 코드 ["+code+"]값은 상위코드값과 동일합니다. 사용 할 수 없습니다.");
		$("#doubleChk").val("N");
		$("#code").val("");
		$("#code").focus();
		return false;
	}
	
	$.ajax({               
 		url: gContextPath+"/mgr/codeMgr/check",
 		data: {'paramCode' : code, 'paramHigherCode' : higherCode},
 		success:function(rowCnt) {
 			
 			if(rowCnt != 0) {                                                                          
 				alert("입력한 ["+code+"]값은 중복되는 코드값이 있습니다.");
 				$("#code").val("");
 				$("#doubleChk").val("N");
 				
 			} else {
 				alert("입력한 ["+code+"]값은 사용할 수 있는 코드입니다.");
 				$("#doubleChk").val("Y");
 			}
 			
 		}
 	});
}

//정렬순서 변경
function fnSortCateogry(clss) {

	var sortkeys = document.getElementById('codeNameSelect');
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

//정렬순서변경 저장
function fnSave() {

	var inputGRVal = new Array();
	
	var sortkeys = document.getElementById('codeNameSelect');
	sortkeys.multiple = true;
 
	var j = 0;
	
	for ( var i=0; i<sortkeys.options.length; i++ ) {
		
		j++;
		inputGRVal.push(sortkeys.options[i].value+"|"+j+"|T");
	}
	
	
	$('#inputGRVal').val(inputGRVal);
	
	if(!confirm("위 코드 순서로 저장하시겠습니까?")) {
		return false;
	}
	
	$("#sortChgForm").submit();
	

}

//코드입력창에서 onkeyup이 발생했을때 중복체크 플래그를 초기화한다.
function fnCodekeyup(){
	
	$("#doubleChk").val("N");
}

</script>
