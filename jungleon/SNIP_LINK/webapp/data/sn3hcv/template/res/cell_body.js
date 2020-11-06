// Todo... 차트 관련 변수를 채워야함
// cell_body.js
console.log ( 'cell_body.js' );
var	chart_startIdx = 0;
var	chart_endIdx = 0;
var	chart_svgPath = '';

function initDefault() {

}

// CHART
localSynap.chart_startIdx = 0;
localSynap.chart_endIdx = 0;
localSynap.chart_svgPath = '';
localSynap.browser_height = null;
localSynap.interval_id = null;

localSynap.updateChartInfo = function(startIdx, endIdx, svgPath) {
	localSynap.chart_startIdx = startIdx;
	localSynap.chart_endIdx = endIdx;
	localSynap.chart_svgPath = svgPath;
};

window.onload = function() {
	//getInnerHeight -> docviewer.js=>synapScroll.js
	localSynap.browser_height = window.innerHeight;
	if (localSynap.browser_height == undefined) {
		localSynap.browser_height = screen.height;
	}

	if (BROWSER.MOBILE.isIOS()) {
		localSynap.browser_height *= 1.5; // iOS 일 경우 scale 문제로 1.5배 적용
	}

	if (localSynap.chart_endIdx != 0){
		localSynap.interval_id = window.setInterval(localSynap.scrolling_chart, 1000);
	}
};

localSynap.interval_chart = function() {
	var i = localSynap.chart_startIdx;
	var chart_id = "chart"+i;
	var chart_obj = document.getElementById(chart_id);

	if (chart_obj != undefined) {
		var url = chart_id + '.xml.svg';
		if(chart_svgPath!="") {
			url = chart_svgPath + '/' + url;
		}

		var chart_top    = chart_obj.offsetTop;
		var chart_width  = chart_obj.offsetWidth;
		var chart_height = chart_obj.offsetHeight;

		localSynap.dynamic_loding_chart(chart_obj, chart_width, chart_height, url);
	}

	localSynap.chart_startIdx += 1;
	if (localSynap.chart_startIdx > localSynap.chart_endIdx) {
		window.clearInterval(localSynap.interval_id);
	}
};

localSynap.scrolling_chart = function() {
	var now_scroll = $(document).scrollTop();

	for(var i = localSynap.chart_startIdx; i <= localSynap.chart_endIdx; i++) {
		var chart_id = "chart"+i;
		var chart_obj = document.getElementById(chart_id);
		if (chart_obj != undefined) {
			var url = chart_id + '.xml.svg';
			if(chart_svgPath!="") {
				url = chart_svgPath + '/' + url;
			}

			var chart_top    = chart_obj.offsetTop;
			var chart_width  = chart_obj.offsetWidth;
			var chart_height = chart_obj.offsetHeight;

			if (chart_top > now_scroll - localSynap.browser_height && chart_top < now_scroll + localSynap.browser_height) {
				localSynap.dynamic_loding_chart(chart_obj, chart_width, chart_height, url);
			}
		}
	}

	if($('.synap_loading_chart').length == 0) {
		window.clearInterval(localSynap.interval_id);
	}
};

localSynap.dynamic_loding_chart = function(chart_obj, width, height, url) {
	// 차트 동적 로딩 IE object 태그 제거
	if ($(chart_obj).attr('class') == "synap_loading_chart") {
		chart_obj.innerHTML = "<object type='image/svg+xml' class='svg' width='"+(width+1)+"px' height='"+(height+1)+"px' align='middle' data='"+url+"'></object>";
		$(chart_obj).attr('class','');
	}
};

localSynap.killCopyContent = function() {
	var mainTable = document.getElementById('mainTable');
	stopBrowserEvent(mainTable);
};

localSynap.updateValid = function() {
	var loadCellMaximum = 100;
	
	var $td = $('#mainTable').find('table td');
	var length = $td.length;
	var loadCell = function(s , e){
		return function(){
			if( s >= length ) {
				localSynap.onLoadedBody && localSynap.onLoadedBody();
				return;
			}
			if( e >= length ) e = length;
			for( var j = s ; j < e ; j ++ ){
				if( $td.eq(j).width() === 0 ){
					$td.eq(j).find('span').css('white-space', 'nowrap');
				}
			}
			setTimeout(loadCell(s + loadCellMaximum, e + loadCellMaximum), 10);
		}
	};
	loadCell(0, loadCellMaximum)();
};

localSynap.contentReadyFunc = function() {
	if(jsValue != "") {
		if(!(BROWSER.PC.isIE() && BROWSER.VERSION.IE()<=9)) {
			wmXml();
		}
		else {
			$("body").empty();
			return;
		}
	}

	window.onscroll = function(e){
		localSynap.onScroll && localSynap.onScroll(e);
	}

	if (!(typeof localSynap.updateValid == "undefined")) {
		localSynap.updateValid();
	}
	initDefault();
	if (!(typeof localSynap.updateChartInfo == "undefined")) {
		localSynap.updateChartInfo(chart_startIdx, chart_endIdx, chart_svgPath);	
	}
	
	if( localSynap.config && !localSynap.config.allowCopy ){
		localSynap.killCopyContent();
	}
	
	localSynap.bodyReadySkinFunc && localSynap.bodyReadySkinFunc();
};

function wmXml() {
	wm.decrypt(jsValue, "cell");
	wm.setRepeat(true);
}

function appendWM() {
	localSynap.mark = wm.getWM();
	if(localSynap.mark != null) {
		var boardWidth = $("#mainTable").width();
		var boardHeight = $("#mainTable").height();
		
		var maxLength = 4000;
		var originWidth = boardWidth;
		var originHeight = boardHeight;

		var top = 0;
		var left = 0;

		var repeatWidth = originWidth > maxLength ? maxLength : boardWidth;
		var repeatHeight = originHeight > maxLength ? maxLength : boardHeight;

		appendWB = function(parentNode, isRepeat) {
			var clone = wm.makeWB(repeatWidth,repeatHeight, isRepeat);
			$(clone).css("top",top).css("left",left);
			$(parentNode).append(clone);
			boardWidth -= repeatWidth;
			left += repeatWidth;
		};

		repeatBoard = function() {
			var fragment = document.createDocumentFragment();
			while(boardHeight > 0) {
				while(boardWidth > 0) {
					if(boardWidth < repeatWidth) {
						repeatWidth = boardWidth;
					}
					if(boardHeight < repeatHeight) {
						repeatHeight = boardHeight;
					}
					appendWB(fragment, true);
				}
				boardHeight -= repeatHeight;
				left = 0;
				boardWidth = originWidth;
				repeatWidth = originWidth > maxLength ? maxLength : boardWidth;
				top += repeatHeight
			}
			$("#container").append(fragment);
		};

		//먼저 보이는 영역부터 생성한다.
		var container = document.getElementById("container");
		appendWB(container, false);

		setTimeout(function() {
			repeatBoard();
		},1000);
	}
}

// DOCUMENT READY FUNC
$(document).ready(function() {
	localSynap.contentReadyFunc();
	if(jsValue!=""){
		if(!(BROWSER.PC.isIE() && BROWSER.VERSION.IE()<=9)) {
			appendWM();
			$("#mainTable").css("visibility","visible");
		}
		else {
			alert("Not support current browser");
		}
	}
});
