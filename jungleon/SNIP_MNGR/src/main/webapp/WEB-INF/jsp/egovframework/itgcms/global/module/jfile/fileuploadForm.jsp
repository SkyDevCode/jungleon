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
	<!-- 파일업로드 폼 추가 시작 -->
	<c:import  url="/afile/fileuploadForm.do">
		<c:param name="formName" value="bbsForm" />//해당업로드폼이 속해 있는 <form>태그 이름
		<c:param name="objectId" value="upload1" />//업로드폼 두곳 이상 사용 시 반드시 다르게 설정필요
		<c:param name="fileIdName" value="fileId" />//업로드폼 두곳 이상 사용 시 반드시 다르게 설정필요
		<c:param name="fileIdTitle" value="첨부파일"/>//파일 업로드폼을 구분할 수 있는 이름
		<c:param name="fileIdValue" value="${boardMap.fileId}" />
		<c:param name="fileTypes" value="${boardconfigVO.bcFiletypedesc}" />
		<c:param name="maxFileSize" value="${boardconfigVO.bcFilesize}" />
		<c:param name="maxFileCount" value="${boardconfigVO.bcFilecount}" />
		<c:param name="isRequired" value="N" />
		<c:param name="useSecurity" value="false" />
		<c:param name="uploadMode" value="db" />
	</c:import>
	<!-- 파일업로드 폼 추가 끝 -->

--%>

<div data-ax5uploader="${objectId}" id="${objectId}Div">
    <input type="hidden" name="fileName" value="${objectId}"/>
    <input type="hidden" name="fileIdName" value="${fileIdName}"/>
    <input type="hidden" name="${fileIdName}" value="${fileIdValue}" title="${fileIdTitle}"/>
    <input type="hidden" name="accept" value="${fileTypes}"/>
    <input type="hidden" name="maxFileSize" value="${maxFileSize}"/>
    <input type="hidden" name="maxFileCount" value="${maxFileCount}"/>
    <input type="hidden" name="useSecurity" value="${useSecurity}"/>
    <input type="hidden" name="uploadMode" value="${uploadMode}"/>
    <label data-ax5uploader-button="selector" id="label${objectId}" class="btn btn-info trigger-file-input">파일선택 (<span class="fileTypeDesc"></span>)</label>
    <div data-uploaded-box="${objectId}" data-ax5uploader-uploaded-box="block"></div>
	<div style="padding: 5px;" data-btn-wrap="">
		<span class="help">※ 파일을 첨부, 삭제 후에 반드시 변경사항을 적용해야 반영됩니다.(순서변경제외) <a class="btn btn-primary" data-upload-btn="${objectId}_apply">적용</a></span>
	</div>
</div>

