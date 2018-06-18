/*-------------------------------------------------
Common Javascript
Version : 1.0
author : mcahn
create date : 2017. 05. 01.
create date : 2017. 05. 01.
-------------------------------------------------*/
$(function(){
	/* ▼ CMS 관리자 페이지 Layout 설정  */
	var windowWidth = $( window ).width();
	if(windowWidth < 900) {
		   $("#side, .logo").addClass("active");
	}else{
		   $("#side, .logo").removeClass("active");
	}
	
	$(".toggle_nav").on("click", function(){
		if($("#side, .logo").hasClass("active")) {
			$("#side, .logo").removeClass("active");
			setCookie("cookieMenu", "", -1);
		}else{
			$("#side, .logo").addClass("active");
			setCookie("cookieMenu", "active" ,7);
		}
	});
	
	if(getCookie("cookieMenu") != ""){
		$("aside").addClass("active");
		$(".logo").addClass("active");
	}
	/* ▲ CMS 관리자 페이지 Layout 설정  */
	 
	/* ▼ 페이지 툴팁 활성화  */
	/*$(".tooltipsy").tooltipsy({
		offset: [10, 0],
		css: {
	        'padding': '10px',
	        'max-width': '200px',
	        'color': '#303030',
	        'background-color': '#ffffff',
	        'border': '2px solid #4893BA',
	        '-moz-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
	        '-webkit-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
	        'box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
	        'text-shadow': 'none'
	    }
	});*/
	/* ▲  페이지 툴팁 활성화  */
	
});

$(window).resize(function() {
   var windowWidth = $( window ).width();
   if(windowWidth < 900) {
	   $("#side, .logo").addClass("active");
   } else {
	   $("#side, .logo").removeClass("active");
   }
});

 /*********************************************************************
  * 팝업 호출
  * 
  * 사용 : gfnOpenWin("url", "name", "style", 100, 200);
  * 입력 : 호출url, 팝업이름, 스타일지정시, width값, height값
 **********************************************************************/
