<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>

<ul class="bg">
	<c:forEach var="result" items="${slidesItemList}" varStatus="status">
		<c:set var="mainBgUrl" value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemImg,result.slitemImg) }"/>
		<c:set var="mainStyleValue" value="background:url(${mainBgUrl}) no-repeat center center/cover;"/>
		<c:set var="tTxtStyleValue" value=""/>
  		<c:set var="sTxtStyleValue" value=""/>
 		<c:choose>
	  		<c:when test="${result.slitemLinkgubun eq '2'}">
	  			<c:choose>
			  		<c:when test="${result.slitemLinktimg eq '' or result.slitemLinktimg eq null}">
						<c:set var="h3class" value="stit2"/><!-- 링크아이템 타이틀텍스트만보임-->
						<c:set var="tTxtStyleValue" value="color:${result.slitemLinktcolor};"/>
					</c:when>
			  		<c:otherwise>
			  			<c:set var="h3class" value="stit1"/><!-- 링크아이템 타이틀이미지만보임-->
			  		</c:otherwise>
				</c:choose>
				<c:choose>
			  		<c:when test="${result.slitemLinksimg eq '' or result.slitemLinksimg eq null}">
						<c:set var="pclass" value="stxt2"/><!-- 링크아이템 설명텍스트만보임-->
						<c:set var="sTxtStyleValue" value="color:${result.slitemLinkscolor};"/>
					</c:when>
			  		<c:otherwise>
			  			<c:set var="pclass" value="stxt1"/><!-- 링크아이템 설명이미지만보임-->
			  		</c:otherwise>
				</c:choose>
				<c:choose>
			  		<c:when test="${result.slitemLinkbtn eq '' or result.slitemLinkbtn eq null}">
						<c:set var="bclass" value="sbtnn"/><!-- 링크아이템 버튼안보임-->	
					</c:when>
			  		<c:otherwise>
			  			<c:set var="bclass" value="sbtn1"/><!-- 링크아이템 버튼노출-->	
			  		</c:otherwise>
				</c:choose>					
			</c:when>
	  		<c:otherwise>
	  			<c:set var="h3class" value="stitn"/><!-- 링크아이템 안보임-->
	  			<c:set var="pclass" value="stxtn"/><!-- 링크아이템 안보임-->
	  			<c:set var="bclass" value="sbtnn"/><!-- 링크아이템 안보임-->
	  		</c:otherwise>
		</c:choose>
		
		<li class="st${status.count}" style="<c:out value="${mainStyleValue}" />">
			<c:choose>
				<c:when test="${result.slitemLinktype eq '1' }">
				<a href="${result.slitemLinkurl}" class="txt <c:out value="${ufn:isNull(result.slitemLinkposhor, 'l')} ${ufn:isNull(result.slitemLinkposver, 't')}"/>">						
				</c:when>
				<c:when test="${result.slitemLinktype eq '2' }">
				<a href="${result.slitemLinkurl}" class="txt <c:out value="${ufn:isNull(result.slitemLinkposhor, 'l')} ${ufn:isNull(result.slitemLinkposver, 't')}"/>" target="_blank">						
				</c:when>
				<c:otherwise>
				<a href="#none" class="txt">
				</c:otherwise>
			</c:choose>
				<h3 class="${h3class}">
					<span style="${tTxtStyleValue}">${result.slitemLinkttxt}</span>
			  		<img src="<c:out value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemLinktimg,result.slitemLinktimg) }"/>" alt="${ufn:getAntiHtml(result.slitemLinkttxt, '1')}"/>
				</h3>
				<p class="${pclass}">
					<span style="${sTxtStyleValue}">${result.slitemLinkstxt}</span>
			  		<img src="<c:out value="/comm/download.do?f=${ufn:getDownloadLink('','slides',result.slitemLinksimg,result.slitemLinksimg) }"/>" alt="${ufn:getAntiHtml(result.slitemLinkstxt, '1')}"/>
				</p>
				<span class="${bclass}"><c:out value="${result.slitemLinkbtn}" /></span>
			</a>
		</li>
	</c:forEach>
</ul>			