<script>
    var ${objectId}_SWAP_URL = "/afile/fileSwap.do";
    var ${objectId}_dialog = new ax5.ui.dialog();
    ${objectId}_dialog.setConfig({lang:{"ok":"확인","cancel":"취소"}});
    var ${objectId} = new ax5.ui.uploader();
    var ${objectId}_Form = document.${formName};
    var ${objectId}_filecnt=0;
    var ${objectId}_errorcnt=0;
    var ${objectId}_successcnt=0;
    var ${objectId}_fileChange = false;
    var ${objectId}_applyFiles = [];
    var ${objectId}_fileIdxs = [];
    var ${objectId}_delIdxs = [];

    if(!ax5.info.supportFileApi){
    	$("#label${objectId}").attr("for","inputFile${objectId}");
    }

    $(function () {

    	$(".fileTypeDesc").text(ItgJs.setAcceptTypeDesc('${fileTypes}'));
    	${objectId}.setConfig({
            debug: true,
            target: $('[data-ax5uploader="${objectId}"]'),
            form: {
                action: "/afile/fileUpload.do",
                fileName: "${objectId}",
                fileIdName:"${fileIdName}",
                fileIdValue:"${fileIdValue}",
                fileTypes:"${fileTypes}",
                maxFileSize:"${maxFileSize}",
                maxFileCount:"${maxFileCount}",
                useSecurity:"${useSecurity}",
                uploadMode:"${uploadMode}"
            },
            accept: ItgJs.setAcceptType('${fileTypes}'),
            multiple: true,
            manualUpload: false,

            progressBox: true,
            progressBoxDirection: "left",

            dropZone: {
                target: $('[data-uploaded-box="${objectId}"]')
            },
            uploadedBox: {
                target: $('[data-uploaded-box="${objectId}"]'),
                icon: {
                    "download": '<i class="fa fa-download" aria-hidden="true"></i>',
                    "delete": '<i class="fa fa-minus-circle" aria-hidden="true"></i>',
                    "arrowup": '<i class="fa fa-arrow-circle-up" aria-hidden="true"></i>',
                    "arrowdown": '<i class="fa fa-arrow-circle-down" aria-hidden="true"></i>'
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
                    supportedHTML5_emptyListMsg: '<div class="text-center">이곳에 파일을 올려놓거나 파일선택 버튼을 눌러주세요.</div>',
                    emptyListMsg: '<div class="text-center">파일이 없습니다.</div>'
                },
                onchange: function () {

                },
                onclick: function () {
                    // console.log(this.cellType);
                    var fileIndex = this.fileIndex;
                    var file = this.uploadedFiles[fileIndex];
                    switch (this.cellType) {
                        case "delete":

                            ${objectId}_dialog.confirm({
                                title: '파일명 : '+file.fileName,
                                msg: '이 파일을 정말 삭제하시겠습니까?',
                                btns: {
                                    del: {label:'삭제', theme:'warning'},
                                    cancel: {label:'취소'}
                                }
                            }, function(key){
                            	//console.log(key,this);
                            	if (this.key == "del") {
                            		${objectId}.removeFile(fileIndex);
                            		${objectId}_delIdxs.push(""+file.fileIdx);
                            		${objectId}_fileChange = true;
                                }
                            });

                            break;

                        case "filename":
                        case "filesize":
                        case "download":
                            location.href = file.downloadPath;
                            break;

                        case "arrowup":
                        	if(fileIndex==0){ ${objectId}_dialog.alert("더이상 위로 올라갈 수 없습니다."); return;}

							if(${objectId}_delIdxs.length + ${objectId}.uploadedFiles.length  > 0 && ${objectId}_fileChange){
								${objectId}_dialog.alert("순서변경을 위해서는 먼저 기존의 변경사항을 적용하여 주시기 바랍니다.\n'적용'버튼 클릭."); return;
							}else{
	                            $.ajax({
	                                url: ${objectId}_SWAP_URL,
	                                method: "post",
	                                data:"mode=UP&fileIdx="+file.fileIdx,
	                                success: function (res) {
	                                	//console.log(res);
	                                	var result = res.result;//프로세스 성공
	                                	if(result == '1'){
	                                		${objectId}.swapFileUp(fileIndex);
	                                	}
	                                }
	                            });
							}
                            break;

                        case "arrowdown":
                        	if(fileIndex==this.uploadedFiles.length-1){ ${objectId}_dialog.alert("더이상 아래로 내려갈 수 없습니다."); return;}
                        	//프로세스진행
							//${objectId}_dialog.alert("location.href ="+ ${objectId}_SWAP_URL + "?mode=DOWN&schIdx="+file.fileIdx);
							//console.log("arrowdown change : "+${objectId}_delIdxs.length + ${objectId}.uploadedFiles.length  > 0 && ${objectId}_fileChange);
							if(${objectId}_delIdxs.length + ${objectId}.uploadedFiles.length  > 0 && ${objectId}_fileChange){
								${objectId}_dialog.alert("순서변경을 위해서는 먼저 기존의 변경사항을 적용하여 주시기 바랍니다.\n'적용'버튼 클릭"); return;
							}else{
	                            $.ajax({
	                                url: ${objectId}_SWAP_URL,
	                                method: "post",
	                                data:"mode=DOWN&fileIdx="+file.fileIdx,
	                                success: function (res) {
	                                	//console.log(res);
	                                	var result = res.result;//프로세스 성공
	                                	if(result == '1'){
	                                		${objectId}.swapFileDown(fileIndex);
	                                	}
	                                }
	                            });
							}

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
	                       			window.open("http://localhost:8080/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );

                       			 	/* 운영서버 */
                       				/* window.open("http://localhost/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */

                       				/* 개발서버 */
	                       			/* window.open("http://snipm.sitegood.co.kr/data/skin/doc.html?fn="+mask+"&rs=/data/html/", "문서바로보기", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); */

                        		}
	                    		, error : function(jqXHR,textStatus,e){
	                    			alert("문서변환 중 오류가 발생하였습니다. 관리자에게 문의해 주세요.");
	                    			return;
	                    		}
	                    	});

                            break;
                    }
                }
            },
            validateSelectedFiles: function () {
                console.log("validateSelectedFiles");
                if(this.uploadedFiles.length + this.selectedFiles.length > ${maxFileCount}){
                	${objectId}_dialog.alert("등록 가능한 최대 파일 개수는 ${maxFileCount}개 입니다.\n기존파일개수 : "+this.uploadedFiles.length+", 신규선택개수 : "+this.selectedFiles.length);
                	return false;
                }else{
                	var returnflag = true;
                	this.selectedFiles.some(function(file) {
						console.log(file);

				        // 사이즈체크
				        var maxSize  = ${maxFileSize} * 1024 * 1024 //MB
						var fileSize = 0;
				    	// 브라우저 확인
				    	var browser=navigator.appName;
				    	// 익스플로러일 경우
				    	if (browser=="Microsoft Internet Explorer"){
				    		var oas = new ActiveXObject("Scripting.FileSystemObject");
				    		fileSize = oas.getFile( file.value ).size;
				    	}else{// 익스플로러가 아닐경우
				    		fileSize = file.size;
				    	}
						if(fileSize > maxSize){
							${objectId}_dialog.alert("등록 가능한 최대 파일 용량은 ${maxFileSize}MB입니다.\n-파일이름 : "+file.name+"\n-파일용량 : "+Math.ceil(file.size/1024/1024)+"MB");
							returnflag = false;
							return true; //some 메소드를 멈추기 위해 true 리턴
						}
                	});
                	return returnflag;
                }
            },
            onprogress: function (p1) {
            	//var files = this.uploadedFiles;
            	//console.log("onprogress : "+this);
            	//console.log("onprogress : "+p1);
            },
            onuploaded: function (p1) {
            	var _index = p1["@i"];
            	//console.log("onuploaded index : "+_index);
            	//console.log("onuploaded : "+p1.result);
            	if(p1.result == "0"){
            		${objectId}_errorcnt++;
            		this.self.removeFile(_index);
            		//this.self.abort();
            	}else{
            		${objectId}_Form.${fileIdName}.value=p1.fileId;
            		$.each(${objectId}.$inputItems,function(i,$item){
            			if($item.name == "${fileIdName}"){
            				$item.value = p1.fileId;//IE9 HTML5 fileAPI 미지원 브라우저
		            		//console.log("$item name : "+$item.name+", value : "+$item.value);
            			};
            		});
            	}
            	${objectId}_filecnt++;
            },
            onuploaderror: function (e) {
                //console.log("error : "+this.error);
                //console.log(e.resultMsg);
                //${objectId}_dialog.alert(this.error.message);
                ${objectId}_dialog.alert(e.resultMsg);
            },
            onuploadComplete: function () {
            	if(${objectId}_errorcnt>0){
            		${objectId}_dialog.alert(${objectId}_filecnt+'개의 파일전송 중\n'+${objectId}_errorcnt+'개의 파일에서 오류가 발생하였습니다.\n확인 후 다시 올려주시기 바랍니다.');
            		${objectId}_errorcnt=0;
            	}
            	${objectId}_filecnt=0;
            	${objectId}_fileChange = true;
            }
        });

        $.ajax({
            url: "/afile/fileList.do",
            data:"fileId=${fileIdValue}",
            success: function (res) {
                ${objectId}.setUploadedFiles(res);
            }
        });

        $('[data-btn-wrap]').clickAttr(this, "data-upload-btn", {

            "${objectId}_apply": function () {

				if(${objectId}_delIdxs.length + ${objectId}.uploadedFiles.length  > 0 && ${objectId}_fileChange){
	                ${objectId}_dialog.confirm({
	                    title: "변경적용",
	                    msg: "변경사항을 적용 하시겠습니까?"
	                }, function () {
	                    if (this.key == "ok") {

	                        ${objectId}.uploadedFiles.forEach(function (f) {
	                        	${objectId}_fileIdxs.push(""+f.fileIdx);
	                        });

	                        $.ajax({
	                            type: "POST",
	                            url: "/afile/fileIdxApply.do",
	                            data: {"fileIdxs":${objectId}_fileIdxs,"delIdxs":${objectId}_delIdxs},
	                            success: function (res) {
	                                if (res.result=='0') {
	                                	${objectId}_dialog.alert("파일 변경 사항 적용 중 오류가 발생하였습니다.");
	                                    return;
	                                }
	                                ${objectId}_fileChange = false;//초기화
	                                ${objectId}_fileIdxs = [];//초기화
	                                ${objectId}_delIdxs = [];//초기화
	                                ${objectId}_dialog.alert("완료 되었습니다.");
	                            }
	                        });
						}
	                });
                }else{
                	${objectId}_dialog.alert("파일 변경 사항이 없습니다.");
                }
            }
        });
    });

