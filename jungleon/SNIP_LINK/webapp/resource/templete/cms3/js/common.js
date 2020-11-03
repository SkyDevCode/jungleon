$(function(){
	chkpcm();
	var beforeVisible = $("header .u_m").is(":visible");
	$(window).resize(function(){
		var afterVisible  = $("header .u_m").is(":visible");
		if (beforeVisible != afterVisible) {
			location.reload();
		}
		chkpcm();
		beforeVisible = $("header .u_m").is(":visible");
	});
});

function chkpcm(){
	if($("header .u_m").is(":visible")){
		$("body").addClass("pc");
		$("body").removeClass("mobile");
		$("body").removeClass("gnbOpen");
		$(".bbg").css("display", "none");
		$("header #gnb .g_l > li > ul.dp2").css("display", "none");
	}else{
		$("body").removeClass("pc");
		$("body").addClass("mobile");
		$("body.mobile .gnbBG").hide();
		$("body.mobile header .stmap").hide();
	}
};

if (matchMedia("screen and (min-width: 1024px)").matches) {
	// 1024px 이상에서 사용할 JavaScript
	$(function(){
			var maxHeight = Math.max.apply(null, $("#gnb .st_g_l > li > .dp2").map(function ()
		{
			return $(this).height()+60;
		}).get());


		$("header #gnb .st_g_l > li a").hover(function(){
			$("header #gnb .st_g_l > li > ul").show()
			$("#gnb .st_g_l > li > ul").css({
				"height":maxHeight
			});
			$("#gnb").css({
				"height":maxHeight+117
			});
			$(".gnbBg").show().css({
				"height":maxHeight+30
			});
			$("header").addClass("on")
		});
		$("header .gnbBg").mouseleave(function(){
			$("header #gnb .st_g_l > li > ul").hide()
			$(".gnbBg").hide()
			$("header").removeClass("on")
			$("#gnb").height(98)
		});
		$("header #gnb").mouseleave(function(){
			$("header #gnb .st_g_l > li > ul").hide()
			$(".gnbBg").hide()
			$("header").removeClass("on")
			$("#gnb").height(98)
		});

		var $lnb_li =$(".lnb > .w > ul > li")
		var $lnb_a=$(".lnb > .w > ul > li > a")
		var $lnb_dp1 = $(".lnb > .w > ul > li.dp1")
		var $lnb_dp2 = $(".lnb > .w > ul > li.dp2")
		$lnb_a.click(function(){
			$(this).parent("li").find("ul").slideToggle()
		})
		if($lnb_dp1.is(":visible")){
			$lnb_dp2.find("a").click(function(){
				$lnb_dp1.find("ul").slideUp()
			})
		}

	});
}
if (matchMedia("screen and (max-width: 1023px)").matches) {
	// 1023px 이하에서 사용할 JavaScript
	$(function(){
		$("header #gnb .st_g_l > li").click(function(){
			$(this).toggleClass("on")
		});
		$(".m-gnb-close").click(function(){
			$("#gnb").fadeOut()
			$(".bbg").fadeOut()
		})
		$(".m-gnb-open").click(function(){
			$("#gnb").fadeIn()
			$(".bbg").fadeIn()
		})
		$(".m-search").click(function(){
			$(".m-search-area").fadeIn()
			$(".m-search").hide()
			if($(".m-search-area").is(":visible")){
				$(".m-search-area .searchClose").show()
			}
		})
		$(".m-search-area .searchClose").click(function(){
			$(".m-search-area").fadeOut()
			$(".m-search").show()
		})

		var $lnb_li =$(".lnb > .w > ul > li")
		var $lnb_a=$(".lnb > .w > ul > li > a")
		var $lnb_dp1 = $(".lnb > .w > ul > li.dp1")
		var $lnb_dp2 = $(".lnb > .w > ul > li.dp2")
		$lnb_a.click(function(){
			$(this).parent("li").find("ul").slideToggle()
		})
		if($lnb_dp1.is(":visible")){
			$lnb_dp2.find("a").click(function(){
				$lnb_dp1.find("ul").slideUp()
			})
		}
	});
}
if(matchMedia("screen and (min-width: 650px)").matches){
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
						var heigth = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						//alert("gr["+i+"], UL["+index+"], heigth : "+heigth);
						return heigth;
					}).get());

				$(".sitemap > li:lt("+endGr+") > ul").css({
					"height":maxHeight
				});

			}else{
				maxHeight = Math.max.apply(null, $(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").map(function (index)
					{
						var heigth = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						//alert("gr["+i+"], UL["+index+"], heigth : "+heigth);
						return heigth;
					}).get());
				$(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}
		}
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
						var heigth = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						//alert("gr["+i+"], UL["+index+"], heigth : "+heigth);
						return heigth;
					}).get());
				$(".sitemap > li:lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}else{
				maxHeight = Math.max.apply(null, $(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").map(function (index)
					{
						var heigth = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						//alert("gr["+i+"], UL["+index+"], heigth : "+heigth);
						return heigth;
					}).get());
				$(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}
		}
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
						var heigth = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						return heigth;
					}).get());
				$(".sitemap > li:lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}else{
				maxHeight = Math.max.apply(null, $(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").map(function (index)
					{
						var heigth = $(this).children().size()*30 + $(this).find("ul > li").size()*20;
						/*alert($(this).parent().children('h3').html());*/
						return heigth;
					}).get());
				$(".sitemap > li:gt("+startGr+"):lt("+endGr+") > ul").css({
					"height":maxHeight
				});
			}
		}
	});
}




