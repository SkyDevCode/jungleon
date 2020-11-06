$(document).on('ready', function() {
	// fixed header
	var sub_header_fixed = $(".header__wrap").hasClass("main_header__wrap");
	if (sub_header_fixed == false){
		$(window).on("scroll",function(){
			var st = $(window).scrollTop();
			if (st > 0) {
				$(".header__wrap").addClass("header_fixed");
			} else {
				$(".header__wrap").removeClass("header_fixed");
			}
		});
	}

	// 다국어 사이트
	$(".web_language_btn").on("click",function(){
		$(this).next(".item-language_list").slideToggle();
		$(this).toggleClass("on");
	});

	// gnb
	if($(window).width() <= 1240){
		gnbMobile();
	}else{
		gnbWeb();
	}

	// mobile
	$(".mobile_menu_open button").on("click",function(){
		$("html").addClass('no_scroll');
		$(".header__wrap--bottom").addClass('active');
	});
	$(".mobile_menu_close").on("click",function(){
		$("html").removeClass('no_scroll');
		$(".header__wrap--bottom").removeClass('active');
		$(".gnb_dep3_open").removeClass('on');
		$(".gnb_dep3_open").next().slideUp();
	});
	$(".mobile_language_btn").on("click",function(){
		var mb_language = $(this).next(".item-language_list").css("display");
		if (mb_language == "none"){
			$(this).next(".item-language_list").slideDown();
			$(this).addClass("on");
		}else{
			$(this).next(".item-language_list").slideUp();
			$(this).removeClass("on");
		}
	});
	$(".search_mb_open").on("click",function(){
		if ($(this).hasClass("close")){;
			$(this).removeClass("close");
			$(".search-form_wrap").fadeOut(200);
		} else {
			$(this).addClass("close");
			$(".search-form_wrap").fadeIn(200)
		}
	});
});

$(window).resize(function() {
	if($(window).width() < 1240){
		gnbMobile();
	}else{
		gnbWeb();
	}
});

var p_gnbOff = '.header__wrap--bottom';// gnb off되는 영역 (pc)
var gnbOn = '.gnb_depth1 > li > a';//gnb on (pc, mobile 공통)

function gnbWeb() {
	$(gnbOn).off().on('mouseover focus',function(e){
		$('.gnb_depth1 > li').not($(this)).removeClass('gnb_over');
		$('.gnb_depth1 .gnb_depth2_item').not($(this).next()).fadeOut(200);
		$(this).parent().addClass('gnb_over');
		$(this).next('.gnb_depth2_item').fadeIn(200);
	});
	$(p_gnbOff).on('mouseleave',function(e){
		$('.gnb_depth1 > li').removeClass('gnb_over');
		$('.gnb_depth1 .gnb_depth2_item').fadeOut(200);
	});
	$(".open_all_menu > a").on('focus',function(e){
		$('.gnb_depth1 > li').removeClass('gnb_over');
		$('.gnb_depth1 .gnb_depth2_item').fadeOut(200);
	});
	/*$("*").not(".gnb_wrap, .gnb_wrap *").on("mouseover", function(e){
		$('.gnb_depth1 > li').removeClass('gnb_over');
		$('.gnb_depth1 .gnb_depth2_item').fadeOut(200);
	});*/
	$(".gnb_dep4_open").off().on("click",function(e){
		e.preventDefault();
		if($(this).hasClass('on')) {
			$(this).removeClass('on');
			$(this).next().slideUp();
		} else {
			$(".gnb_dep4_open").removeClass('on');
			$(".gnb_dep4_open").next().slideUp();
			$(this).addClass('on');
			$(this).next().slideDown();
		}
	});
}

function gnbMobile() {
	$(p_gnbOff).unbind('mouseleave');

	$(gnbOn).off().on('click',function(e){
		e.preventDefault();
		$(gnbOn).removeClass('on');
		$('.gnb_depth2_item').removeClass('on').hide();
		$(this).addClass('on');
		$(this).next('.gnb_depth2_item').addClass('on').show();
	});
	$(".gnb_dep3_open").off().on("click",function(e){
		e.preventDefault();
		if($(this).hasClass('on')) {
			$(this).removeClass('on');
			$(this).next().slideUp();
		} else {
			$(".gnb_dep3_open").removeClass('on');
			$(".gnb_dep3_open").next().slideUp();
			$(this).addClass('on');
			$(this).next().slideDown();
		}
	});
}