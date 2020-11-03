/**
****************************************************
TouchEnNx_config.js
****************************************************
| Version     작성자        수정일        변경사항 
 ---------  -------  -----------  ----------
 | v1.0.0.7    강남준    2020.02.17
 | v1.0.0.6    강남준    2019.07.05
 | v1.0.0.5    강남준    2018.12.14
 | v1.0.0.4    백서린    2018.11.12
 | v1.0.0.3    강남준    2018.05.14
 | v1.0.0.2    허혜림    2018.01.31
 | v1.0.0.1    허혜림    2017.12.20          

****************************************************
 Copyright ⒞ RaonSecure Co., Ltd. 
****************************************************
**/

var nxKeyConfig ={};
nxKeyConfig.version = {
	
	extension :   {
		exChromeExtVer		:	"1.0.0.0",
		exFirefoxExtVer		:	"1.0.2.5",
		exFirefoxJpmExtVer	:	"1.0.1.12",
		exOperaExtVer		:	"1.0.1.14"
	},
		
	/** 키보드보안 설정 */
		tkappiver			:	"1.0.0.69",
		tkappmver			:	"1.0.0.59",
		exWinVer			:	"1.0.0.75",
		exWin64Ver			:	"1.0.0.75",
		exWinProtocolVer	:	"1.0.1.1243",
		daemonVer			:   "1.0.2.8",
		macDaemonVer		:   "1.0.1.5",
		linuxDaemonVer		:   "1.0.0.1",
		exMacVer			:	"1.0.0.11",
		exMacProtocolVer	:	"1.0.1.1392"
};

nxKeyConfig.module = {
	
	extension	:{
		//exChromeExtDownURL	: "https://chrome.google.com/webstore/detail/dncepekefegjiljlfbihljgogephdhph",
		exChromeExtDownURL	: "https://download.raonsecure.com/extension/chrome/chrome.html",
		exFirefoxExtDownURL	: TouchEnNxConfig.path.base + "/extension/touchenex_firefox.xpi",
		exFirefoxJpmExtDownURL	: TouchEnNxConfig.path.base + "/extension/jpm_touchenex_firefox.xpi",
		exOperaExtDownURL	: TouchEnNxConfig.path.base + "/extension/touchenex_opera.nex"
	},
	
		exWinClient		            :	TouchEnNxConfig.path.base + "/nxKey/module/TouchEn_nxKey_32bit.exe",
		exWin64Client            	:	TouchEnNxConfig.path.base + "/nxKey/module/TouchEn_nxKey_64bit.exe",
		daemonDownURL				:	TouchEnNxConfig.path.base + "/nxKey/module/TouchEn_nxKey_32bit.exe",
		macDaemonDownURL			:	TouchEnNxConfig.path.base + "/nxKey/module/TouchEn_nxKey_Installer.pkg",
	//	ubuntu32DaemonDownURL		:	TouchEnNxConfig.path.base + "/nxKey/module/CrossEXService_32bit.deb",
	//	ubuntu64DaemonDownURL		:	TouchEnNxConfig.path.base + "/nxKey/module/CrossEXService_64bit.deb",
	//	fedora32DaemonDownURL		:	TouchEnNxConfig.path.base + "/nxKey/module/CrossEXService_32bit.rpm",
	//	fedora64DaemonDownURL		:	TouchEnNxConfig.path.base + "/nxKey/module/CrossEXService_64bit.rpm",
		exMacClient					:	TouchEnNxConfig.path.base + "/nxKey/module/TouchEn_nxKey_Installer.pkg",
		exMacProtocolDownURL		: 	TouchEnNxConfig.path.base + "/nxKey/module/TouchEn_nxKey_Installer.pkg"
};

/** 키보드보안 E2E 를 사용하지 않을 경우 주석해제*/
var _TNK_SR = "";

if(typeof TNK_SR =="string"){
	_TNK_SR = TNK_SR;
}

