<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>

    <spform:form id="searchForm" name="searchForm" method="post" action="${contextPath}/board">
    <input type="hidden" name="menuId" value="${obj.menuId}">
    <div class="search_form">
    	<i></i>
    	<c:if test="${rtnSetting.countryYN == 'Y' }">
            <select id="continent" name="continent" title="대륙선택">
            	<option value="">대륙 선택</option>
            </select>
               <select id="country" name="country" title="국가 선택">
               	<option value="">국가 선택</option>
               </select>
           </c:if>
		<c:if test="${rtnSetting.categoryYN == 'Y' }">
		<select name="categoryId" id="categoryId" title="카테고리">
			<option value="0">카테고리</option>
		</select>
		 </c:if>
		<select name="schType" id="schType" title="검색구분">
			<option value="1" ${obj.schType == '1' ? 'selected="selected"' : ''}>제목</option>
			<option value="2" ${obj.schType == '2' ? 'selected="selected"' : ''}>내용</option>
			<option value="3" ${obj.schType == '3' ? 'selected="selected"' : ''}>작성자</option>
		</select>
		<input type="text" name="schText" id="schText" value="${obj.schText }" title="검색어입력" />
	    <input type="button" value="검색" class="btn_type01" id="btnSearch" />
    </div>
	<c:set var="totalPage" value="${ totalCnt / obj.rowCnt + (totalCnt % obj.rowCnt != 0 ? 1 : 0) }"/>
	<p class="articles">
		전체 <span class="txt_bold"><fmt:formatNumber value='${totalCnt }' pattern='#,###'/>건</span>, 
		현재 페이지 <span class="total">${obj.pageNum }</span>/<fmt:formatNumber value='${totalPage-(totalPage%1)}' pattern='#,###'/>
	</p>	        
	<div class="table">
		<c:if test="${rtnSetting.boardKind ne 'LINK' }"><%//공지, 자유형게시판%>
			<c:forEach items="${rtnUserMenu }" var="userMenu">
				<c:if test="${userMenu.MENUID == obj.menuId }">
					<c:set var="parentMenuId" value="${userMenu.PARENTMENUID }" />
		        	<c:set var="parentMenuName" value="${userMenu.PARENTMENUNAME }" />
					<c:set var="higherId" value="${userMenu.HIGHERID }" />
					<c:set var="idPath" value="${userMenu.IDPATH}" />
				</c:if>
			</c:forEach>
			<table class="tstyle_list">
				<caption>
					${rtnMenuName } : 번호, <c:if test="${rtnSetting.categoryYN == 'Y' }">분류,</c:if> 제목, <c:if test="${parentMenuId ne 'MENU00082' and parentMenuId ne 'MENU01739'}"> 작성자,</c:if> 등록일, 조회수, <c:choose><c:when test="${ obj.menuId eq 'MENU00122' or obj.menuId eq 'MENU00123' or  obj.menuId eq 'MENU00124' or obj.menuId eq 'MENU00125' or obj.menuId eq  'MENU00126' or obj.menuId eq  'MENU00127'}">새창링크, </c:when><c:otherwise><c:if test="${obj.menuId ne 'MENU00156' and obj.menuId ne 'MENU01740'}">첨부</c:if></c:otherwise></c:choose>에 따른 게시글 목록
				</caption>
				<colgroup>
					<col class="num"/>
					<c:if test="${rtnSetting.countryYN == 'Y' }">
						<col class="country" />
					</c:if>
					<c:if test="${rtnSetting.categoryYN == 'Y' }">
						<col class="category" />
					</c:if>
					<col class="subject"/>
					<col class="name" />
					<col class="date"/>
					<col class="hit"/>
					<col class="file"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<c:if test="${rtnSetting.countryYN == 'Y' }">
						<th scope="col">국가</th>
						</c:if>
		            	<c:if test="${rtnSetting.categoryYN == 'Y' }">
		            	<th scope="col">분류</th>
		            	</c:if>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">등록일</th>
						<th scope="col">조회수</th>
						<th scope="col">첨부</th>
					</tr>
				</thead>
				<tbody>
		
		        <c:choose>          
		            <c:when test="${!empty result && fn:length(result) > 0 }">
		                <c:forEach items="${result }" var="data" varStatus="loop">
		            <tr>
		                <td>
		                	<c:if test="${data.NUM1 > 9000000000}">
		                		<span class="btn_redSmall">공지</span>
		                	</c:if>
		                	<c:if test="${data.NUM1 < 9000000000}">
		                		${data.NUM1}
		                	</c:if>
		                </td>
		                <c:if test="${rtnSetting.countryYN == 'Y' }">
		                	<td>
		                		<c:if test="${data.COUNTRY eq 'ALL' }">
				               		<c:out value="${data.CONTINENTNAME }" />
				               	</c:if>
				               	<c:if test="${data.COUNTRY ne 'ALL' }">
				               		<c:out value="${data.COUNTRYNAME }" />
				               	</c:if>
			            	</td>
		                </c:if>
			            <c:if test="${rtnSetting.categoryYN == 'Y' }">
			                <td>${data.CATEGORYNAME }</td>
			            </c:if>
		                <td class="txt_left ellipsis">
		                  <%--  <c:if test="${data.DEPTH > 1 }">
		                   <img src="${contextPath}/resources/images/common/icon/icon_replay.gif" alt="답글"/>
		                   </c:if> --%>
		                   <c:if test="${rtnSetting.secretYN  == 'Y'}">
			                   <c:if test="${data.SECRETTITLEYN  == 'Y'}">
			                   		<img src="/resources/images/common/icon/icon_secret.gif" alt="비밀글" />
		                   		</c:if>
		                   </c:if>
			               <c:if test="${rtnSetting.newYN == 'Y' }">
				               <c:if test="${data.NEWCHECK eq 'Y'}">
				               	<img src="${contextPath}/resources/images/common/icon/img_new.gif" alt="신규글"/>
				               </c:if>
			               </c:if>
		                   <a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}" title="${data.KNAME}">
								${data.KNAME}
		                   </a>
		                </td>
		                <td><c:out value="${data.USERNAME }" /></td>
		                <td><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></td>
		                <td><fmt:formatNumber value='${data.HITCOUNT }' pattern='#,###'/></td>
		                <td class="file">
		                    <c:if test="${data.FILEYN == 'Y'}">
		                    <a href="javascript:;" class="attach" linkId="${data.LINKID}"><i class="xi-attachment"><span class="hidden">파일다운로드</span></i></a>
		                    </c:if>
		                    <c:if test="${data.FILEYN != 'Y'}">
		                     &nbsp;
		                    </c:if>
		                </td>
		            </tr>
		                </c:forEach>
		            </c:when>
		            <c:otherwise>
		            <tr>
	                	<td colspan="${rtnSetting.categoryYN == 'Y' ? (rtnSetting.countryYN == 'Y' ? 8 : 7) : (rtnSetting.countryYN == 'Y' ? 7 : 6)}">조회된 데이터가 없습니다.</td>
		            </tr>
		            </c:otherwise>
		        </c:choose>
				</tbody>
			</table>
		    </c:if>
		
		<c:if test="${rtnSetting.boardKind eq 'LINK' }"><%//링크형게시판%>
		<table class="tstyle_list">
			<caption>
				번호, 제목,<c:if test="${rtnSetting.categoryYN == 'Y' }">분류,</c:if> 새창링크, 등록일 목록
			</caption>
			<colgroup>
				<col class="num"/>
				<c:if test="${rtnSetting.countryYN == 'Y' }">
					<col class="country" />
				</c:if>
				<c:if test="${rtnSetting.categoryYN == 'Y' }">
					<col class="category"/>
				</c:if>
				<col class="subject"/>
					<c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
						<col class="file"/>
					</c:if>
				<c:choose>
					<c:when test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
						<col class="file"/>
					</c:when>
					<c:otherwise>
						<col width="num" />
					</c:otherwise>
				</c:choose>
				<col width="date" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<c:if test="${rtnSetting.countryYN == 'Y' }">
						<th scope="col">국가</th>
					</c:if>
	            	<c:if test="${rtnSetting.categoryYN == 'Y' }">
	            		<th scope="col">분류</th>
	            	</c:if>
					<th scope="col">제목</th>
					<c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
						<th scope="col"><c:out value="${rtnSetting.addField1}" /></th>
					</c:if>
					<c:choose>
						<c:when test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
							<th scope="col"><c:out value="${rtnSetting.addField2}" /></th>
						</c:when>
						<c:otherwise>
							<th scope="col">새창링크</th>
						</c:otherwise>
					</c:choose>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
	
	        <c:choose>          
	            <c:when test="${!empty result && fn:length(result) > 0 }">
	                <c:forEach items="${result }" var="data" varStatus="loop">
			            <tr>
			                <td>
			                	<c:if test="${data.NUM1 > 9000000000}">
			                		<span class="btn_redSmall">공지</span>
			                	</c:if>
			                	<c:if test="${data.NUM1 < 9000000000}">
			                		${data.NUM1}
			                	</c:if>
			                </td>
			                <c:if test="${rtnSetting.countryYN == 'Y' }">
			                	<td>
			                		<c:if test="${data.COUNTRY eq 'ALL' }">
					               		<c:out value="${data.CONTINENTNAME }" />
					               	</c:if>
					               	<c:if test="${data.COUNTRY ne 'ALL' }">
					               		<c:out value="${data.COUNTRYNAME }" />
					               	</c:if>
				            	</td>
			                </c:if>
				            <c:if test="${rtnSetting.categoryYN == 'Y' }">
				                <td>${data.CATEGORYNAME }</td>
				            </c:if>
			                <td class="ellipsis">
			                	<c:if test="${rtnSetting.newYN == 'Y' }">
				               		<c:if test="${data.NEWCHECK eq 'Y'}">
					                <img src="${contextPath}/resources/images/common/icon/img_new.gif" alt="답글"/>
					                </c:if>
		               			</c:if>
			                   <a href="${data.LINKURL}" title="새창으로 열림" target="_blank">${data.KNAME}</a>
			                </td>
			                <c:if test="${!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-' }">
				            <td><c:out value="${data.CONTENTS1 }" /></td>
				            </c:if>
			                <c:choose>
							<c:when test="${!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-' }">
							<c:choose>
								<c:when test="${obj.menuId == 'MENU01122' }">
									<td><a href="${data.CONTENTS2 }" title="새창으로 열림" target="_blank"><img src="/resources/images/common/bbs/btn_url.gif" alt="url 새창"/></a></td>
								</c:when>
								<c:otherwise>
									<td><c:out value="${data.CONTENTS2 }" /></td>
								</c:otherwise>
							</c:choose>
							</c:when>
							<c:otherwise>
							<td><a href="${data.LINKURL }" title="새창으로 열림" target="_blank"><img src="/resources/images/common/bbs/btn_url.gif" alt="url 새창"/></a></td>
							</c:otherwise>
							</c:choose>
			                <td><dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" /></td>
			            </tr>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
		            <tr>
		           	<c:choose>
		           	<c:when test="${(!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-') && (!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-') }">
		                <td colspan="${rtnSetting.categoryYN == 'Y' ? (rtnSetting.countryYN == 'Y' ? 7 : 6) : (rtnSetting.countryYN == 'Y' ? 6 : 5)}">조회된 데이터가 없습니다.</td>
		           	</c:when>
		           	<c:when test="${(!empty(rtnSetting.addField1) && fn:length(rtnSetting.addField1) > 0 && rtnSetting.addField1 != '-') && (empty(rtnSetting.addField2) || fn:length(rtnSetting.addField2) <= 0 || rtnSetting.addField2 == '-') }">
		                <td colspan="${rtnSetting.categoryYN == 'Y' ? (rtnSetting.countryYN == 'Y' ? 7 : 6) : (rtnSetting.countryYN == 'Y' ? 6 : 5)}">조회된 데이터가 없습니다.</td>
		           	</c:when>
		           	<c:when test="${(empty(rtnSetting.addField1) || fn:length(rtnSetting.addField1) <= 0 || rtnSetting.addField1 == '-') && (!empty(rtnSetting.addField2) && fn:length(rtnSetting.addField2) > 0 && rtnSetting.addField2 != '-') }">
		                <td colspan="${rtnSetting.categoryYN == 'Y' ? (rtnSetting.countryYN == 'Y' ? 7 : 6) : (rtnSetting.countryYN == 'Y' ? 6 : 5)}">조회된 데이터가 없습니다.</td>
		           	</c:when>
		           	<c:otherwise>
		           		<td colspan="${rtnSetting.categoryYN == 'Y' ? (rtnSetting.countryYN == 'Y' ? 6 : 5) : (rtnSetting.countryYN == 'Y' ? 5 : 4)}">조회된 데이터가 없습니다.</td>
		           	</c:otherwise>
		           	</c:choose>
		           </tr>
	            </c:otherwise>
	        </c:choose>
			</tbody>
		</table>
	    </c:if>
    </div>    
    </spform:form>
    
    <c:if test="${!empty result && fn:length(result) > 0 }">
	    <div class="board_pager">
	        <paging:PageFooter totalCount="${totalCnt }" rowCount="${obj.rowCnt }" siteGubun="U">
	            <Previous><AllPageLink><Next>
	        </paging:PageFooter>
	    </div>
	</c:if>
	<div class="btn_area_right">
		<c:if test="${ADMIN eq 'T' or WRITE eq 'T'}"><%//관리권한, 쓰기권한%>
		<button type="button" class="btn_type01" id="btnAdd">등록</button>
		</c:if>
	</div>

