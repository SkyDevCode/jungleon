package egovframework.itgcms.util;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;


public class NaverBlogRss {
	private int rssCnt = 12; //가져올 포스트 개수
    private String rssUrl = "https://rss.blog.naver.com/snsnip2001.xml"; //rss 주소

    /**
     *  블로그의 최근 포스트 5개를 문자열로 반환
     */
    public String getPosts() {
        String result = "";

        SAXBuilder saxBuilder = new SAXBuilder();

        try {
            Document doc = saxBuilder.build(rssUrl);
            Element root = doc.getRootElement();

            Element e_channel = root.getChild("channel");
            List<Element> children = e_channel.getChildren("item");
            Iterator<Element> iter = children.iterator();
            for (int i=0; i<rssCnt; i++) {
                if(!iter.hasNext()) break;
                Element e = iter.next();

                String link = e.getChildTextTrim("link");
                String title = e.getChildTextTrim("title");
                String pubDate = e.getChildTextTrim("pubDate");
                String description = e.getChildTextTrim("description");
                String imgPath = "/resource/templete/cms1/src/img/common/navi_home.png";

                SimpleDateFormat sdf = new SimpleDateFormat("MM월 dd일 a h시 mm분");
                Date pubdate = new Date();
                pubDate = sdf.format(pubdate);

               /* result += "<div class=\"list\">";
                result += "		<div class=\"img_area\">";
                result += "			<a href='"+link+"' target='_blank'>";
                result += "				<img src=\""+imgPath+"\" alt=\""+title+"\" />";
                result += "			  	<span class=\"tit\">"+description+"</span>";
                result += "	  		</a>";
                result += "		</div>";
                result += "		<div class=\"txt_area\">";
                result += "	 		 <a href='"+link+"' class='title' target='_blank'>";
                result += "			  	<span class=\"tit\">"+description+"</span>";
                result += "	  		 </a>";
                result += "			 <span class=\"date\">"+pubDate+"</span>";
                result += "		</div>";
                result += "</div>";

                <div class=\"main_blog_area img_area\">
					<a href="#" target="_blank" title='해당게시물 네이버 블로그 페이지로 새창으로 이동' class='txt'>
						<span class="title">네이버 블로그네이버 블로그네이버 블로그네이버 블로그네이버 블로그네이버 블로그</span>
						<span class="text">안녕하세요?성남산업진흥원에서 NCS(국가직무능력표준)기업활용 컨설팅 사업에 참여할 기업을 모집합니다. *NCS 기업활용 컨설팅은? 국가직무능력표준의 활용 확산을 통한 능력중심사회 구현을 위해 시행되는 사업으로서, 기업의 직무를 분석하여 채용 또는 재직자 훈련의 체계를 마련, NCS 기반 능력중심의 역량 개발 및 인적자원 관리 체계를 마련할 수 있도록 컨설팅을 지원하는 사업. <참여기업 모집 >□ 사 업 명 : 2020년도 NCS 기업활용 컨설팅 사업 □ 주최/주관 : 고용노동부, 한국산업인력공단 □ 수행기관 : 성남산업진흥원 □ 컨설팅 비용 : 전액 무료 (정부지원) □ 신청대상 : 관내 중견·중소기업 중 상시 근로자 수 30인.......</span>
						<span class="date">12월 19일 오후 4:25</span>
					</a>
				</div>*/
                result += "<div class=\"main_blog_area img_area\">";
                result += "			<a href='"+link+"' target='_blank' class='txt'>";
                result += "			  	<span class=\"title\">"+title+"</span>";
                result += "			  	<span class=\"text\">"+description+"</span>";
                result += "			  	<span class=\"date\">"+pubDate+"</span>";
                result += "	  		</a>";
                result += "</div>";

            }

        } catch (JDOMException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * 하나의 포스트 정보를 담을수있는 객체
     * 내부 클래스로 정의
     */
    public class PostData {

        String link;
        String title;
        String description;

        public PostData() {

        }

        public PostData(String link, String title, String description) {
            super();
            this.link = link;
            this.title = title;
            this.description = description;
        }

    }
}
