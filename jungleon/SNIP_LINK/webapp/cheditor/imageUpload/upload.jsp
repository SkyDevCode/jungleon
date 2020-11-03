<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ include file="config.jsp" %>

<%
try {
    long fileSize = 0;
    String saveFileName = null;

	File saveFolder = new File(SAVE_DIR);
	if (!saveFolder.exists() || saveFolder.isFile()) {
		saveFolder.setExecutable(false, true);
		saveFolder.setReadable(true);
		saveFolder.setWritable(true, true);
		saveFolder.mkdirs();
	}

    MultipartRequest mRequest = new MultipartRequest(request, SAVE_DIR, fileSizeLimit, encoding, new DefaultFileRenamePolicy());

    saveFileName = mRequest.getFilesystemName("file");
    File file = mRequest.getFile("file");

    if (file == null) {
        throw new Exception("-ERR: No File");
    }

    fileSize = file.length();

    if (fileSize < 1) {
        throw new Exception("-ERR: File Size 0");
    }

    URLConnection connection = file.toURL().openConnection();
    String mimeType = connection.getContentType();

	//if (!mimeType.equals("image/jpeg") && !mimeType.equals("image/pjpeg") && !mimeType.equals("image/gif") && !mimeType.equals("image/x-png") && !mimeType.equals("image/png"))
	if (!mimeType.startsWith("image/"))
		throw new Exception("-ERR: NOT Image");

    File sFile = new File(SAVE_DIR + saveFileName);

    String rData = String.format("{\"fileUrl\":\"%s%s\", \"filePath\":\"%s%s\", \"fileName\":\"%s\", \"fileSize\":\"%d\"}",
                            SAVE_URL, saveFileName, SAVE_DIR, saveFileName, saveFileName, fileSize);
    out.println(rData);
} catch(Exception e) {
	System.out.println(e.getMessage());
}
%>