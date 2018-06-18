
/**
* NamoCrossUploader 객체를 생성합니다. 
*/
var embedNamoCrossUploader = function (id, swfUrlStr, replaceElemIdStr, widthStr, heightStr, bgColor, wmode, flashvars) {
	
    // For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. 
    var swfVersionStr = "11.1.0";
    // To use express install, set to playerProductInstall.swf, otherwise the empty string.
    
    //var xiSwfUrlStr = "../../bin/playerProductInstall.swf"; // 상대경로 설정시 로드 못하는 오류때문에 절대경로처리 (밑의 소스포함) 2015.09.15 양도경
    var xiSwfUrlStr = "/resources/component/crosseditor/bin/playerProductInstall.swf";
    flashvars.defaultLanguage = ["ko", "false"]; // Default Language 정보를 입력해 주십시오.
    var params = {};
    params.quality = "high";
    params.bgcolor = bgColor;
    params.allowscriptaccess = "sameDomain";
    params.allowfullscreen = "true";
    params.wmode = (wmode != "") ? wmode : "window";
    var attributes = {};
    attributes.id = id;
    attributes.name = id;
    attributes.align = "middle";

    swfobject.embedSWF(
        swfUrlStr,
        replaceElemIdStr,
        widthStr,
        heightStr,
        swfVersionStr,
        xiSwfUrlStr,
        flashvars,
        params,
        attributes);

    // JavaScript enabled so display the flashContent div in case it is not replaced with a swf object.
    swfobject.createCSS("#"+replaceElemIdStr, "display:block;text-align:left;");
}

var getUploadManagerVars = function () {
    var flashvars = {};

	/**
	* NamoCrossUploader 객체에서 Javascript로 전송할 이벤트 함수 이름을 설정합니다.
	* flashvars 객체의 프로퍼티 값을 변경하면 이벤트 함수 이름이 변경되며, 이벤트 함수 이름은 Javascript에 정의되어 있어야 정상적으로 호출됩니다.
	* 사용하지 않는 이벤트는 주석 처리해 주십시오.  
	*/
    flashvars.onCreationComplete	= "onCreationCompleteCu";    // NamoCrossUploader Manager 객체 생성 완료 시
	flashvars.onOpenMonitorWindow   = "onOpenMonitorWindowCu";   // 전송 창 출력 시
	flashvars.onCloseMonitorWindow  = "onCloseMonitorWindowCu";  // 전송 창 종료 시
    flashvars.onStartUpload         = "onStartUploadCu";         // 업로드 시작 시
    flashvars.onEndUpload			= "onEndUploadCu";			 // 업로드 완료 시
    flashvars.onStartUploadItem     = "onStartUploadItemCu";     // 개별 파일의 업로드 시작 시
    flashvars.onEndUploadItem		= "onEndUploadItemCu";       // 개별 파일의 업로드 완료 시
	flashvars.onCancelUploadItem    = "onCancelUploadItemCu";    // 개별 파일의 업로드 취소 시
    flashvars.onException			= "onExceptionCu";           // 예외 발생 시


	/**
	* 언어 정보가 담겨있는 파일의 URL을 입력해 주십시오. 파일명은 변경 가능합니다.
	*/
	flashvars.languageUrl			= "/resources/component/crosseditor/bin/FileUploadManagerLang.xml"; 

    return flashvars;
}

var getUploadMonitorVars = function () {
    var flashvars = {};

	/**
	* NamoCrossUploader 객체에서 Javascript로 전송할 이벤트 함수 이름을 설정합니다.
	* flashvars 객체의 프로퍼티 값을 변경하면 이벤트 함수 이름이 변경되며, 이벤트 함수 이름은 Javascript에 정의되어 있어야 정상적으로 호출됩니다.
	* 사용하지 않는 이벤트는 주석 처리해 주십시오. Javascript 내에 이벤트 이름과 동일한 사용자 함수가 존재하지 않을 경우 그대로 두셔도 무방합니다.  
	*/
    flashvars.onCreationComplete	= "onCreationCompleteMntCu";    // NamoCrossUploader Monitor 객체 생성 완료 시

	/**
	* 언어 정보가 담겨있는 파일의 URL을 입력해 주십시오. 파일명은 변경 가능합니다.
	*/
	flashvars.languageUrl			= "/resources/component/crosseditor/bin/FileUploadMonitorLang.xml"; 

    return flashvars;
}

