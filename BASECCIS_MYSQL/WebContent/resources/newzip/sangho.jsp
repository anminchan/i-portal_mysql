<!DOCTYPE	html PUBLIC	"-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=utf-8" %>
<html	xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko"><%String zipCode1 = request.getParameter("zipCode1");String zipCode2 = request.getParameter("zipCode2");String address1 = request.getParameter("address1");String address2 = request.getParameter("address2");%>
<head>
<meta	http-equiv="Content-Type"	content="text/html;	charset=utf-8" />
<meta	name="viewport"	content="width=device-width, initial-scale=1.0,	maximum-scale=1.0, minimum-scale=1.0,	user-scalable=no"	/>
<title>::건물명검색::</title>
<link	type="text/css"	href="/resources/css/common/newzipstyle.css" rel="stylesheet"	/>
<script	src="/resources/js/newzipcommon.js"></script>
<script	type="text/javascript">	
/*
 *	ver	 : 1.0
 *	date : 2012-08-07
 *	make : yjkim 
 */

	var	xmlHttp;
	var	mode;											
	var	dataFrom;	
	var	dataTo;		
	var	objFrom;	
	var	objTo;		
	var	objClear;					
	var	areaIdx;	
	var	bldnm,group_nm,oldaddr_nm,newaddr_nm,livein_cnt,corplist;	

	function createXMLHttpRequest()
	{
		if(xmlHttp !=	null)	
		{
			xmlHttp.Abort();
			delete xmlHttp;
			xmlHttp	=	null;
		}

		if (window.ActiveXObject)	
		{
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}	
		else if	(window.XMLHttpRequest)
		{
			xmlHttp = new XMLHttpRequest();
		}
	}

	function changeAreaList(idx, obj)
	{	
		if(obj.id	== ''	|| obj.id	== 'undefined')
			return;

		areaIdx	=	idx;
		mode	=	'area';
		dataFrom,	dataTo,	objFrom, objTo,	objClear;				
		
		// 통합검색	
		if(obj.id	== 'city1')
		{
			dataFrom	=	'city';
			dataTo		=	'county';
			objFrom		=	'city1';
			objTo		=	'county1';
			objClear	=	'town1_oldaddr';	

			//①세종시예외처리 
			document.getElementById("county1").disabled	=	false;

			if(document.getElementById(obj.id).value =='36')
			{
				document.getElementById("county1").options.length = 0;
   				document.getElementById("county1").options[0] = new Option(':::::::', '');
				document.getElementById("county1").disabled	=	true;
				dataTo		=	'town';
				objTo		=	'town1_oldaddr';
			}	
			//clearList(objTo);
		}
		// 통합검색	
		else if(obj.id ==	'county1')
		{
			dataFrom	=	'county';
			objFrom		=	'county1';
			objClear	=	'';
			dataTo		=	'town';
			objTo		=	'town1_oldaddr';

			//clearList(objTo);
		}
		else if(obj.id ==	'town1_oldaddr')
		{
			dataFrom	=	'town';
			objFrom		=	'town1_oldaddr';
			objClear	=	'';
			dataTo		=	'';
			objTo		=	'';
			//dataTo		=	'town';
			//objTo		=	'town1_oldaddr';
		}
		// 통합검색	
		else if(obj.id ==	'rd_nm_idx1')
		{
			dataFrom	=	'county';
			objFrom		=	'county1';
			objClear	=	'';

			if(searchType	== 'NORMAL1')
			{		//	새주소검색
				dataTo		=	'rd_nm';
				objTo		=	'rd_nm1';
			}
		}
		
		//	update해야 할 select를 초기화
		clearList(objTo);
		clearList('town1_oldaddr');
		//	clear해야	할	select가	설정된	경우 초기화

		// from	object 선택값이	없으면	return
		if(document.getElementById(objFrom).value	== '')
		{
			return;
		}

		var	url	=	"./AjaxRequestXML.jsp?getUrl=http://www.juso.go.kr/getAreaCode.do?" + escape(createParameter());

		createXMLHttpRequest();
		xmlHttp.onreadystatechange = handleStateChange;
		xmlHttp.open("GET",	url, true);
		xmlHttp.send(null);
	}	


	/*
	 *	행정구역 조회	쿼리에	사용할	파라메터값	설정
	 */

	function createParameter() 
	{
		var	rdIndex;

		// 도로명 clear인	경우,	도로명	인덱스	선택 초기화

		if(dataTo.indexOf("rd_nm") !=	-1){
			var	rdIdxName	=	'rd_nm_idx'+areaIdx;
			rdIndex	=	document.getElementById(rdIdxName).value;
		}

		var	valFrom		=	document.getElementById(objFrom).value;
		var	valTo		=	document.getElementById(objTo).value;

		//	시군구>도로명, 시군구>지번주소인 경우
		//	시도코드도	가져가야함
		
		if(dataFrom == 'county' && (areaIdx == 1 || areaIdx == 3))
		{
			var cityName = 'city'+areaIdx;
			var cityVal = document.getElementById(cityName).value;
		
			valFrom = cityVal+valFrom;		
		}
		else if(dataFrom == 'town' && (areaIdx == 1 || areaIdx == 3))
		{
			var cityName	= 'city'+areaIdx;
			var countyName	= 'county'+areaIdx;
			/*
			if(cityVal=='36')
			{
				valFrom = '36110'+valFrom;
			}
			else*/
				valFrom = document.getElementById(cityName).value+document.getElementById(countyName).value+valFrom;
		}
/*
		if(dataFrom	== 'county'	&& (areaIdx	== 1 ||	areaIdx	== 3)){
			var	cityName = 'city'+areaIdx;
			var	cityVal	=	document.getElementById(cityName).value;
			valFrom	=	cityVal+valFrom;
		}else	if(dataFrom	== 'town'	&& (areaIdx	== 1 ||	areaIdx	== 3)){
			var	cityName	=	'city'+areaIdx;
			var	countyName	=	'county'+areaIdx;
			valFrom	=	document.getElementById(cityName).value+document.getElementById(countyName).value+valFrom;
		}
*/
		var	queryString	=	"from="+encodeURI(dataFrom)+"&to="+encodeURI(dataTo)+"&valFrom="+encodeURI(valFrom)+"&valTo="+encodeURI(valTo)+"&rdIndex="+encodeURI(rdIndex);


		//②세종시 예외처리
		if(encodeURI(valFrom)=='36')
		{
			valFrom	+='110';
		}
		
		return queryString;
	}	

	/*
	 *	응답을	받아 리스트를	update
	 */

	function handleStateChange() 
	{
		if(xmlHttp.readyState	== 4)	
		{
			if(xmlHttp.status ==	200) 
				updateAreaList();
				
			delete xmlHttp;
			xmlHttp	=	null;
		}
	}

	function handleStateChangeSearch() 
	{
		var	j	=	1;
		if(xmlHttp.readyState	== 2||xmlHttp.readyState ==	3)
		document.getElementById("formbox").innerHTML="--처리중입니다.--";

		if(xmlHttp.readyState	== 4)	
		{
		 	if(xmlHttp.status ==	200)
					
			var siNm			=	xmlHttp.responseXML.getElementsByTagName('siNm');
			var sggNm		=	xmlHttp.responseXML.getElementsByTagName('sggNm');
			var emdNm		=	xmlHttp.responseXML.getElementsByTagName('emdNm');
			var liNm			=	xmlHttp.responseXML.getElementsByTagName('liNm');
			var rn				=	xmlHttp.responseXML.getElementsByTagName('rn');
			var rnCd			=	xmlHttp.responseXML.getElementsByTagName('rnCd');
			var buldMnnm		=	xmlHttp.responseXML.getElementsByTagName('buldMnnm');
			var buldSlno		=	xmlHttp.responseXML.getElementsByTagName('buldSlno');
			var lnbrMnnm		=	xmlHttp.responseXML.getElementsByTagName('lnbrMnnm');
			var lnbrSlno		=	xmlHttp.responseXML.getElementsByTagName('lnbrSlno');
			var udrtYn			=	xmlHttp.responseXML.getElementsByTagName('udrtYn');
			var mtYn			=	xmlHttp.responseXML.getElementsByTagName('mtYn');
			var bdNm			=	xmlHttp.responseXML.getElementsByTagName('bdNm');		 
			var bdKd			=	xmlHttp.responseXML.getElementsByTagName('bdkd');
			var zipCl		=	xmlHttp.responseXML.getElementsByTagName('zipCl');
			var intCurrentPage		=	xmlHttp.responseXML.getElementsByTagName('intCurrentPage');
			var intCountPerPage		=	xmlHttp.responseXML.getElementsByTagName('intCountPerPage');
			var totalCount		=	xmlHttp.responseXML.getElementsByTagName('totalCount');
			var setDetailJuso = '';

			document.getElementById("formbox").innerHTML="";

			for(var	i	=	0; i < sggNm.length; i++)	
			{
				var	tempLnbr="";
				var	tempBuld="";
				var	jibun="";
				var	newaddr="";

				if(lnbrSlno[i].firstChild.nodeValue!="0")
				{
					tempLnbr=lnbrMnnm[i].firstChild.nodeValue+'-'+lnbrSlno[i].firstChild.nodeValue;
				}
				else
				{
					tempLnbr=lnbrMnnm[i].firstChild.nodeValue;
				}

				if(buldSlno[i].firstChild.nodeValue!="0")
				{
					tempBuld=buldMnnm[i].firstChild.nodeValue+'-'+buldSlno[i].firstChild.nodeValue;
				}
				else
				{
					tempBuld=buldMnnm[i].firstChild.nodeValue;
				}

				if(liNm[i].childNodes.length ==	'0')
				{
					var	temp=bdKd[i].firstChild.nodeValue;

					if(temp.substring(0,2)=='02'&&bdNm[i].childNodes.length!='0')
						setDetailJuso	=	"("+emdNm[i].firstChild.nodeValue+"，"+bdNm[i].firstChild.nodeValue+")";
					else
						setDetailJuso	=	"("+emdNm[i].firstChild.nodeValue+")";
				}

				if(siNm[i].firstChild.nodeValue=="세종특별자치시")
					newaddr	=	siNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue+'	'+tempBuld;
				else
					newaddr	=	siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+rn[i].firstChild.nodeValue+'	'+tempBuld;
				
				if(siNm[i].firstChild.nodeValue=="세종특별자치시")
					jibun	=	siNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+tempLnbr;
				else
					jibun	=	siNm[i].firstChild.nodeValue+' '+sggNm[i].firstChild.nodeValue+' '+emdNm[i].firstChild.nodeValue+' '+tempLnbr;

				if(i%2=='0')
				{
					document.getElementById("formbox").innerHTML +=	"<ul class='item'>";
					document.getElementById("formbox").innerHTML +=	"<li class='road'><a href='javascript:setParentValue(\""+	newaddr+","+setDetailJuso+","+jibun+","+zipCl[i].firstChild.nodeValue+"\")'>"+newaddr+"</a></li>";
					document.getElementById("formbox").innerHTML +=	"<li class='road'>"+jibun+"</li>";
					document.getElementById("formbox").innerHTML +=	"<li class='road'>"+zipCl[i].firstChild.nodeValue+"</li>";
					document.getElementById("formbox").innerHTML +=	"</ul>";
				}
				else
				{
					document.getElementById("formbox").innerHTML +=	"<ul class='item'>";
					document.getElementById("formbox").innerHTML +=	"<li class='road2'><a	href='javascript:setParentValue(\""+ newaddr+","+setDetailJuso+","+jibun+","+zipCl[i].firstChild.nodeValue+"\")'>"+newaddr+"</a></li>";
					document.getElementById("formbox").innerHTML +=	"<li class='road2'>"+jibun+"</li>";
					document.getElementById("formbox").innerHTML +=	"<li class='road2'>"+zipCl[i].firstChild.nodeValue+"</li>";
					document.getElementById("formbox").innerHTML +=	"</ul>";
				}
			}

			if(siNm.length>0)
				document.getElementById("formbox").innerHTML+=getPaging(intCountPerPage[0].firstChild.nodeValue,'5',totalCount[0].firstChild.nodeValue,document.check.currentPage.value,"");

			if(siNm.length=="0")
				document.getElementById("formbox").innerHTML="검색된	결과가	없습니다.";
				
			delete xmlHttp;
			xmlHttp	=	null;
		}
	}

	/*
	 *	행정구역코드 모든	리스트를 초기화
	 */

	function clearAllList()	
	{
		var	countyObj	=	document.getElementById(vCounty);
		countyObj.options.length = 0;
		countyObj.options[0] = new Option('::선택::',	'');

		clearList(to);
	}

	/*
	 *	지정된	행정구역코드 리스트를	초기화
	 */

	 function	clearList(obj) 
	 {
		if(obj !=	'' )
		{
			var	toObject = document.getElementById(obj);
			toObject.options.length	=	0;
			toObject.options[0]	=	new	Option('::선택::', '');
		}
	}

	
		
	/*
	 *	행정구역코드 리스트를	update
	 */

	function updateAreaList()	
	{
		var	toObj		=	document.getElementById(objTo);
		var	values	=	xmlHttp.responseXML.getElementsByTagName('value');
		var	names		=	xmlHttp.responseXML.getElementsByTagName('name');
		var	j	=	1;

		//	리스트	수만큼	option을	달아준다
		for(var	i	=	0; i < values.length;	i++) 
		{			
			if(isExceptArea(names[i].firstChild.nodeValue))
			{
				j	=	j	-	1;				
			}
			else
			{
				var	option = new Option(names[i].firstChild.nodeValue, values[i].firstChild.nodeValue);
				option.title = names[i].firstChild.nodeValue;
				toObj.options[i+j] = option;
			}
		}

		if(values.length=='0'&&toObj=='county1')
		{
			alert('네트워크가	원활하지 않습니다.\n\n다시선택하여 주시기를	바립니다.');
			return;
		}
	}

	function normalSearch(currentPage)
	{
		var	form = document.check;
		var	keyword	=	"";
		var	cityText='',countyText='',townText='';
		var	special_pattern	=	/['~!@#$%^&*|\\\'\'';:\.?]/gi;

		cityText=	form.city1.options[form.city1.selectedIndex].text;
		countyText = form.county1.options[form.county1.selectedIndex].text;
		townText = form.town1_oldaddr.options[form.town1_oldaddr.selectedIndex].text;

		if(form.city1.value=='') cityText='';
		if(form.county1.value=='') countyText='';
		if(form.town1_oldaddr.value=='')	townText = '';
		if(form.bdnm.value=='')	{alert("건물명을 입력하세요!"); form.bdnm.focus();	return;}

		form.engineCtpNm.value =cityText;
		form.engineSigNm.value =countyText;
		form.engineEmdNm.value =townText;
		form.engineBdNm.value	=	trim(form.bdnm.value);
		form.currentPage.value =currentPage;
		form.extend.value	=	form.extend_building.checked;

		var	url;

		if (form.extend_building.checked ==	true)	
		{	
			url	=	"./AjaxRequestXML.jsp?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=true&mode=road_search&searchType=location_buld&topTab=1&engineCtpNm="+encodeURI(cityText)+"&engineSigNm="+encodeURI(countyText)+"&engineEmdNm="+encodeURI(townText)+"&engineBdNm="+encodeURI(trim(form.bdnm.value))+"&currentPage="+currentPage);
		}
		else
		{	
			url	=	"./AjaxRequestXML.jsp?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=false&mode=road_search&searchType=location_buld&topTab=1&engineCtpNm="+encodeURI(cityText)+"&engineSigNm="+encodeURI(countyText)+"&engineEmdNm="+encodeURI(townText)+"&engineBdNm="+encodeURI(trim(form.bdnm.value))+"&currentPage="+currentPage);
		}

		createXMLHttpRequest();

		xmlHttp.onreadystatechange = handleStateChangeSearch;
		xmlHttp.open("GET",	url, true);
		xmlHttp.send(null);
	}


	function inputNumCom(obj)
	{
		var	keycode	=	event.keyCode;
		if(!((48<=keycode&&keycode<=57)||keycode==13||keycode==46))
		{
			alert('숫자만 입력가능합니다.');
			event.keyCode=0;
		}
	}

	function trim(str)
	{
		var	temp = str.replaceAll("	","");
		return temp;
	}

	function normalSearch2(currentPage)
	{
		var	url;
		var	form = document.check;
		form.currentPage.value =currentPage;

		if(currentPage =='0')	
			currentPage	=	'1';
		if(currentPage!='1')
			currentPage	=	currentPage/10;

		if (form.extend.value	== "true")
		{			 
			url	=	"./AjaxRequestXML.jsp?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=true&mode=road_search&searchType=location_buld&topTab=1&engineCtpNm="+encodeURI(form.engineCtpNm.value)+"&engineSigNm="+encodeURI(form.engineSigNm.value)+"&engineEmdNm="+encodeURI(form.engineEmdNm.value)+"&engineBdNm="+encodeURI(trim(form.engineBdNm.value))+"&currentPage="+currentPage);
		}
		else
		{ 
			url	=	"./AjaxRequestXML.jsp?getUrl="+escape("http://www.juso.go.kr/link/search.do?extend=false&mode=road_search&searchType=location_buld&topTab=1&engineCtpNm="+encodeURI(form.engineCtpNm.value)+"&engineSigNm="+encodeURI(form.engineSigNm.value)+"&engineEmdNm="+encodeURI(form.engineEmdNm.value)+"&engineBdNm="+encodeURI(trim(form.engineBdNm.value))+"&currentPage="+currentPage);
		}

		createXMLHttpRequest();

		xmlHttp.onreadystatechange = handleStateChangeSearch;
		xmlHttp.open("GET",	url, true);
		xmlHttp.send(null);
	}


	/* 
	 fListScale	:	한페이지 출력할 게시물수
	 fPageScale	:	페이지수를	표시할	갯수 
	 fTotal	:	전체 게시물수	
	 fStart	:	리스트를 뿌릴	시작점(최근게시물로 order by	해서 뽑아	내는 자료라면	가장 최근	자료가	0번이	됨	
	 fPagingUrl	:	클릭시	넘어갈	페이지	
	 */	

	function	getPaging(fListScale,fPageScale,fTotal,fStart,fPagingUrl)	
	{	
		var	fReturn	=	"";	
		var	fPage; 
		var	fPP; 
		var	fNP; 
		var	fPreStart; 
		var	fLn; 
		var	fVk; 
		var	fNstart; 
		var	fLast; 

		if(fTotal	>	fListScale)	
		{	
			fPage	=	 Math.floor(fStart/(fListScale*fPageScale)); 
			fReturn	=	fReturn	+	"<table	border='0' cellpadding='0' cellspacing='1' align='center'><tr><td	align='center' class='paging'> ";	
			fPP=fStart-fListScale; 
			fNP=fStart+fListScale	;	

			// 처음으로	이동 
			if(fPP>=0) 
			{ 
				fReturn = fReturn + " <a	href='javascript:normalSearch2(1)'>처음</a>	"; 
			} 

			 /*
			// sPageScale	만큼 앞으로 이동	
			if(	fStart+1 >	fListScale*fPageScale	)	
			{	
				fPreStart	=	fListScale*(fPage*fPageScale - 1); 
				fReturn	 = fReturn + "<a href='javascript:normalSearch2("	+	Math.floor(fPreStart)	+	")'>이전</a> ";	
			}	

			 */
			// sPageScale	만큼 출력	
			for(i=0; i < fPageScale	;	i++)
			{ 
				fLn	=	(fPage * fPageScale	+	i)*fListScale; 
				fVk= fPage * fPageScale	+	i+1; 

				if(fLn<fTotal) 
				{ 
					if(fLn!=fStart)
					{		
						fReturn	 = fReturn + " <a	href='javascript:normalSearch2(" + fLn + ")'>" + fVk + "</a> ";
					}	
					else 
					{ 
						fReturn	 = fReturn + " <span>" + fVk + "</span>	";		
					} 
				}	
			}	
 

			// sPageScale	만큼 뒤로	이동 
			if(fTotal	>	((fPage+1)*fListScale*fPageScale)) 
			{ 
				fNstart=(fPage+1)*fListScale*fPageScale; 
				fReturn	 = fReturn + " <a	href='javascript:normalSearch2(" + fNstart+	")'>다음</a> ";	
			}	

			// 마지막 페이지
			/* 

			if(fNP<fTotal) 
			{ 
				fLast	=	(Math.floor(fTotal/fListScale))*fListScale;	
				fReturn	 = fReturn + "<a href='javascript:normalSearch2("	+	fLast+ ")'>마지막</a> ";	
			}	
			*/

			fReturn	 = fReturn + "</td></tr></table>"; 
		}	

		return fReturn;	
	}	
		

	/*
		회원가입창으로	파라미터 전송
	*/

	 function setParentValue(newaddr,setDetailJuso, jibunaddr, postcd)
	 {
		var	result = newaddr.split(",");
	
		document.getElementById("formbox").innerHTML ="";	
		document.getElementById("formbox").innerHTML +=	"<li class='popuproad'>도로명주소 :&nbsp;<input type='text' style='inputroad' value='"+result[0]+"' readOnly></input></li>";
		document.getElementById("formbox").innerHTML +=	"<li class='popuproad'>&nbsp;&nbsp;&nbsp;&nbsp;상세주소	:&nbsp;<input	type='text'	id='detail'	name ='detail' /></li>";
		document.getElementById("formbox").innerHTML +=	"<li class='popuproad'>&nbsp;&nbsp;&nbsp;&nbsp;참고항목	:&nbsp;<input	type='text'	value="+result[1]+" readOnly></input></li>";
		document.getElementById("formbox").innerHTML +=	"<li class='popuproad'>※상세주소 : 동·층·호</li>";
		document.getElementById("formbox").innerHTML +=	"<li class='popuproad'>※참고항목 :(법정동,공동주택명)</li>";

	/*
		지번주소와	같이 저장가능하도록 추가. 2012.08.30	이준환
		document.getElementById("formbox").innerHTML +=	"<li class='popuproad'>&nbsp;&nbsp;&nbsp;&nbsp;지번주소	:&nbsp;<input	type='text'	style='inputroad'	value='"+result[2]+"'></input></li>";
		document.getElementById("formbox").innerHTML +=	"<li class='popuproad'>&nbsp;&nbsp;&nbsp;&nbsp;우편번호	:&nbsp;<input	type='text'	value="+result[3]+"></input></li>";
	*/
		document.getElementById("formbox").innerHTML +=	"<br/><li	class='road'><a	href='javascript:setOpenerValue(\""+newaddr+"\")'>해당자료 입력</a></li>";
		
	 }


	function setOpenerValue(newaddr)
	{
		var	form = document.check;
		var result = newaddr.split(",");

		/* window.opener.document.getElementById("newAddr1").value	=	result[0];
		window.opener.document.getElementById("newAddr2").value 	= 	document.getElementById("detail").value+""+result[1];
		window.opener.document.getElementById("zipcode1").value	=	result[3].substring(0, 3);
		window.opener.document.getElementById("zipcode2").value	=	result[3].substring(4, 7); */				window.opener.document.getElementById("<%=address1%>").value	=	result[0];		window.opener.document.getElementById("<%=address2%>").value 	= 	document.getElementById("detail").value+""+result[1];		window.opener.document.getElementById("<%=zipCode1%>").value	=	result[3].substring(0, 3);		window.opener.document.getElementById("<%=zipCode2%>").value	=	result[3].substring(4, 7);
		//window.opener.document.getElementById("mbdmngno").value	=	"0000000000000000000000000";
		window.close();
	}
	
	 //
	function selectSearch(mode) 
	{
	 	var form = document.check;
		
		if (mode == 'road')
		{
			document.location.href = "./road.jsp?zipCode1=<%=zipCode1%>&zipCode2=<%=zipCode2%>&address1=<%=address1%>&address2=<%=address2%>";
		}
		else if(mode =='jibun')
		{
			document.location.href = "./jibun.jsp?zipCode1=<%=zipCode1%>&zipCode2=<%=zipCode2%>&address1=<%=address1%>&address2=<%=address2%>";
		}
		else if(mode=='sangho')
		{
			document.location.href = "./sangho.jsp?zipCode1=<%=zipCode1%>&zipCode2=<%=zipCode2%>&address1=<%=address1%>&address2=<%=address2%>";
		}	
	}
	

