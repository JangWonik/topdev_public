package kr.co.toplac.cmm.service;

import org.springframework.stereotype.Service;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

@Service
public class BitlyShortUrlService {

    private static final String ACCESS_TOKEN = "fcad5462f8cf1fc20b70992da3aea3ad04c2b5f1"; // 여기에 실제 토큰 입력

    public String shortenUrl(String longUrl) {
        try {
            String apiUrl = "https://api-ssl.bitly.com/v4/shorten";
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + ACCESS_TOKEN);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);

            String jsonInput = "{\"long_url\": \"" + longUrl + "\"}";
            OutputStream os = conn.getOutputStream();
            os.write(jsonInput.getBytes("UTF-8"));
            os.flush();
            os.close();

            int responseCode = conn.getResponseCode();
            if (responseCode != 200 && responseCode != 201) {
                System.err.println("Bitly HTTP 오류: " + responseCode);
                return longUrl;
            }

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = in.readLine()) != null) {
                response.append(line);
            }
            in.close();
            conn.disconnect();

            JSONObject json = new JSONObject(response.toString());
            String shortUrl = json.getString("link");
            System.out.println("Bitly Success: " + shortUrl);
            return shortUrl;

        } catch (Exception e) {
            System.err.println("Bitly Exception: " + e.getMessage());
            e.printStackTrace();
            return longUrl;
        }
    }
}