var getDownloadManagerVar = function () {
    var flashvars = {};

	/**
	* NamoCrossDownloader 객체에서 Javascript로 전송할 이벤트 함수 이름을 설정합니다.
	* flashvars 객체의 프로퍼티 값을 변경하면 이벤트 함수 이름이 변경되며, 이벤트 함수 이름은 Javascript에 정의되어 있어야 정상적으로 호출됩니다.
	* 사용하지 않는 이벤트는 주석 처리해 주십시오.
	*/
    flashvars.onCreationComplete     = "onCreationCompleteCd";       // NamoCrossDownloader Manager 객체 생성 완료 시
    flashvars.onStartDownloadItem    = "onStartDownloadItemCd";      // 개별 파일의 다운로드 시작 시 (Single Download Only)
    flashvars.onEndDownloadItem		 = "onEndDownloadItemCd";        // 개별 파일의 다운로드 완료 시 (Single Download Only)
    flashvars.onCancelDownloadItem   = "onCancelDownloadItemCd";     // 개별 파일의 다운로드 취소 시 (Single Download Only)
    flashvars.onException            = "onExceptionCd";              // 예외 발생 시

	/**
	* 언어 정보가 담겨있는 파일의 URL을 입력해 주십시오. 파일명은 변경 가능합니다.
	*/
    //flashvars.languageUrl		= getAbsolutePath("bin") + "FileDownloadManagerLang.xml"; 
	flashvars.languageUrl			= "/resources/component/crosseditor/bin/FileDownloadManagerLang.xml"; 
	
	//flashvars.languageUrlForAIR		= getAbsolutePath("bin") + "FileDownloadMonitorAIRLang.xml"; 
	flashvars.languageUrlForAIR		= "/resources/component/crosseditor/bin/FileDownloadMonitorAIRLang.xml";
	//flashvars.languageUrlForAIR		= "http://localhost:8080/NamoCrossUploaderFxSamples/bin/FileDownloadMonitorAIRLang.xml"; 

    return flashvars;
}

/**
* NamoCrossUploader 객체가 생성되지 않았을 경우 Flash 다운로드 링크가 활성화 되도록 설정합니다.
*/
var checkNamoCrossUploader = function (id, flashContentId) {
	if(document.getElementById(id) == null) {
		document.getElementById(flashContentId).style.display = "block";
		return false; 
	}
	return true; 
}

/**
* NamoCrossUploader 객체를 생성합니다.
*/
var createNamoCrossUploader = function (managerId, monitorId, flashContentManagerId, flashContentMonitorId) { 
    // Manager 객체 생성 
    embedNamoCrossUploader(
                managerId,                                  // NamoCrossUploader의 Manager 객체 Id
                "/resources/component/crosseditor/bin/BasicFileUploadManager.swf",     // NamoCrossUploader의 Manager 객체 파일(swf)의 URL 
                flashContentManagerId,                      // 플래쉬 컨텐트로 변경될 HTML 컨텐츠 Id
                "100%",                                     // 가로 사이즈    
                210,                                        // 세로 사이즈    
                "#FFFFFF",                                  // NamoCrossUploader 컴포넌트 로딩 전 배경화면색
                "transparent",                              // 플래시 wmode 설정 (배경 투명, z-index의 영향을 받도록 설정)
                getUploadManagerVars()                      // Javascript로 전송할 이벤트 함수 이름과 기타 환경 변수
                );

	if(checkNamoCrossUploader(managerId, flashContentManagerId) == false)
		return; 

    // Monitor 객체 생성 
    embedNamoCrossUploader(
                monitorId,                                  // NamoCrossUploader의 Manager 객체 Id
                "/resources/component/crosseditor/bin/BasicFileUploadMonitor.swf",     // NamoCrossUploader의 Manager 객체 파일(swf)의 URL  
                flashContentMonitorId,                      // 플래쉬 컨텐트로 변경될 HTML 컨텐츠 Id
                "100%",                                     // 가로 사이즈    
                250,                                        // 세로 사이즈    
                "#FFFFFF",                                  // NamoCrossUploader 컴포넌트 로딩 전 배경화면색
                "transparent",                              // 플래시 wmode 설정 (배경 투명, z-index의 영향을 받도록 설정)
				getUploadMonitorVars()						// Javascript로 전송할 이벤트 함수 이름과 기타 환경 변수
                );
}