function gfnOpenWin(href,name,strStyle,width,height) {
	var sleft = (screen.width - width) / 2;
	var stop = (screen.height - height) / 2;

	var style = "left="+sleft+",top="+stop+",width="+width+",height="+height+","+strStyle;
	window.open(href,name,style);
}

 /*********************************************************************
  * 사이트 콤보 조회 함수
  * 
  * 사용 : gfnSiteComboList($("#siteId"), "all", "전체", "SITE00001");
  * 입력 : selectObject, 기본값사용시 value, 기본값사용시 text, 선택 할 value
 **********************************************************************/
 function gfnSiteComboList(selectObject, strValue, strText, strSelect){
 	$.ajax({
 		url: gContextPath+"/mgr/listSite",
 		success:function(data, textStatus, jqXHR) {
 			selectObject.find("option").remove();
 			
 			if(strText != "" && strText != null){
 				selectObject.append($("<option>", {
 					value:strValue, text: strText
 				}));
 			}
 			
 			if(data != null) {
 				$.each(data, function(i, item) {
 					selectObject.append($("<option>", {
 						value: item.SITEID, text: ConvertSystemSourcetoHtml(item.KNAME)
 					}));
 				});
 			}

 			if(strSelect != "" && strSelect != null){
 	 			selectObject.val(strSelect); 
 			}
 		}
 	});
 }

 /*********************************************************************
  * 사이트 콤보 조회 함수
  * 
  * 사용 : gfnSiteKeyComboList($("#siteId"), "all", "전체", "SITE00001");
  * 입력 : selectObject, 기본값사용시 value, 기본값사용시 text, 선택 할 value
 **********************************************************************/
 function gfnSiteKeyComboList(selectObject, strValue, strText, strSelect){
 	$.ajax({
 		url: gContextPath+"/mgr/listSite",
 		success:function(data, textStatus, jqXHR) {
 			selectObject.find("option").remove();
 			
 			if(strText != "" && strText != null){
 				selectObject.append($("<option>", {
 					value:strValue, text: strText
 				}));
 			}
 			
 			if(data != null) {
 				$.each(data, function(i, item) {
 					if(item.siteKey != "ips"){
 						selectObject.append($("<option>", {
 							value: item.SITEKEY, text: ConvertSystemSourcetoHtml(item.KNAME)
 						}));
 					}
 				});
 			}

 			if(strSelect != "" && strSelect != null){
 	 			selectObject.val(strSelect); 
 			}
 		}
 	});
 }
 
 /*********************************************************************
  * 사이트 콤보 조회 함수 - 권한이 있는 사이트만 조회
  * 
  * 사용 : gfnSiteAdminComboList($("#siteId"), "all", "전체", "SITE00001");
  * 입력 : selectObject, 기본값사용시 value, 기본값사용시 text, 선택 할 value, 제외 할 value
 **********************************************************************/
 function gfnSiteAdminComboList(selectObject, strValue, strText, strSelect, strExcept){
 	$.ajax({
 		url: gContextPath+"/mgr/listAdminSite",
 		success:function(data, textStatus, jqXHR) {
 			selectObject.find("option").remove();
 			
 			if(strText != "" && strText != null){
 				selectObject.append($("<option>", {
 					value:strValue, text: strText
 				}));
 			}
 			
 			if(data != null) {
 				$.each(data, function(i, item) {
 					selectObject.append($("<option>", {
 						value: item.SITEID, text: ConvertSystemSourcetoHtml(item.KNAME)
 					}));
 				});
 			}

 			if(strSelect != "" && strSelect != null){
 	 			selectObject.val(strSelect); 
 			}
 		}
 	});
 }
 
 /*********************************************************************
  * 코드 콤보 조회 함수
  * 
  * 사용 : gfnCodeComboList($("#"), "SearchType", "all", "전체", "1", "900D");
  * 입력 : selectObject, higherCode, 기본값사용시 value, 기본값사용시 text, 선택 할 value, 제외시킬 값 기준+Up/Down(null 처리 가능)
  **********************************************************************/
 function gfnCodeComboList(selectObject, strHigh, strValue, strText, strSelect, strRange){
	 
	 var condition = null;
	 var strVal = null;
	 
	 if(strRange != null && strRange != "" && typeof strRange != "undefined"){
		 condition = strRange.substring(strRange.length-1, strRange.length);
		 strVal = strRange.substring(0, strRange.length-1);
	 }
	 
	 $.ajax({
		 url: gContextPath+"/mgr/listCode",
		 data: "higherCode="+strHigh,
		 async: false,
		 success:function(data, textStatus, jqXHR) {
			 selectObject.find("option").remove();
			 
			 if(strText != "" && strText != null){
				 selectObject.append($("<option>", {
					 value:strValue, text: strText
				 }));
			 }
			 
			 if(data != null) {
				 $.each(data, function(i, item) {
					 // &amp; 기호 치환
					 if(item.kname.indexOf('&amp;') > 0){
						 item.kname = item.kname.replace('&amp;', '&');
					 }
					 
					 if(condition == null || condition == ""){
						 selectObject.append($("<option>", {
							 value: item.code, text: ConvertSystemSourcetoHtml(item.kname)
						 }));
					 }else{
						 if(condition == 'U'){
							 if(item.code >= strVal){
								 selectObject.append($("<option>", {
									 value: item.code, text: ConvertSystemSourcetoHtml(item.kname)
								 }));
							 }
						 }else{
							 if(item.code < strVal){
								 selectObject.append($("<option>", {
									 value: item.code, text: ConvertSystemSourcetoHtml(item.kname)
								 }));
							 }
						 }
					 }
				 });
			 }
			 
			 if(strSelect != "" && strSelect != null){
				 selectObject.val(strSelect); 
			 }
		 }
	 });
 }

 /*********************************************************************
  * 카테고리 콤보 조회 함수
  * 
  * 사용 : gfnCateComboList($("#"), "BOARD00002", "all", "전체", "1");
  * 입력 : selectObject, boardId, 기본값사용시 value, 기본값사용시 text, 선택 할 value
  **********************************************************************/
 function gfnCateComboList(selectObject, strMenuId, strValue, strText, strSelect){
	 $.ajax({
		 url: gContextPath+"/mgr/listCate",
		 data: "boardId="+strMenuId,
		 success:function(data, textStatus, jqXHR) {
			 selectObject.find("option").remove();
			 
			 if(strText != "" && strText != null){
				 selectObject.append($("<option>", {
					 value:strValue, text: strText
				 }));
			 }
			 
			 if(data != null) {
				 $.each(data, function(i, item) {
					 selectObject.append($("<option>", {
						 value: item.CATEGORYID, text: ConvertSystemSourcetoHtml(item.CATEGORYNAME)
					 }));
					 
					// 셀렉트 text
					if(strSelect != "" && strSelect != null){
						if(strSelect == item.CATEGORYID) text = item.CATEGORYNAME;
					}
				 });
			 }
			 
			 if(strSelect != "" && strSelect != null){
				 selectObject.val(strSelect); 
			 }
		 }
	 });
 }
 
 /*********************************************************************
  * 그룹 콤보 조회 함수
  * 
  * 사용 : gfnGroupComboList($("#groupId"), "", "그룹 선택", "GROUP00001");
  * 입력 : selectObject, 기본값사용시 value, 기본값사용시 text, 선택 할 value
 **********************************************************************/
 function gfnGroupComboList(selectObject, strValue, strText, strSelect){
 	$.ajax({
 		url: gContextPath+"/mgr/listGroup",
 		success:function(data, textStatus, jqXHR) {
 			selectObject.find("option").remove();
 			
 			if(strText != "" && strText != null){
 				selectObject.append($("<option>", {
 					value:strValue, text: strText
 				}));
 			}

 			if(data != null) {
 				$.each(data, function(i, item) {
 					selectObject.append($("<option>", {
 						value: item.GROUPID, text: ConvertSystemSourcetoHtml(item.KNAME)
 					}));
 				});
 			}

 			if(strSelect != "" && strSelect != null){
 	 			selectObject.val(strSelect); 
 			}
 		}
 	});
 }
 
 /**************************************************************************************************************
  * 회원정보조회 팝업
  * 
  * 사용 : gfnMemberPopupList("kindType", "outDataForm", "type")
  * 입력 : 회원구분[T : 전체, P : 개인회원, C : 기업회원, K : 내부직원], 전달받을 데이터형태['all'/'id'], 받을건수 형태 ['S'/'M']
  **************************************************************************************************************/
 function gfnMemberPopupList(kindType, outDataForm, type){

	 //회원조회 팝업
	 window.open(gContextPath+"/mgr/listMemberPopup?kind="+kindType+"&outDataForm="+outDataForm+"&type="+type+"&schKind="+kindType, "회원정보", "scrollbars=yes, width=700, height=500");
 }
 
 /**************************************************************************************************************
  * 회원정보조회 팝업 멀티출력
  * 
  * 사용 : gfnMemberPopupMultiList("kindType", "outDataForm", "type")
  * 입력 : 회원구분[T : 전체, P : 개인회원, C : 기업회원, K : 내부직원], 전달받을 데이터형태['all'/'id'], 받을건수 형태 ['S'/'M'], parentInputId
  **************************************************************************************************************/
 function gfnMemberPopupMultiList(kindType, outDataForm, type, parentInputId){

	 //회원조회 팝업
	 window.open(gContextPath+"/mgr/listMemberPopup?kind="+kindType+"&outDataForm="+outDataForm+"&type="+type+"&parentInputId="+parentInputId+"&schKind="+kindType, "회원정보", "scrollbars=yes, width=700, height=500");
 }

 /**************************************************************************************************************
  * 통합VOC 담당자 조회 팝업 멀티출력
  * 
  * 사용 : gfnMemberPopupMultiList("kindType", "outDataForm", "type")
  * 입력 : 회원구분[T : 전체, P : 개인회원, C : 기업회원, K : 내부직원], 전달받을 데이터형태['all'/'id'], 받을건수 형태 ['S'/'M'], parentInputId, parentInputName
  **************************************************************************************************************/
 function gfnVocMemberPopupMultiList(kindType, outDataForm, type, parentInputId, parentInputName){

	 //회원조회 팝업
	 window.open(gContextPath+"/mgr/listMemberPopup?kind="+kindType+"&outDataForm="+outDataForm+"&type="+type+"&parentInputId="+parentInputId+"&parentInputName="+parentInputName+"&schKind="+kindType, "회원정보", "scrollbars=yes, width=700, height=500");
 }
 
 /*********************************************************************
  * 전체선택함수
  * 
  * 사용 : gfnCodeComboList($("#"), "seq");
  * 입력 : selectObject, 선택되게할 Name
  **********************************************************************/
function selectAll(selectObject, ckName){
	 if (selectObject.is(":checked")) { 
		 $("input[name='"+inputName+"']:checkbox").prop("checked", true);
	 } else { 
		 $("input[name='"+inputName+"']:checkbox").prop("checked", false); 
	 } 
}

/*********************************************************************
 * gfnSelectAllCalss 전체선택함수 -- input에 class명으로 체크
 * 
 * 사용 : gfnSelectAllCalss($("#"), "calss");
 * 입력 : selectObject, 선택되게할 Name
 **********************************************************************/
function gfnSelectAllCalss(className, bChk){
	$("."+className).prop("checked", bChk);
}

/********************************************************************************************************
 * gfnCodeCheckList 코드 체크박스 조회함수
 * 
 * 사용 : gfnCodeCheckList($("#"), "interest", "interest", strCheckList);
 * 입력 : 체크박스가 추가될 위치 selectObject, higherCode, 체크박스 이름, 체크될 값 배열(null 가능)
 *******************************************************************************************************/
