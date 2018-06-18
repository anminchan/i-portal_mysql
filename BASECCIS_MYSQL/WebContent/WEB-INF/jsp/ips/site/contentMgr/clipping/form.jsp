<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<!-- ▼ 등록페이지  -->
<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/contentMgr/actClippingBoard" method="post" >
	<input type="hidden" id="link" name="link" value="${link }" />
	
	<input type="hidden" id="menuId" name="menuId" value="${!empty(obj.menuId) ? obj.menuId : '-'}" />
	<input type="hidden" id="boardId" name="boardId" value="${!empty(rtnSetting.boardId) ? rtnSetting.boardId : '-' }" />
	<input type="hidden" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>"/>
    <input type="hidden" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" />
	
	<c:choose>
	<c:when test="${!empty(rtnContent.STARTTIME)}">
		<!-- 글 수정 -->
		<input type="hidden" id="linkId" name="linkId" value="${obj.linkId }" />
	</c:when>
	<c:otherwise>
		<!-- 글 입력/답글 -->
		<input type="hidden" id="linkId" name="linkId" value="${!empty(obj.parentLinkId) && obj.parentLinkId > 0 ? obj.parentLinkId : '-1' }" />
	</c:otherwise>
	</c:choose>	
	<input type="hidden" id="inCondition" name="inCondition" value="${!empty(rtnContent.STARTTIME) ? '수정' : '입력' }" />
	<input type="hidden" id="inBeforeData" name="inBeforeData" value="${rtnContent.inBeforeData}"/>
	
	<c:if test="${fn:split(obj.inDMLUserId, '@')[0] == 'guest'}">
		<input type="hidden" id="guestName" name="guestName" value="${obj.myName }" />
		<input type="hidden" id="key1" name="key1" value="${obj.key1 }" />
		<input type="hidden" id="key2" name="key2" value="${obj.key2 }" />
		<input type="hidden" id="key3" name="key3" value="${obj.key3 }" />
		<input type="hidden" id="dKey" name="dKey" value="${obj.dKey }" />
	</c:if>        
    <fieldset>
        <legend>상세등록</legend>
        <div class="table">
	        <table class="tstyle_view" >
	            <caption>
	                게시물상세 안내
	            </caption>
	            <colgroup>
	                <col class="col-sm-2"/>
					<col class="col-sm-10"/>
	            </colgroup>
	            <tbody>
		            <tr>
		                <th scope="row"><span class="point01">*</span> <label for="subject">제목</label></th>
		                <td>		                
			                <c:choose>
			                    <c:when test="${!empty(rtnContent.STARTTIME)}">
			                	<!-- 글 수정 -->
			                    <input type="text" id="KName" name="KName" value="${rtnContent.KNAME }"  class="input_long"/>
			                    </c:when>
			                    <c:otherwise>
			                	<!-- 글 입력/답글 -->
			                    <input type="text" id="KName" name="KName" value="${title}"  class="input_long"/>
			                    </c:otherwise>
			                </c:choose>
		                </td>
		            </tr>
		            <tr>
		                <th scope="row"><label for="name">작성자</label></th>
		                <td>
		                    <c:out value="${!empty(rtnContent.USERNAME) ? rtnContent.USERNAME : obj.myName  }" />
		                </td>
		            </tr>
		            <tr>
		                <th scope="row"><span class="point01">*</span> <label for="temp_ocode">키워드</label></th>
		                <td>
		                    <input type="text" id="keyword1" name="keyword1" class="keyword" value="${rtnContent.KEYWORD1}" maxlength="30"/>
		                    <input type="text" id="keyword2" name="keyword2" class="keyword" value="${rtnContent.KEYWORD2}" maxlength="30"/>
		                    <input type="text" id="keyword3" name="keyword3" class="keyword" value="${rtnContent.KEYWORD3}" maxlength="30"/>
		                    <input type="text" id="keyword4" name="keyword4" class="keyword" value="${rtnContent.KEYWORD4}" maxlength="30"/>
		                    <input type="text" id="keyword5" name="keyword5" class="keyword" value="${rtnContent.KEYWORD5}" maxlength="30"/>
		                    <input type="text" id="keyword6" name="keyword6" class="keyword" value="${rtnContent.KEYWORD6}" maxlength="30"/>
		                    <input type="text" id="keyword7" name="keyword7" class="keyword" value="${rtnContent.KEYWORD7}" maxlength="30"/>
		                    <input type="text" id="keyword8" name="keyword8" class="keyword" value="${rtnContent.KEYWORD8}" maxlength="30"/>
		                    <input type="text" id="keyword9" name="keyword9" class="keyword" value="${rtnContent.KEYWORD9}" maxlength="30"/>
		                    <input type="text" id="keyword10" name="keyword10" class="keyword" value="${rtnContent.KEYWORD10}" maxlength="30"/>
		                    <input type="button" value="키워드검색" class="input_smallBlack" onClick="javascript:gfnKeywordSearch('${obj.menuId}');" />
		                </td>
		            </tr>
		            <tr>
		                <th scope="row"><label for="name">출처</label></th>
		                <td>
		                    <input type="text" id="origin" name="origin" maxlength="40" class="input_mid" value="${rtnContent.ORIGIN}" />
		                </td>
		            </tr>
		            <tr>
		                <th scope="row"><label for="temp_ocode">보도일</label></th>
		                <td>
		                 <fmt:parseDate value="${rtnContent.REPORTTIME}" pattern="yyyymmdd" var="PARSEREPORTTIME"/>
		                 <fmt:formatDate value="${PARSEREPORTTIME}" pattern="yyyy-mm-dd" var="REPORTTIME"/> 
		                    <input type="text" id="reportTime" name="reportTime" value="${REPORTTIME}" readonly="readonly"/>
		                </td>
		            </tr>
		            <tr>
		                <th scope="row"><label for="name">공개여부</label></th>
		                <td>
		                    <!-- 입력시 공개가 기본 선택 -->
		                    <c:if test="${empty(rtnContent.STARTTIME)}">
		                    	<input type="radio" id="openY" name="openYN" value="Y" checked="checked" />
		                	    <label for="openY">공개</label>
		                    	<input type="radio" id="openN" name="openYN" value="N" />
		                  	  <label for="openN">비공개</label>
		                    </c:if>
		                    <!-- 수정시 기본 선택 -->
		                    <c:if test="${!empty(rtnContent.STARTTIME)}">
			                    <input type="radio" id="openY" name="openYN" value="Y" ${rtnContent.OPENYN == 'Y' ? 'checked="checked"' : ''} />
			                    <label for="openY">공개</label>
			                    <input type="radio" id="openN" name="openYN" value="N" ${rtnContent.OPENYN == 'N' ? 'checked="checked"' : ''} />
			                    <label for="openN">비공개</label>
		                    </c:if>
		                </td>		
		               <%--  <th scope="row"><label for="temp_ocode">유효기간</label></th>
		                <td>
		                    <input type="text" id="startTime" name="startTime" value="<fmt:formatDate value="${rtnContent.STARTTIME }" pattern="yyyy-MM-dd"/>" />~
		                    <input type="text" id="endTime" name="endTime" value="<fmt:formatDate value="${rtnContent.ENDTIME }" pattern="yyyy-MM-dd"/>" />
		                </td> --%>
		            </tr>
	                <c:choose>
	                    <c:when test="${rtnSetting.noticeYN == 'Y' && rtnSetting.categoryYN == 'Y'}">
	                    	<tr>
			                    <th scope="row"><label for="name">공지글지정</label></th>
			                    <td>
				                    <input type="hidden" id="noticeYN" name="noticeYN" />
				                    <input type="checkBox" id="checkNotice" name="checkNotice" ${rtnContent.NOTICETITLEYN == 'Y' ? 'checked="checked"' : ''} />
			                    </td>
		                    </tr>
		                    <tr>
			                    <th scope="row"><span class="point01">*</span> <label for="categoryId">카테고리</label></th>
			                    <td ${rtnSetting.categoryYN == 'Y' ? '' : 'colspan="3"' }>
			                        <select id="categoryId" name="categoryId">
			                        </select>
			                    </td>
		                    </tr>
	                    </c:when>
	                    <c:when test="${rtnSetting.noticeYN == 'Y' && rtnSetting.categoryYN == 'Y'}">
	                    	<tr>
			                    <th scope="row"><label for="name">공지글지정</label></th>
			                    <td>
				                    <input type="hidden" id="noticeYN" name="noticeYN" />
				                    <input type="checkBox" id="checkNotice" name="checkNotice" ${rtnContent.NOTICETITLEYN == 'Y' ? 'checked="checked"' : ''} />
			                    </td>
		                    </tr>
		                    <tr>
			                    <th scope="row"><span class="point01">*</span> <label for="categoryId">카테고리</label></th>
			                    <td>
			                        <select id="categoryId" name="categoryId">
			                        </select>
			                    </td>
							</tr>
	                    </c:when>
	                    <c:when test="${rtnSetting.noticeYN == 'Y' && rtnSetting.categoryYN == 'N'}">
	                    	<tr>
			                    <th scope="row"><label for="name">공지글지정</label></th>
			                    <td>
				                    <input type="hidden" id="noticeYN" name="noticeYN" />
				                    <input type="checkBox" id="checkNotice" name="checkNotice" ${rtnContent.NOTICETITLEYN == 'Y' ? 'checked="checked"' : ''} />
			                    </td>
			            	</tr>       
	                    </c:when>
	                    <c:when test="${rtnSetting.noticeYN == 'N' && rtnSetting.categoryYN == 'Y'}">
	                    	<tr>
			                    <th scope="row"><span class="point01">*</span> <label for="categoryId">카테고리</label></th>
			                    <td>
			                        <select id="categoryId" name="categoryId">
			                        </select>
			                    </td>
			            	</tr>    
	                    </c:when>
	                </c:choose>
		            <!-- ▼ 국가필드유무 -->
		            <c:if test="${rtnSetting.countryYN == 'Y' }">
			            <tr>
			                <th scope="row"><span class="point01">*</span> <label for="country">국가정보</label></th>
			                <td id="tdCountry">
			                	<select id="continent" name="continent"><option>대륙 선택</option></select>
			                    <select id="country" name="country" class="selCountry"><option>국가 선택</option></select>
			                </td>
			            </tr>
		            </c:if>		            
		            <!-- ▼ 추가 필드가 있을 시 -->
		            <c:if test="${!empty(rtnSetting.addField1) }">
			            <tr>
			                <th scope="row"><label><c:out value="${rtnSetting.addField1}" /></label></th>
			                <td><input type="text" id="contents1" name="contents1" maxlength="80" class="input_long" value="${rtnContent.CONTENTS1 }" /></td>
			            </tr>
		            </c:if>
		            <c:if test="${!empty(rtnSetting.addField2) }">
			            <tr>
			                <th scope="row"><label><c:out value="${rtnSetting.addField2}" /></label></th>
			                <td><input type="text" id="contents2" name="contents2" maxlength="80" class="input_long" value="${rtnContent.CONTENTS2 }" /></td>
			            </tr>
		            </c:if>
		            <c:if test="${!empty(rtnSetting.addField3) }">
			            <tr>
			                <th scope="row"><label><c:out value="${rtnSetting.addField3}" /></label></th>
			                <td><input type="text" id="contents3" name="contents3" maxlength="80" class="input_long" value="${rtnContent.CONTENTS3 }" /></td>
			            </tr>
		            </c:if>
		            <!-- ▲ 추가 필드가 있을 시 --> 
		            <tr>
		                <th scope="row"><span class="point01">*</span> <label for="viewtxt">링크 URL</label></th>
		                <td><input type="text" id="linkUrl" name="linkUrl" maxlength="150" class="input_long" value="${rtnContent.LINKURL }" /></td>                    
		            </tr>
	            </tbody>
	        </table>
		</div>
    </fieldset>
