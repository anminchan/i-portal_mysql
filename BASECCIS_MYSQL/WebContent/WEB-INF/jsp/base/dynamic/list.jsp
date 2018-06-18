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
		<c:forEach items="${rtnUserMenu }" var="userMenu">
			<c:if test="${userMenu.MENUID == obj.menuId }">
				<c:set var="parentMenuId" value="${userMenu.PARENTMENUID }" />
	        	<c:set var="parentMenuName" value="${userMenu.PARENTMENUNAME }" />
				<c:set var="higherId" value="${userMenu.HIGHERID }" />
				<c:set var="idPath" value="${userMenu.IDPATH}" />
			</c:if>
		</c:forEach>
		<table class="tstyle_list">
			<colgroup>
				<c:forEach items="${boardListSet }" var="boardSet" varStatus="loop">
					<c:if test="${fn:split(boardSet.INFO, '§§')[1] eq 'Y'}">
						<col width="${fn:split(boardSet.INFO, '§§')[2] eq '100' ? '' : fn:split(boardSet.INFO, '§§')[2] }%"/>
					</c:if>
				</c:forEach>
			</colgroup>
			<thead>
				<tr>
					<c:forEach items="${boardListSet }" var="boardSet" varStatus="loop">
						<c:if test="${fn:split(boardSet.INFO, '§§')[1] eq 'Y'}">
							<th scope="col">${fn:split(boardSet.INFO, '§§')[3] }</th>
						</c:if>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${rtnSetting.boardKind eq 'LINK' }">
					<c:choose>          
			            <c:when test="${!empty result && fn:length(result) > 0 }">
			                <c:forEach items="${result }" var="data" varStatus="loop">
				            <tr>
				            	<c:forEach items="${boardListSet }" var="boardSet" varStatus="loop">
				            		<c:if test="${fn:split(boardSet.INFO, '§§')[1] eq 'Y'}">
						                <td>
						                	<c:choose>
						                   		<c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'KNAME'}">
									                <c:if test="${rtnSetting.newYN == 'Y' }">
											            <c:if test="${data.NEWCHECK eq 'Y'}">
											            	<img src="${contextPath}/resources/images/common/icon/img_new.gif" alt="신규글"/>
											            </c:if>
									                </c:if>
								               	    <a href="${data.LINKURL}" title="새창으로 열림" target="_blank">
								                		${data[fn:split(boardSet.INFO, '§§')[0]] }
								                	</a>
							                    </c:when>
							                    <c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'FILEYN'}">
					                    			<c:if test="${data.FILEYN == 'Y'}">
					                    				<i class="xi-attachment"><span class="hidden">파일</span></i>
				                    				</c:if>
							                    </c:when>
							                    <c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'INSTIME'}">
								                    <dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" />
							                    </c:when>
							                    <c:otherwise>
							                    	${data[fn:split(boardSet.INFO, '§§')[0]] }
							                    </c:otherwise>
					                   		</c:choose>
						                </td>
					                </c:if>
				                </c:forEach>
				            </tr>
			                </c:forEach>
			            </c:when>
			            <c:otherwise>
				            <tr>
			                	<td colspan="${fn:length(boardListSet) }">조회된 데이터가 없습니다.</td>
				            </tr>
			            </c:otherwise>
			        </c:choose>
				</c:when>
				<c:when test="${rtnSetting.boardKind eq 'CLIPPING' }">
					<c:choose>          
			            <c:when test="${!empty result && fn:length(result) > 0 }">
			                <c:forEach items="${result }" var="data" varStatus="loop">
				            <tr>
				            	<c:forEach items="${boardListSet }" var="boardSet" varStatus="loop">
				            		<c:if test="${fn:split(boardSet.INFO, '§§')[1] eq 'Y'}">
						                <td>
						                	<c:choose>
						                   		<c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'KNAME'}">
									                <c:if test="${rtnSetting.newYN == 'Y' }">
											            <c:if test="${data.NEWCHECK eq 'Y'}">
											            	<img src="${contextPath}/resources/images/common/icon/img_new.gif" alt="신규글"/>
											            </c:if>
									                </c:if>
								               	    <a href="${data.LINKURL}" title="새창으로 열림" target="_blank">
								                		${data[fn:split(boardSet.INFO, '§§')[0]] }
								                	</a>
							                    </c:when>
							                    <c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'FILEYN'}">
					                    			<c:if test="${data.FILEYN == 'Y'}">
					                    				<i class="xi-attachment"><span class="hidden">파일</span></i>
				                    				</c:if>
							                    </c:when>
							                    <c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'INSTIME'}">
								                    <dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" />
							                    </c:when>
							                    <c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'REPORTTIME'}">
								                    <dateFormat:dateFormat addPattern="-" value="${data.REPORTTIME}" />
							                    </c:when>
							                    <c:otherwise>
							                    	${data[fn:split(boardSet.INFO, '§§')[0]] }
							                    </c:otherwise>
					                   		</c:choose>
						                </td>
					                </c:if>
				                </c:forEach>
				            </tr>
			                </c:forEach>
			            </c:when>
			            <c:otherwise>
				            <tr>
			                	<td colspan="${fn:length(boardListSet) }">조회된 데이터가 없습니다.</td>
				            </tr>
			            </c:otherwise>
			        </c:choose>
				</c:when>
				<c:otherwise>
					<c:choose>          
			            <c:when test="${!empty result && fn:length(result) > 0 }">
			                <c:forEach items="${result }" var="data" varStatus="loop">
				            <tr>
				            	<c:forEach items="${boardListSet }" var="boardSet" varStatus="loop">
				            		<c:if test="${fn:split(boardSet.INFO, '§§')[1] eq 'Y'}">
						            	<td>
					                   		<c:choose>
						                   		<c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'KNAME'}">
									                <c:if test="${rtnSetting.newYN == 'Y' }">
											            <c:if test="${data.NEWCHECK eq 'Y'}">
											            	<img src="${contextPath}/resources/images/common/icon/img_new.gif" alt="신규글"/>
											            </c:if>
									                </c:if>
								               	    <a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${data.NUM1 }&linkId=${data.LINKID }${link}" title="${data[fn:split(boardSet.INFO, '§§')[0]] }">
								               	    	${data[fn:split(boardSet.INFO, '§§')[0]] }
								               	    </a>
							                    </c:when>
							                    <c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'FILEYN'}">
					                    			<c:if test="${data.FILEYN == 'Y'}">
					                    				<i class="xi-attachment"><span class="hidden">파일</span></i>
				                    				</c:if>
							                    </c:when>
							                    <c:when test="${fn:split(boardSet.INFO, '§§')[0] eq 'INSTIME'}">
								                    <dateFormat:dateFormat addPattern="-" value="${data.INSTIME}" />
							                    </c:when>
							                    <c:otherwise>
							                    	${data[fn:split(boardSet.INFO, '§§')[0]] }
							                    </c:otherwise>
					                   		</c:choose>
					                	</td>
					                </c:if>
				                </c:forEach>
				            </tr>
			                </c:forEach>
			            </c:when>
			            <c:otherwise>
				            <tr>
			                	<td colspan="${fn:length(boardListSet) }">조회된 데이터가 없습니다.</td>
				            </tr>
			            </c:otherwise>
			        </c:choose>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
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
