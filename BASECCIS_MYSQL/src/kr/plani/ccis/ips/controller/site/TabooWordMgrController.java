package kr.plani.ccis.ips.controller.site;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.TabooWord;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.TabooWordMgrService;

@Controller
@RequestMapping(value="/mgr/tabooWordMgr")
public class TabooWordMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(TabooWordMgrController.class);

	@Resource
	private TabooWordMgrService tabooWordMgrService;
	
	@Resource
	private CommonService commonService;

	@RequestMapping()
	public ModelAndView list(@ModelAttribute TabooWord tabooWord, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		tabooWord.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, tabooWord);

		// 금기어설정 조회
		List<?> list = tabooWordMgrService.selectTabooWordList(tabooWord);

		//실행결과 로기 생성
		this.resultLog(tabooWord);
		
		// View 설정
		model.addAttribute("result", list);

		//페이징 정보
		model.addAttribute("rowCnt", tabooWord.getRowCnt());	//페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map)list.get(0)).get("TOTAL_CNT"))));	//전체 카운트
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(tabooWord.getMenuId()) +
				  "&keyBoard=" + StringUtil.nullCheck(tabooWord.getKeyBoard()) +
				  "&keyBoardVal=" + StringUtil.nullCheck(tabooWord.getKeyBoardVal()) +
				  "&schText="+StringUtil.nullCheck(tabooWord.getSchText());
		
		model.addAttribute("link", strLink);
		
		tabooWord.setJsp("site/tabooWordMgr/list");
		return new ModelAndView("ips.layout", "obj", tabooWord);
	}
	
	@RequestMapping(value="/listAjax")
	public @ResponseBody List<?> listAjax(@ModelAttribute TabooWord tabooWord, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		tabooWord.setInParam(request);
		
		// 금기어설정 조회
		List<?> list = tabooWordMgrService.selectTabooWordList(tabooWord);

		return list;
	}
	
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public @ResponseBody int insert(@ModelAttribute TabooWord tabooWord, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		tabooWord.setInParam(request);
		
		// 저장
		int cnt = 0;
		if(tabooWord.getSeq() > 0){
			cnt = tabooWordMgrService.updateTabooWord(tabooWord);
		}else{
			tabooWordMgrService.insertTabooWord(tabooWord);
			cnt = tabooWord.getSeq();
		}

		return cnt;
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute TabooWord tabooWord, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		tabooWord.setInParam(request);		

		// 저장
		tabooWordMgrService.deleteTabooWord(tabooWord);
				
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(tabooWord.getMenuId()) +
				  "&keyBoard=" + StringUtil.nullCheck(tabooWord.getKeyBoard()) +
				  "&keyBoardVal=" + StringUtil.nullCheck(tabooWord.getKeyBoardVal()) +
				  "&schText="+URLEncoder.encode(StringUtil.nullCheck(tabooWord.getSchText()), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/tabooWordMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
}