function gfnCodeCheckList(selectObject, strHigh, ckName, strCheckList){
    $.ajax({
        url: gContextPath+"/mgr/listCode",
        data: "higherCode="+strHigh,
        async: false,
        success:function(data, textStatus, jqXHR) {
        	
        	selectObject.find("input").remove();
        	selectObject.find("label").remove();
        	
        	if(data != null) {
	        	$.each(data, function(i, item) {
	        		if(strCheckList == null || strCheckList == ""){
	    					$("<input type='checkbox' id='"+ckName+i+"' name='"+ckName+"' value='"+item.code+"' />").appendTo(selectObject);
	        				$("<label for='"+ckName+i+"'>"+item.kname+"</label>").appendTo(selectObject);
		        		
		        	} else {
	        				if(strCheckList[i] == item.code ){
	        					$("<input type='checkbox' id='"+ckName+i+"' name='"+ckName+"' value='"+item.code+"' checked='checked' />").appendTo(selectObject);
	        				} else{
	        					$("<input type='checkbox' id='"+ckName+i+"' name='"+ckName+"' value='"+item.code+"' />").appendTo(selectObject);
	        				} 
	        				$("<label for='"+ckName+i+"'>"+item.kname+"</label>").appendTo(selectObject);
		        	}
	        	});
        	}
        }
    });
}

/**************************************************************************************************************
 * 이미지풀조회 팝업
 * 
 * 사용 : gfnImagePoolPopupList("keyword")
 * 입력 :
 **************************************************************************************************************/
function gfnImagePoolPopupList(keyword1){

	 //회원조회 팝업
	 window.open(gContextPath+"/mgr/listImagePoolPopup?menuId=MENU01301&=schType=0&schText=" + keyword1, "이미지풀정보", "scrollbars=no, width=700, height=570");
	 //[운영메뉴ID:MENU01301] MENU01212
}

/*******************************************************************************
 * [ Validate ] 숫자만 입력
 * 
 * 입력 : 폼 객체 허용 : 0~9 사용 : onkeyup="validateOnlyNumber(this)"
 ******************************************************************************/
function validateOnlyNumber(from) {
	for ( var i = 0; i < from.value.length; i++) {
		var str = from.value.charCodeAt(i);
		if (str < 48 || str > 57) {
			// alert("숫자만 입력하실수 있습니다. ");
			from.value = from.value.replace(from.value.charAt(i),"");
			// from.select(); //내용선택
			return false;
		}
	}
	return true;
}

/*******************************************************************************
 * fnStrSplit 문자 자르는 함수
 * 
 * 사용 : fnStrSplit("1###2", "###");
 * 입력 : str, 자를 문자열
 ******************************************************************************/
function fnStrSplit(str, strSplit) {
	var s = str;
	var arrayString;
	
	arrayString = s.split(strSplit);
	
	return arrayString;
}

/*******************************************************************************
 * 선택된 체크박스에 패턴추가 함수
 * 
 * 사용 : gfnRtSelectCheck(chkName, pattern);
 * 입력 : 체크박스 이름, 선택값 뒤 추가될 패턴
 ******************************************************************************/
function gfnRtSelectCheck(chkName, pattern){
	var patternLen = pattern.length;
	var result="";
	var isCount = 0;
	
	$('input:checkbox[name="'+chkName+'"]').each(function(){
	    if(this.checked){
	    	isCount ++;
	        result = result + this.value + pattern;
	    }else{
	        result = result + pattern;
	    }
	});
	
	return result.substring(0, result.length-patternLen);
}

/* 입력 버튼 클릭시 */
function gfnReplyInsert(selectObject, linkId){
	var text = selectObject.val();
	$('#replyArea').val("");
	var param = {linkId : linkId, inCondition : "입력", replyDesc : text };
	
	$.ajax({
		type : "POST",
		async : false,
		url: gContextPath+"/mgr/contentMgr/replyAct",
		data: param,
		success:function(data, textStatus, jqXHR) {
			if(data == "NOUSER"){
				alert("로그인이 필요합니다.");
				location.reload();
			}else{
				gfnReplyList($('#reply'), linkId);
			}
	    }
    });
}

/*******************************************************************************
 * 선택된 오브젝트에 리플 삭제
 * 
 * 사용 : gfnReplyDelete(replyId, linkId)
 * 입력 : 리플 Id, 글 linkId
 ******************************************************************************/
function gfnReplyDelete(replyId, linkId){
	var param = {replyId : replyId, inCondition : "삭제", linkId : linkId };
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			type : "POST",
			async : false,
			url : gContextPath+"/mgr/contentMgr/replyAct",
			data : param,
			success:function(){
				$('li[value='+replyId+']').remove();
			}
		});
	}
}

/*******************************************************************************
 * 선택된 오브젝트에 리플 수정 폼 생성
 * 
 * 사용 : gfnReplyUpdate(replyId, linkId)
 * 입력 : 리플 Id, 글 linkId
 ******************************************************************************/
function gfnReplyUpdate(replyId, linkId){
	var txt = $('li[value='+replyId+'] > p').html();
	txt = replaceAll(txt, "<br>", "\n");
	
	$('li[value='+replyId+'] > p').remove();
	$('li[value='+replyId+']').append('<textarea id="editArea" style="width:100%; height: 56px; min-width: 643px;">');
	$('li[value='+replyId+'] > #editArea').html(txt);
	
	//저장 버튼 추가 할 시
	$('li[value='+replyId+']').append('<button type="button" onclick="javascript:gfnReplyUpdateAct('+replyId+','+linkId+')">');
	$('li[value='+replyId+'] > button').text("저장");
	
	/*var script = "javascript:gfnReplyUpdateAct("+replyId+","+linkId+")";
	$('li[value='+replyId+'] > div > .btn > button[value=modify]').attr('onclick', script);*/
}

/*******************************************************************************
 * 선택된 오브젝트에 리플 수정 처리
 * 
 * 사용 : gfnReplyUpdateAct(replyId, linkId)
 * 입력 : 리플 Id, 글 linkId
 ******************************************************************************/
function gfnReplyUpdateAct(replyId, linkId){
	var text = $('#editArea').val();
	var param = {'linkId' : linkId, 'replyId' : replyId, 'inCondition' : "수정", 'replyDesc' : text };
	
	$.ajax({
		type : "POST",
		async : false,
		url: gContextPath+"/mgr/contentMgr/replyAct",
		data: param,
		success:function(data, textStatus, jqXHR) {
			if(data == "NOUSER"){
				alert("로그인이 필요합니다.");
				location.reload();
			}else{
				$('li[value='+replyId+'] > textarea').remove();
				
				$('li[value='+replyId+']').last().append('<p>');
				var str = text;
				str = replaceAll(str, "\n", "<br />");
				$('li[value='+replyId+'] > p').last().html(str);
			}
			
			gfnReplyList($('#reply'), linkId);
	    }
    });
	
	/*var script = "javascript:gfnReplyUpdate("+replyId+","+linkId+")";
	$('li[value='+replyId+'] > div > .btn > button[value=modify]').attr('onclick', script);*/
}

/*******************************************************************************
 * 선택된 오브젝트에 리플 리스트 가져오기
 * 
 * 사용 : gfnReplyList(selectObject, linkId)
 * 입력 : 추가될 위치, 현재 글 linkId
 ******************************************************************************/
