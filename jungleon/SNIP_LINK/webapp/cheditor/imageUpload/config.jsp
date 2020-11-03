<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="egovframework.itgcms.util.CommUtil" %>


<%
String SAVE_DIR = CommUtil.getFileRoot("") + "/editor/attach/";
String SAVE_URL = "/data/COMMON/editor/attach/";

int fileSizeLimit = 50 * 1000 * 1000;
String encoding = "utf-8";

%>