<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentMgr/actContent" method="post">
<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
<input type="hidden" id="titleId" name="titleId" value="${rtnContent.titleId}"/>
<input type="hidden" id="KHtml" name="KHtml" value="<c:out value='${rtnContent.KHtml}' escapeXml='true'/>"/>
<input type="hidden" id="boardId" name="boardId" value="${rtnContent.boardId}"/>
<input type="hidden" id="linkId" name="linkId" value="${rtnContent.linkId}"/>
<input type="hidden" id="kName" name="kName" value="${rtnContent.boardName}"/>

<fieldset>
	<legend>콘텐츠등록관리</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<c:if test="${rtnContent.menuId ne rtnContent.titleMenuID}">
		<p>공유받은 콘텐츠는 수정할 수 없습니다. 설정된 공유를 해제하고 수정가능 합니다.</p>
	</c:if>
	<div class="table">	
		<table class="tstyle_view">
			<caption>
				콘텐츠등록관리
			</caption>
			<colgroup>
				<col class="col-sm-2"/>
				<col class="col-sm-10"/>
			</colgroup>
			<tr>
				<th scope="row">메뉴명</th>
				<td>${rtnContent.menuName}</td>
			</tr>
			<tr>
				<th scope="row">콘텐츠 명</th>
				<td>${rtnContent.boardName}</td>
			</tr>
			<tr>
				<th scope="row"><label for="context">등록자</label></th>
				<td><c:out value="${!empty(rtnContent.userName) ? rtnContent.userName : obj.myName }" /></td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> 키워드</th>
				<td>
					<input type="text" name="keyword1" id="keyword1" value="${rtnContent.keyword1}" class="input keyword" title="키워드1" maxlength="30"/>
					<input type="text" name="keyword2" id="keyword2" value="${rtnContent.keyword2}" class="input keyword" title="키워드2" maxlength="30"/>
					<input type="text" name="keyword3" id="keyword3" value="${rtnContent.keyword3}" class="input keyword" title="키워드3" maxlength="30"/>
					<input type="text" name="keyword4" id="keyword4" value="${rtnContent.keyword4}" class="input keyword" title="키워드4" maxlength="30"/>
					<input type="text" name="keyword5" id="keyword5" value="${rtnContent.keyword5}" class="input keyword" title="키워드5" maxlength="30"/>
					<input type="text" name="keyword6" id="keyword6" value="${rtnContent.keyword6}" class="input keyword" title="키워드6" maxlength="30"/>
					<input type="text" name="keyword7" id="keyword7" value="${rtnContent.keyword7}" class="input keyword" title="키워드7" maxlength="30"/>
					<input type="text" name="keyword8" id="keyword8" value="${rtnContent.keyword8}" class="input keyword" title="키워드8" maxlength="30"/>
					<input type="text" name="keyword9" id="keyword9" value="${rtnContent.keyword9}" class="input keyword" title="키워드9" maxlength="30"/>
					<input type="text" name="keyword10" id="keyword10" value="${rtnContent.keyword10}" class="input keyword" title="키워드10" maxlength="30"/>
	                <input type="button" value="키워드검색" class="btn btn_basic" onClick="javascript:gfnKeywordSearch('${obj.menuId}');" />
				</td>
			</tr>
			<c:if test="${!empty rtnContent.linkId and rtnContent.menuId eq rtnContent.titleMenuID}">
			<tr>
				<th scope="row">콘텐츠 공유</th>
				<td><button type="button" id="contentLink" class="btn btn_basic" title="이 곳에 컨텐츠를 다른곳에 공유하는 기능">콘텐츠 선택</button>
					<c:forEach var="list" items="${rtnContentLinkList }" varStatus="status">
						<div id="linkId_${list.MENUID }">${list.NAMEPATH }
							 <span class="display_block txt_right">
							 	<a href="javascript:fnDelContentsLink('${list.MENUID }');" class="btn btn_basic">삭제</a>
							 </span>
						</div>
					</c:forEach>
				</td>
			</tr>
			</c:if>
			<tr>
				<td colspan="2">
				<c:if test="${editor eq 'Namo'}">		            
		            <!-- ▼ 에디터 -->  
		          	<script type="text/javascript">         
		            var CrossEditor = new NamoSE('namoEditor');
		            //에디터 업로드 용량
		           	CrossEditor.params.UploadFileSizeLimit = "movie:524288000, image:20971520";
		            CrossEditor.params.Width = "100%";
		            <c:if test="${rtnContent.menuId ne rtnContent.titleMenuID}">
		            CrossEditor.params.CreateTab = "2" ;
		            CrossEditor.params.ActiveTab = 2 ;
		            CrossEditor.ShowTab(false);
					</c:if>
		            CrossEditor.EditorStart();
		            function OnInitCompleted(e){
		            	e.editorTarget.SetBodyValue($("#KHtml").val());
		            }
		          	</script>
		           	<!-- ▲ 에디터  -->
	           	</c:if>
	           	<c:if test="${editor eq 'Daum'}">
	            	<!-- ▼ 에디터 -->  
		          	<script type="text/javascript">
		          		gfnInitEditor("KHtml", 'self');
		          	</script>
	           		<div id="editor_frame"></div>
	           	</c:if>
				</td>
			</tr>		
		</table>
	</div>
