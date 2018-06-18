var page = require('webpage').create(),
	system = require('system'),
	address, filename,orienttype;

if (system.args.length < 5) {
	console.log('Usage: capture.js <some URL> <some FILENAME> <some oType> <some width> <some height>');
	phantom.exit();
}

address = system.args[1];
filename = system.args[2];
orienttype = system.args[3];
widthsize = system.args[4];
heightsize = system.args[5];

var viewportSize = {width: widthsize, height: heightsize * (2339/1654)};
//page.viewportSize = viewportSize;
page.viewportSize = {width: 1024, height: 768};	// PhantomJS에서 화면을 어떤 사이즈로 출력할 것인지에 대한 값 : 미디어 쿼리도 동작

var pageSize = {
	format: 'A4',
	orientation: orienttype,
	margin: {
		top: '1.0cm',
		bottom: '1.0cm',
		left: '1.5cm',
		right: '1.5cm'
	}
};
pageSize.width = (viewportSize.width) + 'px';
pageSize.height = (viewportSize.height) + 'px';
page.paperSize = pageSize;

page.onLoadFinished = function() {
	setTimeout(function () {
		//서버용
		//page.render('/home/KIOM_RS/_storedfiles/capture/' + filename);
		//로컬용
		page.render('D:/attach/capture/' + filename);
		phantom.exit();
	}, 0);
};

page.open(address, function(status) {
	page.evaluate(function () {
		// 폰트 문제로 사용가능한 폰트로 교체
		var cssCode = 'html body, html body * { font-family:"바탕체",sans-serif !important; }';// html { zoom: 1; }
		var styleElement = document.createElement("style");
		styleElement.type = "text/css";
		if (styleElement.styleSheet) {
			styleElement.styleSheet.cssText = cssCode;
		} else {
			styleElement.appendChild(document.createTextNode(cssCode));
		}
		document.getElementsByTagName("head")[0].appendChild(styleElement);
	});

	if(status !== 'success') {
		console.log('Cannot open site');
		phantom.exit();
	}
});