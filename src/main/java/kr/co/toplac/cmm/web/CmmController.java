package kr.co.toplac.cmm.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by kohyeonseok on 2017. 6. 29..
 */
@Controller
public class CmmController {
    @RequestMapping(value = "/page_navi")
    public String pageGen(){
        return "util_page/page_navi";
    }

    @RequestMapping(value = "/page_navi2")
    public String pageGen2(){
        return "util_page/page_navi2";
    }
    
    @RequestMapping(value = "/page_navi_multi")
    public String pageMultiGen(){
        return "util_page/page_navi_multi";
    }
    
    @RequestMapping(value = "/page_navi_vacation_list")
    public String pageVacation(){
        return "util_page/page_navi_vacation_list";
    }
    
    @RequestMapping(value = "/page_navi_leave_list")
    public String pageLeave(){
        return "util_page/page_navi_leave_list";
    }
    
    @RequestMapping(value = "/page_navi_leave_result")
    public String pageLeaveResult(){
        return "util_page/page_navi_leave_result";
    }
    
    @RequestMapping(value = "/page_navi_vacation_result")
    public String pageVacationResult(){
        return "util_page/page_navi_vacation_result";
    }
    
    @RequestMapping(value = "/page_navi_leave_search")
    public String pageLeaveSearch(){
        return "util_page/page_navi_leave_search";
    }
    
    @RequestMapping(value = "/page_navi_vacation_search")
    public String pageVacationSearch(){
        return "util_page/page_navi_vacation_search";
    }
    
    @RequestMapping(value = "/page_navi_vacation_manager_search")
    public String pageVacationManagerSearch(){
        return "util_page/page_navi_vacation_manager_search";
    }
    
    @RequestMapping(value = "/page_navi_vacation_annual")
    public String pageVacationAnnual(){
        return "util_page/page_navi_vacation_annual";
    }
    
    @RequestMapping(value = "/page_navi_nilink_list")
    public String pageNiLinkList(){
        return "util_page/page_navi_nilink_list";
    }
    
    @RequestMapping(value = "/page_navi_login_list")
    public String pageLoginList(){
        return "util_page/page_navi_login_list";
    }
    
    @RequestMapping(value = "/page_navi_search_list")
    public String pageSearchList(){
        return "util_page/page_navi_search_list";
    }
    
    @RequestMapping(value = "/page_navi_ptnr_member_search")
    public String pagePtnrMemberSearch(){
        return "util_page/page_navi_ptnr_member_search";
    }
    
    @RequestMapping(value = "/page_navi_ptnr_company_search")
    public String pagePtnrCompanySearch(){
        return "util_page/page_navi_ptnr_company_search";
    }
    
}