</fieldset>
</spform:form>

<div id="dialog" style="display: none;">
	<div class="table">
		<table class="tstyle_list">
			<caption>
				콘텐츠 이력보기
			</caption>
			<colgroup>
				<col width="80" />
				<col width="170"/>
				<col width="120"/>
				<col width="170"/>
			</colgroup>
			<thead>
				<tr>				
					<th scope="col">순번</th>
					<th scope="col">수정일</th>
					<th scope="col">작성자</th>
					<th scope="col">기능</th>				
				</tr>
			</thead>
			<tbody>			
			<c:choose>			
				<c:when test="${!empty rtnHistory }">
					<c:forEach items="${rtnHistory }" var="data" varStatus="loop">
					<tr>								
						<td>${data.RNUM}</td>
						<td>${data.INSTIME}</td>
						<td>${data.DMLUSERNAME}</td>
						<td>
							<button type="button" class="btn btn_basic btnApply" id="btnApply_${data.RNUM}">적용하기</button>
							<input type="hidden" id="html_${data.RNUM}" name="html_${data.RNUM}" value="<c:out value='${data.KHTML}' escapeXml='true'/>"/>							
						</td>				
					</tr>				
					</c:forEach>
				</c:when>
				<c:otherwise>		
				<tr>
					<td colspan="4">조회된 데이터가 없습니다.</td>
				</tr>			
				</c:otherwise>
			</c:choose>           
			</tbody>
		</table>	
	</div>
</div>

<div class="btn_area">
	<span class="float_left">
		<button type="button" class="btn btn_type01" id="btnHistory">이력보기</button>		
		<button type="button" class="btn btn_basic tooltipsy" id="btnBbsSettingMove" title="해당 게시판 컨텐츠설정관리 화면으로 이동함">컨텐츠설정관리이동</button>
	</span>
	<span class="float_right">
		<button type="button" class="btn btn_type02" id="btnSave">저장</button>		
	</span>
</div>
<div id="historylist" style="clear: both; display:none; height: 400px; overflow-y:auto;">
	<div class="table">
	<table class="tstyle_list">
		<caption>
			콘텐츠 이력보기 - 번호, 수정일, 작성자, 기능
		</caption>
		<colgroup>
			<col class="num"/>
			<col span="3"/>
		</colgroup>
		<thead>
			<tr>				
				<th scope="col">번호</th>
				<th scope="col">수정일</th>
				<th scope="col">작성자</th>
				<th scope="col">기능</th>				
			</tr>
		</thead>
		<tbody>		
		<c:choose>			
			<c:when test="${!empty rtnHistory }">
				<c:forEach items="${rtnHistory }" var="data" varStatus="loop">
					<tr>								
						<td>${data.RNUM}</td>
						<td>${data.DMLTIME}</td>
						<td>${data.DMLUSERNAME}</td>
						<td>
							<button type="button" class="btn btn_basic btnPreview" id="btnPreview_${data.RNUM}">미리보기</button>
							<input type="hidden" id="html1_${data.RNUM}" name="html1_${data.RNUM}" value="<c:out value='${data.KHTML}' escapeXml='true'/>"/>						
							<button type="button" class="btn btn_basic btnApply" id="btnApply_${data.RNUM}">적용하기</button>
							<input type="hidden" id="html2_${data.RNUM}" name="html2_${data.RNUM}" value="<c:out value='${data.KHTML}' escapeXml='true'/>"/>						
						</td>				
					</tr>				
				</c:forEach>
			</c:when>
			<c:otherwise>		
				<tr>
					<td colspan="4">조회된 데이터가 없습니다.</td>
				</tr>			
			</c:otherwise>
		</c:choose>           
		</tbody>
	</table>
	</div>
</div>

<div id="preview" style="display: none;"></div>
			
<!-- <dl class="autonomy-person" id="autonomyPerson" style="display: none;">
	<dt>항목세부 담당자</dt>
	<dd></dd>
</dl> -->	
			
