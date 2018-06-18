<%@ page contentType="text/html; charset=utf-8" %>

<style type="text/css">
/* 파일 업로드 STYLE */	
 <!--
.fileUpload_progress{background:transparent;border:0;}
.uploadify-queue-item{background:transparent;margin-top:0;padding-top:0;padding-bottom:0;}

.fileUpload_area {
	width:100%;
	margin-top: 15px;
	background: #eff3f9;
	border: solid 1px #e9e9e9;
	border-radius: 5px;
	box-sizing: border-box;
	}
.fileUpload_area h2 {
	padding: 20px 0px 10px 20px; 
	color: #317eac;	
	font-size: 1.2em;
	}
.fileUpload_progress {
	padding: 10px 0 10px 5px;
	background: #fff;
	border: solid 1px #e9e9e9;
	}
.fileUpload_progress li {
	position: relative;
	padding-left: 8px;
	width:98%;
	overflow: hidden;
	}
.fileUpload_progress li a {
	margin-right: 3px;
	color: #333;
	}
.fileUpload_progress .file_loding {
	display: inline-block;
	margin-left: 15px;
	}
.fileUpload_progress .icon_delete {
	position: absolute;
	right: 5px;
	}		
 //-->
</style>

<!-- uploadify hidden -->
<!-- 파일 정보를 저장할 폼 데이터 -->
<input type="hidden" name="uploadedFilesInfo" id="uploadedFilesInfo" />
<input type="hidden" name="modifiedFilesInfo" id="modifiedFilesInfo" />
<input type="hidden" name="uploadedFilesInfoImages" id="uploadedFilesInfoImages" />
<input type="hidden" name="modifiedFilesInfoImages" id="modifiedFilesInfoImages" />

<!-- uploadify -->
<script src="${contextPath}/resources/component/uploadify/jquery.uploadify.js"></script>
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/component/uploadify/uploadify.css" />

<script type="text/javascript">
	var fileInfoList = new Array();
	//var fileInfoList2 = new Array();
	
	function uploadifyInit(form, action, uploadUrl){
		$("#file_upload").uploadify({
		    'height'      	: 24,
		    'width'        	: 69,
		    'auto'     		: false,
		    'queueSizeLimit': 999,
		    'uploadLimit': 999,
		    'totalUploadLimit' : 999,
		    'removeCompleted' : false,
		    'buttonImage' 	: "${contextPath}/resources/images/common/button/btn_file.gif",
		    'buttonText' 	: "파일 선택",
		    'fileSizeLimit' : 0,
		    'fileTypeDesc' : "General files",
		    'fileTypeExts' 	: "*.gif;*.jpg;*.png;*.bmp;*.zip;*.xls;*.xlsx;*.ppt;*.pptx;*.doc;*.docx;*.txt;*.hwp;*.pdf",
		    'swf'      		: '${contextPath}/resources/component/uploadify/uploadify.swf',
		    'uploader'      : '${contextPath}/uploadifyFileUpload?'+uploadUrl,
			'itemTemplate' 	: '<div id="@{fileID}" class="uploadify-queue-item">\
				<div class="cancel">\
				<a href="javascript:$(\'#@{instanceID}\').uploadify(\'cancel\', \'@{fileID}\')">X</a>\
				</div>\
				<div class="file_area">\
				<span class="fileName">\
				\@{fileName} (@{fileSize})\
				</span>\
				<span class="data"> - 0%</span>\
				</div>\
				<div class="uploadify-progress">\
				<div class="uploadify-progress-bar"><!--Progress Bar--></div>\
				</div>\
				</div>',
			'onUploadSuccess': function (fileObj, data, response) {   // 대기 중 하나하나 파일 업로드 작업이 실행 완료 트리거 내가 아무리 업로드 성공을 하든 실패를
				fileInfoList.push(data);
		    },
			'onQueueComplete'  : function(file){
				$("#uploadedFilesInfo").val(fileInfoList);
				var frm = form
				frm.attr('action', action);
				frm.submit();
			}
		});
	}
	
	/* function uploadifyInit2(form, action, uploadUrl){
		$("#file_upload2").uploadify({
		    'height'      	: 24,
		    'width'        	: 69,
		    'auto'     		: false,
		    'queueSizeLimit': 999,
		    'uploadLimit': 999,
		    'totalUploadLimit' : 999,
		    'removeCompleted' : false,
		    'buttonImage' 	: "${contextPath}/resources/images/common/button/btn_file.gif",
		    'buttonText' 	: "파일 선택",
		    'fileSizeLimit' : 0,
		    'fileTypeDesc' : "General files",
		    'fileTypeExts' 	: "*.gif;*.jpg;*.png;*.bmp;*.zip;*.xls;*.xlsx;*.ppt;*.pptx;*.doc;*.docx;*.txt;*.hwp;*.pdf",
		    'swf'      		: '${contextPath}/resources/component/uploadify/uploadify.swf',
		    'uploader'      : '${contextPath}/uploadifyFileUpload?'+uploadUrl,
			'itemTemplate' 	: '<div id="@{fileID}" class="uploadify-queue-item">\
				<div class="cancel">\
				<a href="javascript:$(\'#@{instanceID}\').uploadify(\'cancel\', \'@{fileID}\')">X</a>\
				</div>\
				<div class="file_area">\
				<span class="fileName">\
				\@{fileName} (@{fileSize})\
				</span>\
				<span class="data"> - 0%</span>\
				</div>\
				<div class="uploadify-progress">\
				<div class="uploadify-progress-bar"><!--Progress Bar--></div>\
				</div>\
				</div>',
			'onUploadSuccess': function (fileObj, data, response) {   // 대기 중 하나하나 파일 업로드 작업이 실행 완료 트리거 내가 아무리 업로드 성공을 하든 실패를
		    },
			'onQueueComplete'  : function(file){
				$("#uploadedFilesInfo").val(fileInfoList);
				var frm = form
				frm.attr('action', action);
				frm.submit();
			}
		});
	} */
	
	// 저장 된 파일 삭제할 경우
	function uploadifyCancel(gubun, index){
		fileInfoList.splice(index, 1);
		$('#file_upload'+gubun).uploadify('cancel', 'divAtcharea'+gubun+'_'+index)
	}
			
</script>