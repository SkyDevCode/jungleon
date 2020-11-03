function mainSlider(item, show, break1, break2, fade, autoplay, dots) {
	var slideWrap = $(item).closest('.rolling-slide');
	var prevBtn = slideWrap.find('.slick-prev');
	var nextBtn = slideWrap.find('.slick-next');
	var stopBtn = slideWrap.find('.slick-stop');
	var playBtn = slideWrap.find('.slick-play');
	
	$(item).slick({
		slidesToShow:show,
		autoplaySpeed:5000,
		//speed:2000,
		pauseOnHover: false,
		prevArrow: prevBtn,
		nextArrow: nextBtn,
		dots: dots,
		fade: fade,
		autoplay:autoplay,
		responsive: [
			{
				breakpoint: 1000,
				settings: {
					slidesToShow:break1
				}
			},
			{
				breakpoint: 480,
				settings: {
					slidesToShow:break2
				}
			}
			]
	});
	/*control*/
	$(stopBtn).on('click', function() {
		$(item).slick('slickPause');
		$(this).hide();
		$(playBtn).show();
	});
	$(playBtn).on('click', function() {
		$(item).slick('slickPlay');
		$(this).hide();
		$(stopBtn).show();
	});
}
$(document).ready(function () {

	/* main slide banner*/ 
	mainSlider('.main_mission_step_list_1','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_2','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_3','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_4','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_5','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_6','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_7','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_8','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_9','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_10','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_11','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_12','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_13','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_14','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_15','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_16','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_17','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_18','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_19','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_mission_step_list_20','5','3','2',false,true,false); //성남산업진흥원 사업미션
	mainSlider('.main_business-list','4','2','2',false,true,true); //성남산업진흥원 핵심사업
	mainSlider('.main_library-list','4','2','2',false,true,true); //성남산업진흥원 전자도서관

	$('.main-visual_list .rolling-slide').slick({
		centerMode: true,
		autoplay:true,
		autoplaySpeed:3000,
		speed:500,
		centerPadding: '200px',
		slidesToShow: 1,
		responsive: [
		{
		  breakpoint: 1240,
		  settings: {
			arrows: true,
			centerMode: true,
			centerPadding: '0',
			slidesToShow: 1
		  }
		},
		{
		  breakpoint: 768,
		  settings: {
			arrows: true,
			centerMode: true,
			centerPadding: '0',
			slidesToShow: 1,
			dots : true
		  }
		}
	  ]
	});

	$(document).ready(function() {
		$('#fullpage').fullpage({
			//sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff'],
			anchors: ['main-section_1', 'main-section_2', 'main-section_3', 'main-section_4', 'main-section_5','main-section_6'],
			menu: '#menu',
			responsiveWidth: 1024
			
		});
	});


	function main_tab(tabTit, tabCont){
		var tabBtn = $(tabTit);
		var tabCont = $(tabCont);
		tabBtn.on("click",function(){
			var tabTit_idx = tabBtn.index(this);
			var tabCont_idx = tabCont.eq(tabTit_idx);
			tabBtn.removeClass("tabOn");
			tabCont.removeClass("tabOn");
			tabCont.eq(tabTit_idx).addClass("tabOn");
			$(this).addClass("tabOn");
			tabCont.find('.slick-slider').slick('refresh');
		});
	}
	main_tab(".main-mission_item_title", ".main-mission_item_cont");
	main_tab(".main-mission_item_titleA", ".main-mission_item_contA");
	main_tab(".main-mission_item_titleB", ".main-mission_item_contB");
	main_tab(".main-mission_item_titleC", ".main-mission_item_contC");
	main_tab(".main-mission_step_title", ".main-mission_item");
	main_tab(".main_mission_title", ".main-mission_cont");
	main_tab(".m_sns_title", ".m_sns_cont");


	/* 스크롤 이동
	var windowH = $(window).height();
	$(window).on('load scroll resize',function(){
		if($(window).width() > 1000) {
			$('.main-visual .slide-con').css('height',windowH)
			$('.sc-box').not('.footer-wrap').css('height',windowH)
			scrollSection();
		}else {
			$('.main-visual .slide-con').css('height','500px')
			$('.sc-box').not('.footer-wrap').css('height','auto')
			$('.sc-box').off('mousewheel DOMMouseScroll');
		}

		$(".main-anchor li").on("click",function(){
			var anchor_idx = $(this).find("a").attr("href");
			var anchor_top = $(anchor_idx).offset().top;
			console.log(anchor_top);
			$("body,html").animate({"scrollTop":anchor_top+"px"},600);
			return false;
		});
	});
	function scrollSection() {
		var elm = ".sc-box";
		$(elm).each(function (index) {
			// 개별적으로 Wheel 이벤트 적용
			$(this).on("mousewheel DOMMouseScroll", function (e) {
				e.preventDefault();
				var delta = 0;
				if (!event) event = window.event;
				if (event.wheelDelta) {
					delta = event.wheelDelta / 120;
					if (window.opera) delta = -delta;
				} 
				else if (event.detail)
					delta = -event.detail / 3;
				var moveTop = $(window).scrollTop();
				var elmSelecter = $(elm).eq(index);
				// 마우스휠을 위에서 아래로
				if (delta < 0) {
					if ($(elmSelecter).next() != undefined) {
						try{
							moveTop = $(elmSelecter).next().offset().top;
							$(elmSelecter).removeClass("sc_on");
							$(elmSelecter).next().addClass("sc_on");
						}catch(e){}
					}
				// 마우스휠을 아래에서 위로
				} else {
					if ($(elmSelecter).prev() != undefined) {
						try{
							moveTop = $(elmSelecter).prev().offset().top;
							$(elmSelecter).removeClass("sc_on");
							$(elmSelecter).prev().addClass("sc_on");
						}catch(e){}
					}
				}
				
				// 화면 이동 0.8초(800)
				if(!$('body').hasClass('scroll')){
				    //check_animate1 = true;	
					$('body').addClass('scroll')
				   $("html,body").stop().animate({
						scrollTop: moveTop + 'px'
					}, {
						duration: 800, complete: function () {
							//check_animate1 = false;
							$('body').removeClass('scroll')
						}
					});
				}
			});
			
		});
	}
	*/
});