/**	클라이언트 솔루션별 동작 설정*/
TouchEnNxConfig.solution={
		nxkey : {
				tekOption : {
					"pki": "TouchEnkeyEx",
				    "keyboardonly": "false",
				    "defaultenc": "false",
				    "verify": "1",
				    "defaultpaste": "true",
				    "iframename": "",
				    "usegetenc": "false",
				    "clearbufferonempty": "true",
				    "refreshsession": "true",
				    "improve": "true",
					"bstart": 0,
				    "setcallback": "false",
				    "usebspress": "false",
				    "ignoreprogress": "true",
				    "ignoreprogress2": "true",
				    "exformname": "",
				    "idbase": "true",
				    "allcrypt": "false",
					"browserinfo" : "",
					"cert" : "-----BEGIN CERTIFICATE-----MIIDQzCCAiugAwIBAgIJAOYjCX4wgWNXMA0GCSqGSIb3DQEBCwUAMGcxCzAJBgNVBAYTAktSMR0wGwYDVQQKExRSYW9uU2VjdXJlIENvLiwgTHRkLjEaMBgGA1UECxMRUXVhbGl0eSBBc3N1cmFuY2UxHTAbBgNVBAMTFFJhb25TZWN1cmUgQ28uLCBMdGQuMB4XDTE2MDUzMTAxMTgzMVoXDTQ2MDUyNDAxMTgzMVowPzELMAkGA1UEBhMCS1IxFzAVBgNVBAoTDkNJVElCQU5LIEtPUkVBMRcwFQYDVQQDEw5DSVRJQkFOSyBLT1JFQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMILlJ9A+jmDywYyZX77hzzy77s0mW9oVRMhyVQAi2WQn2R9FD9J7pz3ebgdMbECQO6kZjI1M9A3m5AYkvFuChfUt6Bb68Z6fEAcFZR3KyQBfprBd7LPorG4DD4E//c87GsO4T4xYE1z4kPnN27rckTiTv42AfY9RYOu+D0NmZt8ggnOJhOGFcoOAkQTyCRo8qYEXOpKp/BYWsLjA5pCwK4GIMUKB/AXjqd7zfXpRQCvV3yFvKXIx75w1LKs98Px6sFnQW1GkERnlzGCPp2MjWt3gSBt9tyVDzfuuMq146alksQHJBw6It4bKNlPcX9ZKxVJU7Lzq+5qpT/xgOyQ3Z8CAwEAAaMaMBgwCQYDVR0TBAIwADALBgNVHQ8EBAMCBeAwDQYJKoZIhvcNAQELBQADggEBAAx9V5f8Wgt0Busyi3UJruW8SLYj07B8E5MbLqd1G6euQANUVYr8CAYDn5BITyzMvkKf1sp+NrfeP0FHhdrcF0UB3PJLXac2ZQcbm2ZPGn1skJa+CPbCVzRlGZkbpNzfB2mE4co75oyDPag8U507n/Tt2tPu4GS59bvHyuq2E7vn/sJG5Kyz0CeuSekp1shT4jYFrpcZ95gckAeN1mBO2ylts6H6K+B3mdtj4ElhLrlcn92O6ya8WHCt1Jsu0bSyUmQ35TIk5mC6R6DDI2TbjTtQ19i6dAFyHxggMppf1ibNkWOgl4Ii5Bj1JPvIiDwIxvusrSF+44xJZptXfO2Xosk=-----END CERTIFICATE-----",
					"srdk": _TNK_SR,
					"generate_event": "false",
					"driverexcept": "0",
					"delayedck": "false",
					"shiftbypass": "true",
					"allowdup": "false",
					"enc2": "false",
				    "searchformname":"",
					"runtype": TouchEnNxConfig.runtype,
					"tk_isRunningSecurity" : "false", 
					"isAllowIdOverlap" : "true", //히든필드 중복오류 수정시 false설정 및 서버버전 v2.0.3.3 적용필요
					"defaultsecurityid" : "true",
					"newModule" : "true"
				}
		}
};