function gfnReplyList(selectObject, linkId){
	selectObject.empty();
	
    $.ajax({
        url: gContextPath+"/mgr/contentMgr/replyList",
        data: "linkId="+linkId,
        success:function(data, textStatus, jqXHR) {
            if(data != null) {
                $.each(data, function(i, item) {
                	selectObject.append('<li value='+item.replyId+'>');
                	selectObject.find('li').last().append('<div class="cmt_control">');
                	selectObject.find('.cmt_control').last().append('<strong class="cmt_name">');
                	selectObject.find('.cmt_name').last().text(item.dmlUserName);
                	selectObject.find('.cmt_control').last().append('<span class="date">');
                	selectObject.find('.cmt_control > .date').last().text(item.insTime);
                	if(item.isMyReply == "Y"){
                		selectObject.find('.cmt_control').last().append('<span class="btn">');
                		selectObject.find('.btn').last().append('<button type="button" value="modify" onclick="javascript:gfnReplyUpdate('+item.replyId+','+item.linkId+');">수정</button>');
                		selectObject.find('.btn').last().append('<button type="button" value="delete" onclick="javascript:gfnReplyDelete('+item.replyId+','+item.linkId+');">삭제</button>');
                	}
                	selectObject.find('li').last().append('<p>');
                	
                	var str = item.replyDesc;
                	str = replaceAll(str, "\n", "<br />");
                	selectObject.find('li > p').last().html(str);
                	
                });
            }
        }
    });
}

/*********************************************************************
 * 프린트 div 영역 지정 출력
 * 
**********************************************************************/
var win=null;
function printIt(contextPath)  {
	win = window.open('','','width=1024,height=900');
	self.focus();
	win.document.open();
	win.document.write('<'+'html'+'><'+'head'+'><'+'style'+'>');
	win.document.write('body, td { font-size: 10pt;}');
	win.document.write('body, th { font-size: 10pt;}');
	win.document.write('<'+'/'+'style'+'><link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/ips/basic.css" /><'+'/'+'head'+'><'+'body'+'>');
	win.document.write($("#contentArea").html());
	win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
	win.document.close();
	win.print();
	win.close();
}

/*********************************************************************
 * 프린트 div content 영역 출력
 * 
**********************************************************************/
function printContent(contextPath, strSiteKey)  {
	var $divContent = $('#content').clone();
	var menuId = $('#menuId').val();
	var step = $('#step').val();
	
	win = window.open('','','width=1024,height=900');
	self.focus();
	win.document.open();
	win.document.write('<'+'html'+'><'+'head'+'><'+'style type="text/css" media="print" '+'>');
	win.document.write('body, td { font-size: 10pt;}');
	win.document.write('body, th { font-size: 10pt;}');
	win.document.write('.content-footer { display:none; }');
	win.document.write('@media print { .content-footer { display:none; } }');
	win.document.write('@page{ size:auto; margin:8mm;} ');
	win.document.write('<'+'/'+'style'+'>');
	win.document.write('<link rel="stylesheet" type="text/css" href="'+contextPath+'/resources/css/'+strSiteKey+'/basic.css" />');
	win.document.write('<'+'/'+'head'+'><'+'body id="print"'+'>');
	win.document.write($divContent.html());
	win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
	win.document.close();
	
	setTimeout(function () { 
		win.print();
		win.close();
	} ,1000);
}

//쿠키값 설정
function setCookie(name, value, expiredays){
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape(value) + "; path="+gContextPath+"; expires=" + today.toGMTString() + ";";
}

function setCookieWithSamePath(name, value, expiredays){
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + today.toGMTString() + ";";
}

//쿠키값 가져오기 
function getCookie(key){
	var cook = document.cookie + ";";
	var idx = cook.indexOf(key,0);
	var val = "";
	
	if(idx!=-1)
	{
		cook = cook.substring(idx,cook.length);
		begin = cook.indexOf("=",0) + 1;
		end = cook.indexOf(";",begin);
		
		//key 값과 cookie의 key 값이 일치 할 경우에만 
		if(key == cook.substring(0,begin-1)){
			val = unescape(cook.substring(begin,end));			
		}
	}
	
	return val;
}

function replaceAll(sValue, param1, param2) {
	return sValue.split(param1).join(param2);
}


/*******************************************************************************
 * 선택된 게시글(메뉴) 스크랩하기
 * 
 * 사용 : gfnMyScrapInsert(menuid, linkId)
 * 입력 : 현재메뉴 menuid, 현재 글 linkId
 ******************************************************************************/
//스크랩중복체크 후 인서트
function gfnMyScrapInsert(menuid,linkid){
	if(menuid.length < 9 ){
		
		alert("스크랩할 수 없습니다.");
		return;
	}
	
	$.ajax({               
 		url: gContextPath+"/mps/mypage/check",
 		data: {'menuId' : menuid, 'schText' : linkid},
 		success:function(rtn) {

 	 		fnScrapInsert(menuid,linkid,rtn); 
 		}
 	});
}

//마이스크랩등록
function fnScrapInsert(menuid,linkid,rtn){
	if(rtn>0){
		alert("이미 스크랩되어 있습니다.");
		return false;
	}else{
		if(confirm("해당 게시물(메뉴)를 스크랩 하시겠습니까?")) {

			$.ajax({               
			url: gContextPath+"/mps/mypage/insert",
 			data: {'menuId' : menuid, 'schText' : linkid},
 				success:function(val) {
 					alert("해당 게시물(메뉴)이 스크랩되었습니다.");
 				}
			});
		}else{
			alert("취소되었습니다.");
		}
	}
}

/********************************************************************************************************
 * gfnCodeRadioList 코드 라디오버튼 조회함수
 * 
 * 사용 : gfnCodeRadioList($("#"), "interest", "answerWay", "", "", "01");
 * 입력 : 추가될 위치 selectObject, higherCode, 라디오버튼 이름, 기본값 사용시 value, 기본값 사용시 text, 선택 할 value
 *******************************************************************************************************/
function gfnCodeRadioList(selectObject, strHigh, objName, strValue, strText, strSelect){
    $.ajax({
        url: gContextPath+"/mgr/listCode",
        data: "higherCode="+strHigh,
        async: false,
        success:function(data, textStatus, jqXHR) {
        	
        	selectObject.find("input").remove();
        	selectObject.find("label").remove();
        	
        	if(data != null) {
	        	$.each(data, function(i, item) {
					$("<input type='radio' id='"+objName+i+"' name='"+objName+"' value='"+item.code+"' />").appendTo(selectObject);
					$("<label for='"+objName+i+"'>"+item.kname+"</label>").appendTo(selectObject);
	        	});
        	}
        	
        	if(strSelect != "" && strSelect != null){
        		$('input[name='+objName+']').each(function(){
        			if($(this).val() == strSelect){
        				$(this).attr('checked', 'checked');
        			}
        		});
        	}
        }
    });
}

function padDigit(num){
	if(num < 10){
		return "0"+num;
	}else{
		return num;
	}
}

