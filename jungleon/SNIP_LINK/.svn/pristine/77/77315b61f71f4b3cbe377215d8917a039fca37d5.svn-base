package egovframework.itgcms.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.model.PlaylistItem;
import com.google.api.services.youtube.model.PlaylistItemListResponse;
import com.google.common.collect.Lists;

public class YoutubePlayList {

 /** Global instance of the HTTP transport. */
  private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();

  /** Global instance of the JSON factory. */
  private static final JsonFactory JSON_FACTORY = new JacksonFactory();

  /** Global instance of YouTube object to make all API requests. */
  private static YouTube youtube;

  public String getPosts() {

	String result = "";

	//Scope required to upload to YouTube.
	List<String> scopes = Lists.newArrayList("https://www.googleapis.com/auth/youtube");

	youtube = new YouTube.Builder(HTTP_TRANSPORT, JSON_FACTORY, null).setApplicationName(
	          "youtube-cmdline-myuploads-sample").build();
	List<PlaylistItem> playlistItemList = new ArrayList<PlaylistItem>();

	try {
		YouTube.PlaylistItems.List playlistItemRequest =
		        youtube.playlistItems().list("contentDetails,snippet");

		 playlistItemRequest.setPlaylistId("PLWtlp60AoqOS0Ers_RG7BmLhK8mK0NzQ8");
		 playlistItemRequest.setKey("AIzaSyAxXY-PDjoxU45FQN4qhtQqWYf5vht8xV4");
		 playlistItemRequest.setMaxResults((long) 12);
		 playlistItemRequest.setFields(
         "items(contentDetails/videoId,snippet/title,snippet/publishedAt,snippet/description)");

		 PlaylistItemListResponse playlistItemResult = playlistItemRequest.execute();
		 playlistItemList.addAll(playlistItemResult.getItems());

	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	return prettyPrint(playlistItemList.size(), playlistItemList.iterator());

  }

  /*
   * Method that prints all the PlaylistItems in an Iterator.
   *
   * @param size size of list
   *
   * @param iterator of Playlist Items from uploaded Playlist
   */
  private static String prettyPrint(int size, Iterator<PlaylistItem> playlistEntries) {

	String result = "";


    while (playlistEntries.hasNext()) {
      PlaylistItem playlistItem = playlistEntries.next();

      long epochMillis = playlistItem.getSnippet().getPublishedAt().getValue();
      ZonedDateTime zonedDateTime = ZonedDateTime.ofInstant(Instant.ofEpochMilli(epochMillis),
             						ZoneId.systemDefault());
      String pubDate = zonedDateTime.format(DateTimeFormatter.ofPattern("MM월 dd일 a h시 m분 "));

      result += "<div class=\"list\">";
      result += "		<div class=\"img_area\">";
      result += "			<a href='https://www.youtube.com/watch?v="+playlistItem.getContentDetails().getVideoId()+"' target='_blank'>";
      result += "				<img src=\"http://img.youtube.com/vi/"+playlistItem.getContentDetails().getVideoId()+"/default.jpg\" alt=\""+playlistItem.getSnippet().getTitle()+"\" />";
      result += "			  	<span class=\"tit\">"+playlistItem.getSnippet().getTitle()+"</span>";
      result += "	  		</a>";
      result += "		</div>";
      result += "		<div class=\"txt_area\">";
      result += "			<a href='https://www.youtube.com/watch?v="+playlistItem.getContentDetails().getVideoId()+"' target='_blank'>";
      result += "			  	<span class=\"tit\">"+playlistItem.getSnippet().getTitle()+"</span>";
      result += "	  		 </a>";
      result += "			 <span class=\"date\">"+pubDate+"</span>";
      result += "		</div>";
      result += "</div>";
    }

    return result;
  }
}