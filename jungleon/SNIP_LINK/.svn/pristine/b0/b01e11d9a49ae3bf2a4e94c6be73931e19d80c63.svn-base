package egovframework.itgcms.user.member.web;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.MultiPartEmail;

import egovframework.com.cmm.service.EgovProperties;

public class EgovMultiPartEmail extends MultiPartEmail {
	private String id = EgovProperties.getProperty("Email.id");
	private String password = EgovProperties.getProperty("Email.password");
	private int port = Integer.parseInt(EgovProperties.getProperty("Email.port"));
	private String host = EgovProperties.getProperty("Email.host");
	private String emailAddress = EgovProperties.getProperty("Email.emailAddress");
	private String senderName = EgovProperties.getProperty("Email.senderName");
	private boolean useTls;
	private boolean useSsl;

	public EgovMultiPartEmail() {
		String tempTls = EgovProperties.getProperty("Email.useTls");
		String tempSsl = EgovProperties.getProperty("Email.useSsl");
		this.useTls = !tempTls.equals("false");
		this.useSsl = !tempSsl.equals("false");
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getPort() {
		return this.port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getHost() {
		return this.host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getEmailAddress() {
		return this.emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getSenderName() {
		return this.senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public boolean getUseTls() {
		return this.useTls;
	}

	public void setUseTls(boolean useTls) {
		this.useTls = useTls;
	}

	public boolean getUseSsl() {
		return this.useSsl;
	}

	public void setUseSsl(boolean useSsl) {
		this.useSsl = useSsl;
	}

	public String send() throws EmailException {
		super.setCharset("utf-8");
		super.setHostName(this.host);
		super.setSmtpPort(this.port);
		super.setTLS(this.useTls);
		super.setSSL(this.useSsl);
		super.setAuthenticator(new DefaultAuthenticator(this.id, this.password));
		super.setSocketConnectionTimeout(600000);
		super.setSocketTimeout(600000);
		super.setFrom(this.emailAddress, this.senderName);
		return super.send();
	}
}