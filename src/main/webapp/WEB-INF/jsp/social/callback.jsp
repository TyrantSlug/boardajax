<%-- <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
  <head>
    <title>네이버로그인</title>
  </head>
  <body>
  <%
    String clientId = "VXjYInITwpfPtDZDVliJ";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "TzmhLMeX1C";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("YOUR_CALLBACK_URL", "UTF-8");
    String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
        + "&client_id=" + clientId
        + "&client_secret=" + clientSecret
        + "&redirect_uri=" + redirectURI
        + "&code=" + code
        + "&state=" + state;
    String accessToken = "";
    try {
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      if (responseCode == 200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuilder res = new StringBuilder();
      while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
      }
      br.close();

      if (responseCode == 200) {
        // 액세스 토큰을 파싱
        JSONObject json = new JSONObject(res.toString());
        accessToken = json.getString("access_token");
        
        // 액세스 토큰을 사용하여 사용자 프로필 정보를 요청
        String header = "Bearer " + accessToken;
        String profileApiURL = "https://openapi.naver.com/v1/nid/me";
        URL profileURL = new URL(profileApiURL);
        HttpURLConnection profileCon = (HttpURLConnection) profileURL.openConnection();
        profileCon.setRequestMethod("GET");
        profileCon.setRequestProperty("Authorization", header);
        int profileResponseCode = profileCon.getResponseCode();
        BufferedReader profileBr;
        if (profileResponseCode == 200) { // 정상 호출
            profileBr = new BufferedReader(new InputStreamReader(profileCon.getInputStream()));
        } else {  // 에러 발생
            profileBr = new BufferedReader(new InputStreamReader(profileCon.getErrorStream()));
        }
        StringBuilder profileRes = new StringBuilder();
        while ((inputLine = profileBr.readLine()) != null) {
            profileRes.append(inputLine);
        }
        profileBr.close();
        if (profileResponseCode == 200) {
            JSONObject profileJson = new JSONObject(profileRes.toString());
            JSONObject responseObject = profileJson.getJSONObject("response");
            String nickname = responseObject.getString("nickname");
            
            out.println("User Nickname: " + nickname);
        }
      }
    } catch (Exception e) {
      out.println("Error: " + e.getMessage());
    }
  %>
  </body>
</html>
 --%>