/**
* ImagesNamoCrossUploader 객체를 생성합니다. 이미지 파일
*/
var createImagesNamoCrossUploader = function (managerId, flashContentManagerId) { 
    // ImagesNamoCrossUploader 객체 생성 
    embedNamoCrossUploader(
                managerId,                                  // NamoCrossUploader의 Manager 객체 Id
                "/resources/component/crosseditor/bin/SimpleFileUploadManager.swf",    // NamoCrossUploader의 Manager 객체 파일(swf)의 URL
                flashContentManagerId,						// 플래쉬 컨텐트로 변경될 HTML 컨텐츠 Id
                "100%",                                     // 가로 사이즈    
                180,                                        // 세로 사이즈    
                "#FFFFFF",                                  // NamoCrossUploader 컴포넌트 로딩 전 배경화면색
                "transparent",                              // 플래시 wmode 설정 (배경 투명, z-index의 영향을 받도록 설정)
                getUploadManagerVars()                      // Javascript로 전송할 이벤트 함수 이름과 기타 환경 변수
                );

	checkNamoCrossUploader(managerId, flashContentManagerId); 
}

/**
* SimpleNamoCrossUploader 객체를 생성합니다.
*/
var createSimpleNamoCrossUploader = function (managerId, flashContentManagerId) { 
    // SimpleNamoCrossUploader 객체 생성 
    embedNamoCrossUploader(
                managerId,                                  // NamoCrossUploader의 Manager 객체 Id
                "/resources/component/crosseditor/bin/SimpleFileUploadManager.swf",    // NamoCrossUploader의 Manager 객체 파일(swf)의 URL
                flashContentManagerId,						// 플래쉬 컨텐트로 변경될 HTML 컨텐츠 Id
                "100%",                                     // 가로 사이즈    
                210,                                        // 세로 사이즈    
                "#FFFFFF",                                  // NamoCrossUploader 컴포넌트 로딩 전 배경화면색
                "transparent",                              // 플래시 wmode 설정 (배경 투명, z-index의 영향을 받도록 설정)
                getUploadManagerVars()                      // Javascript로 전송할 이벤트 함수 이름과 기타 환경 변수
                );

	checkNamoCrossUploader(managerId, flashContentManagerId); 
}


/**
* NamoCrossDownloader 객체를 생성합니다.
*/
var createNamoCrossDownloader = function (managerId, flashContentManagerId, isSingle) {
    var swfUrl = "/resources/component/crosseditor/bin/SingleFileDownloadManager.swf";
    if (isSingle == false)
        swfUrl = "/resources/component/crosseditor/bin/MultipleFileDownloadManager.swf";

    // Manager 객체 생성 
    embedNamoCrossUploader(
                managerId,                          // NamoCrossDownloader의 Manager 객체 Id
                swfUrl,                             // NamoCrossDownloader의 Manager 객체 파일(swf)의 URL 
                flashContentManagerId,              // 플래쉬 컨텐트로 변경될 HTML 컨텐츠 Id
                "100%",                             // 가로 사이즈    
                210,                                // 세로 사이즈    
                "#FFFFFF",                          // NamoCrossDownloader 컴포넌트 로딩 전 배경화면색
                "transparent",                      // 플래시 wmode 설정 (배경 투명, z-index의 영향을 받도록 설정)
                getDownloadManagerVar()             // Javascript로 전송할 이벤트 함수 이름과 기타 환경 변수
                );
	
	checkNamoCrossUploader(managerId, flashContentManagerId);
}