/*     function ${objectId}_checkFileChangeSubmit(title, exitfunction, runfuncion){
		alert(title+" : "+${objectId}_delIdxs.length+","+ ${objectId}_fileChange+","+(${objectId}_delIdxs.length + ${objectId}.uploadedFiles.length > 0 && ${objectId}_fileChange));
		if(${objectId}_delIdxs.length > 0 || ${objectId}_fileChange){
			${objectId}_dialog.confirm({
                title: title+" 추가/삭제",
                msg: title+" 추가/삭제 내역이 있습니다.\n적용버튼을 클릭하여 변경사항을 적용하여 주시기 바랍니다.\n무시하고 계속 저장하실 경우 변경 내역은 사라집니다.",
                btns: {
                    ok: {label:'확인', theme:'warning'},
                    go: {label:'무시하고 계속 저장'}
                }
            }, function () {
                if (this.key == "ok") {
                	exitfunction();
				}else{
					runfuncion();
				}
            });
		}else{
			truefunction();
		}
    } */

    function ${objectId}_checkFileChangeSubmit(title){
		//alert(title+" : "+${objectId}_delIdxs.length+","+ ${objectId}_fileChange+","+(${objectId}_delIdxs.length + ${objectId}.uploadedFiles.length > 0 && ${objectId}_fileChange));
		<c:if test="${isRequired eq 'Y'}">
		if(${objectId}.uploadedFiles.length == 0){
			alert(title+"은(는) 필수입력사항입니다. 파일을 첨부해주세요.");
			return false;
		};
		</c:if>
		if(${objectId}_delIdxs.length > 0 || ${objectId}_fileChange){
			alert(title+" 추가/삭제 내역이 있습니다.\n적용버튼을 클릭하여 변경사항을 적용하여 주시기 바랍니다.");
			return false;
			//return (confirm(title+" 추가/삭제 내역이 있습니다.\n적용버튼을 클릭하여 변경사항을 적용하여 주시기 바랍니다.\n무시하고 계속 저장하실 경우 변경 내역은 사라집니다.\n(확인:무시 하고 저장, 취소:취소하고 나가기)"));
		}
		return true;
    }
</script>