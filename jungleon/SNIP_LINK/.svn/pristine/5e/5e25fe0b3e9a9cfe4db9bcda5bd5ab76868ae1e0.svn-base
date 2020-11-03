$(document).on('ready', function() {

	// fixed header
	$(function(){
		var sub_header_fixed = $(".header__wrap").hasClass("main_header__wrap");
		if (sub_header_fixed == false){
			$(window).on("scroll",function(){
				var st = $(window).scrollTop();
				if (st > 0){
					$(".header__wrap").addClass("header_fixed");
				}else{
					$(".header__wrap").removeClass("header_fixed");
				}
				
			});
		}
	});


	/*
	$(function(){
		$(".open_all_menu button").on("click",function(){
			$(".all-menu__wrap").fadeIn(200);
			$("body").css("overflow","hidden");
			console.log("aa");
		});

		$(".total_menu_close").on("click",function(){
			$(".all-menu__wrap").fadeOut(200);
			$("body").attr("style","");
		});
	});
	*/


	if (matchMedia("screen and (min-width: 1240px)").matches) {
		// 1240px 이상에서 사용할 JavaScript
		$(function(){
			var dep4_btn = $(".gnb_dep4_open");
			var dep4_all = dep4_btn.next();
			dep4_btn.on("click",function(){
				var dep4_cont = $(this).next(".gnb_dep4_list").css("display");
				if (dep4_cont == "none"){
					dep4_all.slideUp(200);
					$(".gnb_dep4_open").removeClass("on");
					$(this).next(".gnb_dep4_list").slideDown(200);
					$(this).addClass("on");
				}else{
					$(this).next(".gnb_dep4_list").slideUp(200);
					$(this).removeClass("on");
				}
				return false;
			});

			$(".web_language_btn").on("click",function(){
				var mb_language = $(this).next(".item-language_list").css("display");
				if (mb_language == "none"){
					$(this).next(".item-language_list").slideDown();
					$(this).addClass("on");
				}else{
					$(this).next(".item-language_list").slideUp();
					$(this).removeClass("on");
				}
			});

			$(".gnb_depth1_item").on("mouseenter",function(){
				$(this).find(".gnb_depth2_item").fadeIn(200);
				$(this).addClass("gnb_over");
			}).on("mouseleave",function(){
				$(this).find(".gnb_depth2_item").hide();
				$(this).removeClass("gnb_over");
			});
		});
	}
    if (matchMedia("screen and (max-width: 1239px)").matches) {
        // 1239px 이하에서 사용할 JavaScript
        $(function(){
			$(".mobile_menu_close").on("click",function(){
				$(".header__wrap--bottom").animate({"left":"-110%"});
				return false;
			});

			$(".mobile_menu_open").on("click",function(){
				$(".header__wrap--bottom").animate({"left":"0"});
				return false;
			});

			$(".search_mb_open").on("click",function(){
				var mb_search = $(".search-form_wrap").css("display");
				console.log(mb_search);
				if (mb_search =="none"){
					$(this).addClass("close");
					$(".search-form_wrap").fadeIn(200);
				}else{
					$(this).removeClass("close");
					$(".search-form_wrap").fadeOut(200);
				}
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

			$(".gnb_depth2_list>ul>li>a.gnb_dep3_open").on("click",function(){
				var dep3_cont = $(this).next(".gnb_dep3_list").css("display");
				if (dep3_cont == "none"){
					$(".gnb_dep3_list").slideUp(200);
					$(".gnb_depth2_list>ul>li>a.gnb_dep3_open").removeClass("on");
					$(this).next(".gnb_dep3_list").slideDown(200);
					$(this).addClass("on");
				}else{
					$(this).next(".gnb_dep3_list").slideUp(200);
					$(this).removeClass("on");
				}
				return false;
			});

			$(".gnb_depth1_item>a").on("click",function(){
				$(".gnb_depth2_item ").hide();
				$(this).next(".gnb_depth2_item").show();
				$(".gnb_depth1_item>a").removeClass("on");
				$(this).addClass("on");
				return false;
			});



		});
	}

	$(window).resize(function(){
		//반응형 전체메뉴
		if($(window).width() >= 1240){
			$(".web_language_btn").unbind("click");
			$(".gnb_depth1_item").unbind("mouseenter");
			$(".gnb_depth1_item").unbind("mouseleave");
			$(".gnb_dep4_open").unbind("click");
			$(".mobile_menu_open").unbind("click");
			$(".mobile_menu_close").unbind("click");
			$(".gnb_dep4_open").unbind("click");
			$(".gnb_depth2_list>ul>li>a.gnb_dep3_open").unbind("click");
			$(".gnb_depth1_item>a").unbind("click");

			$(".header__wrap--bottom").css({"left":0});
			$(".gnb_depth2_item").css("display","none");

		// 1240px 이상에서 사용할 JavaScript
			var dep4_btn = $(".gnb_dep4_open");
			var dep4_all = dep4_btn.next();
			dep4_btn.on("click",function(){
				var dep4_cont = $(this).next(".gnb_dep4_list").css("display");
				if (dep4_cont == "none"){
					dep4_all.slideUp(200);
					$(".gnb_dep4_open").removeClass("on");
					$(this).next(".gnb_dep4_list").slideDown(200);
					$(this).addClass("on");
				}else{
					$(this).next(".gnb_dep4_list").slideUp(200);
					$(this).removeClass("on");
				}
				return false;
			});

			$(".web_language_btn").on("click",function(){
				var mb_language = $(this).next(".item-language_list").css("display");
				if (mb_language == "none"){
					$(this).next(".item-language_list").slideDown();
					$(this).addClass("on");
				}else{
					$(this).next(".item-language_list").slideUp();
					$(this).removeClass("on");
				}
			});

			$(".gnb_depth1_item").on("mouseenter",function(){
				$(this).find(".gnb_depth2_item").fadeIn(200);
				$(this).addClass("gnb_over");
			}).on("mouseleave",function(){
				$(this).find(".gnb_depth2_item").hide();
				$(this).removeClass("gnb_over");
			});

		}else{
			$(".gnb_depth1_item").unbind("mouseleave");
			$(".web_language_btn").unbind("click");
			$(".gnb_depth1_item").unbind("mouseenter");
			$(".gnb_dep4_open").unbind("click");
			$(".mobile_menu_open").unbind("click");
			$(".mobile_menu_close").unbind("click");
			$(".gnb_dep4_open").unbind("click");
			$(".gnb_depth2_list>ul>li>a.gnb_dep3_open").unbind("click");
			$(".gnb_depth1_item>a").unbind("click");

			$(".header__wrap--bottom .header__wrap--inbox .gnb_depth1>.gnb_depth1_item>a.on").next(".gnb_depth2_item").css("display","block");
			$(".header__wrap--bottom").css({"left":"-110%"});
			
			// 1239px 이하에서 사용할 JavaScript
			$(".mobile_menu_close").on("click",function(){
				$(".header__wrap--bottom").animate({"left":"-110%"});
				return false;
			});

			$(".mobile_menu_open").on("click",function(){
				$(".header__wrap--bottom").animate({"left":"0"});
				return false;
			});

			$(".search_mb_open").on("click",function(){
				var mb_search = $(".search-form_wrap").css("display");
				console.log(mb_search);
				if (mb_search =="none"){
					$(this).addClass("close");
					$(".search-form_wrap").fadeIn(200);
				}else{
					$(this).removeClass("close");
					$(".search-form_wrap").fadeOut(200);
				}
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

			$(".gnb_depth2_list>ul>li>a.gnb_dep3_open").on("click",function(){
				var dep3_cont = $(this).next(".gnb_dep3_list").css("display");
				if (dep3_cont == "none"){
					$(".gnb_dep3_list").slideUp(200);
					$(".gnb_depth2_list>ul>li>a.gnb_dep3_open").removeClass("on");
					$(this).next(".gnb_dep3_list").slideDown(200);
					$(this).addClass("on");
				}else{
					$(this).next(".gnb_dep3_list").slideUp(200);
					$(this).removeClass("on");
				}
				return false;
			});

			$(".gnb_depth1_item>a").on("click",function(){
				$(".gnb_depth2_item ").hide();
				$(this).next(".gnb_depth2_item").show();
				$(".gnb_depth1_item>a").removeClass("on");
				$(this).addClass("on");
				return false;
			});
		}
	});
});