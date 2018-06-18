/**
 * 화면Info파라메타
 */
var createType = "";
var actionfrom = "";
var formaction = "";
var filePath = "";
var strOldFileInfoArray = new Array();
var strOldImgFileInfoArray = new Array();
var fileMaxSize = "";
var extFilterExclude = "";
var extFilterPermit = "";
var fileMaxCount = "";
var fileImgMaxCount = 1;
var cuManagerBoolean = true;
var cuManagerImgBoolean = true;

/**
* NamoCrossUploader의 Manager 객체
*/
var cuManager = null;
var cuManagerImages = null;

//HTML의 onload 이벤트 핸들러
var onInitNamoUploader = function (type) {
    /**
	* NamoCrossUploader 객체를 생성합니다.
    * 객체의 크기 변경, Javascript로 전송하는 이벤트 이름 변경 및 기타 설정은 함수 내부를 참조해 주십시오. 
    * createNamoCrossUploader 함수는 namocrossuploader.js 파일에 구현되어 있습니다. 
    * 각각의 Id는 변경 가능합니다.
    */
	if(type.indexOf('BASE') > -1){
		createNamoCrossUploader(
			"crossUploadManager",   // NamoCrossUploader의 Manager 객체 Id
			"crossUploadMonitor",   // NamoCrossUploader의 Monitor 객체 Id 
			"flashContentManager",  // NamoCrossUploader의 Manager 객체가 위치할 HTML Id (body 태크 내에 선언된 Id와 동일해야 함)
			"flashContentMonitor"   // NamoCrossUploader의 Monitor 객체가 위치할 HTML Id (body 태크 내에 선언된 Id와 동일해야 함)
		);
	}
	if(type.indexOf('IMG') > -1){
		createImagesNamoCrossUploader(
		    "crossUploadManagerImages",     // NamoCrossUploader의 Manager 객체 Id
		    "flashContentManagerImages"  	// NamoCrossUploader의 Manager 객체가 위치할 HTML Id (body 태크 내에 선언된 Id와 동일해야 함)
    	);
	}
	createType = type;
}

/**
 * NamoCrossDownloader의 Manager 객체
 */
 var cdManager = null;
 
/**
* NamoCrossUploader의 Monitor 객체 생성 완료 시 호출됩니다.
*/
var onCreationCompleteMntCu = function () {
    cuManager.setMonitorResources(document.getElementById("crossUploadMonitor").getMonitorResources());
}

/** 
* 전송창이 열릴 때 호출됩니다.
*/ 
var onOpenMonitorWindowCu = function () {
	window.focus();
    document.getElementById("monitorBgLayer").style.display = "block";
    document.getElementById("monitorLayer").style.display = "block";
}
	
/**
* 예외 발생 시 호출됩니다.
*/ 
var onExceptionCu = function (params) {
	// 300~ : 일반적 예외
    // 400~ : 시스템 예외
    // 500~ : 서측에서 발생한 예외
    // 필요한 예외정보만 고객에서 보여주십시오.
	var obj = jQuery.parseJSON(params); 
	alertTimeout("[예외 정보]\n" + "code : " + obj.code + "\n" + "message : " + obj.message + "\n" + "detailMessage : " + obj.detailMessage); 
} 

/**
* 업로드 시작 시 호출됩니다. 
*/
var onStartUploadCu = function () { 
	 //alertTimeout("업로드가 시작됐습니다."); 
} 

/**
* 개별 파일에 대한 업로드 시작 시 호출됩니다. 
   * 필요할 경우, 주석을 풀고 사용해 주십시오. 
*/
var onStartUploadItemCu = function (params) { 
	/*
	var obj = jQuery.parseJSON(params); 
	alertTimeout("[개별 파일에 대한 업로드 시작 정보]\n" + 
		"FileName : "				+ obj.fileName + "\n" +
		"FileSize : "				+ obj.fileSize + "\n"
	); 
	*/
} 

/**
* 개별 파일에 대한 업로드 완료 시 호출됩니다. 
* 인자로 넘어온 데이터는 서버측(UploadProcess.jsp)에서 조합한 형태의 문자열입니다.
* 샘플에서는 JSON 타입으로 넘겨주고 있습니다. 
* 필요할 경우, 주석을 풀고 사용해 주십시오. 
*/ 
var onEndUploadItemCu = function (params) { 
	/*
	var obj = jQuery.parseJSON(params); 
	alertTimeout("[개별 파일에 대한 업로드 결과 정보]\n" + 
		"Name : "					+ obj.name + "\n" +
		"FileName : "				+ obj.fileName + "\n" +
		"LastSavedDirectoryPath : " + obj.lastSavedDirectoryPath + "\n" +
		"LastSavedFilePath : "		+ obj.lastSavedFilePath + "\n" +
		"LastSavedFileName : "		+ obj.lastSavedFileName + "\n" +
		"FileSize : "				+ obj.fileSize + "\n" +
		"FileNameWithoutFileExt : " + obj.fileNameWithoutFileExt + "\n" +
		"FileExtension : "			+ obj.fileExtension + "\n" +
		"ContentType : "			+ obj.contentType + "\n" +
		"IsSaved : "				+ obj.isSaved + "\n" +
		"IsEmptyFile : "			+ obj.isEmptyFile
	); 
	*/
}