</script>

</head>

<body>
<div id="wrapper">
	<div id="header">
		<h1>
			<img src="/resources/images/common/newzip/h1.jpg" alt="도로명주소찾기(우편번호)">
		</h1>
	</div>
	<div id="container">
		<div id="content">
			<ul	class="tab">
				<li><a href="#n" onclick="selectSearch('road');return	false;"><img src="/resources/images/common/newzip/tab1_off.gif" alt="도로명주소"/></a></li>
				<li><a href="#n" onclick="selectSearch('jibun');return false;"><img	src="/resources/images/common/newzip/tab2_off.gif"	alt="지번"/></a></li>
				<li><a href="#n" onclick="selectSearch('sangho');return	false;"><img src="/resources/images/common/newzip/tab3.gif" alt="건물명"/></a></li>
			</ul>

			<form	name="check" method="post">
			<input type="hidden" name="searchType" id="searchType" value ="" />
			<input type="hidden" name="san1" id="san1"	value="0"/>
			<input type="hidden" name="extend"			id="extend"				value="${extend}"/>
			<input type="hidden" name="engineCtpNm"	id="engineCtpNm"	value="${engineCtpNm}"/>
			<input type="hidden" name="engineSigNm"	id="engineSigNm"	value="${engineSigNm}"/>
			<input type="hidden" name="engineEmdNm"	id="engineEmdNm"	value="${engineEmdNm}"/>
			<input type="hidden" name="engineLiNm" id="engineLiNm"	value="${engineLiNm}"/>
			<input type="hidden" name="engineBdNm" id="engineBdNm"	value="${engineBdNm}"/>
			<input type="hidden" name="engineRdNm" id="engineRdNm"	value="${engineRdNm}"/>
			<input type="hidden" name="engineMtYn" id="engineMtYn"	value="${engineMtYn}"/>
			<input type="hidden" name="engineBdMaSn" id="engineBdMaSn"	value="${engineBdMaSn}"/>
			<input type="hidden" name="engineBdSbSn" id="engineBdSbSn"	value="${engineBdSbSn}"/>
			<input type="hidden" name="currentPage"	id="currentPage"	value="${currentPage}"/>
					
			<div class="form"	id="formbox">
				<fieldset>
				<legend>정보 입력</legend>
				<p class="input" style="margin-left:17px">
					<label for="bd_number1"><strong>건&nbsp;&nbsp;물&nbsp;&nbsp;명</strong></label>
					<input type="text" name="bdnm" value=""	id="bdnm"	class="text" style="width:105px; ime-mode:active;" />
					<input type="checkbox" name="extend_building"	value="" id="extend_building"	/>
					<label for="ck_search">확장검색</label>
				 </p>
				<div class="group">
					<p class="input">
						<label for="siCode"><strong>시&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;도</strong></label>
						<select	title="시/도 선택"	name="city1" onchange="javascript:changeAreaList(1,	this);"	id="city1" style="width:185px">
							<option	value="">::선택::</option>
							<option	value="11" title="서울특별시" >서울특별시</option>
							<option	value="42" title="강원도" >강원도</option>
							<option	value="41" title="경기도">경기도</option>
							<option	value="48" title="경상남도"	>경상남도</option>
							<option	value="47" title="경상북도"	>경상북도</option>
							<option	value="46" title="전라남도"	>전라남도</option>
							<option	value="45" title="전라북도"	>전라북도</option>
							<option	value="44" title="충청남도"	>충청남도</option>
							<option	value="43" title="충청북도"	>충청북도</option>
							<option	value="29" title="광주광역시" >광주광역시</option>
							<option	value="27" title="대구광역시" >대구광역시</option>
							<option	value="30" title="대전광역시" >대전광역시</option>
							<option	value="26" title="부산광역시" >부산광역시</option>
							<option	value="31" title="울산광역시" >울산광역시</option>
							<option	value="28" title="인천광역시" >인천광역시</option>
							<option	value="36" title="세종특별자치시" >세종특별자치시</option>
							<option	value="50" title="제주특별자치도" >제주특별자치도</option>
						</select>
					</p>

					<p class="input">
						<label for="siCode2"><strong>시&nbsp;&nbsp;군&nbsp;&nbsp;구</strong></label>
						<select	title="시/군/구 선택"	name="county1" id="county1"	style="width:185px"	onchange="javascript:changeAreaList(1, this);">
							<option	value="">::선택::</option>
							<!--<c:forEach items="${county}" var="county">
							<option	value="${county.countyId}">${county.countyName}</option>
							</c:forEach>-->						
						</select>
					</p>

					<p class="input">
						<label for="siCode3"><strong>읍&nbsp;&nbsp;면&nbsp;&nbsp;동</strong></label>
						<select	id="town1_oldaddr" name="town1_oldaddr"	title="지번주소" style="width:185px">	
							<option	value="">::선택::</option>
							<!--<c:forEach items="${town}" var="county">
							<option	value="${town.townId}" >${town.townName	}</option>
							</c:forEach>-->									
						</select>
					</p>
				</div>
				<div class="btn">
					<a href="#"><img src="/resources/images/common/newzip/btn_search.gif" alt="검색"	onclick="normalSearch('1');return	false;"	/></a>
				</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>

</body>

</html>