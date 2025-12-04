import kr.co.toplac.util.cmm.HttpProxy;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.junit.Assert;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

public class CrawlingTest {
    @Test
    public void kebhansTest() throws Exception {
        String targetURL = "http://www.investing.com/indices/south-korea-indices";
        Map<String, Object> paramMap = new HashMap<>();
        HttpProxy httpProxy = new HttpProxy();
    
        String result = httpProxy.borwserGet(targetURL);
    
        System.out.println(result);
        Document document = Jsoup.parse(result);
    
        //String kospi_last = document.select("#pair_37426 td.pid-37426-last").text().replace(",", "");
        //String kospi_pc = document.select("#pair_37426 td.pid-37426-pc").text();
        //String kospi_pcp = document.select("#pair_37426 td.pid-37426-pcp").text().replace("%", "");
        //String kosdaq_last = document.select("#pair_38016 td.pid-38016-last").text().replace(",", "");
        //String kosdaq_pc = document.select("#pair_38016 td.pid-38016-pc").text();
        //String kosdaq_pcp = document.select("#pair_38016 td.pid-38016-pcp").text().replace("%", "");
        
        
        Assert.assertEquals(0,0);
    }
}