/**
* 개별 파일에 대한 업로드 취소 시 호출됩니다.
* 필요할 경우, 주석을 풀고 사용해 주십시오. 
*/
var onCancelUploadItemCu = function (params) { 
	/*
	var obj = jQuery.parseJSON(params); 
	alertTimeout("[개별 파일에 대한 업로드 취소 정보]\n" + 
		"FileName : "				+ obj.fileName + "\n" +
		"FileSize : "				+ obj.fileSize + "\n"
	); 
	*/
}

/**
* Flash로부터 호출되는 Javascript 콜백함수 내에서 alert 창을 띄우기 위한 처리로 Chrome, Firefox, Safari 브라우저의 일부 버전에 해당됩니다. 
*/
var alertTimeout = function (params) {
    window.focus();
    setTimeout(function () { alert(params) }, 100);
}

/**
* NamoCrossUploader의 Manager 객체 생성 완료 시 호출됩니다.
*/
var onCreationCompleteCu = function () {
	var fileUploadURL = filePath;
	// UI 프로퍼티를 설정합니다.
	var uiProperties = {"visibleUploadButton": false};
	
	// 최초 생성시 cuManager
	if(cuManagerBoolean){
		if(createType.indexOf('BASE') > -1){
			cuManager = document.getElementById("crossUploadManager");
			// upload url 설정
			cuManager.setUploadURL(fileUploadURL);
			//기존에 업로드된 파일을 추가
			for(var i=0; i<strOldFileInfoArray.length; i++){
				cuManager.addUploadedFile(strOldFileInfoArray[i]);
			}
			cuManager.setUIProperties(uiProperties);
			// 옵션 설정
			if(extFilterPermit != "") cuManager.setFileFilter([extFilterPermit]);
			// 전체 파일 크기를 제한
			cuManager.setMaxTotalFileSize(fileMaxSize);
			// 허용하지 않을 파일 확장자 기준으로 File Extension을 설정하시려면 setAllowedFileExtension 메소드의 두번째 파라미터에 true를 입력해 주십시오.
			cuManager.setAllowedFileExtension(extFilterExclude, true); 
			// 파일 개수 제한
			cuManager.setMaxFileCount(fileMaxCount);
			
			cuManagerBoolean = false;
		}
	}
	
	// 최초 생성시 cuManagerImgaes
	if(cuManagerImgBoolean){
		if(createType.indexOf('IMG') > -1){
			cuManagerImages = document.getElementById("crossUploadManagerImages");
			// upload url 설정
			cuManagerImages.setUploadURL(fileUploadURL);
			//기존에 업로드된 파일을 추가
			for(var i=0; i<strOldImgFileInfoArray.length; i++){
				cuManagerImages.addUploadedFile(strOldImgFileInfoArray[i]);
			}
			cuManagerImages.setUIProperties(uiProperties);
			// 옵션 설정
			// 파일 필터 설정
			var imageFilter = { "desc": "이미지 파일(jpg, jpeg)", "ext": "*.jpg;*.jpeg;*.png;*.gif;*.bmp" };
			cuManagerImages.setFileFilter([imageFilter]);
			cuManagerImages.setMaxTotalFileSize(fileMaxSize);
			// 실제 허용할 파일의 확장자를 설정 (filter에서는 모든 파일을 등록 했지만, 실제 업로드 할 수 있는 확장자는 아래와 같이 제한)
			cuManagerImages.setAllowedFileExtension(extFilterExclude, true);
			// 파일 개수 제한
			cuManagerImages.setMaxFileCount(fileImgMaxCount);
			
			cuManagerImgBoolean = false;
		}
	}
}

