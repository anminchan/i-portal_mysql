<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" method="POST">
	<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
	<input type="hidden" id="pageNum" name="pageNum" value="${param.pageNum}"/>
	<input type="hidden" id="schText" name="schText" value="${param.schText}"/>

	<input type="hidden" id="siteId" name="siteId" value="${result.SITEID}"/>
	<input type="hidden" id="saveStatus" name="saveStatus" value=""/>
	<input type="hidden" id="state" name="state" value="T"/>
	<input type="hidden" id="newsLetterId" name="newsLetterId" value="${result.NEWSLETTERID}"/>
	<input type="hidden" id="version" name="version" value="1"/>

	<!-- 이미지 파일 hidden - (이미지에서 이미지등록 선택 시 필요)  -->
	<input type="hidden" name="upImageFileName" id="upImageFileName" value="${result.UPIMAGEFILENAME}" />
	<input type="hidden" name="upImageSFileName" id="upImageSFileName" value="${result.UPIMAGESFILENAME}" />
	<input type="hidden" name="upImageFilePath" id="upImageFilePath" value="${result.UPIMAGEFILEPATH}" />

	<fieldset>
		<legend>팝업존 정보 입력</legend>
		<p><span class="point01">*</span> 필수입력항목 입니다.</p>
		<div class="table">
			<table class="tstyle_view">
				<caption>
					사이트 상세 정보 입력 - 사이트, 등록자, 공개여부
				</caption>
				<colgroup>
					<col class="col-sm-2"/>
					<col class="col-sm-4"/>
					<col class="col-sm-2"/>
					<col class="col-sm-4"/>
				</colgroup>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="siteIdSel">사이트</label></th>
					<td><select name="siteIdSel" id="siteIdSel"></select></td>
					<th scope="row"><span class="point01">*</span> <label for="insuserName">등록자</label></th>
					<td>
						<input type="text" id="insuserName" name="insuserName" value="${empty result.INSUSERNAME ? ADMUSER.userName : result.INSUSERNAME }" readOnly="readOnly" />
						<input type="hidden" id="insuserId" name="insuserId" value="${empty result.INSUSERID ? ADMUSER.userId : result.INSUSERID }" />
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="openYn">공개여부</label></th>
					<td>
						<input type="radio" id="openYn1" name="openYn" value="Y" <c:if test="${empty result.OPENYN or result.OPENYN eq 'Y'}">checked</c:if> />공개
						<input type="radio" id="openYn2" name="openYn" value="N" <c:if test="${result.OPENYN eq 'N'}">checked</c:if> />비공개
					</td>
					<th scope="row"><span class="point01">*</span> <label for="KName">발송예정일</label></th>
					<td>
						<input type="text" name="sendDueDate" id="sendDueDate" value="<fmt:formatDate value="${result.SENDDUEDATE}" pattern="yyyy-MM-dd" />" readOnly="readOnly"/>
						<select name="HH" id="HH">
							<c:forEach begin="0" end="23" step="1" varStatus="status">
								<c:if test="${status.index > 9}">
								<c:set var="chkHH" value="${status.index}" />
									<option value="${status.index}" <c:if test="${result.HH eq chkHH}">selected</c:if>>${status.index}시</option>
								</c:if>
								<c:if test="${status.index <= 9}">
								<c:set var="chkHH" value="0${status.index}" />
									<option value="0${status.index}" <c:if test="${result.HH eq chkHH}">selected</c:if>>0${status.index}시</option>
								</c:if>
							</c:forEach>
						</select>
						<select name="MM" id="MM">
							<c:forEach begin="0" end="5" step="1" varStatus="status">
								<c:set var="chkMM" value="${status.index}0" />
								<option value="${status.index}0" <c:if test="${result.MM eq chkMM}">selected</c:if>>${status.index}0분</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="KName">제목</label></th>
					<td colspan="3"><input type="text" id="KName" name="KName" value="${result.KNAME}" class="input_long" maxlength="130" title="제목" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="pubNo">발행호수</label></th>
					<td>
						<input type="text" id="pubNo" name="pubNo" value="${result.PUBNO }"  onkeyUp="javascript:fnSetPubNo(this.value);" />
					</td>
					<th scope="row"><span class="point01">*</span> <label for="pubDate">발행일</label></th>
					<td>
						<input type="text" id="pubDate" name="pubDate" onChange="javascript:fnSetPubDate(this.value);" value="<fmt:formatDate value="${result.PUBDATE }" pattern="yyyy-MM-dd" />" readOnly="readOnly" />
					</td>
				</tr>
				<!-- tr>
					<th scope="row"><span class="point01">*</span> <label for="pubNo">PDF Width</label></th>
					<td>
						<input type="text" id="pdfwidth" name="pdfwidth" value="${result.PDFWIDTH }"/>
					</td>
					<th scope="row"><span class="point01">*</span> <label for="pubDate">PDF Height</label></th>
					<td>
						<input type="text" id="pdfheight" name="pdfheight" value="${result.PDFHEIGHT }"/>
					</td>
				</tr-->
				<tr>
					<th scope="row"><span class="point01">*</span> <label for="KName">스킨선택</label></th>
					<td colspan="3">
						<select id="template" name="template" onchange="fnTemplateChange();">
							<option value="TYPE00" <c:if test="${result.TEMPLATE eq 'TYPE00' }">selected</c:if>>템플릿1 (포탈)</option>
							<option value="TYPE02" <c:if test="${result.TEMPLATE eq 'TYPE02' }">selected</c:if>>템플릿2</option>
							<option value="TYPE03" <c:if test="${result.TEMPLATE eq 'TYPE03' }">selected</c:if>>템플릿3</option>
							<option value="TYPE04" <c:if test="${result.TEMPLATE eq 'TYPE04' }">selected</c:if>>템플릿4</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="upImage">이미지</label></th>
					<td colspan="3">
						<span id="upImage10"><input type="radio" name="upImage" value="default" onchange="fnSkinChange('default');" />기본</span>
						<span id="upImage20"><input type="radio" name="upImage" value="spring" onchange="fnSkinChange('spring');" />봄</span>
						<span id="upImage22"><input type="radio" name="upImage" value="spring02" onchange="fnSkinChange('spring02');" />봄2</span>
						<span id="upImage23"><input type="radio" name="upImage" value="spring03" onchange="fnSkinChange('spring03');" />봄3</span>
						<span id="upImage30"><input type="radio" name="upImage" value="summer" onchange="fnSkinChange('summer');" />여름</span>
						<span id="upImage33"><input type="radio" name="upImage" value="summer03" onchange="fnSkinChange('summer03');" />여름2</span>
						<span id="upImage34"><input type="radio" name="upImage" value="summer04" onchange="fnSkinChange('summer04');" />여름3</span>
						<span id="upImage40"><input type="radio" name="upImage" value="autumn" onchange="fnSkinChange('autumn');" />가을</span>
						<span id="upImage50"><input type="radio" name="upImage" value="winter" onchange="fnSkinChange('winter');" />겨울</span>
						<span id="upImage60"><input type="radio" name="upImage" value="newYear" onchange="fnSkinChange('newYear');" />겨울</span>
						<span id="upImage42"><input type="radio" name="upImage" value="autumn02" onchange="fnSkinChange('autumn02');" />명절</span>
						<span id="upImage70"><input type="radio" name="upImage" value="survey" onchange="fnSkinChange('survey');" />설문조사</span>
						<span id="upImage43"><input type="radio" name="upImage" value="autumn03" onchange="fnSkinChange('autumn03');" />추석</span>
						<span id="upImage41"><input type="radio" name="upImage" value="autumn01" onchange="fnSkinChange('autumn01');" />갈대</span>
	
						<input type="radio" id="upImage80" name="upImage" value="image" onchange="fnSkinChange('image');" />이미지등록
						<input type="radio" id="upImage90" name="upImage" value="html" onchange="fnSkinChange('html');" />HTML등록
	
						<div id="divUpImageFileArea" style="display: none;">
							<div id="divUpImgaeFileView">
								<span class="txt"><a href="${contextPath}/fileDownload?fileGubun=common&menuId=newsLetterMgr&userFileName=${result.UPIMAGEFILENAME }&systemFileName=${result.UPIMAGESFILENAME }"><c:out value="${result.UPIMAGEFILENAME }" /></a></span>
							</div>
							<div id="divUpImageFile"></div>
							<div id="divUpImageFileWrite">
								<input type="text" name="upImageUFileName" id="upImageUFileName" class="input_mid02" title="이미지" readonly="readonly"/>
								<input type="button" value="파일찾기" class="btn_smallbasic imgUpBtn" />
							</div>
						</div>
	
						<div id="divUpImageHtmlWrite" style="display: none;">
							<textarea id="upImageHtml" name="upImageHtml" rows="" cols="" style="display: none;">
								<c:out value="${result.UPIMAGEHTML}" escapeXml="true" />
							</textarea>
	
							<!-- ▼ 에디터 -->
							<script type="text/javascript">
								var CrossEditor1 = new NamoSE('upImageHtml');
								CrossEditor1.params.ImageSavePath = "${editorImgPath}";
								CrossEditor1.params.UploadFileExecutePath = "${editorUploadFileExePath}";
								CrossEditor1.params.Width = "100%";
								CrossEditor1.EditorStart();
								function OnInitCompleted(e){
									e.editorTarget.SetBodyValue(document.getElementById("upImageHtml").value);
								}
								//화면 크기 수정
								CrossEditor1.SetBodyValue($("#upImageHtml").val());
							</script>
							<!-- ▲ 에디터  -->
						</div>
					</td>
				</tr>
			</table>
		</div>
	</fieldset>
