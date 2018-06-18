<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/devToolMgr/imagesList">
<!-- 첨부파일 사용경우 START -->
<!-- 파일 정보를 저장할 폼 데이터 -->
<c:import url="/includes/namoCrossUpDown.jsp" charEncoding="UTF-8" />
<!-- 첨부파일 사용경우 END -->
<fieldset>
	<article class="treeMenu_area">
		<!-- 트리메뉴 -->
		<div class="tree_nav">		
			<span class="siteIdSel_view"><a href="javascript: deptTree.openAll();"><i class="xi-folder-add-o"></i>전체보기</a> <a href="javascript: deptTree.closeAll();"><i class="xi-folder-remove-o"></i>전체닫기</a></span>
			<div id="siteNavi">
				<script type="text/javascript">
					<!--
	
					deptTree = new dTree('deptTree', '${contextPath }'); //dTree 생성
					
					//add(id, pid, name, url, title, target, icon, iconOpne, open)
					
					//트리 root고정 
					deptTree.add(0, -1, 'imgages');
					
					<c:forEach items="${imgFileList }" var="data" varStatus="loop">
						<c:if test="${data.type eq 'DIRECTORY'}">
						deptTree.add('${data.name }', '${data.name == "images" ? 0 : fn:split(data.path, '/')[(fn:length(fn:split(data.path, '/')))-2] }', '${data.name }','','','','');
						</c:if>
						<c:if test="${data.type eq 'FILE'}">
						deptTree.add('${data.name }', '${data.name == "images" ? 0 : fn:split(data.path, '/')[(fn:length(fn:split(data.path, '/')))-2] }', '${data.name }', 
								"javascript:fnClickTree('${data.name }', '${data.path }');",'','','');
						</c:if>
					</c:forEach>
					
					//dTree 화면 출력
					document.write(deptTree);
					
					//-->
				</script>
			</div>
		</div>
		<!-- //트리메뉴 -->
		<div class="tree_list">
		<!-- 트리메뉴 생성 -->
			<div class="table">
				<table  id="tableMenu" class="tstyle_view">
					<colgroup>
						<col class="col-sm-3"/>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="imgName">이미지명</label></th>
							<td><input type="text" id="imgName" name="imgName" value="" class="input_mid02" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="row"><label for="imgPath">이미지경로</label></th>
							<td><input type="text" id="imgPath" name="imgPath" value="" class="input_long" readonly="readonly"/></td>
						</tr>
						<tr>
							<th scope="row"><label for="imgView">이미지</label></th>
							<td><img src="" id="imgView"/></td>
						</tr>
						<tr class="fileAdd">
							<th scope="row"><label for="sort">첨부파일</label></th>
							<td>
							<!-- NamoCrossUploader의 Manager 객체가 위치할 HTML Id -->
					        <div id="flashContentManagerImages" style="display: none;">
					            <p>To view this page ensure that Adobe Flash Player version 11.1.0 or greater is installed.</p>
					            <script type="text/javascript"> 
					                var pageHost = ((document.location.protocol == "https:") ? "https://" : "http://"); 
					                document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
					                 + pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" );
					            </script> 
					        </div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn_area">
				<button type="button" class="btn btn_type01" id="btnImgAdd">이미지추가</button>	
				<button type="button" class="btn btn_type02 fileAdd" id="btnSave">저장</button>
			</div>
		</div>
		<!-- //트리메뉴 생성 -->
	</article>
</fieldset>
</spform:form>

<script type="text/javascript">
$(function() {
	$(".fileAdd").hide();
	
	$("#btnImgAdd").click(function(){
		$(".fileAdd").show();
		$("#imgPath").val($("#imgPath").val().replace($("#imgName").val(), ''));
		$("#imgName").val('');
		$("#imgView").prop('src', '');
	});
	
	$("#btnSave").click(function(){
		if(cuManagerImages.getTotalFileCount() == 0 ) {
			alert("이미지를 입력하세요.");
			return false;
		}
		if(!confirm("등록하시겠습니까?")) {
			return false;
		}else{
			cuManagerImages.setUploadURL("${contextPath}/namoFileUploadLocal?filePath="+$("#imgPath").val());
			cuManagerImages.startUpload();
		}
	});

});

function fnClickTree(imgName, imgPath){
	$(".fileAdd").hide();
	$("#imgName").val(imgName);
	$("#imgPath").val(imgPath);
	$("#imgView").prop('src', '${contextPath}/fileDownloadLocal?fileName='+imgName+'&filePath='+imgPath);
}

//나모첨부파일 시작
$(window).load(function(){
	/*나모 Start*/
	onInitNamoUploader('IMG'); //파일Init : 이미지만
	// 파일정보파라메타
	actionfrom = $("#insertForm");
	formaction = "${ctxMgr}/devToolMgr/imagesList";
	fileMaxSize = 5120 * 1024 * 1024 * 10;
	extFilterExclude = "${extFilterExclude}";
	fileMaxCount = 1;
	/*나모 End*/
});


</script>