/**
* ImagesNamoCrossDownloader 객체를 생성합니다. 이미지 파일
*/
var createImagesNamoCrossDownloader = function (managerId, flashContentManagerId, isSingle) { 
    var swfUrl = "/resources/component/crosseditor/bin/SingleFileDownloadManager.swf";
    if (isSingle == false)
        swfUrl = "/resources/component/crosseditor/bin/MultipleFileDownloadManager.swf";

    // Manager 객체 생성 
    embedNamoCrossUploader(
                managerId,                          // NamoCrossDownloader의 Manager 객체 Id
                swfUrl,                             // NamoCrossDownloader의 Manager 객체 파일(swf)의 URL 
                flashContentManagerId,              // 플래쉬 컨텐트로 변경될 HTML 컨텐츠 Id
                "100%",                             // 가로 사이즈    
                180,                                // 세로 사이즈    
                "#FFFFFF",                          // NamoCrossDownloader 컴포넌트 로딩 전 배경화면색
                "transparent",                      // 플래시 wmode 설정 (배경 투명, z-index의 영향을 받도록 설정)
                getDownloadManagerVar()             // Javascript로 전송할 이벤트 함수 이름과 기타 환경 변수
                );
	
	checkNamoCrossUploader(managerId, flashContentManagerId);
}

/**
* 현재 HTTP 경로를 알아오기 위한 함수입니다. (샘플을 위한 것으로 필요 없을 경우 삭제)
*/ 
var getCurrentPath = function () {
	var url = window.location.protocol + "//" + window.location.host;		
	var pos = window.location.pathname.lastIndexOf("/"); 
	if(pos == -1)
		url += "/";
	else 
		url += (window.location.pathname.substring(0, pos+1)); 

	return url; 
}

/**
* 샘플의 디렉토리 경로를 알아오기 위한 함수입니다. (샘플을 위한 것으로 필요 없을 경우 삭제)
* 샘플의 NamoCrossUploaderFxSamples 디렉토리 구성을 임의로 변경할 경우, 아래 함수는 수정이 필요합니다. 
*/ 
var getAbsolutePath = function (dirName) {
	var url = location.href; 				
	var pos = url.lastIndexOf("/NamoCrossUploaderFxSamples/"); 
	if(pos != -1) 
		url = url.substring(0, pos+("/NamoCrossUploaderFxSamples/").length); 
	else
		return ""; 

	url = url + dirName + "/"
	return url; 
}

/**
* 샘플의 디렉토리 경로를 알아오기 위한 함수입니다. (샘플을 위한 것으로 필요 없을 경우 삭제)
* 샘플의 NamoCrossUploaderFxSamples 디렉토리 구성을 임의로 변경할 경우, 아래 함수는 수정이 필요합니다. 
*/ 
var getAbsolutePathNoProtocol = function (dirName) {
	var url = location.href; 				
	var pos = url.lastIndexOf("/NamoCrossUploaderFxSamples/"); 
	if(pos != -1) 
		url = url.substring(0, pos+("/NamoCrossUploaderFxSamples/").length); 
	else
		return ""; 

	url = url + dirName + "/"
	
	var protocol = window.location.protocol + "//" + window.location.host;
	url = url.substring(protocol.length);
	
	return url; 
}

/**
 * 입력받은 URL 을 , 절대경로(full url)로 변경하여 반환합니다. 
 *  - setUploadUrl 과 함께 사용되며, 본 function 을 사용하지 않으면 Chrome 에서 target URL 설정시, swf 파일 대비 상대경로로 입력해야만 정상동작합니다.
 *  - full url 이 입력된 경우는 별도 처리 없이 입력된 값 자체를 반환합니다.
 */
var getAbsoluteUrl = function(path){
	if(path){
		if(!/^http[s]*\:\/\//.test(path)) {
			var basepath = location.pathname.substr(0,location.pathname.lastIndexOf('/')+1);
			if(path.indexOf('./')==0) {
				path = path.replace('./','');
			} else if(path.indexOf('/')==0) {
				basepath = '';
			}
			path = basepath + path;
		}
	}
	return path;
}
