<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<style>
	.fileDiv{border-top: 1px solid #e4e7ec; margin-top: 5px; padding-top: 5px;}
</style>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/surveyMgr/questionAct" method="POST">
<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>
<input type="hidden" id="state" name="state" value="${empty rtnSurvey.state ? 'T' : rtnSurvey.state}"/>

<!-- SurveyHiddenData -->
<input type="hidden" id="siteId" name="siteId" value="${rtnSurvey.siteId}"/>
<input type="hidden" id="surveyId" name="surveyId" value="${rtnSurvey.surveyId}"/>
<input type="hidden" id="questionId" name="questionId" value="${rtnQuestion.questionId}"/>
<input type="hidden" id="answerCount" name="answerCount" value=""/>
<input type="hidden" id="chkQuestionId" name="chkQuestionId" value="">

<!-- BeforeData -->
<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnQuestion.inBeforeData}"/>

<!-- 목록 이동용 검색조건 모두 표시 -->
<input type="hidden" name="pageNum" value="${param.pageNum}">
<input type="hidden" name="schSiteId" value="${param.schSiteId}">
<input type="hidden" name="pageNum" value="${param.pageNum}">
<input type="hidden" name="schSiteId" value="${param.schSiteId}">
<input type="hidden" name="schKName" value="${param.schKName}">
<input type="hidden" name="schType" value="${param.schType}">

<h2 class="depth2_title">문항관리</h2>
<fieldset>
	<legend>설문조사 문항 정보 입력</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<table class="tstyle_view">
		<caption>
			문항명, 답안유형, 객관식유형 설문조사 문항 정보 입력
		</caption>
		<colgroup>
			<col class="col-sm-2" />
			<col class="col-sm-4" />
			<col class="col-sm-2" />
			<col class="col-sm-4" />
		</colgroup>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="KName">문항명</label></th>
			<td colspan="3">
				<input type="text" name="KName" id="KName" value="${rtnQuestion.KName}" class="input_long" maxlength="80" title="문항">
			</td>
		</tr>
		<c:if test="${!empty rtnQuestion.questionId }">
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="answerType">답안유형</label></th>
				<td colspan="3">
					<input type="radio" name="answerType" value="1" title="주관식" <c:if test="${rtnQuestion.answerType == '1'}">checked="checked"</c:if> />
					<label>주관식</label>
					<input type="radio" name="answerType" value="2" title="객관식" <c:if test="${rtnQuestion.answerType == '2'}">checked="checked"</c:if> />
					<label>객관식</label>
					<input type="radio" name="answerType" value="3" title="IMAGE" <c:if test="${rtnQuestion.answerType == '3'}">checked="checked"</c:if> />
					<label>IMAGE</label>
				</td>
			</tr>
			<tr id="multipleChoiceTypeTR" <c:if test="${rtnQuestion.answerType == '1' }"> style="display: none;" </c:if>>
				<th scope="row"><span class="point01">*</span> <label for="multipleChoiceType">객관식유형</label></th>
				<td colspan="3">
					<input name="multipleChoiceType" value="1" type="radio" title="단수" <c:if test="${rtnQuestion.multipleChoiceType == '1'}">checked="checked"</c:if> />
					<label>단수</label>
					<input name="multipleChoiceType" value="2" type="radio" title="복수" <c:if test="${rtnQuestion.multipleChoiceType == '2'}">checked="checked"</c:if> />
					<label>복수</label>
				</td>
		</c:if>
		<c:if test="${empty rtnQuestion.questionId }">
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="answerType">답안유형</label></th>
				<td colspan="3">
					<input type="radio" name="answerType" value="1" title="주관식"/>
					<label>주관식</label>
					<input type="radio" name="answerType" value="2" title="객관식" />
					<label>객관식</label>
					<input type="radio" name="answerType" value="3" title="IMAGE" />
					<label>IMAGE</label>
				</td>
			</tr>
			<tr id="multipleChoiceTypeTR" style="display: none;">
				<th scope="row"><span class="point01">*</span> <label for="multipleChoiceType">객관식유형</label></th>
				<td colspan="3">
					<input name="multipleChoiceType" value="1" type="radio" title="단수"/>
					<label>단수</label>
					<input name="multipleChoiceType" value="2" type="radio" title="복수"/>
					<label>복수</label>
				</td>
			</tr>
		</c:if>
	</table>
</fieldset>

<h2 class="depth2_title">답안관리</h2>
<div class="float_wrap">
	<div class="float_right">
		<button type="button" class="btn btn_basic" id="btnCopy">답안복사</button>
		<button type="button" class="btn btn_basic" id="btnAdd" <c:if test="${!empty rtnQuestion.questionId and rtnQuestion.answerType == '3'}"> style="display: none;" </c:if>>답안추가</button>
		<button type="button" class="btn btn_basic" onclick="javascript:exCreateInput();" id="btnImageAdd" <c:if test="${empty rtnQuestion.questionId or rtnQuestion.answerType != '3'}"> style="display: none;" </c:if>>IMAGE답안추가</button>
	</div>
