package kr.co.toplac.cmm.service;

import org.springframework.stereotype.Service;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@Service
public class ShortUrlService {

    public String shortenUrl(String longUrl) {
        try {
            // 1. https:// → http:// 변경
            String urlForApi = longUrl.replace("https://", "http://");

            // 2. % 치환
            String tempUrl = urlForApi.replace("%", "___PERCENT___");

            // 3. UTF-8 인코딩
            String encodedTemp = URLEncoder.encode(tempUrl, "UTF-8");

            // 4. % 복구
            String encodedUrl = encodedTemp.replace("___PERCENT___", "%");

            String apiUrl = "http://tinyurl.com/api-create.php?url=" + encodedUrl;

            System.out.println("TinyURL 요청: " + apiUrl.substring(0, Math.min(200, apiUrl.length())) + "...");

            // 5. HttpURLConnection으로 직접 호출 (리다이렉트 차단!)
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setInstanceFollowRedirects(false);  // 리다이렉트 차단!
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                System.err.println("TinyURL HTTP 오류: " + responseCode);
                return longUrl;
            }

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String shortUrl = in.readLine();
            in.close();
            conn.disconnect();

            if (shortUrl == null || shortUrl.contains("Error") || shortUrl.isEmpty()) {
                System.err.println("TinyURL 실패: " + shortUrl);
                return longUrl;
            }

            System.out.println("TinyURL 성공: " + shortUrl);
            return shortUrl;

        } catch (Exception e) {
            System.err.println("TinyURL 예외: " + e.getMessage());
            e.printStackTrace();
            return longUrl;
        }
    }
}