$(window).resize(function() {
	if ($(window).width() <= 1119){
		$("header").removeClass();
	}
});


if ($(window).width() <= 1119)
{
	$(document).ready(function(){
		$("header").removeClass();
	});
}

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
		$(this).addClass("active");
		$("#lnb ul.lnb_l .dp2").slideUp(150);
		$(this).parent().find(".dp2").slideDown(150);
	});
});

/*visual*/
$(function(){
	var owls=$(".sliderWrap .bg");
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
});

/*banner*/
$(function(){
	var owls=$("#banner .b_l");
	owls.owlCarousel({
		margin:0,
		dots:false,
		responsiveClass:true,
		loop:true,
		autoplayTimeout:3000,
		autoplayHoverPause:true,
		autoplay:true,
		responsive:{
			0:{
				items:4
			},
			1199:{
				items:6
			}
		}
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
	adddp1+=$("header .st_g_l").html();
	adddp1+="</ul>";
	adddp1+="</div>";
	adddp1+="</li>";
	$("#lnb ul.lnb_l").append(adddp1);
	$("#lnb ul.lnb_l>li.dp:eq(0) ul.dp2").find("ul.dp2").remove();*/
	$("#lnb ul.lnb_l>li.dp:eq(0)>a").text($("header .st_g_l>li:eq("+dp1+")>a").text());
	//$("header .st_g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>a").addClass("mon");

	/*var adddp2="<li class='dp'>";
	adddp2+="<a href='#'></a>";
	adddp2+="<div class='dp2_w'>";
	adddp2+="<ul class='dp2'>";
	adddp2+=$("header .st_g_l>li:eq("+dp1+")>ul.dp2").html();
	adddp2+="</ul>";
	adddp2+="</div>";
	adddp2+="</li>";
	$("#lnb ul.lnb_l").append(adddp2);
	$("#lnb ul.lnb_l>li.dp:eq(1)").find("ul.dp3").remove();
	$("#lnb ul.lnb_l>li.dp:eq(1)>a").text($("header .st_g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>a").text());*/
	$("header .st_g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>a").addClass("mon");

	/*var adddp3="<li class='dp'>";
	adddp3+="<a href='#'></a>";
	adddp3+="<div class='dp2_w'>";
	adddp3+="<ul class='dp2'>";
	adddp3+=$("header .st_g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>ul.dp3").html();
	adddp3+="</ul>";
	adddp3+="</div>";
	adddp3+="</li>";
	//$("header .st_g_l>li:eq("+dp1+")").addClass("active");*/
	if($("header .st_g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>ul.dp3").size()>0){
		/*$("header .st_g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>ul.dp3>li:eq("+dp3+")>a").addClass("mon");
		$("#lnb ul.lnb_l").append(adddp3);*/
		$("#lnb ul.lnb_l>li.dp:eq(2)>a").text($("header .st_g_l>li:eq("+dp1+")>ul.dp2>li:eq("+dp2+")>ul.dp3>li:eq("+dp3+")>a").text());
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
			$(this).parent("dd").removeClass("active");
		}else{
			$(elm).find(".answ").hide();
			$(this).closest(".head").next().show();
			$(".board_qna .quest > dd.que").removeClass("active");
			$(this).parent("dd").addClass("active");
		};
		return false;
	});
};

//메인 게시판 탭
$(function(){
	$(".bbswrap > div[id != 'tab1' ]").hide()
	var $li = $("#tabmenu li");
	var cnt  = "" ;

	$li.hover(function(){
		cnt  = $(this).index()+1
		$(".bbswrap > div").hide()
		$(".bbswrap > div#tab"+cnt).show()
		$li.removeClass("on")
		$(this).addClass("on")
	})

	if (matchMedia("screen and (max-width: 768px)").matches) {
		$li.click(function(){
			cnt  = $(this).index()+1
			$(".bbswrap > div").hide()
			$(".bbswrap > div#tab"+cnt).show()
			$li.removeClass("on")
			$(this).addClass("on")
			return false;
		})
	}
})

function main4popupzone(){
	var time=3000;
	var eventTime=500;
	var popupNum=0;
	var popupMaxNum=$(".popup_w>.item:last").index();
	var popupinter = setInterval(popupinterv,time);
	var owlss=$(".popup_w .item");
	if($(owlss).length>1){
		$(".popup_w>.item").each(function(index){
			$(".popupcontroler").prepend("<button type='button' class='bullit'><span class='blind'>"+eval($(this).index()+1)+"</span></button>");
		});

	$(".popupzone").prepend("<button type='button' class='btn prev'><span class='blind'>"+"</span></button>");
	$(".popupzone").prepend("<button type='button' class='btn next'><span class='blind'>"+"</span></button>");
	$(".popup_w>.item").eq(popupNum).show();
	$(".popupcontroler>.bullit").eq(popupNum).addClass("on");
	function popupinterv(){
		if(popupMaxNum>popupNum){
		++	popupNum;
		}else{
			popupNum=0;
		}
		$(".popup_w>.item").fadeOut(eventTime);
		$(".popup_w>.item").eq(popupNum).fadeIn(eventTime);
		$(".popupcontroler>.bullit").eq(popupNum).addClass("on").siblings().removeClass("on");
	};

	$(".popupcontroler>.bullit").on("click",function(){
		popupNum = $(this).index();
		//alert(slideNum);
		$(".popup_w>.item").fadeOut(eventTime);
		$(".popup_w>.item").eq(popupNum).fadeIn(eventTime);
		$(".popupcontroler>.bullit").eq(popupNum).addClass("on").siblings().removeClass("on");
	});

	$(".popupzone>.next").on("click",function(){
		if(popupMaxNum>popupNum){
		++	popupNum;
		}else{
			popupNum=0;
		}
		clearInterval(popupinter);
		$(".popup_w>.item").fadeOut(eventTime);
		$(".popup_w>.item").eq(popupNum).fadeIn(eventTime);
		$(".popupcontroler>.bullit").eq(popupNum).addClass("on").siblings().removeClass("on");
		popupinter = setInterval(popupinterv,time);
	});

	$(".popupzone>.prev").on("click",function(){
		if(popupNum>0){
		--	popupNum;
		}else{
			popupNum=popupMaxNum;
		}
		clearInterval(popupinter);
		$(".popup_w>.item").fadeOut(eventTime);
		$(".popup_w>.item").eq(popupNum).fadeIn(eventTime);
		$(".popupcontroler>.bullit").eq(popupNum).addClass("on").siblings().removeClass("on");
		popupinter = setInterval(popupinterv,time);
	});

		$(".popupcontroler>.btn_stop").click(function(){
			if($(this).hasClass("stop")){
				popupinter = setInterval(popupinterv,time);
				$(this).removeClass("stop");
			}else{
				clearInterval(popupinter);
				$(this).addClass("stop");
			}
		});
	}
};

$(document).ready(function(){
	autoplay:false
	// autoplayTimeout:5000
	autoplayHoverPause:false

	var portfolio1 = $('.portfolio.pc');
	var portfolio2 = $('.portfolio.mobile');
	portfolio1.owlCarousel({
		items:3,
		loop:true,
		margin:29,
		autoplay:true,
		autoplayHoverPause:true,
		nav:true,
		dots:true
	});
	portfolio2.owlCarousel({
		loop:true,
		margin:10,
		autoplay:true,
		autoplayHoverPause:true,
		dots:true,
		stagePadding: 100,
		responsive:{
			0:{
				items:1,
				stagePadding: 50,
			},
			480:{
				items:1
			},
			768:{
				items:2,
				stagePadding: 100
			}
		}
	});

});

$(function(){
	$(".rel-btn.n1").on("click", function(){
		$(".rel-list.n1").toggleClass("on")
		$(".rel-btn.n1").toggleClass("on")
	})
	$(".rel-btn.n2").on("click", function(){
		$(".rel-list.n2").toggleClass("on")
		$(".rel-btn.n2").toggleClass("on")
	})

	//상단 검색창
	$(".u_l .search > a").on("click", function(){
		$(".search-area").addClass("on")
	})
	$(".search-area .searchClose").on("click", function(){
		$(".search-area").removeClass("on")
	})
})

$(function(){
	var navbar = document.getElementById("navbar");
	if(navbar != null){
		window.onscroll = function() {myFunction()};
		var sticky = navbar.offsetTop;
		function myFunction() {
			if (window.pageYOffset >= sticky) {
				navbar.classList.add("sticky")
			} else {
				navbar.classList.remove("sticky");
			}
		}
	}
})

$(function(){
	$("#container div.s-naviBox").hide()
	$("#container #navbar li.sns").click(function(){
  		if($("#container ul.snsList > li").is(":hidden")){
    		$("#container div.s-naviBox").css({"opacity":1}).slideDown("slow");
  		}else{
  			$("#container div.s-naviBox").hide();
		}
	});
})