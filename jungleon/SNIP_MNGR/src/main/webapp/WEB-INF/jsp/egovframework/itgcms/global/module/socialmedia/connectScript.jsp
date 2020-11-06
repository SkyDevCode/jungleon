<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:if test="${naver != null}">
	<div id="naver_id_login" style="display:none;"></div>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</c:if>

<script>
/*****************************************************************
******************************************************************
*********************  SNS 관련 script start    *************************
******************************************************************
******************************************************************/
/*
<c:if test="${twitter != null}">
window.twttr = (function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0],
	    t = window.twttr || {};
	  if (d.getElementById(id)) return t;
	  js = d.createElement(s);
	  js.id = id;
	  js.src = "https://platform.twitter.com/widgets.js";
	  fjs.parentNode.insertBefore(js, fjs);

	  t._e = [];
	  t.ready = function(f) {
	    t._e.push(f);
	  };

	  return t;
	}(document, "script", "twitter-wjs"));
</c:if>


 */


$(function(){
	<c:if test="${facebook != null}">
		$.ajaxSetup({ cache: true });

		$.getScript('//connect.facebook.net/en_US/sdk.js', function(){
			FB.init({
		      appId: "${facebook.smAppkey}",
		      version: 'v2.9'
		    });
			fbLogout();
	  });

		$("input[name='facebook_Use']").on("ifChecked",function(){
			if ($(this).val() == "Y") {
				fbLogin();
			}
		});
	</c:if>

	<c:if test="${naver != null}">
		$("input[name='naver_Use']").on("ifChecked",function(){
			if ($(this).val() == "Y") {
				$("#naver_id_login").find("a").click();
			}
		});
	</c:if>
	/*
	<c:if test="${twitter != null}">
		$("input[name='twitter_Use']").on("ifChecked",function(){
			if ($(this).val() == "Y") {
				twitLoginPop();
			}
		});
	</c:if> */
});


	<c:if test="${facebook != null}">
		var fbUserId = "${facebook.smUserid}";
		var fbAccessToken = "${facebook.smAccesstoken}";

		function fbLogout(alert){
			 FB.getLoginStatus(function(response) {
		        if (response && response.status === 'connected') {
		            FB.logout();
		           	fbResetAccessToken(fbAccessToken, fbUserId, "N", function(){
		       		});
		        }
		    });
			 if (alert) {
				 alert("페이스북 연결을 해제 하였습니다.");
			 }

		}

		function fbLogin(){

			 FB.getLoginStatus(function(response) {
		        if (response && response.status === 'connected') {
		        } else {
		        	FB.login(function(res){
		       		 if (res.status === 'connected') {
		      				fbResetAccessToken(res.authResponse.accessToken, res.authResponse.userID, "Y", function(){
		      					alert("페이스북 연결에 성공하였습니다.");
		      				});
		       		  } else {
		       			  FB.login(function(res){
		       			 	 fbResetAccessToken(res.authResponse.accessToken, res.authResponse.userID, "Y", function(){
		       					alert("페이스북 연결에 성공하였습니다.");
		       				});
		       		    }, {scope:"publish_pages,manage_pages,publish_actions"});
		       		  }
		        	}, {scope:"publish_pages,manage_pages,publish_actions"});
		        }
		    });

		}

		function fbResetAccessToken(accToken, userId, accessible, callBack){
			 $.ajax({
					url : "/_mngr_/socialKey/facebookAT_comm.do",
					type : "POST",
					data : {
						accessToken : accToken,
						userID : userId,
						siteCode : "${mngrSiteVO.siteCode}",
						accessible : accessible
					},
					success : function(data){
						if (data.error) {
							fbLogin();
						} else {
							fbAccessToken = data.access_token;
						}

						if (callBack) {
							callBack();
						}
					},
					error : function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
			});
		}


	</c:if>


	<c:if test="${naver != null}">

		var naver_id_login = new naver_id_login("${naver.smAppkey}", "${naver.etc1}");
		//alert(naver_id_login.oauthParams.access_token);
		var state = naver_id_login.getUniqState();
		naver_id_login.response_type = "code";
		naver_id_login.setState(state);
	  	naver_id_login.setPopup();
	  	naver_id_login.init_naver_id_login();

	  	var nvUserId = "${nv.smUserid}";
		var nvAccessToken = "${nv.smAccesstoken}";



		function nvResetAccessToken(accToken, userId, accessible, callBack) {
			$.ajax({
				url : "/_mngr_/socialKey/naverAT_comm.do",
				type : "POST",
				data : {
					accessToken : accToken,
					userID : userId,
					siteCode : "${mngrSiteVO.siteCode}",
					accessible : accessible
				},
				success : function(data){
					if (callBack) {
						callBack(data);
					}
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	</c:if>




	/*
	<c:if test="${twitter != null}">

		function twitLoginPop(){

			$.ajax({
				url : "/_mngr_/socialKey/twitterToken.do",
				data : {
					siteCode : "${mngrSiteVO.siteCode}"
				},
				success : function(data){
					var popUrl = "https://api.twitter.com/oauth/authorize?oauth_token="+data;
					var popOption = "width=710, height=360, resizable=no, scrollbars=no, status=no;";
					window.open(popUrl,"",popOption);
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});


		}

		function twResetAccessToken(accToken, verifier, accessible, callBack) {
			$.ajax({
				url : "/_mngr_/socialKey/twitterAT_comm.do",
				type : "POST",
				data : {
					accessToken : accToken,
					userID : verifier,
					siteCode : "${mngrSiteVO.siteCode}",
					accessible : accessible
				},
				success : function(data){
					if (callBack) {
						callBack(data);
					}
				},
				error : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}


	</c:if>
	 */
</script>
