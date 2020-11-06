package egovframework.itgcms.util;

import java.text.SimpleDateFormat;
import java.util.List;

import twitter4j.JSONArray;
import twitter4j.JSONObject;
import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;


public class TwitterRss {

	// 한성길 책임 테스트 계정
	// final static String CONSUMER_KEY        = "wcprHSt3hdJK938yOuMiYSgli";
	// final static String CONSUMER_SECRET     = "VRKvxDs3A6FCjzPOvPborAjdCYcFW659nR9E98y04gyKkx9jkS";
	// final static String ACCESS_TOKEN        = "1272719922087354369-xQ5KN29cA2Yo5gAW5tz3TrWEaaEK56";
	// final static String ACCESS_TOKEN_SECRET = "DtIDQ43yF1TqUa6qZTllZOUfDpKjCHcQFhbXF2YvA9mIi";

	// 성남 계정
	final static String CONSUMER_KEY        = "Ov1qx3q1Idz4ojOMo5m9XQklT";
	final static String CONSUMER_SECRET     = "7GgZTvI5LTjKKFqpR0URwilDON0OdoaeJ3rRCJ3Yt6HDgI0mpu";
	final static String ACCESS_TOKEN        = "172209891-Yesp59at9sA34XkSMde0YsFua2NcRl4MzvIjPzyj";
	final static String ACCESS_TOKEN_SECRET = "eZwt7XurIcCjBpCnrAlePfBkM35p5iWUabTJv5I7hdpd3";

	 public String getPosts() {

		String result = "";

		Twitter twitter = new TwitterFactory().getInstance();

		try {
			AccessToken token = null;
			twitter.setOAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET);
			token = new AccessToken(ACCESS_TOKEN, ACCESS_TOKEN_SECRET);
			twitter.setOAuthAccessToken(token);

			User user = twitter.verifyCredentials();
			Paging paging = new Paging(1, 10);
			List<Status> list = twitter.getUserTimeline(paging);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 M월 d일 a h:mm");

			for(Status status : list) {
				String link = "https://twitter.com/" + user.getScreenName() + "/status/" + status.getId();
	            String title = status.getText();
	            String pubDate = sdf.format(status.getCreatedAt());
	            String description = status.getText();

				result += "<div class=\"main_blog_area img_area\">";
                result += "			<a href='"+link+"' target='_blank' class='txt'>";
                result += "			  	<span class=\"title\">"+title+"</span>";
                result += "			  	<span class=\"text\">"+description+"</span>";
                result += "			  	<span class=\"date\">"+pubDate+"</span>";
                result += "	  		</a>";
                result += "</div>";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	 return result;

	 }
}