<%@ include file="/includes/bbsContentsFooter.jsp" %>

<script type="text/javascript">

$(function() {
	
	$("#schText").css("ime-mode", "active"); // input 한글우선입력
	
	gfnCateComboList($('#categoryId'), '${obj.menuId}', '', '전체', '${param.categoryId}');
	gfnCodeComboList($("#continent"), "country", "", "대륙 선택", "${param.continent}", ""); // 새창여부 코드조회
	
	$('#continent').on("change", function() { // 새창여부 이벤트
		if($("#continent").val() != ""){
			gfnCodeComboList($("#country"), $("#continent").val(), "", "국가 선택", "", ""); // 새창여부 코드조회
		}else{
			$("#country").find('option').remove();
			$("#country").append("<option value=''>국가 선택</option>");
		}
	}); 
    
    <c:if test="${!empty param.continent}">
	    gfnCodeComboList($("#country"), "${param.continent}", "", "국가 선택", "${!empty param.country ? param.country : ''}", ""); // 새창여부 코드조회
    </c:if>
	    
    $('#btnSearch').click(function(){
        $('#searchForm').submit();
    }); 
    
    //등록
    $('#btnAdd').click(function(){
        document.location.href="${contextPath}/board/form?menuId=${obj.menuId}";
    });
    
    //첨부파일 보기
    $('.viewFiles').click(function(){
		
    	//첨부파일 펄쳐져 있을경우 닫기
		if($(this).parent().children(".attach_file").length > 0){
			$('.attach_file').remove();
		}else{
			$('.attach_file').remove();
	    	
	    	var linkId = $(this).attr("linkId");
	    	var menuId = "${obj.menuId}";
	    	var str = "";	
	    	var strFileName = "";
	    	var strFileExt = "";
	        $.ajax({
	            url: gContextPath+"/board/fileListJson",
	            async:false,
	            data: {linkId : linkId, menuId : menuId },
	            success:function(data, textStatus, jqXHR) {
	                if(data != null) {

	             		str = str + "<div class='attach_file download_list'>";
	             		str = str + "	<dl>";
	            		str = str + "		<dt>첨부파일</dt>";
	            		str = str + "		<dd>";
	            		str = str + "			<ul>";
	            		
	                    $.each(data, function(i, item) {
	                    	strFileName = item.USERFILENAME;
	                    	
	                    	strFileExt = item.FILEEXTENSION;
	                    	
	                    	str = str + "				<li><a href="+gContextPath+"'/fileDownload?titleId="+item.TITLEID+"&fileId="+item.FILEID+"&fileDownType=C&paramMenuId=${obj.menuId}'>";
	                    	
	                    	if( strFileExt == 'pdf' || strFileExt == 'PDF'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_pdf.gif' alt='PDF파일'/>";
	                    	}else if(strFileExt == 'doc' || strFileExt == 'docx' || strFileExt == 'DOC' || strFileExt == 'DOCX'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_doc.gif' alt='DOC파일'/>";
	                    	}else if(strFileExt == 'ppt' || strFileExt == 'pptx' || strFileExt == 'PPT' || strFileExt == 'PPTX'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_ppt.gif' alt='PPT파일'/>";
	                    	}else if(strFileExt == 'xls' || strFileExt == 'xlsx' || strFileExt == 'XLS' || strFileExt == 'XLSX'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_xls.gif' alt='XLS파일'/>";
	                    	}else if(strFileExt == 'hwp' || strFileExt == 'HWP'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_hwp.gif' alt='HWP파일'/>";
	                    	}else if(strFileExt == 'txt' || strFileExt == 'TXT'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_txt.gif' alt='TXT파일'/>";
	                    	}else if(strFileExt == 'zip' || strFileExt == 'ZIP'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_zip.gif' alt='ZIP파일'/>";
	                    	}else if(strFileExt == 'jpg' || strFileExt == 'JPG' || strFileExt == 'jpeg' || strFileExt == 'JPEG' || strFileExt == 'gif' || strFileExt == 'GIF' || strFileExt == 'png' || strFileExt == 'PNG' || strFileExt == 'bmp' || strFileExt == 'BMP'){
	                    		str = str + "<img src='${contextPath}/resources/images/common/icon/icon_img.gif' alt='IMG파일'/>";
	                    	}
	                    	
	                    	str = str + strFileName+"<span>내려받기</span></a></li>";
	                    });
	                    
	            		str = str + "			</ul>";
	            		str = str + "		</dd>";
	            		str = str + "	</dl>";
	            		str = str + "	<p class='file_close'><button type='button'>첨부파일 닫기</button></p>";
	            		str = str + "</div>";
	                }
	            }
	        });  
	        $(this).after(str);
		}
    });

    //첨부파일 닫기
	$(document).on('click', '.file_close', function(){
		$(this).parent().parent().children(".viewFiles").focus();
		$(".attach_file").remove();
	});
    
});
</script>