</spform:form>
    <!-- ▲ 등록페이지  -->
    
    <!-- ▼ 버튼 -->
	<div class="btn_area">
	    <!-- 콘텐츠 이관 target으로 참조되는 메뉴가 아닐 경우 || 공유 게시글인 경우-->
		<c:if test="${transCnt <= 0 && (!empty rtnContent.STARTTIME ? obj.menuId == rtnContent.MENUID : true) }">
	        <button type="button" class="btn btn_type02" id="btnSave">저장</button>
	        <button type="button" class="btn btn_type01" id="btnDelete">삭제</button>
	    </c:if>
	    <button type="button" class="btn btn_type01" id="btnCancel">취소</button>
	</div>
    <!-- ▲ 버튼 -->

<script type="text/javascript">

$(function() {
	
	gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '카테고리선택', '${rtnContent.CATEGORYID != null ? rtnContent.CATEGORYID : ""}');
	
	gfnCodeComboList($("#continent"), "country", "", "대륙 선택", "${rtnContent.CONTINENT}", ""); // 대륙 코드조회
	$('#continent').on("change", function() { // 대륙 이벤트
		if($("#continent").val() != ""){
			gfnCodeComboList($("#country"), $("#continent").val(), "", "국가 선택", "", ""); // 국가 코드조회
		}else{
			$("#country").find('option').remove();
			$("#country").append("<option value=''>국가 선택</option>");
		}
	});
	
	<c:if test="${!empty rtnContent.COUNTRY}">
		gfnCodeComboList($("#country"), "${rtnContent.CONTINENT }", "", "국가 선택", "${!empty rtnContent.COUNTRY ? rtnContent.COUNTRY : ''}", ""); // 국가 코드조회
	</c:if>
		
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
	
	$('#allChk').click(function(){
		$(".listCheck").prop("checked", this.checked);
	}); 
	
	// 저장
	$('#btnSave').click(function(){
		if($.trim($("#KName").val()) == null || $.trim($("#KName").val()) == ""){
            alert("제목을 입력하세요");
            return true;
        }
		
		/* if($.trim($("#keyword1").val()) == null || $.trim($("#keyword1").val()) == ""){
			alert("키워드를 입력하세요");
			return true;
		} */
		
		if($('#categoryId').length){
			if($('#categoryId').val() == ""){
				alert("카테고리를 선택하세요");
				return true;
			}
		}
		
		<c:if test="${rtnSetting.countryYN == 'Y' }">
			if($('#continent').length){
				if($('#continent').val() == ""){
					alert("대륙을 선택하세요");
					$('#continent').focus();
					return true;
				}
			}
			
			if($('#country').length){
				if($('#country').val() == ""){
					alert("국가를 선택하세요");
					$('#country').focus();
					return true;
				}
			}
		</c:if>
		
		if($.trim($("#linkUrl").val()) == null || $.trim($("#linkUrl").val()) == ""){
            alert("링크 URL을 입력하세요");
            return true;
        }else{
        	
        	if($('#linkUrl').val().indexOf("http://") < 0 && $('#linkUrl').val().indexOf("https://") < 0){
        		alert("링크는 http:// 또는 https:// 로 시작해야합니다.");
				$('#linkUrl').focus();
				return true;
        	}
        	
        }
		
		if($('#checkNotice').length){
			if($('#checkNotice').checked){
				$('#noticeYN').val('Y');
			}else{
				$('#noticeYN').val('N');
			}
		}			
		
		// 유해어 검출 스크립트
 		if(gfnTabooWordCheck('KName§§KHtml')[1] > 0){
 			alert(gfnTabooWordCheck('KName§§KHtml')[0]);
 			return false;
 		}
		
		$('#insertForm').submit();
		
	});

	// 삭제
	$("#btnDelete").click(function(){
		$("#inCondition").val("삭제");
		
		$('#insertForm').submit();
	});
	
	//취소
	$("#btnCancel").click(function(){		
	    document.location.href="${contextPath}/mgr/contentMgr?${link}";		
	});
	
	//입력시 달력 기본 셋팅
	$('#startTime').val('<fmt:formatDate value="${DATE }" pattern="yyyy-MM-dd"/>');
	$('#endTime').val(<fmt:formatDate value="${DATE }" pattern="yyyy"/>+10+'<fmt:formatDate value="${DATE }" pattern="-MM-dd"/>');
	
    $( "#reportTime" ).datepicker({
    	showOtherMonths:true,
        selectOtherMonths:true,
        showButtonPanel: true,
        changeYear:true,
        changeMonth:true,
        dateFormat: 'yy-mm-dd'
    });
	
});

</script>
