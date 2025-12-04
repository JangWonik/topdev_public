package kr.co.toplac.util.cmm;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.HttpVersion;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Created by icwking on 2015. 11. 2..
 */
@Component
public class HttpProxy {
    /**
     * POST 요청
     * @param url       요청할 url
     * @param params    파라메터
     * @param encoding  파라메터 Encoding
     * @return 서버 응답결과 문자열
     */
    public String post(String url, Map params, String encoding){
        HttpClient client = new DefaultHttpClient();
        //HttpClient client = HttpClientBuilder.create().build();
        //CloseableHttpClient client = HttpClients.createDefault();

        try{
            HttpPost post = new HttpPost(url);
            System.out.println("POST : " + post.getURI());

            List<NameValuePair> paramList = convertParam(params);
            post.setEntity(new UrlEncodedFormEntity(paramList, encoding));

            ResponseHandler<String> rh = new BasicResponseHandler();

            return client.execute(post, rh);

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            client.getConnectionManager().shutdown();
            //client.close();
        }

        return "error";
    }

    public String post(String url, Map params){
        return post(url, params, "UTF-8");
    }




    /**
     * GET 요청
     * POST 와 동일
     */
    public String get(String url, Map params, String encoding){
        HttpClient client = new DefaultHttpClient();

        try{
            List<NameValuePair> paramList = convertParam(params);
            HttpGet get = new HttpGet(url+"?"+ URLEncodedUtils.format(paramList, encoding));
            System.out.println("GET : " + get.getURI());

            ResponseHandler<String> rh = new BasicResponseHandler();

            return client.execute(get, rh);
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            client.getConnectionManager().shutdown();
        }

        return "error";
    }

    public String get(String url, Map params){
        return get(url, params, "UTF-8");
    }



    private List<NameValuePair> convertParam(Map params){
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        Iterator<String> keys = params.keySet().iterator();
        while(keys.hasNext()){
            String key = keys.next();
            paramList.add(new BasicNameValuePair(key, params.get(key).toString()));
        }

        return paramList;
    }


    public String borwserGet(String url){

        CloseableHttpClient httpClient = HttpClients.createDefault();

        // Request configuration can be overridden at the request level.
        // They will take precedence over the one set at the client level.
        RequestConfig requestConfig = RequestConfig.custom()
                .setSocketTimeout(5000)
                .setConnectTimeout(5000)
                .setConnectionRequestTimeout(5000)
                .build();

        HttpGet httpget = new HttpGet(url);

        httpget.setConfig(requestConfig);
        httpget.setHeader("User-Agent", "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101206 Firefox/3.6.13");

        // Execution context can be customized locally.
        HttpClientContext context = HttpClientContext.create();
        // Contextual attributes set the local context level will take
        // precedence over those set at the client level.
        context.setAttribute("http.protocol.version", HttpVersion.HTTP_1_1);

        String contents = "";

        try {

            // Execute the method.
            HttpResponse response = httpClient.execute(httpget);
            int statusCode = response.getStatusLine().getStatusCode();

            if (statusCode != HttpStatus.SC_OK) {
                throw new IllegalStateException("Method failed: " + response.getStatusLine());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent())));

            StringBuffer buf = new StringBuffer();
            String output;
            while ((output = br.readLine()) != null) {
                buf.append(output);
            }

            contents =  buf.toString();

        } catch (Exception e) {

            e.printStackTrace();

        } finally {
            // Release the connection.
            try {
                httpClient.close();
            }catch (Exception e){
                e.printStackTrace();
            }

        }

        return contents;
    }

    // Test
//    public static void main(String[] args) {
//        HttpProxy p = new HttpProxy();
//
//        Map params = new HashMap();
//        params.put("w", "tot");
//        params.put("q", "한예슬");
//
//        System.out.println(p.get("http://m.search.daum.net/search", params));
//    }
}