</div>

<fieldset>
	<legend>설문조사 답안 정보 입력</legend>
    <div class="table">
		<table class="tstyle_view" id="answerTable" summary="설문조사 답안정보 입력">
			<caption>
				설문조사 답안 정보 입력
			</caption>
			<colgroup>
				<col width="30" />
				<col />
				<col width="60" />
			</colgroup>
			
			<c:if test="${empty rtnQuestion.questionId or rtnQuestion.answerType != '3'}">
				<c:if test="${!empty rtnAnswer }">
					<c:forEach items="${rtnAnswer }" var="data" varStatus="loop">
						<tr class="answerTR">
							<td>
								<input type="text" name="answers" class="answer input_mid02" value="${data.KName}" style="vertical-align: middle;">
								<button class='btn_graySmall' onclick='javascript:fnAnswerDelete(this);' type='button'>삭제</button>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<tr class="imageAnswerTR" style="display: none;">
					<td>
						<p class="message_block">* IMAGE답안은 최대 4개까지 입니다. (최적화된 IMAGE 사이즈는 148x148px입니다.)</p>
						<div id="fileDiv1" class="fileDiv">
							<span>첫번째 IMAGE</span>
						 	<button type="button" class="btn btn_basic imgUpBtn">IMAGE등록</button>
							<input type="hidden" id="file1" name="fileVal"/>
						</div>
						<div id="fileDiv2" style="display:none;" class="fileDiv">
							<span>두번째 IMAGE</span>
							<button type="button" class="btn btn_basic imgUpBtn">IMAGE등록</button>
							<input type="hidden" id="file2" name="fileVal"/>
			            </div>
						<div id="fileDiv3" style="display:none;" class="fileDiv">
							<span>세번째 IMAGE</span>
							<button type="button" class="btn btn_basic imgUpBtn">IMAGE등록</button>
							<input type="hidden" id="file3" name="fileVal"/>
			            </div>
						<div id="fileDiv4" style="display:none;" class="fileDiv">
							<span>네번째 IMAGE</span>
							<button type="button" class="btn btn_basic imgUpBtn">IMAGE등록</button>
							<input type="hidden" id="file4" name="fileVal"/>
			            </div>
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty rtnQuestion.questionId }">
				<c:if test="${rtnQuestion.answerType == '3'}">
					<tr class="imageAnswerTR">
						<td>
							<p class="message_block">* IMAGE답안은 최대4개까지 입니다. (최적화된 IMAGE 사이즈는 148x148px 입니다.)</p>
							<div id="fileDiv1" class="fileDiv">
								<span>첫번째 IMAGE</span>
							 	<div id="divFileView1">
			                        <c:if test="${!empty fileResult[0].IMAGEFILENAME }">
				                        <span class="txt">
				                        	<img alt="첫번째 IMAGE답안" src="${contextPath}/fileDownload?fileGubun=common&menuId=surveyMgr&userFileName=${fileResult[0].IMAGEFILENAME }&systemFileName=${fileResult[0].IMAGESFILENAME }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" width="148px" height="148px"/>
				                        </span>
				                        <p>${fileResult[0].IMAGEFILENAME }</p>
			                        </c:if>
				                </div>
							 	<button type="button" class="btn btn_basic imgUpBtn">IMAGE변경</button>
								<input type="hidden" id="file1" value="<c:if test="${!empty fileResult[0].IMAGEFILENAME }">${fileResult[0].IMAGEFILENAME }@${fileResult[0].IMAGESFILENAME }@${fileResult[0].FILEPATH }</c:if>" name="fileVal"/>
							</div>
							<div id="fileDiv2" style="display:${!empty fileResult[1].IMAGEFILENAME?'block':'none'};" class="fileDiv">
								<span>두번째 IMAGE</span>
								<div id="divFileView2">
				                	<c:if test="${!empty fileResult[1].IMAGEFILENAME }">
				                    	<span class="txt">
				                        	<img alt="두번째 IMAGE답안" src="${contextPath}/fileDownload?fileGubun=common&menuId=surveyMgr&userFileName=${fileResult[1].IMAGEFILENAME }&systemFileName=${fileResult[1].IMAGESFILENAME }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" width="148px" height="148px"/>
										</span>
										<p>${fileResult[1].IMAGEFILENAME }</p>
									</c:if>
								</div>
							 	<button type="button" class="btn btn_basic imgUpBtn">IMAGE변경</button>
								<input type="hidden" id="file1" value="<c:if test="${!empty fileResult[1].IMAGEFILENAME }">${fileResult[1].IMAGEFILENAME }@${fileResult[1].IMAGESFILENAME }@${fileResult[1].FILEPATH }</c:if>" name="fileVal"/>
				            </div>
							<div id="fileDiv3" style="display:${!empty fileResult[2].IMAGEFILENAME?'block':'none'};" class="fileDiv">
								<span>세번째 IMAGE</span>
								<div id="divFileView3">
				                	<c:if test="${!empty fileResult[2].IMAGEFILENAME }">
				                    	<span class="txt">
				                        	<img alt="세번째 IMAGE답안" src="${contextPath}/fileDownload?fileGubun=common&menuId=surveyMgr&userFileName=${fileResult[2].IMAGEFILENAME }&systemFileName=${fileResult[2].IMAGESFILENAME }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" width="148px" height="148px"/>
										</span>
			                        	<p>${fileResult[2].IMAGEFILENAME }</p>
									</c:if>
								</div>
							 	<button type="button" class="btn btn_basic imgUpBtn">IMAGE변경</button>
								<input type="hidden" id="file1" value="<c:if test="${!empty fileResult[2].IMAGEFILENAME }">${fileResult[2].IMAGEFILENAME }@${fileResult[2].IMAGESFILENAME }@${fileResult[2].FILEPATH }</c:if>" name="fileVal"/>
				            </div>
							<div id="fileDiv4" style="display:${!empty fileResult[3].IMAGEFILENAME?'block':'none'};" class="fileDiv">
								<span>네번째 IMAGE</span>
								<div id="divFileView4">
				                	<c:if test="${!empty fileResult[3].IMAGEFILENAME }">
				                    	<span class="txt">
				                        	<img alt="네번째 IMAGE답안" src="${contextPath}/fileDownload?fileGubun=common&menuId=surveyMgr&userFileName=${fileResult[3].IMAGEFILENAME }&systemFileName=${fileResult[3].IMAGESFILENAME }" onerror="this.src='${contextPath}/resources/images/ips/bbs/noimage.gif'" width="148px" height="148px"/>
										</span>
				                        <p>${fileResult[3].IMAGEFILENAME }</p>
									</c:if>
								</div>
							 	<button type="button" class="btn btn_basic imgUpBtn">IMAGE변경</button>
								<input type="hidden" id="file1" value="<c:if test="${!empty fileResult[3].IMAGEFILENAME }">${fileResult[3].IMAGEFILENAME }@${fileResult[3].IMAGESFILENAME }@${fileResult[3].FILEPATH }</c:if>" name="fileVal"/>
				            </div>
						</td>
					</tr>
				</c:if>
			</c:if>
		</table>
	</div>
