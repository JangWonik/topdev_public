package kr.co.toplac.topdisaster;

import kr.co.toplac.util.cmm.RequestUtil;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class DisasterCostController {
    private static final Logger logger = LoggerFactory.getLogger(DisasterCostController.class);
    
    @Autowired
    private SqlSession sqlSession;
    
    /**
     * 이재 조사 비용 리스트
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_cost_list")
    public String list(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    
        //===============================================
        // 비즈니스 로직
        //===============================================
        List<Map<String, Object>> list = sqlSession.selectList("DisasterCost.selectList",paramMap);
        Long count = sqlSession.selectOne("DisasterCost.selectListCnt",paramMap);
    
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("srchArg",paramMap);
        model.addAttribute("list", list);
        
        return "top_disaster/disaster_cost_list";
    }
    
    /**
     * 이재 조사 비용 뷰
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_cost_view")
    public String view(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("srchArg",paramMap);
        return "top_disaster/disaster_cost_view";
    }
    
    /**
     * 이재 조사 비용 쓰기 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_cost_write")
    public String write(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("srchArg",paramMap);
        return "top_disaster/disaster_cost_write";
    }
    
    /**
     * 이재 조사 비용 입력
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_cost_insert")
    public String insert(HttpServletRequest request) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        return "redirect:/disaster_cost_list";
    }
    
    /**
     * 이재 조사 비용 수정 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_cost_edit")
    public String edit(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("srchArg",paramMap);
        return "top_disaster/disaster_cost_edit";
    }
    
    /**
     * 이재 조사 비용 수정
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_cost_update")
    public String update(HttpServletRequest request) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        return "redirect:/disaster_cost_list";
    }
    
    /**
     * 이재 조사 비용 삭제
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_cost_delete")
    public String delete(HttpServletRequest request) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        return "redirect:/disaster_cost_list";
    }
}
