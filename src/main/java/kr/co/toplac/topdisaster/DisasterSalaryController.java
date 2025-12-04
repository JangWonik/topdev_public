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
public class DisasterSalaryController {
    private static final Logger logger = LoggerFactory.getLogger(DisasterSalaryController.class);
    
    @Autowired
    private SqlSession sqlSession;
    
    /**
     * 이재 조사 연봉 리스트
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_salary_list")
    public String list(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    
        //===============================================
        // 비즈니스 로직
        //===============================================
        List<Map<String, Object>> list = sqlSession.selectList("DisasterSalary.selectList",paramMap);
        Long count = sqlSession.selectOne("DisasterSalary.selectListCnt",paramMap);
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("srchArg",paramMap);
        model.addAttribute("list", list);
        
        return "top_disaster/disaster_salary_list";
    }
    
    /**
     * 이재 조사 연봉 뷰
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_salary_view")
    public String view(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("srchArg",paramMap);
        return "top_disaster/disaster_salary_view";
    }
    
    /**
     * 이재 조사 연봉 쓰기 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_salary_write")
    public String write(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("srchArg",paramMap);
        return "top_disaster/disaster_salary_write";
    }
    
    /**
     * 이재 조사 연봉 입력
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_salary_insert")
    public String insert(HttpServletRequest request) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
    
        
        return "redirect:/disaster_salary_list";
    }
    
    /**
     * 이재 조사 연봉 수정 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_salary_edit")
    public String edit(HttpServletRequest request, Model model) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        //===============================================
        // 뷰단 데이터 세팅
        //===============================================
        model.addAttribute("srchArg",paramMap);
        return "top_disaster/disaster_salary_edit";
    }
    
    /**
     * 이재 조사 연봉 수정
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_salary_update")
    public String update(HttpServletRequest request) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        return "redirect:/disaster_salary_list";
    }
    
    /**
     * 이재 조사 연봉 삭제
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/disaster_salary_delete")
    public String delete(HttpServletRequest request) throws Exception {
        //===============================================
        //	파라미터 체크
        //===============================================
        Map<String, Object> paramMap = RequestUtil.getParameterMap(request);
        
        
        return "redirect:/disaster_salary_list";
    }
    
    
}
