$(document).on('ready', function() {

    // drop toggle
    function dropToggle() {
        var dropBtn = $('.drop .drop-btn');
        dropBtn.on('click',function(){
            $(this).toggleClass('on');
            $(this).closest('.drop').siblings().find('.drop-btn').removeClass('on');
            $(this).closest('.drop').siblings().find('.drop-list').slideUp();
            $(this).closest('.drop').find('.drop-list').slideToggle('fast');
        });
    }
    dropToggle();

    // sitemap toggle
    function sitemap_Toggle() {
        var sitemap_open = $('.sitemap_open');
		sitemap_open.on("click",function(){
			var dep4_cont = $(this).next(".sitemap_submenu").css("display");
			if (dep4_cont == "none"){
				$(this).next(".sitemap_submenu").slideDown(200);
				$(this).addClass("on");
				$(this).attr("alt","하위메뉴 닫기");
			}else{
				$(this).next(".sitemap_submenu").slideUp(200);
				$(this).removeClass("on");
				$(this).attr("alt","하위메뉴 열기");
			}
			return false;
		});
    }
    sitemap_Toggle();

    // main tab
    function mainTab() {
        var tabBtn = $('.main-tab-nav li a');
        tabBtn.on('click',function(e){
            e.preventDefault();
            var tabCon = $(this).attr('href');
            $(tabCon).attr('tabindex',0).focus();
            
            $(this).parent().siblings().removeClass('on');
            $(this).parent().addClass('on');
            $(this).closest('.main-tab').find('.main-tab-con > div').removeClass('on');
            $(tabCon).addClass('on');
            $('.main-tab .slick-slider').slick('refresh');
        });
    }
    mainTab();

    // slick-slider
    $('.slider').slick({
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear'
    });

    // partner slider
    function partnerSlide(item) {
        var slideWrap = $(item).closest('.slide');
        var prevBtn = slideWrap.find('.slick-prev');
        var nextBtn = slideWrap.find('.slick-next');
        var stopBtn = slideWrap.find('.slick-stop');
        var playBtn = slideWrap.find('.slick-play');

        $(item).slick({
            slidesToShow:6,
            autoplaySpeed:6000,
            //speed:2000,
            infinite:true,
            prevArrow: prevBtn,
            nextArrow: nextBtn,
            autoplay:true,
            responsive: [
                {
                  breakpoint: 1240,
                  settings: {
                    slidesToShow:5
                  }
                },
                {
                  breakpoint: 1000,
                  settings: {
                    slidesToShow:4
                  }
                },
				{
                  breakpoint: 768,
                  settings: {
                    slidesToShow:3
                  }
                },
                {
                  breakpoint: 520,
                  settings: {
                    slidesToShow:2
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
    partnerSlide('.family_site_list');

    // gallery view slider
    function gallerViewSlide(item) {
        var slideWrap = $(item).closest('.slide');
        var prevBtn = slideWrap.find('.slick-prev');
        var nextBtn = slideWrap.find('.slick-next');
        var stopBtn = slideWrap.find('.slick-stop');
        var playBtn = slideWrap.find('.slick-play');

        $(item).slick({
            autoplaySpeed:6000,
            //speed:2000,
            infinite:true,
            prevArrow: prevBtn,
            nextArrow: nextBtn,
            autoplay:true
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
    gallerViewSlide('.gallery-view_rolling_list');
    gallerViewSlide('.business_guide_slide_list');

	//sub_tab 
	function sub_tab(tabTit, tabCont){
		var tabBtn = $(tabTit);
		var tabCont = $(tabCont);
		tabBtn.on("click",function(){
			var tabTit_idx = tabBtn.index(this);
			var tabCont_idx = tabCont.eq(tabTit_idx);
			tabBtn.removeClass("tabOn");
			tabCont.removeClass("tabOn");
			tabCont.eq(tabTit_idx).addClass("tabOn");
			$(this).addClass("tabOn");
			//tabCont.find('.slick-slider').slick('refresh');
			//console.log(tabBtn);
			return false;
		});
	}

	// dep4_menu_slider
	function dep4Menu_slider(item, infinite) {
        var slideWrap = $(item).closest('.slide');
        var prevBtn = slideWrap.find('.slick-prev');
        var nextBtn = slideWrap.find('.slick-next');

        $(item).slick({
            infinite:infinite,
			slidesToShow: 1,
			//centerMode: true,
			//centerPadding: 0,
			variableWidth: true,
            prevArrow: prevBtn,
            nextArrow: nextBtn
        });
    }

	dep4Menu_slider(".advisory_committee_title", true);

	function dep5Menu_slider(item, infinite) {
        var slideWrap = $(item).closest('.slide');
        //var prevBtn = slideWrap.find('.slick-prev');
        //var nextBtn = slideWrap.find('.slick-next');

        $(item).slick({
            infinite:infinite,
			slidesToShow: 1,
			//centerMode: true,
			//centerPadding: 0,
			variableWidth: true,
            arrows:true
        });
    }
	dep5Menu_slider(".depth5Menu_list", false);

	$(".sub-tab__4dep").each(function(){
		var win_w = $(".subcont").width();
		var page_tab = $(this).hasClass("sub-tab__pageTab");

		var totalWidth = 0;
		var set = $(this).find('.menu');
		set.each(function(){
			totalWidth = totalWidth + $(this).width();
		});
		console.log(win_w, totalWidth);
		$(".sub-tab__smenu").not(".active .sub-tab__smenu").css("display","none");
		if (page_tab  == false){
			var sub_tab_idx = $(this).index();
			var sub_tab_4dep = $(this).find(".sub-tab__4dep_list>div").length;
			$(this).addClass("tab_4dep_"+sub_tab_4dep);

			if (totalWidth < win_w){
				$(this).addClass("tab_4dep_"+sub_tab_4dep);
				}else{
					var slideNo = $(this).find(".active").index();
					$(this).find(".sub-tab__4dep_list").addClass("sub-tab__4dep_list_rolling"+sub_tab_idx);
					$(this).find(".sub-tab__4dep_list").after('<ul class="slick_arrow_wrap"><li class="slick-prev"><button>이전목록으로</button></li><li class="slick-next"><button>다음목록으로</button></li></ul>')
					dep4Menu_slider('.sub-tab__4dep_list_rolling'+sub_tab_idx,true);
					$('.sub-tab__4dep_list_rolling').slick('slickGoTo', slideNo);
					var dep4_active_idx = $(".sub-tab__4dep_list .menu.active").parents(".slick-slide").not(".slick-cloned").data("slick-index");
					$('.sub-tab__4dep_list_rolling'+sub_tab_idx).slick('slickGoTo', dep4_active_idx);
				}
			}else{
				var sub_tab_idx = $(this).index();
				var sub_tab_4dep = $(this).find(".sub-tab__4dep_list>div").length;
				$(this).addClass("tab_4dep_"+sub_tab_4dep);
				sub_tab(".sub-tab__pageTab .menu", ".sub-tab__pageCont>div");
				
			}
	});

	$(".sub-tab__smenu").each(function(){
		var win_w = $(".subcont").width();

		var totalWidth = 0;
		var set = $(this).find('.dep5_menu');
		set.each(function(){
			totalWidth = totalWidth + $(this).width();
		});
		var sub_tab_idx = $(this).parents("li").index();
		console.log(totalWidth , win_w);
		if (totalWidth > win_w){
			$(this).find(".depth5Menu_list").addClass("sub-tab__5dep_list_rolling"+sub_tab_idx);
			var dep5_active_idx = $(".depth5Menu_list .dep5_menu.s_active").parents(".slick-slide").not(".slick-cloned").data("slick-index");
			$('.sub-tab__5dep_list_rolling'+sub_tab_idx).slick('slickGoTo', dep5_active_idx);
		}
	});

	$(".sub-tab__menu_inner").each(function(){
		var sub_tab_3dep_idx = $(this).find(">ul>li").length;
		var sub_tab_3dep_width = 100/sub_tab_3dep_idx;
		$(this).find(">ul>li").css({"width":sub_tab_3dep_width+"%"});
	});


	// advisory list
	function advisory_person_slide(item) {
        var slideWrap = $(item).closest('.slide');
        var prevBtn = slideWrap.find('.slick-prev');
        var nextBtn = slideWrap.find('.slick-next');

        $(item).slick({
            infinite:true,
            prevArrow: prevBtn,
            nextArrow: nextBtn
        });
    }
    advisory_person_slide('.advisory_person_rolling');
    advisory_person_slide('.patent_attorney_rolling');
    advisory_person_slide('.investment_rolling');
    advisory_person_slide('.production_rolling');
    advisory_person_slide('.taxation_rolling');
    advisory_person_slide('.accountant_rolling');
    advisory_person_slide('.customs_duties_rolling');
    advisory_person_slide('.personnel_rolling');
    advisory_person_slide('.management_rolling');
    advisory_person_slide('.certified_rolling');
    advisory_person_slide('.policy_fund_rolling');
    advisory_person_slide('.overseas_marketing_rolling');

	function advisory_person_select(item, id_name, slideName){
		$(item).on("change",function(){
			var slideNo = $(id_name+' option').index($(id_name+" option:selected"));
			$(slideName).slick('slickGoTo', slideNo);
		});
	}
	advisory_person_select('.advisory_person_slt','#advisory_person','.advisory_person_rolling');
	advisory_person_select('.patent_attorney_slt','#patent_attorney','.patent_attorney_rolling');
	advisory_person_select('.investment_slt','#investment','.investment_rolling');
	advisory_person_select('.production_slt','#production','.production_rolling');
	advisory_person_select('.taxation_slt','#taxation','.taxation_rolling');
	advisory_person_select('.accountant_slt','#accountant','.accountant_rolling');
	advisory_person_select('.customs_duties_slt','#customs_duties','.customs_duties_rolling');
	advisory_person_select('.personnel_slt','#personnel','.personnel_rolling');
	advisory_person_select('.management_slt','#management','.management_rolling');
	advisory_person_select('.certified_slt','#certified','.certified_rolling');
	advisory_person_select('.policy_fund_slt','#policy_fund','.policy_fund_rolling');
	advisory_person_select('.overseas_marketing_slt','#overseas_marketing','.overseas_marketing_rolling');

	$(".advisory_committee_title .menu").on("click",function(){
		var advisory_title_idx = $(this).data("lastValue")
		$(".advisory_person_list_wrap>div").hide();
		$(".advisory_person_list_wrap>div").eq(advisory_title_idx-1).show();
		$(".advisory_person_list_wrap").find('.slick-slider').slick('refresh');
		$(".advisory_committee_title .menu").removeClass("active");
		$(this).addClass("active");
		return false;
	});


	// family site
	function goUrl(f) {
	var url = f.url.value;
	if(!url) {
		alert('선택하세요!');
	return false;
	}
	f.action = url;
		return true;
	}

	$(".relate-site .btn_go").on("click",function(){
		var url = $(this).prev().val();
		console.log(url);
		if(!url) {
			alert('선택하세요!');
		return false;
		}
		window.open(url, "_blank"); 
		return true;
	});

    // modal
    $(function(){
        $(".contbtn").on("click", function(){
            $(".detail-seachbox").attr("tabindex", "0").show().focus();
            $(".btn-close-search").click(function(){
                $(".detail-seachbox").removeAttr("tabindex").hide();
                $(".contbtn").focus();
            });
            
        });
    });

	//sns공유
	$('.menu__set-sns .menu__set-sns_open').on('click',function(){
		$('.menu__sns-group').toggle();
	});

    $(function(){
        $(".btn-modal-pop").on("click", function(){
     
           var btn_id = $(this).attr('id');
     
           $('.'+btn_id).attr("tabindex", "0").show().focus();
              $('.'+btn_id).before('<div class="pop-bg"></div>');
              $('.'+btn_id).fadeIn();
			  $("body").css({"overflow":"hidden"});
           $(".btn-pop-close, .modal_close").click(function(){
              $('.'+btn_id).removeAttr("tabindex").hide();
              $('.pop-bg').remove();
              $(".btn-modal-pop#"+btn_id).focus();
           });
           $(".btn-pop-close, .modal_close").focus(function(){
              $('.'+btn_id).append("<a href='javascript:void(0);' class='linkAppend'>팝업닫기</a>");
			  $("body").removeAttr("style");
              $(".linkAppend").focus(   function(){
                 $('.'+btn_id).attr("tabindex", "0").focus();
                 $(".linkAppend").remove();
              });
           });
        });
     });

     $(function(){
        $(".btn-map").on("click", function(){
            var btn_id = $(this).attr('id');

            $('.industrial-box').hide();
            $('.'+btn_id).show().fadeIn();
        });
     });
     
    
        function btn_modal_pop(btn_id) {
    
            $('.'+btn_id).attr("tabindex", "0").show().focus();
                $('.'+btn_id).before('<div class="pop-bg"></div>');
                $('.'+btn_id).fadeIn();
            $(".btn-pop-close, .modal_close").click(function(){
                $('.'+btn_id).removeAttr("tabindex").hide();
                $('.pop-bg').remove();
                $(".btn-modal-pop#"+btn_id).focus();
            });
            $(".btn-pop-close").focus(function(){
                $('.'+btn_id).append("<a href='javascript:void(0);' class='linkAppend'>팝업닫기</a>");
                $(".linkAppend").focus(   function(){
                $('.'+btn_id).attr("tabindex", "0").focus();
                $(".linkAppend").remove();
                });
            });
    
        };
    
    $(function(){
        $(".mobilechck").on("click", function(){
            $(".mobile-input").attr("tabindex", "0").show().focus();
        });
    });
    
    //모달창
    $(function(){
       $(".btn-modal-pop").on("click", function(){
    
          var btn_id = $(this).attr('id');
    
          $('.'+btn_id).attr("tabindex", "0").show().focus();
             $('.'+btn_id).before('<div class="pop-bg"></div>');
             $('.'+btn_id).fadeIn();
          $(".btn-pop-close, .modal_close").click(function(){
             $('.'+btn_id).removeAttr("tabindex").hide();
             $('.pop-bg').remove();
             $(".btn-modal-pop#"+btn_id).focus();
          });
          $(".btn-pop-close").focus(function(){
             $('.'+btn_id).append("<a href='javascript:void(0);' class='linkAppend'>팝업닫기</a>");
             $(".linkAppend").focus(   function(){
                $('.'+btn_id).attr("tabindex", "0").focus();
                $(".linkAppend").remove();
             });
          });
       });
    });
});
$(document).ready(function(e) { $('img[usemap]').rwdImageMaps(); });

//2dep menu
$(function(){
	var dep3 = $(".sub-tab__menu_inner>ul>li.active").find(".sub-tab__smenu").length;
	if (dep3 > 0){
		$(".sub-tab__menu").addClass("on");
	}else{
		$(".sub-tab__menu").removeClass("on");
	}
	$(".sub-tab__menu_inner>ul>li").on("mouseenter", function(){
		var dep2_active = $(this).hasClass("active");
		$(".sub-tab__smenu").hide();
		$(this).find(".sub-tab__smenu").show();
		$(".sub-tab__menu").addClass("on");
		$(".depth5Menu_list").find('.slick-slider').slick('refresh');
	});
	
	$(".sub-tab__menu_inner>ul>li").on("mouseleave",function(){
		var dep2_active = $(this).hasClass("active");

		if (dep2_active == false){
			$(".sub-tab__smenu").hide();
		}
	});

	$(".sub-tab__menu_inner").on("mouseleave",function(){
		$(".sub-tab__menu_inner>ul>li.active").find(".sub-tab__smenu").delay(200).fadeIn(200);
	});
});