</fieldset>
</spform:form>

<div class="btn_area">
	<button type="button" class="btn btn_type02 ${!empty rtnQuestion.surveyId ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
	<c:if test="${!empty rtnQuestion.questionId}">
		<button type="button" class="btn btn_type01 roleDELETE" id="btnDelete">삭제</button>
	</c:if>
	<button type="button" class="btn btn_type01" id="btnList">목록</button>
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
$(function(){
	/* 답안유형 변경 이벤트 */
 	$("input[name=answerType]").click(function(){
 		if($(this).val()=="1"){ // 주관식
 			$("#btnImageAdd").hide();
 			$("#btnAdd").show();
 			$("#multipleChoiceTypeTR").hide();
 			$(".answerTR").remove();
 			$(".imageAnswerTR").hide();
 			
 		}else if($(this).val()=="2"){ // 객관식
 			
 			$("#btnImageAdd").hide();
 			$("#btnAdd").show();
 			$("#multipleChoiceTypeTR").show();
 			$(".answerTR").remove();
 			$(".imageAnswerTR").hide();
 			
 		}else if($(this).val()=="3"){ // IMAGE
 			
 			$("#btnImageAdd").show();
 			$("#btnAdd").hide();
 			$("#multipleChoiceTypeTR").show();
 			$(".answerTR").remove();
 			$(".imageAnswerTR").show();
 		}
 	});
	
	/* 답안추가 이벤트 */
	$("#btnAdd").click(function(){
		if($(":radio[name='answerType']:checked").val()=="2"){ // 객관식
			$("#answerTable").append("<tr class='answerTR'><td><input type='text' name='answers' class='answer input_mid02' style='vertical-align:middle;'> <input type='button' value='삭제' class='input_smallBlack' onclick='javascript:fnAnswerDelete(this);' /></td></tr>");
		}
	});
	
	/* 답안복사 팝업 */
	$("#btnCopy").click(function(){
		if($("#KName").val().length <= 0){
			alert("문항명을 입력하세요.");
			$("#KName").focus();
			return false;
		}else{
			var url = "${ctxMgr }/surveyMgr/answerCopyPopup?surveyId=" + $('#surveyId').val() + "&questionId=" + $('#questionId').val() + "&KName=" + $('#KName').val() + "${link}";
			gfnOpenWin(url, "답안복사",'scrollbars=yes', 700, 500);
		}
	});
	
	/* 목록 이동 */
	$("#btnList").click(function(){
		location.href="${contextPath}/mgr/surveyMgr/questionList?surveyId="+$("#surveyId").val()+"&pageNum=${param.pageNum}&schType=${param.schType}${link}";
	});
	
	/* 삭제 */
	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr }/surveyMgr/questionDelete');
		$("#insertForm").submit();
	});
	
    
	/* 저장 */
    $("#btnSave").click(function(){
    	
    	var valid = true;
    	
    	// 필수값 검증
    	if($("#KName").val().length <= 0) {
			alert("문항명을 입력하세요.");
   			valid = false;
   			$("#KName").focus();
			return false;
		}
    	
    	if($(":radio[name='answerType']:checked").length <= 0) {
			alert("답안유형을 선택하세요.");
   			valid = false;
			return false;
		}
    	
    	if($(":radio[name='answerType']:checked").val()!="1"){
			if($(":radio[name='multipleChoiceType']:checked").length <= 0) {
				alert("객관식유형을 선택하세요.");
	   			valid = false;
				return false;
			}
    	}
		
    	if($(":radio[name='answerType']:checked").val()=="2"){ // 객관식
    		
    		if($(".answer").length <= 0){
    			alert("답안을 1개 이상 등록해주세요.");
    			valid = false;
    			return false;
    		}else{
    			$(".answer").each(function(){
    				if($(this).val() <= 0){
		    			alert("답안을 입력해주세요.");
		    			$(this).focus();
		    			valid = false;
		    			return false;
    				}
    			});
    		}
    		
    	}else if($(":radio[name='answerType']:checked").val()=="3"){ // IMAGE
    		
    		/* var validCnt = 0;
    	
    		$(".newFILENAME").each(function(i){
	    		if($(this).val().length > 0 || $(".fileDiv").eq(i).find("span").length > 0){
	    			validCnt++;
	    		}
	    	});
    		
    		if(validCnt <= 0){
    			alert("IMAGE를 첨부해 주세요.");
    			valid = false;
    			return false;
    		} */
    	}
    	
    	if(valid){
    		
	    	// 답안갯수 저장
	    	var answerCnt = 0;
	    	
	    	if($(":radio[name='answerType']:checked").val()=="2"){ // 객관식
	    		
	    		answerCnt = $("input[name='answers']").length;
			    
	    	}else if($(":radio[name='answerType']:checked").val()=="3"){ // IMAGE
	    		
		    	$(".newFILENAME").each(function(i){
		    		if($(this).val().length > 0 || $(".fileDiv").eq(i).find("span").length > 0){
		    			answerCnt++;
		    		}
		    	});
		    	
	    	}
	    	
		    $("#answerCount").val(answerCnt);
	    	
			$("#insertForm").attr('action', '${ctxMgr }/surveyMgr/questionAct');
			$("#insertForm").submit();
    	}
    	
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
			title: "자격증 사진 등록",
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
			             url: '/multiPartFileUpload?fileGubun=common&menuId=surveyMgr&fileType=single&frmFilename=files',
			             type: "post",
			             dataType: "text",
			             data: data,
			             processData: false,
			             contentType: false,
			             dataType:"json",
			             success: function(data) {
			         	 	//fileArray.push(data.userFileName+"@"+data.systemFileName+"@"+data.filePath);
			         	 	$obj.next().val(data.userFileName+"@"+data.systemFileName+"@"+data.filePath);
			         	 	$obj.prev().text("[신규파일] "+data.userFileName);
							$("#dialog").dialog("close");
			             }, error: function(jqXHR, textStatus, errorThrown) {
			            	 alert("사진 업로드 중 오류가 발생하였습니다.");
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

/* 답안 복사 처리 */
function fnAnswerCopy(chkQuestionId){
	$("#chkQuestionId").val(chkQuestionId);
	$("#insertForm").attr('action', '${ctxMgr }/surveyMgr/answerCopy');
	$("#insertForm").submit();
}

/* 파일첨부 추가버튼 */
var attCount = $(".fileDiv:visible").length;
function exCreateInput(){            /* 입력창 증가 함수 */
	if(attCount<2) attCount=1;	
	++attCount;
	$("#fileDiv"+attCount).attr("style", "display:block;");
}

/* 답안 삭제 */
function fnAnswerDelete(obj){
	$(obj).closest("tr").remove();
}

</script>