/*********************************************************************
 * 통합검색 함수
 * 
 * 사용 : gfnTotalSearch();
 * 입력 :
 * 검색 참조 값 :  
	parameter.put("query","보건");					// 검색 키워드
	parameter.put("sortField","RANK");				// 정렬필드 (DATE,RANK)
	parameter.put("sortOrder","DESC");				// 정령방식 (DESC,ASC)
	parameter.put("searchField","ALL");				// 검색필드 (ALL, TITLENAME , KHTML, ATTACH)
	parameter.put("viewCount","10");				// 출력갯수 
	parameter.put("startCount","0");				// 페이지 번호 0
	parameter.put("startDate","");					// 시작날짜 : YYYY/MM/DD
	parameter.put("endDate","");					// 종료날짜 : YYYY/MM/DD
	parameter.put("collection","ALL");				// 컬렉션 이름 
													ALL 	: 전체
													khidi_1 : 보건의료
													khidi_2 : 의료기기
													khidi_3 : 의료서비스
													khidi_4 : 식품
													khidi_5 : 뷰티화장품
													khidi_6 : 고령친화
													khidi_7 : 한의약
													khidi_8 : 보건산업총괄
	 												
	parameter.put("SITEID","");						// 검색범위(코드값)
	parameter.put("SEARCHCODE1","");				// 콘턴츠분류(코드값)
	parameter.put("DETAIL_1","");					// 완전일치
	parameter.put("DETAIL_2","");					// 포함
	parameter.put("DETAIL_3","");					// 제외
	parameter.put("DETAIL_4","");					// 하나이상 포함

 * 
**********************************************************************/
function gfnTotalSearch(){
	
	if($('#categoryQuery').val() != ""){
		//검색버튼을 누르면 카테고리 검색이 해제 
		document.totSearchForm.categoryQuery.value = "";
		
	}
	if(document.totSearchForm.categoryUse.value == "false"){
		document.totSearchForm.categoryUse.value = "true";
	}
	
	if($.trim($('#search_keyword').val()) == ""){
		alert("검색어를 입력해 주세요.");
		$("#search_keyword").val("");
		$("#search_keyword").focus();
		return false;
	}

	
	if(($("#startDate").length > 0 && $("#endDate").length > 0 ) && ($("#startDate").val() != '' && $("#endDate").val() != '')){
		
		document.totSearchForm.startDate.value = $("#startDate").val();
		document.totSearchForm.endDate.value = $("#endDate").val();
		document.totSearchForm.period.value = "keyIn";
	}
	
    var li_str_len     = $.trim($('#search_keyword').val()).length; // 이벤트가 일어난 컨트롤의 value 값 길이
	
	if(li_str_len < 2){
		alert("두 글자이상 입력바랍니다.");

		$("#search_keyword").val("");
		$("#search_keyword").focus();
		return false;
	}
	
	if($.trim($('#SITEID').val()) == "SITE00017"){
		$('#SITEID').val("");
	}

	var name = "";
	var addHistory = true;
	var cookieLength = 30;
	
	for(var i=1; i <=cookieLength; i++){
		if(getCookie("schKeyWord"+padDigit(i)) == $('#search_keyword').val()){
			addHistory = false;
		}
	}

	if(addHistory){
		// 검색어 쿠키를 항상 30개로 채워놓는다. 그래야 최근 것부터 01,02,... 순으로 채워넣을 수 있음.
		if(document.cookie.indexOf("schKeyWord")<0){
			for(var i=1; i<=cookieLength; i++){
				setCookieWithSamePath("schKeyWord"+padDigit(i), "null", 30);
			}
		}

		if(name == ""){
			// 항상 1을 남기고 한칸씩  뒤로 밈.
			for(var i=cookieLength; i>1; i--){
				setCookieWithSamePath("schKeyWord"+padDigit(i), getCookie("schKeyWord"+padDigit(i-1)), 30);
			}
			setCookieWithSamePath("schKeyWord"+padDigit(i), getCookie("schKeyWord"+padDigit(i)), -1);
			name = "schKeyWord"+padDigit(i);
		}
		setCookieWithSamePath(name, $('#search_keyword').val(), 30);
	}
	
	if($("#id_re-search").is(":checked")){
		var lastQuery = document.totSearchForm.query.value;
		document.totSearchForm.query.value = lastQuery + ' ' + $("#search_keyword").val();
	}else{		
		document.totSearchForm.query.value = $('#search_keyword').val();
	}
	document.totSearchForm.submit();
}

function goCategorySearch(objId,str){
	document.totSearchForm.categoryQuery.value = objId;
	document.totSearchForm.categoryUse.value = str;
	document.totSearchForm.submit();
}

function goRecommandSearch(objId){
	document.totSearchForm.query.value = objId;
	document.totSearchForm.submit();
}

function gfnAjaxError(){
	alert("경로가 정확하지 않거나 오류가 발생하였습니다.");
	return; 
}

//메일보내기
function gfnToMail(rtnLoction, KNAME, url){
	var pop_title = "mail_pop";
	window.open("", pop_title,'width=870px,height=610px,scrollbars=yes,status=no');

	var frmData = document.frmData;
	frmData.menuName.value=rtnLoction;
	frmData.KName.value=KNAME;
	frmData.linkUrl.value=url;
	frmData.target = pop_title;
	frmData.action = "/mps/footerMail";
	frmData.submit();
}

