/*pc,mobile check*/
$(function(){
	chkpcm();
	$(window).resize(function(){
		chkpcm();
	});
});

function chkpcm(){
	if($("header .u_m").is(":visible")){
		$("body").addClass("pc");
		$("body").removeClass("mobile");
	}else{
		$("body").removeClass("pc");
		$("body").addClass("mobile");
	}
};

if (matchMedia("screen and (min-width: 1030px)").matches) {
	// 1030px 이상에서 사용할 JavaScript
	$(function(){
	  	var maxHeight = Math.max.apply(null, $(".gnb .st_g_l > li > .dp2").map(function ()
	  			{
	  				return $(this).children().size()*30+30;
	  			}).get());
	  	var dp2 = $(".gnb .st_g_l > li > .dp2");
	  	var width = 1200 / dp2.length;
	  	width = (width > 220) ? 220 : width;

		$(".gnb .st_g_l > li > ul").css({
			"height":maxHeight+210,
			"width":width
		});
		dp2.each(function(index){
			$(this).css({"left":index*width})
		});

		$(".gnb_bg .inner").css({
			"height":maxHeight+210
		});
		$(".gnb .st_g_l > li > a").hover(function(){
			$(".gnb .st_g_l > li > ul").stop().slideDown(150);
			$(".gnb_bg").stop().slideDown(150);
		});
		$(".gnb .st_g_l > li > a").focusin(function(){
			$(".gnb .st_g_l > li > ul").stop().slideDown(150);
			$(".gnb_bg").stop().slideDown(150);
		});
		$("header").mouseleave(function(){
			$(".gnb .st_g_l > li > ul").stop().slideUp(100);
			$(".gnb_bg").stop().slideUp(100);
		});
/*		$(".gnb_bg").mouseleave(function(){
			$(".gnb .st_g_l > li > ul").stop().slideUp(100);
			$(".gnb_bg").stop().slideUp(100);
		});*/
		$(".gnb_bg .gnbClose").click(function(){
			$(".gnb .st_g_l > li > ul").stop().slideUp(100);
			$(".gnb_bg").stop().slideUp(100);
		});
		$(".gnb .st_g_l > li a").eq("-1").focusout(function(){
			$(".gnb .st_g_l > li > ul").stop().slideUp(100);
			$(".gnb_bg").stop().slideUp(100);
		});
  	});
}else if(matchMedia("screen and (min-width: 650px)").matches){
	$(function(){
		var menuSize = $(".sitemap > li > ul").size();
		var menuGroupCnt = parseInt(menuSize/4)+1;
		for(i=0;i<menuGroupCnt;i++){
			var startGr = (i*4)-1;
			var endGr = 4;
			var maxHeight = 0;
			if(startGr < 0){
				maxHeight = Math.max.apply(null, $(".sitemap > li:lt("+endGr+") > ul").map(function (index)
					{
						var height = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						//alert("gr["+i+"], UL["+index+"], height : "+height);
						return height;
					}).get());

				$(".sitemap > li:lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}else{
				maxHeight = Math.max.apply(null, $(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").map(function (index)
					{
						var height = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						//alert("gr["+i+"], UL["+index+"], height : "+height);
						return height;
					}).get());
				$(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}
		}
		$(".gnb .dp2 > li > .dp3 > li").each(function(){
			$(this).parent().parent("li").addClass("hasDp3")
		});
		$(".gnb .st_g_l > li > a").on("click", function(){
			$(this).parent("li").toggleClass("on");
			$(this).parent("li").children("ul").slideToggle();
		})
		$(".gnb .dp2 > li > a").on("click", function(){
			$(this).parent("li").toggleClass("on");
			$(this).parent("li").children("ul").slideToggle();
			// return false;
			if($(this).parent("li").hasClass("hasDp3")){return false;}
		})
		$(".gnb .dp3 > li > a").click(function(){
			var thisUrl=$(this).attr("href")
			window.location=(thisUrl)
		});
	});
}else if(matchMedia("screen and (min-width: 481px)").matches){
	$(function(){
		var menuSize = $(".sitemap > li > ul").size();
		var menuGroupCnt = parseInt(menuSize/3)+1;
		for(i=0;i<menuGroupCnt;i++){
			var startGr = (i*3)-1;
			var endGr = 3;
			var maxHeight = 0;
			if(startGr < 0){
				maxHeight = Math.max.apply(null, $(".sitemap > li:lt("+endGr+") > ul").map(function (index)
					{
						var height = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						//alert("gr["+i+"], UL["+index+"], height : "+height);
						return height;
					}).get());
				$(".sitemap > li:lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}else{
				maxHeight = Math.max.apply(null, $(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").map(function (index)
					{
						var height = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						//alert("gr["+i+"], UL["+index+"], height : "+height);
						return height;
					}).get());
				$(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}
		}

		$(".gnb .st_g_l > li > a").on("click", function(){
			$(this).parent("li").toggleClass("on");
			$(this).parent("li").children("ul").slideToggle();
			if($(".gnb .dp2 > li > .dp3 > li").length > 1){
				$(".gnb .dp2 > li > .dp3").parent("li").addClass("hasDp3")
			}
		})
		$(".gnb .dp2 > li > a").on("click", function(){
			$(this).parent("li").toggleClass("on");
			$(this).parent("li").children("ul").slideToggle();
			// return false;
			if($(this).parent("li").hasClass("hasDp3")){return false;}
		})
		$(".gnb .dp3 > li > a").click(function(){
			var thisUrl=$(this).attr("href")
			window.location=(thisUrl)
		});
	});
}else{
	$(function(){
		var menuSize = $(".sitemap > li > ul").size();
		var menuGroupCnt = parseInt(menuSize/2)+1;
		for(i=0;i<menuGroupCnt;i++){
			var startGr = (i*2)-1;
			var endGr = 2;
			var maxHeight = 0;
			if(startGr < 0){
				maxHeight = Math.max.apply(null, $(".sitemap > li:lt("+endGr+") > ul").map(function (index)
					{
						var height = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						return height;
					}).get());
				$(".sitemap > li:lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}else{
				maxHeight = Math.max.apply(null, $(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").map(function (index)
					{
						var height = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						/*alert($(this).parent().children('h3').html());*/
						return height;
					}).get());
				$(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}
		}

		$(".gnb .st_g_l > li > a").on("click", function(){
			$(this).parent("li").toggleClass("on");
			$(this).parent("li").children("ul").slideToggle();
			if($(".gnb .dp2 > li > .dp3 > li").length > 1){
				$(".gnb .dp2 > li > .dp3").parent("li").addClass("hasDp3")
			}
		})
		$(".gnb .dp2 > li > a").on("click", function(){
			$(this).parent("li").toggleClass("on");
			$(this).parent("li").children("ul").slideToggle();
			// return false;
			if($(this).parent("li").hasClass("hasDp3")){return false;}
		})
		$(".gnb .dp3 > li > a").click(function(){
			var thisUrl=$(this).attr("href")
			window.location=(thisUrl)
		});
	});
}



/*
$(window).resize(function() {
	if ($(window).width() <= 1023){
		$("header").removeClass();
	}
});
*/

/*GNB*/
$(function(){

	$("button.gnbOpen").click(function(){
		if($("body").hasClass("gnbOpen")){
			$("body").removeClass("gnbOpen");
		}else{
			$("body").addClass("gnbOpen");
		}
	});
	$(document).on("touchstart click",".bbg",function(e){
		e.preventDefault();
		$("body").removeClass("gnbOpen");
	});
});


/*LNB*/
$(function(){
	$("#lnb ul.lnb_l > li > a").click(function(){
		$("#lnb ul.lnb_l > li > a").removeClass("active");
		$("#lnb ul.lnb_l > li").removeClass("active");
		$(this).addClass("active");
		$("#lnb ul.lnb_l .dp2").slideUp(150);
		$(this).parent().find(".dp2").slideDown(150);
	});
	$("#lnb ul.lnb_l > li > a").focusin(function(){
		$("#lnb ul.lnb_l > li > a").removeClass("active");
		$("#lnb ul.lnb_l > li").removeClass("active");
		$(this).addClass("active");
		$("#lnb ul.lnb_l .dp2").slideUp(150);
		$(this).parent().find(".dp2").slideDown(150);
	});
});

/*visual*/
$(function(){
	var owlss=$(".sliderWrap .bg");
	$(owlss).each(function() {
		var owls = $(this);
		var owls_c = $(this).find("li");
		if($(owls_c).length>1){
			owls.owlCarousel({
				items:1,
				animateOut: 'fadeOut',
				responsiveClass:true,
				loop:true,
				autoplayTimeout:3000,
				autoplayHoverPause:true,
				autoplay:true,
				dots:true,
				dotsEach:true,
				autoHeight:true
			});
			$(".sliderWrap .bg").on("click",function(e){
				if($(this).hasClass("t1")){
					owls.trigger("prev.owl.carousel");
				}else if($(this).hasClass("t3")){
					owls.trigger("next.owl.carousel");
				}else{
					owls.trigger("stop.owl.autoplay");
				}
			});
			owls.on("focusin",function(){
				owls.trigger("stop.owl.autoplay");
			});
		}
	});
});

/*banner*/
$(function(){
	var owls=$("#banner .b_l");
	owls.owlCarousel({
		items:7,
		margin:15,
		dots:false,
		responsiveClass:true,
		loop:true,
		autoplayTimeout:3000,
		autoplayHoverPause:true,
		autoplay:true
	});
	$("#banner button.bt").on("click",function(e){
		if($(this).hasClass("t1")){
			owls.trigger("prev.owl.carousel");
		}else if($(this).hasClass("t3")){
			owls.trigger("next.owl.carousel");
		}else{
			owls.trigger("stop.owl.autoplay");
		}
	});
	owls.on("focusin",function(){
		owls.trigger("stop.owl.autoplay");
	});
});

/*nowpage control*/
function nowpage(d1,d2,d3){
	var dp1=d1-1;
	var dp2=d2-1;
	var dp3=d3-1;

	/*var adddp1="<li class='dp'>";
	adddp1+="<a href='#'></a>";
	adddp1+="<div class='dp2_w'>";
	adddp1+="<ul class='dp2'>";
	adddp1+=$("header .g_l").html();
	adddp1+="</ul>";
	adddp1+="</div>";
	adddp1+="</li>";
	$("#lnb ul.lnb_l").append(adddp1);
	$("#lnb ul.lnb_l>li.dp:eq(0) ul.dp2").find("ul.dp2").remove();*/
	$("#lnb ul.lnb_l>li.dp:eq(0)>a").text($("header .g_l>li:eq("+dp1+")>a").text());
	//$("header .g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>a").addClass("mon");

	/*var adddp2="<li class='dp'>";
	adddp2+="<a href='#'></a>";
	adddp2+="<div class='dp2_w'>";
	adddp2+="<ul class='dp2'>";
	adddp2+=$("header .g_l>li:eq("+dp1+")>ul.dp2").html();
	adddp2+="</ul>";
	adddp2+="</div>";
	adddp2+="</li>";
	$("#lnb ul.lnb_l").append(adddp2);
	$("#lnb ul.lnb_l>li.dp:eq(1)").find("ul.dp3").remove();
	$("#lnb ul.lnb_l>li.dp:eq(1)>a").text($("header .g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>a").text());*/
	$("header .g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>a").addClass("mon");

	/*var adddp3="<li class='dp'>";
	adddp3+="<a href='#'></a>";
	adddp3+="<div class='dp2_w'>";
	adddp3+="<ul class='dp2'>";
	adddp3+=$("header .g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>ul.dp3").html();
	adddp3+="</ul>";
	adddp3+="</div>";
	adddp3+="</li>";
	//$("header .g_l>li:eq("+dp1+")").addClass("active");*/
	if($("header .g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>ul.dp3").size()>0){
		/*$("header .g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>ul.dp3>li:eq("+dp3+")>a").addClass("mon");
		$("#lnb ul.lnb_l").append(adddp3);*/
		$("#lnb ul.lnb_l>li.dp:eq(2)>a").text($("header .g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>ul.dp3>li:eq("+dp3+")>a").text());
	}
}


/*$(function(){
	$(".busin_list .thumb").mousemove(function(e){
		var w=$(this).innerWidth()/2;
		var h=$(this).innerHeight()/2;
		var x=(e.pageX-this.offsetLeft)-w;
		var y=(e.pageY-this.offsetTop)-h;
		var px=x*0.03;
		var py=y*0.03;
		$(this).find("img").css("-webkit-transform","translate3d("+px+"px,"+py+"px,0)");
		console.log(x,y);
	}).mouseleave(function(){
		$(this).find("img").removeAttr("style");
	});
});*/

/*main브로슈어*/
function m_broshur(){
	var owls=$(".mbox.t3 ul.b_l");
	owls.owlCarousel({
		items:3,
		margin:20,
		dots:false,
		responsiveClass:true,
		loop:false,
		autoplay:false
	});
	$(".mbox.t3 .r .bbox>button").on("click",function(e){
		if($(this).hasClass("s_prev")){
			owls.trigger("prev.owl.carousel");
		}else{
			owls.trigger("next.owl.carousel");
		}
	});
}

$(function(){
	$("#modalpopup.zip ul.zipTab>li>a").click(function(){
		var _href=$(this).attr("href");
		$("#modalpopup.zip #zip1").hide();
		$("#modalpopup.zip #zip2").hide();
		$("#modalpopup.zip").find(_href).show();
		$(this).parent().addClass("active");
		$(this).parent().siblings().removeClass("active");
		return false;
	});
});

//qna기능
function qnaTabs(elm){
	$(elm).on("click",".answOpen",function(){
		if($(this).closest(".head").next().is(":visible")){
			$(this).closest(".head").next().hide();
		}else{
			$(elm).find(".answ").hide();
			$(this).closest(".head").next().show();
		};
		return false;
	});
};

$(function(){
	$("#container div.s-naviBox").hide()
	$("#container .neviTop a.ic.sharing").click(function(){
  		if($("#container ul.snsList > li").is(":hidden")){
    		$("#container div.s-naviBox").css({"opacity":1}).slideDown("slow");
  		}else{
  			$("#container div.s-naviBox").hide();
		}
	});
})

$(function(){
	$(".bottom").hide();
	var ty  =  0;
	var top = 0;
	$(window).on("scroll", function(){
		top = $(window).scrollTop();
		if( top > 150){
			$(".bottom").fadeIn();
		}else{
			$(".bottom").fadeOut();
		}
	})
})


// 201905 추가
;(function($) {
	// select 박스
	$.fn.selectBox = function(options) {
		var settings = {
			isSelectTag: true,
			eventType: 'click'
		};
		var opt = $.extend(settings, options);

		return this.each(function() {
			var $obj = $(this),
				$select = $obj.find('select'),
				$selArea = $obj.parent('.sel_wrap'),
				$selBtn = $obj.find('.btn_sel'),
				$selList = $obj.find('ul'),
				$scrollBox = $obj.find('.scroll_wrap');
				$input = $obj.find('input');

			var $event = settings.eventType;

			if ($event == 'click') {
				// click Event
				$selBtn.on({
					click: function(e) {
						e.stopPropagation();
						e.preventDefault();

						if($obj.hasClass('opened')){
							$obj.removeClass('opened');
						} else {
							$('.sel_wrap').removeClass('opened');
							$obj.addClass('opened');
							$scrollBox.each(function(){
								$(this).tinyscrollbar();
							});
						}
					}
				});

				$(document).on({
					click: function() {
						$obj.removeClass('opened');
					}
				});
			} else {
				// mouseenter Event
				$selArea.on({
					mouseenter: function() {
						$('.sel_wrap').removeClass('opened');
						$obj.addClass('opened');
						$scrollBox.each(function(){
							$(this).tinyscrollbar();
						});
					},
					mouseleave: function() {
						$obj.removeClass('opened');
					}
				});
			}

			$selList.find('.select').on({
				click: function() {
					var clickIdx = $(this).parent('li').index(),
						clickTxt = $(this).text();
					$obj.removeClass('opened');
					$selBtn.text(clickTxt);
					$input.val($(this).val());

					if( $(this).parents('.sel_wrap').siblings('label').attr('for') == 'receive' ) {
						$('.view_area').css('display','none');
						$('.view_area').eq(clickIdx).css('display','block');
					}
				}
			});
		});
	};
	// input placeholder
	$.fn.placeHolder = function() {
		return this.each(function() {
			var $obj = $(this),
				$input = $obj.find('.inp_txt'),
				$placeholderTxt = $obj.find('.placeholder');

			$input.each(function() {
				if ($(this).val().length) {
					$(this).addClass('focus');
				}
			});

			$input.on({
				focus: function() {
					$(this).addClass('focus');
				},
				blur: function() {
					if ($(this).val().length) {
						$(this).addClass('focus');
					} else {
						$(this).removeClass('focus');
					}
				}
			});

			$placeholderTxt.on({
				click: function() {
					$(this).next($input).addClass('focus').focus();
				}
			});
		});
	};
})(jQuery);

$(function() {
	// $('.sel_wrap').selectBox({
	// 	isSelectTag: true,
	// 	eventType : 'click'
	// });

	$('.inp_txt_wrap, .inp_txt_wrap2, .inp_txt_wrap3, .inp_txt_search').placeHolder();
});