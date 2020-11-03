<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ufn"    uri="/WEB-INF/tlds/egovfn.tld"%>
<%@ taglib prefix="orderby" uri="/WEB-INF/tlds/orderby.tld" %>
<c:set var="nowUrl" value="${fn:replace(pageContext.request.requestURL,pageContext.request.requestURI,'')}"/>

<%-- 삽입하고자 하는 위치에 아래 태그 추가--%>
<%--
	<!-- 파일다운로드 폼 추가 시작 -->
	<c:import  url="/afile/filedownForm.do">
		<c:param name="formName" value="bbsForm" />
		<c:param name="objectId" value="download1" />
		<c:param name="fileIdName" value="fileId" />
		<c:param name="fileIdValue" value="${boardMap.fileId}" />
		<c:param name="useSecurity" value="false" />
		<c:param name="uploadMode" value="db" />
	</c:import>
	<!-- 파일다운로드 폼 추가 끝  -->
--%>

<div data-ax5uploader="${objectId}" id="${objectId}Div">
	<input type="hidden" name="fileIdName" value="${fileIdName}"/>
    <input type="hidden" name="${fileIdName}" value="${fileIdValue}"/>
    <input type="hidden" name="useSecurity" value="${useSecurity}"/>
    <input type="hidden" name="uploadMode" value="${uploadMode}"/>
	<label data-ax5uploader-button="selector" id="label${objectId}" style="display:none">파일선택 (<span class="fileTypeDesc"></span>)</label>
    <div data-uploaded-box="${objectId}" data-ax5uploader-uploaded-box="block"></div>
</div>

<script>

    var ${objectId}_dialog = new ax5.ui.dialog();
    ${objectId}_dialog.setConfig({lang:{"ok":"확인","cancel":"취소"}});
    var ${objectId} = new ax5.ui.uploader();
    var ${objectId}_Form = document.${formName};
    $(function () {

    	${objectId}.setConfig({
            uploadMode: "download",
            debug: false,
            target: $('[data-ax5uploader="${objectId}"]'),
            form: {
                action: "/afile/fileUpload.do",
                fileName: "${objectId}"
            },
            uploadedBox: {
                target: $('[data-uploaded-box="${objectId}"]'),
                icon: {
                    "download": '<i class="fa fa-download" aria-hidden="true"></i>',
                    "previewUrl": '<i class="fa fa-download" aria-hidden="true"></i>'
                },
                columnKeys: {
                	fileIdx: "fileIdx",
                	fileId: "fileId",
                    name: "fileName",
                    type: "ext",
                    size: "fileSize",
                    uploadedName: "fileMask",
                    isImage: "isImage",
                    downloadPath: "downloadPath",
                    downloadCount: "downloadCount"
                },
                lang: {
                    supportedHTML5_emptyListMsg: '<div class="text-center">파일이 없습니다.</div>',
                    emptyListMsg: '<div class="text-center">파일이 없습니다.</div>'
                },
                onclick: function () {
                    // console.log(this.cellType);
                    var fileIndex = this.fileIndex;
                    var file = this.uploadedFiles[fileIndex];
                    switch (this.cellType) {
                        case "filename":
                        case "filesize":
                        case "downloadCount":
                        case "download":
                            location.href = file.downloadPath;
                            break;

                        case "previewUrl":
                        	var fileIdx = file.fileIdx;
                        	var fileName = file.fileName;
                         	var fileMask = file.fileMask;
                         	fileMask = fileMask.substr(0, 6);
                            $.ajax({
                        		type : "post"
                        		, url : "/web/link/userPreview.ajax"
                        		, data : { "fileIdx":fileIdx,"fileName" : fileName  }
                                , cache: false
                        		, dataType : "json"
                        		, async: false
                        		, success : function(data){
                        			var mask = data.fileMaskExt;
                        			var fileName = data.fileName;
                        			var fileFolder = data.fileFolder;
                        			fileFolder = fileMask.substr(0, 6);

                        			/* 로컬서버 */
                       				//window.open("http://localhost/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );

                       			 	/* 운영서버 */
                       			 	window.open("https://snip.or.kr/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );

                       			 	/* 개발서버 */
                       			 	/* window.open("http://snip.sitegood.co.kr/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */

                        		}
	                    		, error : function(jqXHR,textStatus,e){
	                    			alert("문서변환 중 오류가 발생하였습니다. 관리자에게 문의해 주세요.");
	                    			return;
	                    		}
	                    	});

                            break;
                    }
                }
            }
        });

        $.ajax({
            url: "/afile/fileList.do",
            data:"fileId=${fileIdValue}",
            success: function (res) {
                ${objectId}.setUploadedFiles(res);
            }
        });
    });
</script>