//트위터보내기
function gfnToTwitter(strUrl){
	strUrl =  "http://www.khidi.or.kr"+strUrl;
	var shareUrl = "http://twitter.com/share?url=" + encodeURIComponent(strUrl);
	window.open(shareUrl, 'share_twitter', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');
}	

/**************************************************************************************************************
 * Editor 팝업
 * 
 * 사용 : gfnEditorPopup("opener")
 * 입력 : 
 **************************************************************************************************************/
function gfnEditorPopup(eId){
	 //Editor 팝업
	 window.open(gContextPath+"/mgr/editorPopup?editorId="+eId, "Editor", "scrollbars=no, width=800, height=840");
}

/**************************************************************************************************************
 * 이용약관 전체선택 공통
 * 
 * 사용 : gfnOpenNewsLetter()
 * 입력 : 
 **************************************************************************************************************/
function gfnAllPolicyCheck(){
	var choicePolicyChk = $("input:checkbox[name='allcheck']").is(":checked");
	
	if(choicePolicyChk){
		$(".agree1").prop("checked", true);
		$(".agree2").prop("checked", true);
	}else{
		$(".agree1").removeAttr('checked');
		$(".agree2").removeAttr('checked');
	}	
}

/**************************************************************************************************************
 * 이용약관 전체선택 공통
 * 
 * 사용 : gfnNotAgreeCheck()
 * 입력 : 
 **************************************************************************************************************/
function gfnNotAgreeCheck()
{
	$("#allcheck").removeAttr('checked');
}

/**************************************************************************************************************
 * 날짜 공통함수
 * 
 * 사용 : 
 * 입력 : 
 **************************************************************************************************************/
function gfnIsHoliday(yyyy, mm, dd){
	//검사년도
	var yyyymmdd = yyyy+""+mm+""+dd;
	//var yyyy = "";
	var holidays = new Array();
	var holidaysName = new Array();
	var holidayName = "";
	// 음력 공휴일 양력으로 바꾸어서 입력
	
	// 양력 공휴일 일력
	holidays[0] = yyyy+"0101"; //양력설날
	holidays[1] = yyyy+"0301"; //삼일절
	//holidays[2] = yyyy+"0405"; //식목일
	holidays[2] = yyyy+"0505"; //어린이날
	holidays[3] = yyyy+"0606"; //현충일
	holidays[4] = yyyy+"0815"; //광복절
	holidays[5] = yyyy+"1003"; //개천절
	holidays[6] = yyyy+"1009"; //한글날
	holidays[7] = yyyy+"1225"; //성탄절
	
	var tmp01 = lunerCalenderToSolarCalenger(yyyy+"0101");
	var tmp02 = lunerCalenderToSolarCalenger(yyyy+"0815");

	holidays[8] = Number(tmp01) -1;  //음력설 첫쨋날
	holidays[9] = tmp01; 	 //음력설 둘쨋날
	holidays[10] =Number(tmp01) +1; //음력설 셋쨋날
	holidays[11] = Number(tmp02) -1; //음력추석 첫쨋날
	holidays[12] = tmp02; 	 //음력추석 둘쨋날
	holidays[13] = Number(tmp02) +1; //음력추석 셋쨋날
	holidays[14] = lunerCalenderToSolarCalenger(yyyy+"0408"); //석가탄신일
	
	holidaysName[0] = "신정";
	holidaysName[1] = "삼일절";
	//holidaysName[2] = "식목일";
	holidaysName[2] = "어린이날";
	holidaysName[3] = "현충일";
	holidaysName[4] = "광복절";
	holidaysName[5] = "개천절";
	holidaysName[6] = "한글날";
	holidaysName[7] = "성탄절";
	holidaysName[8] = "구정 첫쨋날";
	holidaysName[9] = "구정 둘쨋날";
	holidaysName[10] = "구정 셋쨋날";
	holidaysName[11] = "추석 첫쨋날";
	holidaysName[12] = "추석 둘쨋날";
	holidaysName[13] = "추석 셋쨋날";
	holidaysName[14] = "석가탄신일";
	
	for(var i=0; i<holidays.length; i++){
		if(holidays[i] == yyyymmdd){
			holidayName = holidaysName[i];
			//return true;
		}
	}
	return holidayName;
}

function get_year(src) {
	 if ((src < 1841) || (src > 2043 )) {
	  alert('연도 범위는 1841 ~ 2043 까지입니다.');
	  return;
	 } else {
	  return src;
	 }
	}

	/**
	 * 달이 12보다 크거나 1보다 작은지 검사한다.
	 * 날짜가 잘못된 경우에는 경고창 후 멈춘다.
	 *
	 * @param int
	 * @return int
	 */
	function get_month(src) {
	 if ((src < 1) || (src > 12 )) {
	  alert('월 범위는 1 ~ 12 까지입니다.');
	  return;
	 } else {
	  return src;
	 }
	}

	/**
	 * 날짜가 1일보다 크고 src보다 작은 경우는 날짜를 반환한다.
	 * 날짜가 잘못된 경우에는 경고창 후 멈춘다.
	 *
	 * @param int
	 * @param int
	 * @return int
	 */
	function get_day(src,day) {
	 if ((src < 1) || (src > day )) {
	  alert('일 범위가 틀립니다.');
	  return;
	 } else {
	  return src;
	 }
	}
	
/**
 * 음력을 양력으로 바꾸어서 반환한다.
 *
 * @param string
 * return string
 */
function lunerCalenderToSolarCalenger (input_day) {
 var kk = [[1, 2, 4, 1, 1, 2, 1, 2, 1, 2, 2, 1],   /* 1841 */
     [2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 1],
     [2, 2, 2, 1, 2, 1, 4, 1, 2, 1, 2, 1],
     [2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 2, 1, 5, 2, 1, 2, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 3, 2, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 5, 2],   /* 1851 */
     [2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 5, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
     [2, 1, 6, 1, 1, 2, 1, 1, 2, 1, 2, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2],   /* 1861 */
     [2, 1, 2, 1, 2, 2, 1, 2, 2, 3, 1, 2],
     [1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 4, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],
     [1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2, 1],
     [2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 2, 1, 2, 1, 2, 1, 1, 5, 2, 1],
     [2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 2],   /* 1871 */
     [1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 1, 2, 4, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
     [2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1, 2],
     [2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 4, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
     [1, 2, 1, 2, 1, 2, 5, 2, 2, 1, 2, 1],   /* 1881 */
     [1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
     [2, 1, 1, 2, 3, 2, 1, 2, 2, 1, 2, 2],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 2, 1, 5, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],   /* 1891 */
     [1, 1, 2, 1, 1, 5, 2, 2, 1, 2, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 5, 1, 2, 1, 2, 1, 2, 1],
     [2, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 5, 2, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 5, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],   /* 1901 */
     [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1],
     [2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 4, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
     [1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 5, 1, 2, 2, 1, 2, 2],   /* 1911 */
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
     [2, 2, 1, 2, 5, 1, 2, 1, 2, 1, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 5, 2, 2, 1, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],   /* 1921 */
     [2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2],
     [2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
     [2, 1, 2, 5, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 5, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],
     [1, 2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1],
     [2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1],   /* 1931 */
     [2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
     [1, 2, 2, 1, 6, 1, 2, 1, 2, 1, 1, 2],
     [1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 4, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
     [2, 2, 1, 1, 2, 1, 4, 1, 2, 2, 1, 2],
     [2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 1, 2, 2, 4, 1, 1, 2, 1, 2, 1],   /* 1941 */
     [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 4, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
     [2, 5, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],   /* 1951 */
     [1, 2, 1, 2, 4, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
     [2, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 5, 2, 1, 2, 2],
     [1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1],
     [2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],   /* 1961 */
     [1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1],
     [2, 2, 5, 2, 1, 1, 2, 1, 1, 2, 2, 1],
     [2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 1, 5, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
     [1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1, 2],   /* 1971 */
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1],
     [2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 1, 5, 2, 1, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1],
     [2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 6, 1, 2, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],   /* 1981 */
     [2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2, 2],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
     [2, 1, 2, 2, 1, 1, 2, 1, 1, 5, 2, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
     [2, 1, 2, 2, 1, 5, 2, 2, 1, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
     [1, 2, 1, 1, 5, 1, 2, 1, 2, 2, 2, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],   /* 1991 */
     [1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
     [1, 2, 5, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 2, 1, 5, 2, 1, 1, 2],
     [1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 1],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
     [2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1],
     [2, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2],   /* 2001 */
     [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2],
     [1, 5, 2, 2, 1, 2, 1, 2, 2, 1, 1, 2],
     [1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
     [1, 1, 2, 1, 2, 1, 5, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
     [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
     [2, 2, 1, 1, 5, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],   /* 2011 */
     [2, 1, 6, 2, 1, 2, 1, 1, 2, 1, 2, 1],
     [2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
     [1, 2, 1, 2, 1, 2, 1, 2, 5, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 2],
     [1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
     [2, 1, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
     [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
     [2, 1, 2, 5, 2, 1, 1, 2, 1, 2, 1, 2],
     [1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],   /* 2021 */
     [2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
     [1, 5, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
     [2, 1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
     [1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2],
     [1, 2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1],
     [2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2],
     [1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1],
     [2, 1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1],   /* 2031 */
     [2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 5, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
     [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
     [2, 2, 1, 2, 1, 4, 1, 1, 2, 1, 2, 2],
     [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
     [2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1],
     [2, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1, 1],
     [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1],
     [2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],   /* 2041 */
     [1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
     [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2]];

 var gan = new Array("甲","乙","丙","丁","戊","己","庚","辛","壬","癸");
 var jee = new Array("子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥");
 var ddi = new Array("쥐","소","범","토끼","용","뱀","말","양","원숭이","닭","개","돼지");
 var week = new Array("일","월","화","수","목","금","토");

 var md = new Array(31,0,31,30,31,30,31,31,30,31,30,31);

 var year =input_day.substring(0,4);
 var month =input_day.substring(4,6);
 var day =input_day.substring(6,8);

 // 음력에서 양력으로 변환
 var lyear, lmonth, lday, leapyes;
 var syear, smonth, sday;
 var mm, y1, y2, m1;
 var i, j, k1, k2, leap, w;
 var td, y;
 lyear = get_year(year);        // 년도 check
 lmonth = get_month(month);     // 월 check

 y1 = lyear - 1841;
 m1 = lmonth - 1;
 leapyes = 0;
 if (kk[y1][m1] > 2)  {
     if (document.frmTest.yoon[0].checked) {
     leapyes = 1;
     switch (kk[y1][m1]) {
        case 3:
        case 5:
          mm = 29;
          break;
        case 4:
        case 6:
          mm = 30;
          break;
      }
     } else {
     switch (kk[y1][m1]) {
       case 1:
       case 3:
       case 4:
         mm = 29;
         break;
       case 2:
       case 5:
       case 6:
         mm = 30;
         break;
     } // end of switch
    } // end of if
 } // end of if

   lday = get_day(day, mm);

   td = 0;
   for (i=0; i<y1; i++) {
   for (j=0; j<12; j++) {
      switch (kk[i][j]) {
        case 1:
          td = td + 29;
          break;
        case 2:
          td = td + 30;
          break;
        case 3:
          td = td + 58;    // 29+29
          break;
        case 4:
          td = td + 59;    // 29+30
          break;
        case 5:
          td = td + 59;    // 30+29
          break;
        case 6:
          td = td + 60;    // 30+30
          break;
        } // end of switch
   } // end of for
 } // end of for

 for (j=0; j<m1; j++) {
  switch (kk[y1][j]) {
    case 1:
      td = td + 29;
      break;
    case 2:
      td = td + 30;
      break;
    case 3:
      td = td + 58;    // 29+29
      break;
    case 4:
      td = td + 59;    // 29+30
      break;
    case 5:
      td = td + 59;    // 30+29
      break;
    case 6:
      td = td + 60;    // 30+30
      break;
  } // end of switch
  } // end of for

  if (leapyes == 1) {
  switch(kk[y1][m1]) {
    case 3:
    case 4:
      td = td + 29;
      break;
    case 5:
    case 6:
      td = td + 30;
      break;
   } // end of switch
  } // end of switch

  td =  td + parseFloat(lday) + 22;
  // td : 1841 년 1 월 1 일 부터 원하는 날짜까지의 전체 날수의 합
  y1 = 1840;
  do {
  y1 = y1 +1;
  if  ((y1 % 400 == 0) || ((y1 % 100 != 0) && (y1 % 4 == 0))) {
    y2 = 366;
  }
  else {
    y2 = 365;
  }
  if (td <= y2) {
    break;
  }
  else {
    td = td- y2;
  }
  } while(1); // end do-While
 
 syear = y1;
 md[1] = parseInt(y2) -337;
 m1 = 0;
 do {
 m1= m1 + 1;
 if (td <= md[m1-1]) {
  break;
 }
 else {
  td = td - md[m1-1];
 }
 } while(1); // end of do-While

 smonth = parseInt(m1);
 sday = parseInt(td);

 // 월이 한자리인경우에는 앞에 0을 붙혀서 반환
 if ( smonth < 10 ) {
  smonth = "0" + smonth;
 }
 // 일이 한자리인경우에는 앞에 0을 붙혀서 반환
 if ( sday < 10 ) {
  sday = "0" + sday;
 }

 return new String( syear + smonth + sday );
}

//날짜 포맷변환  00000000 => 0000-00-00
function gfnDateYYYYMMDDFormat(object){
	
	var num, year, month, day;
	
	var input = "#"+object;
	
	num = $(input).val();
	
	if(num.length == 0){
		return;
	}
	
	while(num.search("-") != -1){
		
		num = num.replace("-","");
	}
	
	if(isNaN(num)){
		alert("숫자로만 작성하셔야 합니다.");
		$(input).focus();
		return;
	}
    
	if(num != 0 && num.length == 8){
		
		year = num.substring(0,4);
		month = num.substring(4,6);
		day = num.substring(6);
		
		if(isValidDay(year,month,day)==false){
			
			num = "";
			alert("유효하지 않는 날짜입니다. 다시 한번 확인하시고 입력해주세요.");
			$(input).val(num);
			$(input).focus();
			return;
		}
		
		num = year+"-"+month+"-"+day;
		
	}else{
		num = "";
		alert("날짜 입력형식 오류입니다. 다시 한번 확인하시고 입력해 주세요");
		$(input).val(num);
		$(input).focus();
		return;
	}
	
	$(input).val(num);
} 

//유효한 날짜인지 체크
function isValidDay(yyyy, mm, dd){
	
	var m = parseInt(mm,10) -1;
	var d = parseInt(dd,10);
	var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	
	if((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0){
		
		end[1]=29;
	}
	
	return(d >=1 && d <= end[m]);
}


/*********************************************************************
 * 키워드 호출
 * 
 * 사용 : gfnOpenLogin();
 * 입력 : 
**********************************************************************/
function gfnKeywordSearch(strMenuId){
	var strStyle = "scrollbars=yes";
	var strUrl = "/mgr/contentMgr/selectKeywordSearchPopup?menuId="+strMenuId;
	
	gfnOpenWin(strUrl, "키워드검색", strStyle, 750, 710);
	
}

/*********************************************************************
 * 로그인  호출
 * 
 * 사용 : gfnOpenLogin();
 * 입력 : 
**********************************************************************/
function gfnOpenLogin() 
{
	
	//$(".login_layerPopup").show();
	$(".login_layerPopup").css("display","none");
	$(".login_layerPopup").fadeIn('slow');
}

/*********************************************************************
 * 유해어 체크
 * 
 * 사용 : gfnTabooWordCheck();
 * 입력 : 
**********************************************************************/
function gfnTabooWordCheck(objs) 
{
	var chkCnt = 0;
	var chkKNameArray = new Array();
	var kNameArray = new Array();
	var kNameArray = new Array();
	
	$.each(objs.split('§§'), function(index, obj){
		$.ajax({
			url: gContextPath+"/tabooWord",
			async: false,
			cache: false,
			success:function(data, textStatus, jqXHR) {
				if(data != null){
					$.each(data, function(j){
						if($("#"+obj).val() != undefined){
							if($("#"+obj).val().indexOf(data[j].KNAME) > -1){
								chkCnt += 1;
								chkKNameArray.push(data[j].KNAME);
							}
						}
					});
				}
			}
		});
	});
	
	$.each(chkKNameArray, function(i, el){
		if($.inArray(el, kNameArray) == -1) kNameArray.push(el);
	});
		
	
	return [chkCnt+"건의 유해어가 검출되었습니다.\n"+kNameArray, chkCnt];
}

function zooms(nowZoom) {
	var docbody = document.body;
	header.style.zoom = nowZoom;// IE
	body.style.zoom = nowZoom;// IE
	footer.style.zoom = nowZoom;  // IE
	docbody.style.webkitTransform = 'scale('+nowZoom+')';  // Webkit(chrome)
	docbody.style.webkitTransformOrigin = '0 0';
	docbody.style.mozTransform = 'scale('+nowZoom+')';  // Mozilla(firefox)
	docbody.style.mozTransformOrigin = '0 0';
	docbody.style.oTransform = 'scale('+nowZoom+')';  // Opera
	docbody.style.oTransformOrigin = '0 0';
}

/*********************************************************************
 * 에디터 설정
 * 
**********************************************************************/
function gfnInitEditor(objId, objPosition){
	// 다음에디터 설정
	$.ajax({
        url : gContextPath + "/resources/component/daumeditor-7.4.27/editor.html",
        success : function(data){
        	data = data.replace(/images\/icon\/editor\/skin\/01\/btn_drag01.gif/g, gContextPath + "/resources/component/daumeditor-7.4.27/images/icon/editor/skin/01/btn_drag01.gif");
        	data = data.replace(/images\/icon\/editor\/loading2.png/g, gContextPath + "/resources/component/daumeditor-7.4.27/images/icon/editor/loading2.png");
        	data = data.replace(/images\/icon\/editor\/pn_preview.gif/g, gContextPath + "/resources/component/daumeditor-7.4.27/images/icon/editor/pn_preview.gif");
			
        	$("#editor_frame").html(data);
            var config = {
            		txHost: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */
            		txPath: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
            		txService: 'sample', /* 수정필요없음. */
            		txProject: 'sample', /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */
            		initializedId: "", /* 대부분의 경우에 빈문자열 */
            		wrapper: "tx_trex_container", /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
            		form: 'tx_editor_form'+"", /* 등록하기 위한 Form 이름 */
            		txIconPath: gContextPath + "/resources/component/daumeditor-7.4.27/images/icon/editor/", /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
            		txDecoPath: gContextPath + "/resources/component/daumeditor-7.4.27/images/deco/contents/", /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
            		canvas: {
                        exitEditor:{
                            /*
                            desc:'빠져 나오시려면 shift+b를 누르세요.',
                            hotKey: {
                                shiftKey:true,
                                keyCode:66
                            },
                            nextElement: document.getElementsByTagName('button')[0]
                            */
                        },
            			styles: {
            				color: "#123456", /* 기본 글자색 */
            				fontFamily: "굴림", /* 기본 글자체 */
            				fontSize: "9pt", /* 기본 글자크기 */
            				backgroundColor: "#fff", /*기본 배경색 */
            				lineHeight: "1.5", /*기본 줄간격 */
            				padding: "10px" /* 위지윅 영역의 여백 */
            			},
            			showGuideArea: false
            		},
            		events: {
            			preventUnload: false
            		},
            		sidebar: {
            			attachbox: {
            				show: true,
            				confirmForDeleteAll: true
            			},
            			capacity: {
            				available : 1024 * 1024 * 10, /* 첨부 용량 제한 */
            				maximum: 1024 * 1024 * 10     /* 첨부 용량 제한 */
            			}
            		},
            		size: {
            			//contentWidth: 670 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */
            		}
            	};

            	EditorJSLoader.ready(function(Editor) {
            		var editor = new Editor(config);
            		Editor.getCanvas().setCanvasSize({height:250});

            		if(objPosition == 'self'){
            			Editor.modify({
                            "content":  document.getElementById(objId) /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
                        });
            		}else{
            			Editor.modify({
            				"content": opener.document.getElementById(objId) /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
            			});
            		}
            		
            	});
    	}
	});
}

/*********************************************************************
 * 파일업로드 확장자 체크
 * 
**********************************************************************/
function gfnCheckFext(objs, type){
	 
 	var retval = true;
 	var ext = "";
 	
 	objs.each(function(){
 		var fpath = $(this).val();
 		if(fpath.length > 0)
 		{
 			ext = fpath.substr(fpath.lastIndexOf(".") + 1, fpath.length);
 			ext = ext.toLowerCase();
 			
 			if(type == "IMG")
 			{
 				var allows = "jpg|png|bmp|gif";
 				if(allows.indexOf(ext) < 0)
 				{
 					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다.\n이미지 파일을 등록해주십시오.\n현재 파일 종류 : " + ext);
 					retval = false;
 					return false;
 				}
 			}
 			else if(type == "DOC")
 			{
 				var allows = "doc|docx|xls|xlsx|ppt|pptx|pdf|hwp|txt";
 				if(allows.indexOf(ext) < 0)
 				{
 					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다/.\n문서 파일을 등록해주십시오.\n현재 파일 종류 : " + ext);
 					retval = false;
 					return false;
 				}
 			}
 			else if(type == "GNR")
 			{
 				var allows = "jpg|png|bmp|gif|doc|docx|xls|xlsx|ppt|pptx|pdf|hwp|txt|zip";
 				if(allows.indexOf(ext) < 0)
 				{
 					alert("허용되지 않는 파일이거나 목적에 맞지 않는 파일입니다.\n파일 종류 : " + ext);
 					retval = false;
 					return false;
 				}
 			}
 		}
 	});
 	
 	return retval;
}


/*********************************************************************
 * 파일미리보기
 * 
**********************************************************************/
function gfnFileViewer(url){
	$.ajax({   
		type : "POST",
		async : false,
 		url: url,
 		success:function(data){
 			window.open(data.INFO, "_balnk", "status=no,toolbar=no,scrollbars=no");
 		}
 	});
}

/*********************************************************************
 * 특수문자변화코드
 * 
**********************************************************************/
function ConvertSystemSourcetoHtml(str){
	str = str.replace(/&lt;/g,"<");
	str = str.replace(/&gt;/g,">");
	str = str.replace(/&quot;/g,"\"");
	str = str.replace(/&#39;/g,"\'");
	str = str.replace(/&apos;/g,"\'");
	return str;
}

function gfnCountryAdd(obj){
	var nodeLeng = $("#tdCountry").children('select').length;
	var continentName = "continent"+(nodeLeng/2);
	var countryName = "country"+(nodeLeng/2);
	
	obj.before('<select id="'+continentName+'" name="'+continentName+'" class="selContinent"><option value="">대륙 선택</option></select> '
             + '<select id="'+countryName+'" name="'+countryName+'" class="selCountry"><option value="">국가 선택</option></select> ');
	
	gfnCodeComboList($("#"+continentName), "country", "", "대륙 선택", "", ""); // 대륙 코드조회
	
}

function gfnFileTagAdd(obj){
	obj.after('<input type="file" id="file_upload" name="file_upload" class="input_mid"/> '
			+ '<input type="button" value="파일삭제" class="input_smallBlack" onClick="javascript:gfnFileTagDel($(this));" />');
}

function gfnFileTagDel(obj){
	obj.prev().remove();
	obj.remove();
}