</spform:form>

<div class="btn_area">
	<span class="float_left">
		<button type="button" class="btn btn_type01" id="btnPreView">미리보기</button>
	</span>
	<span class="float_right">
		<button type="button" class="btn btn_type02 ${!empty result.NEWSLETTERID ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
		<%--<c:if test="${!empty result.NEWSLETTERID && empty result.SEND_FLAG}">--%>
			<%--<button type="button" class="btn_colorType01" id="btnDelete">삭제</button>--%>
		<%--</c:if>--%>
		<button type="button" class="btn btn_type02" id="btnCreateNewsletter">뉴스레터 생성</button>
		<button type="button" class="btn btn_type01" id="btnList">목록</button>
	</span>
</div>

<div id ="dialog" class="selector" style="display: none;">
	<spform:form id="submitForm" enctype="multipart/form-data">	
		<table class="tstyle_view">
			<caption>
				첨부파일등록
			</caption>
			<colgroup>
				<col width="15%" />
	            <col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>첨부파일</th>
					<td><input name="files" id="files" type="file" class="input_long"/></td>
				</tr>
			</tbody>
		</table>
	</spform:form>
</div>

<script type="text/javascript">
	$(function() {

		// 저장 상태에 따라 메시지 표시
		var saveStatus = '${obj.saveStatus}';

		if ( saveStatus != '' )
		{
			if ( saveStatus == 'save' )
			{
				alert('저장 되었습니다.');
			}
			else if ( saveStatus == 'preView' )
			{
				fnPreView();
			}
		}

		gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${result.SITEID}"); // 사이트 select세팅
		$('#siteIdSel').on("change", function() { // 사이트 이벤트
			$("#siteId").val($(this).val());
		});

		//달력 세팅
		$( "#sendDueDate" ).datepicker({
			showOtherMonths:true,
			selectOtherMonths:true,
			showButtonPanel: true,
			changeYear:true,
			changeMonth:true
		});

		$( "#pubDate" ).datepicker({
			showOtherMonths:true,
			selectOtherMonths:true,
			showButtonPanel: true,
			changeYear:true,
			changeMonth:true
		});

		// 초기화
		fnTemplateChange('${result.UPIMAGE}');

		// 미리보기 버튼
		$("#btnPreView").click(function() {

			$("#saveStatus").val("preView");

			var status = fnSave();

			if ( !status )
				$("#saveStatus").val("");

			return status;
		});

		// 저장 버튼
		$("#btnSave").click(function() {

			$("#saveStatus").val("save");

			var status = fnSave("save");

			if ( !status )
				$("#saveStatus").val("");

			return status;
		});

		// 뉴스레터 생성 버튼
		$("#btnCreateNewsletter").click(function() {

			$("#saveStatus").val("createNewsLetter");

			var status = fnSave("createNewsLetter");

			if ( !status )
				$("#saveStatus").val("");

			return status;
		});

		// 목록 버튼
		$("#btnList").click(function(){
			location.href="${contextPath}/mgr/newsLetterMgr?${link}";
		});

		// 사진등록 팝업창
		$(".imgUpBtn").on("click", function(){
			var $obj = $(this);
			$("#files").val("");
			$("#dialog").dialog({
				width: 700,
				height: 315,
				resizable: false,
				modal: true,
				title: "이미지 등록",
				buttons:{
					"확인":function(){
						var ext = $("#files").val().split('.').pop().toLowerCase();
						if($.inArray(ext, ['gif','jpg','png','bmp']) == -1) {
							alert('gif,jpg,png,bmp 파일만 업로드 할수 있습니다.');
							$("#files").val("");
							return;
						}
							
						var data = new FormData(document.getElementById("submitForm"));
						$.ajax({
				             url: '/fileUpload?fileGubun=common&menuId=newsLetterMgr',
				             type: "post",
				             dataType: "text",
				             data: data,
				             processData: false,
				             contentType: false,
				             dataType:"json",
				             success: function(data) {
				            	$("#upImageFileName").val(data.userFileName);
				            	$("#upImageSFileName").val(data.systemFileName);
				            	$("#upImageFilePath").val(data.filePath);
				            	$("#upImageUFileName").val(data.userFileName);
								$("#dialog").dialog("close");
				             }, error: function(jqXHR, textStatus, errorThrown) {
				            	 alert("이미지 업로드 중 오류가 발생하였습니다.");
				             }
				         });
					},
					"닫기":function(){
						$(this).dialog("close");
					}
				}
			});
			
			$("#dialog").show();
		});
	});

	$(window).load(function(){
		fnSkinChange($("input:radio[name=upImage]:checked").val());
	});

	function fnSave(saveStatus)
	{
		if($("#siteIdSel option:selected").val() == "")
		{
			alert("사이트를 선택하세요.");
			$("#siteIdSel").focus();
			return false;
		}

		if($("#sendDueDate").val() == "")
		{
			alert("발송예정일을 입력하세요.");
			$("#sendDueDate").focus();
			return false;
		}

		if($("#KName").val().length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#KName").focus();
			return false;
		}

		if($("#pubNo").val().length <= 0)
		{
			alert("발행호수를 입력하세요.");
			$("#pubNo").focus();
			return false;
		}

		if($("#pubDate").val() == "")
		{
			alert("발행일을 입력하세요.");
			$("#pubDate").focus();
			return false;
		}

		// 이미지 타입에 따라 validation 체크
		var imageType = $("input:radio[name=upImage]:checked").val();

		if ( imageType == 'image' )
		{
			$("#upImageHtml").val('');
		}
		else if ( imageType == 'html' )
		{
			// 이미지 - HTML로 설정했을 경우 Editor의 값을 불러 옴
			$("#upImageHtml").val(CrossEditor1.GetBodyValue().replace(/,/g, "§§"));
		}
		else
		{
			$("#upImageHtml").val('');
			$("#upImageUFileName").val('');
		}

		if ( saveStatus == 'save' )
		{
			if(!confirm("등록하시겠습니까?"))
			{
				return false;
			}
		}
		else
		{
			alert("입력한 정보가 저장됩니다.");
		}

		//File.Upload();
		$("#insertForm").attr("action", "${ctxMgr }/newsLetterMgr/updateNewLetter");
		$("#insertForm").submit();
			
		return true;
	}

	// 미리보기 팝업
	function fnPreView()
	{
		var newsLetterId = $("#newsLetterId").val();

		try{win.focus();}catch(e){}
		win = window.open('${contextPath}/newsLetter/preView?newsLetterId='+ newsLetterId, 'preView_pop', 'width=870px,height=800px,scrollbars=yes,status=no');
	}

	function fnTemplateChange(selectValue)
	{
		var selectedTemplate = $('#template').val();

		$("#upImage10").show();
		$('input[name=upImage][value="' + (selectValue=='' || selectValue==null ||selectValue==undefined ? 'default' : selectValue) + '"]').prop('checked', true);

		switch (selectedTemplate)
		{
			case 'TYPE00' :
				$("#upImage20").show();
				$("#upImage22").hide();
				$("#upImage23").hide();
				$("#upImage30").show();
				$("#upImage33").hide();
				$("#upImage34").hide();
				$("#upImage40").show();
				$("#upImage50").show();
				$("#upImage60").hide();
				$("#upImage42").show();
				$("#upImage70").hide();
				$("#upImage43").hide();
				$("#upImage41").hide();
				break;

			case 'TYPE02' :
				$("#upImage20").show();
				$("#upImage22").hide();
				$("#upImage23").hide();
				$("#upImage30").show();
				$("#upImage33").hide();
				$("#upImage34").hide();
				$("#upImage40").show();
				$("#upImage50").show();
				$("#upImage60").hide();
				$("#upImage42").hide();
				$("#upImage70").hide();
				$("#upImage43").hide();
				$("#upImage41").hide();
				break;

			case 'TYPE03' :
				$("#upImage20").show();
				$("#upImage22").show();
				$("#upImage23").show();
				$("#upImage30").show();
				$("#upImage33").show();
				$("#upImage34").show();
				$("#upImage40").show();
				$("#upImage50").show();
				$("#upImage60").show();
				$("#upImage42").show();
				$("#upImage70").show();
				$("#upImage43").show();
				$("#upImage41").show();
				break;

			default :
				$("#upImage20").hide();
				$("#upImage22").hide();
				$("#upImage23").hide();
				$("#upImage30").hide();
				$("#upImage33").hide();
				$("#upImage34").hide();
				$("#upImage40").hide();
				$("#upImage50").hide();
				$("#upImage60").hide();
				$("#upImage42").hide();
				$("#upImage70").hide();
				$("#upImage43").hide();
				$("#upImage41").hide();
				break;
		}

		// 이미지 등록 및 HTML 등록 값 초기화
		fnSkinChange(null);
	}

	function fnSkinChange(skin)
	{
		// 이미지등록. HTML등록 숨기기
		$("#divUpImageFileArea").hide();
		$("#divUpImageHtmlWrite").hide();

		// 이미지등록, HTMNL등록 값 초기화
		$("#upImageUFileName").val('');

		if (skin == 'image')
		{
			$("#divUpImageFileArea").show();
		}
		else if (skin == 'html')
		{
			$("#divUpImageHtmlWrite").show();
		}
		else
		{
			// No Action
		}
	}

	function fnSetPubDate(pubDate){
		var template = $('#template').val();
		if(template == "TYPE00" || template == "TYPE01"){
			$('#pubDate'+template).text("발행일 : " + fnGetDateFormat(2,pubDate));
		}else{
			$('#pubDate'+template).text("발행일 : " + fnGetDateFormat(1,pubDate));
		}

	}

	function fnSetPubNo(pubNo){
		var template = $('#template').val();
		if(template == "TYPE00" || template == "TYPE01"){
			$('#pubNo'+template).text("Vol."+pubNo);
		}else{
			$('#pubNo'+template).text("[제"+pubNo+"호]");
		}
	}

	function fnGetDateFormat(flag, date) {
		var result = "";
		if(date.length < 10)
			return result;

		var year = date.split("-")[0];
		var month = date.split("-")[1];
		var day = date.split("-")[2];
		switch(flag){
			case 1: result = year + "년 " + month + "월 " + day + "일"; break;
			case 2: result = year + "/" + month + "/" + day; break;
			default : result = ""; break;
		}

		return result;
	}

	function innoOnEvent(msgEvent, arrParam, objName)
	{
		if (msgEvent == Event.msgBeforeAddFile)
		{
			if (objName == "InnoDS")
			{
				document.getElementById("upImageUFileName").value = arrParam[0];
			}
		}
	}

	function fnFileAdd(objName)
	{
		File.RemoveAllItems(objName);
		File.OpenFileDialog(objName, 'true');
	}
</script>
