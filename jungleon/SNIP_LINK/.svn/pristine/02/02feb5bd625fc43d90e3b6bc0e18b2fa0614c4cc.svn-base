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
	mainSlider('.m_startup_list','3','2','2',false,true,false); 
	mainSlider('.m_cooperative_list','4','3','2',false,true,false); 
	

	$('.main_visual_list').slick({
		//autoplay:true,
		autoplaySpeed:3000,
		speed:500,
		slidesToShow: 1,
		dots:true
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
	//main_tab(".main-mission_item_title", ".main-mission_item_cont");

	function mainEn_tab(en_tab_title){
		var en_tab_title = $(en_tab_title);
		en_tab_title.on("click",function(){
			$(en_tab_title).parent(".main_tabCont").removeClass("tabOn");
			var en_tab_title_idx = $(this).parent(".main_tabCont").addClass("tabOn");
			$(".main_btm_list").hide();
			$(".tabOn .main_btm_list").show();
		});
	}
	mainEn_tab(".main_tab_title");
	
	/*
	$(window).resize(function(){
		var win_w = $(window).width();
		if (win_w > 768){
			$('.main_visual_list').slick('refresh');
		}
	});
	*/

});