<script type="text/javascript">
$(function() {
	var menuId = "${rtnContent.menuId}";
	var titleMenuId = "${rtnContent.titleMenuID}";
	
	if(menuId != titleMenuId){
		$('#keyword1').prop("disabled", true);
		$('#keyword2').prop("disabled", true);
		$('#keyword3').prop("disabled", true);
	}
	
	$("#btnSave").click(function(){	
		if(menuId != titleMenuId){
			alert("수정할 수 없습니다.");
			return false;
		}
		if($.trim($("#keyword1").val()) == null || $.trim($("#keyword1").val()) == ""){
			alert("키워드를 입력하세요");
			return true;
		}
		if(!confirm("저장하시겠습니까?")) {
			return false;
		}
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			$("#KHtml").val(Editor.getContent());
		}else{
			$("#KHtml").val(CrossEditor.GetBodyValue());
		}
		// 다음에디터, 나모에디터 구분 End
		
		$("#insertForm").submit();
		
	});	
	
	$(".btnApply").click(function(){
		var html = $(this).next();
		
		// 다음에디터, 나모에디터 구분 Start
		if("${editor}" == "Daum"){
			Editor.modify({
                "content":  $(html).val() /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
            });
		}else{
			CrossEditor.SetBodyValue($(html).val());
		}
		// 다음에디터, 나모에디터 구분 End
		
	});
	 
	 $("#btnHistory").click(function(){		
		$("#historylist" ).slideToggle( "fast", function() {
		    // 이력리스트 
		});
	});
	 
	$(".btnPreview").click(function(){
		var html = $(this).next();
		$("#preview").empty();
		$("#preview").append($(html).val());
		$("#preview").dialog({
			width: '750',
			height: '450',
			resizable: false,
			modal: true,
			title: "미리보기",			
		});			
			
	});	

	$("#contentLink").click(function(){
		try{win.focus();}catch(e){}
		win = window.open("${ctxMgr}/contentMgr/selectContentMenuPopup?menuId=${obj.menuId}&siteId="+$('#siteIdSel', parent.document).val(),'menu_pop', 'width=350px,height=570px,scrollbars=yes,status=no');
	});

	// 경영공시담당자
	/* if("${fn:length(rtntAutonomy)}" > 0){
		var cArray = new Array();
		var sArray = new Array();
		var wArray = new Array();
		
		<c:forEach items="${rtntAutonomy}" var="item" varStatus="loop">
			if("${item.MANAGETYPE}" == '01') cArray.push("${item.DUTYNAME}"+" "+"${item.NAME}"+"("+"${item.PHONE}"+" / "+"${item.USERID}"+" / "+"${item.LOGTIME}"+")");
			if("${item.MANAGETYPE}" == '02') sArray.push("${item.DUTYNAME}"+" "+"${item.NAME}"+"("+"${item.PHONE}"+" / "+"${item.USERID}"+" / "+"${item.LOGTIME}"+")");
			if("${item.MANAGETYPE}" == '03') wArray.push("${item.DUTYNAME}"+" "+"${item.NAME}"+"("+"${item.PHONE}"+" / "+"${item.USERID}"+" / "+"${item.LOGTIME}"+")");
		</c:forEach>
		
		$("#autonomyPerson").append('<dd>작성자 : '+wArray+'</dd>');
		$("#autonomyPerson").append('<dd>감독자 : '+sArray+'</dd>');
		$("#autonomyPerson").append('<dd>확인자 : '+cArray+'</dd>');
		
		$("#autonomyPerson").show();
	} */

	$('.keyword').focus(function(i){
		var indexNode = $(this).index()+1;
		var strLength;
		
		if(indexNode > 1){
			for(var i=1; i<indexNode; i++){
				strLength = $.trim($('#keyword'+i).val());
				if(strLength == null || strLength.length <= 0){
					alert("키워드 "+i+"번째 값부터 입력하세요.");
					$('#keyword'+i).focus();
					return true;
				}
			}
		}
	});
	
	// 게시판설정화면으로 이동
    $("#btnBbsSettingMove").click(function(){
    	parent.document.location.href = "${ctxMgr}/contentSetMgr?menuId=${contentSetMgrMenu }&siteId="+$('#siteIdSel', parent.document).val()+"&action=move&paramMenuId=${obj.menuId}";
    });
	
});

function fnDelContentsLink(menuId)
{
	if(!confirm("삭제하시겠습니까?")) {
		return;
	}

	$.ajax({
		url: gContextPath+"/mgr/contentMgr/actListContentLink",
		data: {'menuId' : $('#menuId').val(), 'linkId' : $('#linkId').val(), 'copyMenuId' : menuId, 'titleId' : $('#titleId').val(), "condition" : "삭제"},
		async: false,
 		success:function(result, textStatus, jqXHR) {
 			if(result != null) {
				if(result.outResult == "SUCCESS"){
					parent.document.all.contentArea.src="${ctxMgr}/contentMgr?menuId="+$('#menuId').val()+"&boardKind=CONTENTS";
				}
 			}
 		}
	}); 

}
</script>