/** 
* 전송창이 닫힐 때 호출됩니다.
*/ 
var onCloseMonitorWindowCu = function () {
	window.focus(); 
	document.getElementById("monitorBgLayer").style.display = "none";
	document.getElementById("monitorLayer").style.display = "none";    

	// 데이터 처리 페이지로 업로드 결과를 전송합니다. 
	// onEndUploadCu 나 onCloseMonitorWindowCu 이벤트 시점에 처리하시면 되며, onCloseMonitorWindowCu 시에는 getUploadStatus()를 사용하여 업로드 상태를 체크해 주십시오.
	if(cuManager.getUploadStatus() == "COMPLETE") {
		/**
		* 업로드된 전체 파일의 정보를 가져옵니다. 
		* 서버측에서 JSON 타입으로 반환했을 경우는 JSON 타입으로 가져오는 것을 권장하며, 그 외의 경우는 개별 파일 정보를 조합할 delimiter 문자(또는 문자열)를 입력해 주십시오.
		*/
		var uploadedFilesInfo = cuManager.getUploadedFilesInfo("JSON"); 
		/**
	     * addUploadedFile로 추가한 전체 파일 정보를 가져옵니다. 
	     */ 
		var modifiedFilesInfo = cuManager.getModifiedFilesInfo("JSON");
		
		// 데이터 처리 페이지로 업로드 결과를 전송합니다.
		$("#uploadedFilesInfo").val(uploadedFilesInfo);
		$("#modifiedFilesInfo").val(modifiedFilesInfo);
		if($('#dialog').length > 0){
			// 썸네일형 이미지 설명
			var idx = cuManager.getTotalFileCount();
			var objUpload = jQuery.parseJSON(uploadedFilesInfo); 
			if(objUpload != ""){
				for(var i=0; i<objUpload.length; i++){
					$('#dialog').append('<p>'+objUpload[i].origfileName+' 정보</p>');
					$('#dialog').append('<input type="text" name="altInfo" class="input_long">');
				}
			}
			
			modifiedFilesInfo = modifiedFilesInfo.replace(/\"isDeleted/gi, ",\"isDeleted");
			var objModified = jQuery.parseJSON(modifiedFilesInfo);
			if(objModified != ""){
				for(var i=0; i<objModified.length; i++){
					if(objModified[i].isDeleted == "true"){
						$("#dialog p").each(function(j){
							if($(this).text().split(" ")[0] == objModified[i].fileName){
								$("#dialog p").eq(j).remove();
								$("#dialog input").eq(j).remove();
							}
						});
					}
				}
			}
			
			// 썸네일형 이미지 설명 넣기
			fnFileAltInfoSave(idx);
		}else{
			actionfrom.attr('action', formaction);
			actionfrom.submit();
		}
	}
}

/**
* 업로드 완료 시 호출됩니다. 
*/
var onEndUploadCu = function () {
	if(createType.indexOf('BASE') > -1){
		var uploadedFilesInfo = cuManager.getUploadedFilesInfo("JSON"); 
		var modifiedFilesInfo = cuManager.getModifiedFilesInfo("JSON");
	 
		// 데이터 처리 페이지로 업로드 결과를 전송합니다.
		$("#uploadedFilesInfo").val(uploadedFilesInfo);
		$("#modifiedFilesInfo").val(modifiedFilesInfo);
	 }
	 
	if(createType.indexOf('IMG') > -1){
		var uploadedFilesInfoImages = cuManagerImages.getUploadedFilesInfo("JSON"); 
		var modifiedFilesInfoImages = cuManagerImages.getModifiedFilesInfo("JSON");
	 
		// 데이터 처리 페이지로 업로드 결과를 전송합니다.
		$("#uploadedFilesInfoImages").val(uploadedFilesInfoImages);
		$("#modifiedFilesInfoImages").val(modifiedFilesInfoImages);
	}

	if(createType.indexOf('BASE') > -1 && createType.indexOf('IMG') > -1){
		if(cuManager.getTotalFileCount() == 0){
			actionfrom.attr('action', formaction);
			actionfrom.submit();
		}
	}else if(createType.indexOf('IMG') > -1){
		actionfrom.attr('action', formaction);
		actionfrom.submit();
	}
}

/*
 * 이미지 업로드 시 설명넣기
 */
function fnFileAltInfoSave(totalFileCnt){
	try{
	    $("#dialog").dialog({
            width: 500,
            height: 400,
            resizable: false,
            modal: true,
            title: "파일 설명 넣기",
            buttons:{
                "OK": function(){
                	
                	var altInfoStr = "";
	        	    for(var i=0; i<totalFileCnt; i++){
		   		    	if($("#dialog input:eq("+i+")").val() == null || $("#dialog input:eq("+i+")").val() == ""){
		   		    		alert("모든 첨부파일에 설명을 넣어주세요");
		   		    		$("#dialog input:eq("+i+")").focus();
		   		    		return;
		   		    	}
		   		    	altInfoStr += $("#dialog input:eq("+i+")").val();
		   		    	
		   		    	if(i != (totalFileCnt-1)){
		   		    		altInfoStr += "#";
		   		    	}
		   		    }
					
	        		$('#altInfoFirst').val($("#dialog input:eq(0)").val());
	        		$('#altInfoArr').val(altInfoStr);
	        		
	        		actionfrom.attr('action', formaction);
	        		actionfrom.submit();

					$(this).dialog("close");
		            
                }
            },
            open : function(event, ui){
            	$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
            }
        });
	    
	}catch(e){ 
	    alert("File.InsertTagSelectedItems: "+ e);
	}
}
