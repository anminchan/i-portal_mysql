package kr.plani.ccis.base.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.base.domain.SiteSet;
import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.common.util.FileUtil;
import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.domain.site.GuestInfo;
import kr.plani.ccis.ips.domain.site.Link;
import kr.plani.ccis.ips.domain.site.Tender;
import kr.plani.ccis.ips.domain.site.Title;
/*****************************************************************
* 공통 게시판 및 정적 컨트롤
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
* @since  2014. 8. 12. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2017. 05. 01.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/board")
public class BoardController extends BaseCommonController {
	private static final Logger logger = LoggerFactory.getLogger(BaseCommonController.class);

	/** 공통기능 서비스   */
	@Resource
	private BaseService baseService;
	
	@Value("#{config['upload.dir']}")
	private String uploadDir;
	
	/* 첨부파일관련 */
	@Resource
	private NamoCrossFile namoCrossFile;
	
	@Resource
	private FileUtil fileUtil;
	
	/*******************************************************************
	 * boardList 공통 정적컨텐츠, 게시판 목록
	 * @param request
	 * @param response
	 * @param contentSet
	 * @param content
	 * @param title
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 ******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response, @ModelAttribute ContentSet contentSet, 
			@ModelAttribute Content content, @ModelAttribute Title title, @ModelAttribute Tender tender, Model model) throws Exception {
		String viewJsp = "base/board/list";
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		// 기본 셋팅
		SiteSet siteSet = new SiteSet();
		this.setCommon(baseService, request, model, contentSet, siteSet);
		
		content.setCopyParam(contentSet);
		title.setCopyParam(contentSet);
		tender.setCopyParam(contentSet);
		
		SCookie usrSc = (SCookie)request.getSession().getAttribute("USER");
		String siteLayout = siteSet.siteLayer+".content";
		
		if(siteSet.siteLang.equals("E")){
			siteLayout = "commonEng.sub.layout";
		}
		if(siteSet.siteLayer.equals("mobile")){
			viewJsp = "baseMobile/board/list";
		}else{
			if(siteSet.siteLang.equals("E")){
				viewJsp = "baseEng/board/list";
			}
		}
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)baseService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();

		if(setItem == null){
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();
	        
	        out.println("<html>");
	        out.println("<head><title>설정정보  error page</title></head>");
	        out.println("<script type='text/javascript'>");
	        out.println("alert('설정 정보를 확인하세요.');"); 
	        out.println("history.back(-1);");
	        out.println("</script>");
	        out.println("</html>");
			
			return null;
		}
		model.addAttribute("rtnSetting", setItem);
		
		if(setItem.getImageYN().equals("Y")){
			if (setItem.getBoardKind().equals("LINK")) {
				setItem.setBoardKind("THUMBNAILLINK");
			} else {
				setItem.setBoardKind("THUMBNAIL");
			}
		}
		
		if(setItem.getBoardKind().equals("CONTENTS")){
			// Parameter 설정
			contentSet.setInParam(request);
			contentSet.setParamMenuId(contentSet.getMenuId());
			
			// 정적콘텐츠 조회
			Content rtnContent = (Content)baseService.getContent(content);
			model.addAttribute("content", (Content)rtnContent.getOutCursor());
			
			title.setJsp("/base/content");
			
			// 정적콘텐츠 모바일
			if(siteSet.siteType.equals("M")){
				title.setJsp("/baseMobile/content");
			}
		}else{
			// Parameter 설정
			title.setInParam(request);
			
			if(setItem.getPageCount() > 0){
				title.setRowCnt(setItem.getPageCount());
			}
			
			//Title rtnBoard = new Title();
			List<?> boardList = null;
			int boardListCnt = 0;
			
			if(setItem.getBoardKind().equals("NOTICE") || setItem.getBoardKind().equals("FREE")){
				// 공지형게시판 조회
				if(!setItem.getBoardListKind().equals("BASE")) viewJsp = "base/board/list_"+setItem.getBoardListKind();
					
				if(setItem.getBoardListKind().equals("CALENDAR")) {
					String today_year = StringUtil.getYear();
					String today_month = StringUtil.addZero(StringUtil.getMonth());
					String today_day = StringUtil.addZero(StringUtil.getDay());

					if (title.getYEAR() == null || title.getYEAR().equals("")) {
						title.setYEAR(today_year);
					}

					if (title.getMONTH() == null || title.getMONTH().equals("")) {
						title.setMONTH(today_month);
					}

					Calendar cal = StringUtil.getCalendar();
					cal.set(Integer.parseInt(title.getYEAR()), Integer.parseInt(title.getMONTH())+1, 0);

					String nextYear = StringUtil.formatter_y.format(cal.getTime()); 
					String nextMonth = StringUtil.formatter_m.format(cal.getTime()); 
					model.addAttribute("nextYear", nextYear);
					model.addAttribute("nextMonth", nextMonth);

					cal.set(Integer.parseInt(title.getYEAR()), Integer.parseInt(title.getMONTH())-1, 0);
					String beforeYear = StringUtil.formatter_y.format(cal.getTime()); 
					String beforeMonth = StringUtil.formatter_m.format(cal.getTime()); 
					model.addAttribute("prevYear", beforeYear);
					model.addAttribute("prevMonth", beforeMonth);

					title.setYearMonth(title.getYEAR() + title.getMONTH());

					model.addAttribute("DAYS", StringUtil.generateCalendar(Integer.parseInt(title.getYEAR()), Integer.parseInt(title.getMONTH())));
					model.addAttribute("YEAR", title.getYEAR());
					model.addAttribute("MONTH", StringUtil.addZero(title.getMONTH()));
					model.addAttribute("today_year", StringUtil.getCalendar().get(Calendar.YEAR));
					model.addAttribute("today_month", today_month);
					model.addAttribute("today_day", today_day);
				}
			}else if(setItem.getBoardKind().equals("THUMBNAIL") || setItem.getBoardKind().equals("VOD")){
				
				// 기본 boardStyle 지정
				if(contentSet.getBoardStyle() == null || contentSet.getBoardStyle().equals("") ){
					title.setBoardStyle("Gallery");
					
					if (StringUtil.isNotBlank(setItem.getThumbnailListKind()))
						title.setBoardStyle(setItem.getThumbnailListKind());
				}
				
				// boardStyle별 리스트 갯수 지정[pc - text : set value / image : 10 / gallery : 9] 
				if(title.getBoardStyle().equals("Text")){
					//title.setRowCnt(setItem.getRowCnt());
				}else if(title.getBoardStyle().equals("Image")){
					//title.setRowCnt(10);
				}else if(title.getBoardStyle().equals("Gallery")){
					
					title.setRowCnt(9);
										
					if(siteSet.siteType.equals("M")){
						//디자인 맞춘 후 작업해야함-임시로 4개
						title.setRowCnt(4);
					}
				}
				
				// 썸네일형게시판 조회
				viewJsp = "base/thumbnail/list"+title.getBoardStyle();
				
				if(siteSet.siteLang.equals("E")){
					viewJsp = "baseEng/thumbnail/list"+title.getBoardStyle();
				}
				
			}else if(setItem.getBoardKind().equals("THUMBNAILLINK")){
				
				// 기본 boardStyle 지정
				if (contentSet.getBoardStyle() == null
						|| contentSet.getBoardStyle().equals("")) {
					title.setBoardStyle("Gallery");
				}

				// boardStyle별 리스트 갯수 지정[text : set value / image : 10 / gallery
				// : 9]
				if(title.getBoardStyle().equals("Text")) {
					//title.setRowCnt(setItem.getRowCnt());
				}else if (title.getBoardStyle().equals("Image")) {
					//title.setRowCnt(10);
				}else if (title.getBoardStyle().equals("Gallery")) {
					title.setRowCnt(8);
				}
				
				// 썸네일형게시판 조회
				viewJsp = "base/thumbnailLink/list" + title.getBoardStyle();
				
			}else if(setItem.getBoardKind().equals("CARD")){
				
				// 기본 boardStyle 지정
				if(contentSet.getBoardStyle() == null || contentSet.getBoardStyle().equals("") ){
					title.setBoardStyle("Gallery");
				}
				
				// boardStyle별 리스트 갯수 지정[text : set value / image : 10 / gallery : 9] 
				if(title.getBoardStyle().equals("Text")){
					//title.setRowCnt(setItem.getRowCnt());
				}else if(title.getBoardStyle().equals("Image")){
					//title.setRowCnt(10);
				}else if(title.getBoardStyle().equals("Gallery")){;
					title.setRowCnt(9);
				}
				
				// 카드형게시판 조회
				viewJsp = "base/card/list"+title.getBoardStyle();
			}else{
				if(setItem.getBoardKind().equals("CLIPPING")){
					// 클리핑형게시판 조회
					viewJsp = "base/clipping/list";
				}else if(setItem.getBoardKind().equals("APPEAL")) {
					// 민원형게시판 조회
					viewJsp = "base/appeal/list";
				} else if (setItem.getBoardKind().equals("REPLY")) {
					// 관리자답변형게시판 조회
					viewJsp = "base/reply/list";
				}
			}
			
			if(setItem.getCustomizingYN() != null && setItem.getCustomizingYN().equals("Y") && (setItem.getBoardKind().equals("NOTICE") 
					|| setItem.getBoardKind().equals("FREE") || setItem.getBoardKind().equals("CLIPPING") || setItem.getBoardKind().equals("LINK"))){
				title.setBoardId(setItem.getBoardId());
				List<?> boardListSet = baseService.getBoardListSet(title);
				model.addAttribute("boardListSet", boardListSet);
				
				viewJsp = "base/dynamic/list";
			}
			
			boardList = baseService.getBoardList(title);
			boardListCnt = baseService.getBoardListCnt(title);

			//페이징 정보
			model.addAttribute("result", boardList);
			model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
			
			//링크 정보
			String strLink = "";
			
			strLink = "&menuId=" + StringUtil.paramUnscript(title.getMenuId()) + 
					  "&schType=" + StringUtil.paramUnscript(title.getSchType()+"") + 
					  "&schText=" + StringUtil.paramUnscript(StringUtil.nullCheck(title.getSchText())) +
					  "&boardStyle=" + StringUtil.paramUnscript(StringUtil.nullCheck(title.getBoardStyle())) +
					  "&categoryId=" + StringUtil.paramUnscript(StringUtil.nullCheck(title.getCategoryId())) +
					  "&continent=" + StringUtil.paramUnscript(StringUtil.nullCheck(title.getContinent())) +
					  "&country=" + StringUtil.paramUnscript(StringUtil.nullCheck(title.getCountry()));
			
			model.addAttribute("link", strLink);
			model.addAttribute("board", contentSet);
			
			title.setSchText(StringUtil.paramUnscript(StringUtil.nullCheck(title.getSchText())));
			title.setJsp(viewJsp);
		}

		return new ModelAndView(siteLayout, "obj", title);
	}

	/*******************************************************************
	 * boardView 게시판 상세
	 * @param request
	 * @param response
	 * @param contentSet
	 * @param link
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 ******************************************************************/
	@RequestMapping(value="/view")
	public ModelAndView boardView(HttpServletRequest request, HttpServletResponse response, @ModelAttribute ContentSet contentSet, @ModelAttribute Content content, @ModelAttribute Title title, @ModelAttribute Tender tender, @ModelAttribute Link link, Model model) throws Exception {
		String viewJsp = "base/board/view";
		
		if(contentSet.getMenuId() == null || contentSet.getMenuId().equals("") || contentSet.getMenuId().equals("-1")){
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();
	        
	        out.println("<html>");
	        out.println("<head><title>error page</title></head>");
	        out.println("<script type='text/javascript'>");
	        out.println("alert('해당 메뉴가 존재하지 않습니다.');");
	        out.println("history.back(-1);");
	        out.println("</script>");
	        out.println("</html>");
	        
	        return null;
		}else{
			if(link.getLinkId() <= -1){
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
		        PrintWriter out = response.getWriter();
		        
		        out.println("<html>");
		        out.println("<head><title>error page</title></head>");
		        out.println("<script type='text/javascript'>");
		        out.println("alert('해당 메뉴가 존재하지 않습니다.');");
		        out.println("history.back(-1);");
		        out.println("</script>");
		        out.println("</html>");
		        
		        return null;
			}
		}

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		SiteSet siteSet = new SiteSet();
		
		// 기본 셋팅
		this.setCommon(baseService, request, model, contentSet, siteSet);
		
		content.setCopyParam(contentSet);
		link.setCopyParam(contentSet);
		
		String siteLayout = siteSet.siteLayer+".content";
		
		if(siteSet.siteLang.equals("E")){
			siteLayout = "commonEng.sub.layout";
		}
		
		if(siteSet.siteType.equals("M")){
			viewJsp = "baseMobile/board/view";
		}else{
			if(siteSet.siteLang.equals("E")){
				viewJsp = "baseEng/board/view";
			}
		}
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)baseService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		model.addAttribute("rtnSetting", setItem);

		if(setItem.getBoardKind().equals("FREE") || setItem.getBoardKind().equals("NOTICE") || setItem.getBoardKind().equals("THUMBNAIL") || 
				setItem.getBoardKind().equals("VOD") || setItem.getBoardKind().equals("APPEAL") || setItem.getBoardKind().equals("REPLY") ||
				setItem.getBoardKind().equals("ETCNOTICE1") || setItem.getBoardKind().equals("CARD")){

			// Parameter 설정
			link.setInParam(request);

			Link rtnBoard = new Link();
			
			try {
				if(setItem.getBoardKind().equals("FREE")){
					// 자유게시판 상세조회
					rtnBoard = (Link)baseService.getFreeBoard(link);
					
					/*if(setItem.getBoardListKind().equals("FAQ")){
						viewJsp = "base/board/view_FAQ";
					}else if(setItem.getBoardListKind().equals("CONNECTION")){
						viewJsp = "base/board/view_CONNECTION";
					}else if(setItem.getBoardListKind().equals("DOWNLOAD")){
						viewJsp = "base/board/view_DOWNLOAD";
					}*/
				}else if(setItem.getBoardKind().equals("NOTICE")){
					// 자유게시판 상세조회
					rtnBoard = (Link)baseService.getNoticeBoard(link);
					
					//if(!setItem.getBoardListKind().equals("BASE")) viewJsp = "base/board/view_"+setItem.getBoardListKind();
					
					/*if(setItem.getBoardListKind().equals("FAQ")){
						viewJsp = "base/board/view_FAQ";
					}else if(setItem.getBoardListKind().equals("CONNECTION")){
						viewJsp = "base/board/view_CONNECTION";
					}else if(setItem.getBoardListKind().equals("DOWNLOAD")){
						viewJsp = "base/board/view_DOWNLOAD";
					}*/
				}else if(setItem.getBoardKind().equals("THUMBNAIL")){
					// 썸네일게시판 상세조회
					rtnBoard = (Link)baseService.getThumbnailBoard(link);
					viewJsp = "base/thumbnail/view";
					if(siteSet.siteType.equals("M")){
						viewJsp = "baseMobile/board/thumbnailView";
					}
					if(siteSet.siteLang.equals("E")){
						viewJsp = "baseEng/thumbnail/view";
					}
				}else if(setItem.getBoardKind().equals("VOD")){
					// 썸네일게시판 상세조회
					rtnBoard = (Link)baseService.getVodBoard(link);
					viewJsp = "base/thumbnail/view";
				}else if(setItem.getBoardKind().equals("CARD")){
					// 카드게시판 상세조회
					rtnBoard = (Link)baseService.getCardBoard(link);
					viewJsp = "base/card/view";
					if(siteSet.siteType.equals("M")){
						viewJsp = "baseMobile/board/cardView";
					}
					if(siteSet.siteLang.equals("E")){
						viewJsp = "baseEng/card/view";
					}
				}else if(setItem.getBoardKind().equals("APPEAL")) {
					// 민원게시판 상세조회
					rtnBoard = (Link) baseService.getAppealBoard(link);
					viewJsp = "base/appeal/view";

					model.addAttribute("rtnComment", rtnBoard.getOutCursor3());
				}else if(setItem.getBoardKind().equals("REPLY")) {
					// 관리자답변형게시판 상세조회
					rtnBoard = (Link) baseService.getReplyBoard(link);
					viewJsp = "base/reply/view";

					model.addAttribute("rtnComment", rtnBoard.getOutCursor3());
				}
			} catch (Exception e) {
				System.out.println("처리 중 오류가 발생했습니다.");
				logger.info("오류발생");
				
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
		        PrintWriter out = response.getWriter();
		        
		        out.println("<html>");
		        out.println("<head><title>error page</title></head>");
		        out.println("<script type='text/javascript'>");
		        out.println("alert('존재하지 않는 게시글입니다.');");
		        out.println("history.back(-1);");
		        out.println("</script>");
		        out.println("</html>");
				
				return null;
			}
			
			//기본 정보
			SCookie myInfo = (SCookie)request.getSession().getAttribute("USER");
			
			HashMap rtnOutCursor = new HashMap();
			HashMap<String, String> rtnContent = new HashMap<String, String>();
			rtnContent = (HashMap<String, String>)rtnBoard.getOutCursor();
			rtnOutCursor = (HashMap) rtnBoard.getOutCursor();

			//따옴표 때문에 스크립트가 먹통이 되는걸 방지
			rtnContent.put("KNAME", rtnContent.get("KNAME").replace("'", "\""));
			
			if(rtnContent.get("SECRETTITLEYN").equals("Y") || "MENU00156".equals(contentSet.getMenuId()) ){
				if(myInfo == null){
					response.setCharacterEncoding("utf-8");
					response.setContentType("text/html; charset=utf-8");
			        PrintWriter out = response.getWriter();
			        
			        String rtnUrl = "/menu?menuId="+contentSet.getMenuId(); //로그인 성공 이후 : 게시판 목록 url
			        
			        out.println("<html>");
			        out.println("<head><title>error page</title></head>");
			        out.println("<script type='text/javascript'>");
			        out.println("if(confirm('작성자 외 에는 열람하실 수 없습니다. 로그인 하시겠습니까?')){");
			        out.println("window.location.href=\"/mps/member/loginForm?menuId=MENU00427&rtnUrl="+java.net.URLEncoder.encode(rtnUrl, "utf-8")+"\"");
			        out.println("}else{history.back(-1);}");
			        out.println("</script>");
			        out.println("</html>");
			        
			        return null;
				}
				
				if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){

					if(StringUtil.nullCheck(link.getParentLinkId()) == ""){
						
						if(!myInfo.getUserId().equals(rtnOutCursor.get("USERID"))){
							
							response.setCharacterEncoding("utf-8");
							response.setContentType("text/html; charset=utf-8");
					        PrintWriter out = response.getWriter();
					        
					        out.println("<html>");
					        out.println("<head><title>error page</title></head>");
					        out.println("<script type='text/javascript'>");
					        out.println("alert('작성자 외 에는 열람하실 수 없습니다.');");
					        out.println("history.back(-1);");
					        out.println("</script>");
					        out.println("</html>");
							
							return null;
						}else{
							if(myInfo.getUserId().equals("guest")){
								if(!myInfo.getdKey().equals(rtnOutCursor.get("DKEY"))){
									
									response.setCharacterEncoding("utf-8");
									response.setContentType("text/html; charset=utf-8");
							        PrintWriter out = response.getWriter();
							        
							        out.println("<html>");
							        out.println("<head><title>error page</title></head>");
							        out.println("<script type='text/javascript'>");
							        out.println("alert('작성자 외 에는 열람하실 수 없습니다.');");
							        out.println("history.back(-1);");
							        out.println("</script>");
							        out.println("</html>");
									
									return null;
								}
							}
						}
					}
				}
			}			
			
			model.addAttribute("rtnContent", rtnBoard.getOutCursor());
			model.addAttribute("rtnFileList", rtnBoard.getOutCursor1());
			model.addAttribute("rtnFrevNext", rtnBoard.getOutCursor2());

			//실행결과 로기 생성
			this.resultLog(rtnBoard);
			
			//링크 정보
			String strLink = "";
			
			strLink = "pageNum=" + StringUtil.paramUnscript(link.getPageNum()+"") +
					  "&rowCnt=" + StringUtil.paramUnscript(link.getRowCnt()+"") +
					  "&menuId=" + StringUtil.paramUnscript(link.getMenuId()) + 
					  "&schType="+StringUtil.paramUnscript(link.getSchType()+"") + 
					  "&schText="+StringUtil.paramUnscript(StringUtil.nullCheck(link.getSchText())) +
					  "&categoryId="+StringUtil.paramUnscript(StringUtil.nullCheck(link.getCategoryId())) +
					  "&continent="+ StringUtil.paramUnscript(StringUtil.nullCheck(title.getContinent())) +
					  "&country="+ StringUtil.paramUnscript(StringUtil.nullCheck(title.getCountry())) +
					  "&boardStyle="+StringUtil.paramUnscript(StringUtil.nullCheck(title.getBoardStyle()));
			
			// 주요일정 파라메터 세팅
			if(setItem.getBoardKind().equals("NOTICE")){
				/*strLink += "&YEAR="+StringUtil.nullCheck(request.getParameter("YEAR"));
				strLink += "&MONTH="+StringUtil.nullCheck(request.getParameter("MONTH"));*/
			}
			
			model.addAttribute("link", strLink);
			
			link.setJsp(viewJsp);
			return new ModelAndView(siteLayout, "obj", link);
		}else if(setItem.getBoardKind().equals("CONTENTS")){
			
			return this.boardList(request, response, contentSet, content, title, tender, model);
		}else{
			return null;
		}

	}

	/*******************************************************************
	 * boardForm 게시판 폼
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 ******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form")
	public ModelAndView boardForm(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String viewJsp = "base/board/form";
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		SiteSet siteSet = new SiteSet();
		
		// 기본 셋팅
		this.setCommon(baseService, request, model, contentSet, siteSet);
		link.setCopyParam(contentSet);
		link.setMyName("전체관리자");
		
		String siteLayout = siteSet.siteLayer+".content";
		
		if(siteSet.siteLang.equals("E")){
			siteLayout = "commonEng.sub.layout";
		}
		
		String rtnUrl = "/board/form?menuId="+contentSet.getMenuId();
		
		//기본 정보
		SCookie myInfo = (SCookie)request.getSession().getAttribute("USER");
		if(myInfo == null){
			String strLink = "";
			strLink = "&menuId=" + StringUtil.nullCheck(contentSet.getMenuId())+
					  "&rtnUrl=" + StringUtil.nullCheck(rtnUrl);
			
			model.addAttribute("link", strLink);
			
			contentSet.setOutNotice("로그인이 필요한 서비스 입니다.");
			this.setMessage(request, contentSet);
			
			// View 설정
			RedirectView rv = new RedirectView(request.getContextPath().concat("/mps/member/loginForm?"+strLink));
			return new ModelAndView(rv);
		}
		
		//link.setInParam(request);
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)baseService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		model.addAttribute("rtnSetting", setItem);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		HashMap rtnOutCursor = new HashMap();
		try {
			if(setItem.getBoardKind().equals("FREE")){
				// 수정데이터 조회
				if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
					// 자유게시판 상세조회
					Link rtnFreeBoard = (Link)baseService.getFreeBoard(link);
					
					model.addAttribute("rtnContent", rtnFreeBoard.getOutCursor());
					model.addAttribute("rtnFileList", rtnFreeBoard.getOutCursor1());
					
					rtnOutCursor = (HashMap) rtnFreeBoard.getOutCursor();
					
					//실행결과 로기 생성
					this.resultLog(rtnFreeBoard);
				
				// 답글 타이틀 조회	
				} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){
					// 자유게시판 상세조회
					link.setLinkId(Integer.parseInt(link.getParentLinkId()));
					Link rtnParent = (Link)baseService.getFreeBoard(link);
					HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();
					
					model.addAttribute("title", "re :"+parentData.get("KNAME"));
				}
			}else if(setItem.getBoardKind().equals("NOTICE")){
				// 수정데이터 조회  - 수정모드
				if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
					// 공지게시판 상세조회
					Link rtnNoticeBoard = (Link)baseService.getNoticeBoard(link);
					
					model.addAttribute("rtnContent", rtnNoticeBoard.getOutCursor());
					model.addAttribute("rtnFileList", rtnNoticeBoard.getOutCursor1());
					
					rtnOutCursor = (HashMap) rtnNoticeBoard.getOutCursor();
					
					//실행결과 로그 생성
					this.resultLog(rtnNoticeBoard);
				}
			}else if(setItem.getBoardKind().equals("THUMBNAIL")){
				// 수정데이터 조회  - 수정모드
				if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
					// 썸네일게시판 상세조회
					Link rtnThumbnail = (Link)baseService.getThumbnailBoard(link);
					
					model.addAttribute("rtnContent", rtnThumbnail.getOutCursor());
					model.addAttribute("rtnFileList", rtnThumbnail.getOutCursor1());
					
					rtnOutCursor = (HashMap) rtnThumbnail.getOutCursor();
					
					//실행결과 로그 생성
					this.resultLog(rtnThumbnail);
				}
				
				viewJsp = "base/thumbnail/form";
			}else if(setItem.getBoardKind().equals("VOD")){
				// 수정데이터 조회  - 수정모드
				if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
					// 동영상형게시판 상세조회
					Link rtnThumbnail = (Link)baseService.getVodBoard(link);
					
					model.addAttribute("rtnContent", rtnThumbnail.getOutCursor());
					model.addAttribute("rtnFileList", rtnThumbnail.getOutCursor1());
					
					rtnOutCursor = (HashMap) rtnThumbnail.getOutCursor();
					
					//실행결과 로그 생성
					this.resultLog(rtnThumbnail);
				}
				
				viewJsp = "base/thumbnail/form";
			}else if(setItem.getBoardKind().equals("CARD")){
				// 수정데이터 조회  - 수정모드
				if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
					// 썸네일게시판 상세조회
					Link rtnCard = (Link)baseService.getCardBoard(link);
					
					model.addAttribute("rtnContent", rtnCard.getOutCursor());
					model.addAttribute("rtnFileList", rtnCard.getOutCursor1());
					
					rtnOutCursor = (HashMap) rtnCard.getOutCursor();
					
					//실행결과 로그 생성
					this.resultLog(rtnCard);
				}
				
				viewJsp = "base/card/form";
			}else if(setItem.getBoardKind().equals("APPEAL")) {
				// 수정데이터 조회 - 수정모드
				/*if (myInfo.kind.equals("C")) {
					// 기업회원 담당자이름
					CompanyUser companyUser = new CompanyUser();
					companyUser.setUserId(myInfo.userId);
					String userid = companyUser.getUserId();
					CompanyUser companyUserName = baseService.getCompanyChargeName(userid);
					model.addAttribute("companyUserName", companyUserName);
				}*/

				if (StringUtil.nullCheck(link.getLinkId()) != ""
						&& link.getLinkId() > 0) {
					// 민원형게시판 상세조회
					Link rtnAppealBoard = (Link) baseService
							.getAppealBoard(link);

					HashMap<String, String> rtnContent = new HashMap<String, String>();
					rtnContent = (HashMap<String, String>) rtnAppealBoard
							.getOutCursor();

					rtnOutCursor = (HashMap) rtnAppealBoard.getOutCursor();

					// 질문자인지 확인
					if (link.getMyId().equals(rtnContent.get("USERID"))) {
						logger.info("본인글");
					}

					model.addAttribute("rtnContent", rtnContent);
					model.addAttribute("rtnComment",
							rtnAppealBoard.getOutCursor3());
					model.addAttribute("rtnFileList",
							rtnAppealBoard.getOutCursor1());

					// 실행결과 로그 생성
					this.resultLog(rtnAppealBoard);
				}

				if (siteSet.siteLang.equals("E")) {
					viewJsp = "baseEng/board/form";
				} else {
					viewJsp = "base/board/form";
				}
			}else if(setItem.getBoardKind().equals("REPLY")) {
				// 수정데이터 조회 - 수정모드
				/*if (myInfo.kind.equals("C")) {
					// 기업회원 담당자이름
					CompanyUser companyUser = new CompanyUser();
					companyUser.setUserId(myInfo.userId);
					String userid = companyUser.getUserId();
					CompanyUser companyUserName = baseService.getCompanyChargeName(userid);
					model.addAttribute("companyUserName", companyUserName);
				}*/

				if (StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0) {
					// 관리자답변형게시판 상세조회
					Link rtnAppealBoard = (Link) baseService
							.getReplyBoard(link);

					HashMap<String, String> rtnContent = new HashMap<String, String>();
					rtnContent = (HashMap<String, String>) rtnAppealBoard
							.getOutCursor();

					rtnOutCursor = (HashMap) rtnAppealBoard.getOutCursor();

					// 질문자인지 확인
					if (link.getMyId().equals(rtnContent.get("USERID"))) {
						logger.info("본인글");
					}

					model.addAttribute("rtnContent", rtnContent);
					model.addAttribute("rtnComment",
							rtnAppealBoard.getOutCursor3());
					model.addAttribute("rtnFileList",
							rtnAppealBoard.getOutCursor1());

					// 실행결과 로그 생성
					this.resultLog(rtnAppealBoard);
				}

				if (siteSet.siteLang.equals("E")) {
					viewJsp = "baseEng/board/form";
				} else {
					viewJsp = "base/board/form";
				}
			}
			
			if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){

				if(StringUtil.nullCheck(link.getParentLinkId()) == ""){
					
					if(!myInfo.getUserId().equals(rtnOutCursor.get("USERID"))){
						
						response.setCharacterEncoding("utf-8");
						response.setContentType("text/html; charset=utf-8");
				        PrintWriter out = response.getWriter();
				        
				        out.println("<html>");
				        out.println("<head><title>error page</title></head>");
				        out.println("<script type='text/javascript'>");
				        out.println("alert('수정 권한이 없습니다.');");
				        out.println("history.back(-1);");
				        out.println("</script>");
				        out.println("</html>");
						
						return null;
					}else{
						if(myInfo.getUserId().equals("guest")){
							if(!myInfo.getdKey().equals(rtnOutCursor.get("DKEY"))){
								
								response.setCharacterEncoding("utf-8");
								response.setContentType("text/html; charset=utf-8");
						        PrintWriter out = response.getWriter();
						        
						        out.println("<html>");
						        out.println("<head><title>error page</title></head>");
						        out.println("<script type='text/javascript'>");
						        out.println("alert('수정 권한이 없습니다.');");
						        out.println("history.back(-1);");
						        out.println("</script>");
						        out.println("</html>");
								
								return null;
							}
						}
					}
				}			
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.info("오류발생");
			System.out.println("처리 중 오류가 발생했습니다.");
			
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();
	        
	        out.println("<html>");
	        out.println("<head><title>error page</title></head>");
	        out.println("<script type='text/javascript'>");
	        out.println("alert('존재하지 않는 게시글입니다.');");
	        out.println("history.back(-1);");
	        out.println("</script>");
	        out.println("</html>");
			
			return null;
		}

		if(siteSet.siteLang.equals("E")){
			viewJsp = "baseEng/board/form";
		}
		
		//링크 정보
		String strLink = "";
		strLink = "pageNum=" + StringUtil.paramUnscript(link.getPageNum()+"") +
				  "&rowCnt=" + StringUtil.paramUnscript(link.getRowCnt()+"") +
				  "&menuId=" + StringUtil.paramUnscript(link.getMenuId()) + 
				  "&schType="+StringUtil.paramUnscript(link.getSchType()+"") + 
				  "&schText="+StringUtil.paramUnscript(StringUtil.nullCheck(link.getSchText())) +
				  "&categoryId="+StringUtil.paramUnscript(StringUtil.nullCheck(link.getCategoryId())) +
				  "&continent=" + StringUtil.paramUnscript(StringUtil.nullCheck(link.getContinent())) +
				  "&country=" + StringUtil.paramUnscript(StringUtil.nullCheck(link.getCountry()));
		
		model.addAttribute("link", strLink);
		
		link.setJsp(viewJsp+link.getFileFormType());
		return new ModelAndView(siteLayout, "obj", link);
	}
	
	/****************************************************************
	 * actBoard 게시판 입력/수정/삭제
	 * @param contentSet
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actBoard", method=RequestMethod.POST)
	public ModelAndView actBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Content content, @ModelAttribute Files files, @ModelAttribute GuestInfo guestInfo, @ModelAttribute Link link, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		/* 게시판 설정 정보 받아오기   시작 */
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		SiteSet siteSet = new SiteSet();
		
		// 기본 셋팅
		this.setCommon(baseService, request, model, contentSet, siteSet);
		content.setCopyParam(contentSet);
		link.setCopyParam(contentSet);
		link.setInParam(request);
		
		String rtnUrl = "/board?menuId="+contentSet.getMenuId();
				
		//기본 정보
		SCookie myInfo = (SCookie)request.getSession().getAttribute("USER");
		if(myInfo == null){
			String strLink = "";
			strLink = "&menuId=" + StringUtil.nullCheck(contentSet.getMenuId())+
					  "&rtnUrl=" + StringUtil.nullCheck(rtnUrl);
			
			model.addAttribute("link", strLink);
			
			contentSet.setOutNotice("로그인이 필요한 서비스 입니다.");
			this.setMessage(request, contentSet);
			
			// View 설정
			RedirectView rv = new RedirectView(request.getContextPath().concat("/mps/member/loginForm?"+strLink));
			return new ModelAndView(rv);
		}
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)baseService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		/* 게시판 설정 정보 받아오기   끝 */
		
		if(!content.getInCondition().equals("입력")){
			HashMap rtnOutCursor = new HashMap();
			
			try {
				if(setItem.getBoardKind().equals("FREE")){
					// 수정데이터 조회
					if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
						// 자유게시판 상세조회
						Link rtnFreeBoard = (Link)baseService.getFreeBoard(link);
						
						rtnOutCursor = (HashMap) rtnFreeBoard.getOutCursor();
					}
				}else if(setItem.getBoardKind().equals("NOTICE")){
					// 수정데이터 조회  - 수정모드
					if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
						// 공지게시판 상세조회
						Link rtnNoticeBoard = (Link)baseService.getNoticeBoard(link);
						
						rtnOutCursor = (HashMap) rtnNoticeBoard.getOutCursor();
					}
				}else if(setItem.getBoardKind().equals("THUMBNAIL")){
					// 수정데이터 조회  - 수정모드
					if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
						// 썸네일게시판 상세조회
						Link rtnThumbnail = (Link)baseService.getThumbnailBoard(link);
						
						rtnOutCursor = (HashMap) rtnThumbnail.getOutCursor();
					}
				}else if(setItem.getBoardKind().equals("VOD")){
					// 수정데이터 조회  - 수정모드
					if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
						// 동영상형게시판 상세조회
						Link rtnThumbnail = (Link)baseService.getVodBoard(link);
						
						rtnOutCursor = (HashMap) rtnThumbnail.getOutCursor();
					}
				}else if(setItem.getBoardKind().equals("CARD")){
					// 수정데이터 조회  - 수정모드
					if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
						// 썸네일게시판 상세조회
						Link rtnCard = (Link)baseService.getCardBoard(link);
						
						rtnOutCursor = (HashMap) rtnCard.getOutCursor();
					}
				}else if(setItem.getBoardKind().equals("APPEAL")){
					// 수정데이터 조회  - 수정모드
					if(StringUtil.nullCheck(content.getLinkId()) != "" && link.getLinkId() > 0){
						// 민원형게시판 상세조회
						Link rtnAppealBoard = (Link)baseService.getAppealBoard(link);
						rtnOutCursor = (HashMap) rtnAppealBoard.getOutCursor();
					}
				}else if(setItem.getBoardKind().equals("REPLY")){
					// 수정데이터 조회  - 수정모드
					if(StringUtil.nullCheck(content.getLinkId()) != "" && link.getLinkId() > 0){
						// 관리자답변형게시판 상세조회
						Link rtnReplyBoard = (Link)baseService.getReplyBoard(link);
						rtnOutCursor = (HashMap) rtnReplyBoard.getOutCursor();
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				logger.info("오류발생");
				System.out.println("처리 중 오류가 발생했습니다.");
				
				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");
		        PrintWriter out = response.getWriter();
		        
		        out.println("<html>");
		        out.println("<head><title>error page</title></head>");
		        out.println("<script type='text/javascript'>");
		        out.println("alert('존재하지 않는 게시글입니다.');");
		        out.println("history.back(-1);");
		        out.println("</script>");
		        out.println("</html>");
				
				return null;
			}
			
			if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){

				if(StringUtil.nullCheck(link.getParentLinkId()) == ""){
					
					if(!myInfo.getUserId().equals(rtnOutCursor.get("USERID"))){
						
						response.setCharacterEncoding("utf-8");
						response.setContentType("text/html; charset=utf-8");
				        PrintWriter out = response.getWriter();
				        
				        out.println("<html>");
				        out.println("<head><title>error page</title></head>");
				        out.println("<script type='text/javascript'>");
				        out.println("alert('작성자만 수정 하실 수 있습니다.');");
				        out.println("history.back(-1);");
				        out.println("</script>");
				        out.println("</html>");
						
						return null;
					}else{
						if(myInfo.getUserId().equals("guest")){
							if(!myInfo.getdKey().equals(rtnOutCursor.get("DKEY"))){
								
								response.setCharacterEncoding("utf-8");
								response.setContentType("text/html; charset=utf-8");
						        PrintWriter out = response.getWriter();
						        
						        out.println("<html>");
						        out.println("<head><title>error page</title></head>");
						        out.println("<script type='text/javascript'>");
						        out.println("alert('작성자만 수정 하실 수 있습니다.');");
						        out.println("history.back(-1);");
						        out.println("</script>");
						        out.println("</html>");
								
								return null;
							}
						}
					}
				}
			}
		}
		
		/* 게시판 저장 데이타 셋팅 */
		//기본 셋팅
		content.setInParam(request);
		files.setInParam(request);
		guestInfo.setInParam(request);

		//태그 제거
		content.setKName(StringUtil.unscript(content.getKName()));
		content.setKHtml(StringUtil.unscript(content.getKHtml()));
		
		content.setInCLOBData1(content.getKHtml());
		
		//dml data 변수
		String contentDml = null;
		String guestDml = null;
		String fileDml = null;
		
		//after data  변수
		String contentData = null;
		String guestData = null;
		String fileData = null;

		Files uploadFiles = new Files();
		Files uploadFilesImg = new Files();
		
		if(content.getFileFormType().equals("_inputFiles")){ // inputFile
			// multipartFileUpload
			uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", "attachFileMgr", "common", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 파일저장기능명, 저장폴더명) 
		}else{ // namoFiles
			uploadFiles = (Files)namoCrossFile.fileUploadAttempt(content, request);
		}
		
		//dmlData 설정
		guestDml = guestInfo.makeFreeDMLDataString();
		fileDml = uploadFiles.makeFreeDMLDataString();

		//afterData 설정
		guestData = guestInfo.makeFreeDataString(); 
		fileData = uploadFiles.makeFreeDataString();
		
		//게시판 유형 지정
		if(setItem.getBoardKind().equals("FREE")){

			//dmlData 설정
			contentDml = content.makeFreeDMLDataString();
			
			//afterData 설정
			contentData = content.makeFreeDataString();
			
			content.setInWorkName("자유형게시판관리");
		}else if(setItem.getBoardKind().equals("NOTICE")){
			
			//parameter 설정
			contentData = content.makeNoticeDataString();

			//afterData 설정
			contentDml = content.makeNoticeDMLDataString();
			
			content.setInWorkName("공지형게시판관리");
		}else if(setItem.getBoardKind().equals("THUMBNAIL")){
			
			content.setInWorkName("썸네일형게시판관리");
			
			String altInfo = request.getParameter("altInfoArr");
			String altInfoFirst = request.getParameter("altInfoFirst");
			
			//대표이미지 설정
			if(uploadFiles.getFileList() != null && uploadFiles.getFileList().size() > 0){
				content.setImageFileName(uploadFiles.getFileList().get(0).getUserFileName());
				content.setImageSFileName(uploadFiles.getFileList().get(0).getSystemFileName());
				content.setFilePath(uploadFiles.getFileList().get(0).getFilePath());
				//content.setImageYN_Name(altInfoFirst);
			}
			
			//dmlData 설정
			contentData = content.makeThumbnailDataString();
			fileData = uploadFiles.makeFreeDataString();
			
			//afterData 설정
			contentDml = content.makeThumbnailDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString()+"|"+altInfo;
			
		}else if(setItem.getBoardKind().equals("LINK")){
			content.setInWorkName("링크형게시판관리");

			//parameter 설정			
			contentData = content.makeLinkDataString();
			guestData = guestInfo.makeFreeDataString();
			fileDml = "";
			
			//DML data 설정
			contentDml = content.makeLinkDMLDataString();			
			guestDml = guestInfo.makeFreeDMLDataString();
			fileDml = "";
			
		}else if(setItem.getBoardKind().equals("VOD")){
			content.setInWorkName("동영상형게시판관리");
						
			if(content.getFileFormType().equals("_inputFiles")){ // inputFile
				// multipartFileUpload
				uploadFilesImg = (Files) fileUtil.uploadFormfiles(request, response, "fileImg_upload", "fileImgId", content.getMenuId(), "board", "single"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
				content.setImageFileName(uploadFiles.getUserFileName());
				content.setImageSFileName(uploadFiles.getSystemFileName());
				content.setFilePath(uploadFiles.getFilePath());
				
			}else{
				// 첨부파일 JSON정보
				JSONParser jsonParser = new JSONParser();
				Object jsonObj = null;
		 		JSONArray jsonArray = null;
				JSONObject jsonObject = null;
				
				// 이미지 첨부가 없을경우
				if(!StringUtil.isNotBlank(request.getParameter("modifiedFilesInfoImages"))) {
					if(StringUtil.isNotBlank(content.getImageFileName())){
						NamoCrossFile.fileDeleteAttempt(content.getFilePath(), content.getImageSFileName());
						content.setImageFileName(null);
						content.setImageSFileName(null);
						content.setFilePath(null);
					}
				}else{
					String modifiedFilesInfo = request.getParameter("modifiedFilesInfoImages"); 
					jsonObj = jsonParser.parse(modifiedFilesInfo); 
					jsonArray = (JSONArray)jsonObj; 
					if(jsonArray.size() > 0){
						jsonObject = (JSONObject)jsonArray.get(0); 
						String[] strData = StringUtil.strToArr((String)jsonObject.get("fileId"), "@@");
						if(!Boolean.parseBoolean((String) jsonObject.get("isDeleted"))){
							content.setImageFileName((String)jsonObject.get("fileName"));
							content.setImageSFileName(strData[2]);
							content.setFilePath(strData[3]);
						}else{
							NamoCrossFile.fileDeleteAttempt(strData[3], strData[2]);
							if("jpg;jpeg;png;gif;bmp".indexOf(strData[2].toString().toLowerCase().substring(strData[2].toString().lastIndexOf(".")+1)) > -1){
								NamoCrossFile.fileDeleteAttempt(strData[3]+"thumbnails"+File.separator, strData[2]);
							}
						}
					}
				}
				
				// 이미지 파일 등록
				if(StringUtil.isNotBlank(request.getParameter("uploadedFilesInfoImages"))) {
					String uploadedFilesInfoImages = request.getParameter("uploadedFilesInfoImages");
					jsonObj = jsonParser.parse(uploadedFilesInfoImages); 
					jsonArray = (JSONArray)jsonObj; 
					if(jsonArray.size() > 0){
						if(StringUtil.isNotBlank(content.getImageFileName())){
							NamoCrossFile.fileDeleteAttempt(content.getFilePath(), content.getImageSFileName());
						}
						jsonObject = (JSONObject)jsonArray.get(0);
						
						content.setImageFileName((String)jsonObject.get("origfileName"));
						content.setImageSFileName((String)jsonObject.get("fileName"));
						content.setFilePath((String)jsonObject.get("lastSavedDirectoryPath"));
					}
				}
			}
			
			//dmlData 설정
			contentDml = content.makeVodDataString();
			fileDml = uploadFiles.makeFreeDMLDataString();
			
			//afterData 설정
			contentDml = content.makeVodDMLDataString();
			fileData = uploadFiles.makeFreeDataString();
			
		}else if(setItem.getBoardKind().equals("CARD")){
			
			content.setInWorkName("카드형게시판관리");
			
			String altInfo = request.getParameter("altInfoArr");
			String altInfoFirst = request.getParameter("altInfoFirst");
			
			//대표이미지 설정
			if(uploadFiles.getFileList() != null && uploadFiles.getFileList().size() > 0){
				content.setImageFileName(uploadFiles.getFileList().get(0).getUserFileName());
				content.setImageSFileName(uploadFiles.getFileList().get(0).getSystemFileName());
				content.setFilePath(uploadFiles.getFileList().get(0).getFilePath());
				//content.setImageYN_Name(altInfoFirst);
			}
			
			//dmlData 설정
			contentData = content.makeCardDataString();
			fileData = uploadFiles.makeFreeDataString();
			
			//afterData 설정
			contentDml = content.makeCardDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString()+"|"+altInfo;
			
		}else if(setItem.getBoardKind().equals("APPEAL")){
			content.setInWorkName("민원형게시판관리");
			
			//dmlData 설정
			contentDml = content.makeAppealDMLDataString();
			
			//afterData 설정
			contentData = content.makeAppearlDataString();
		}else if(setItem.getBoardKind().equals("REPLY")){
			content.setInWorkName("관리자답변형게시판관리");
			
			//dmlData 설정
			contentDml = content.makeReplyDMLDataString();
			
			//afterData 설정
			contentData = content.makeReplyDataString();
		}

		content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
		content.setInAfterData(contentData+guestData+fileData);
		
		baseService.actBoard(content);
		
		//링크 정보
		String strLink = request.getParameter("link");
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		if(content.getInCondition().equals("입력")) {
			String parent = request.getParameter("parentId");
			if(parent != null && parent != "" && Integer.parseInt(parent) > 0){
				//답글 일때
				rv.setUrl(request.getContextPath().concat("/board?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
			}else{
				//답글이 아닐때
				strLink = "pageNum=1"+strLink.substring(strLink.indexOf("&"), strLink.length());
				rv.setUrl(request.getContextPath().concat("/board?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
			}
		}else if(content.getInCondition().equals("수정")) {
			rv.setUrl(request.getContextPath().concat("/board/view?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
		}else {
			rv.setUrl(request.getContextPath().concat("/board?").concat(strLink));
		}
		return new ModelAndView(rv);
	}
	
	/************************************************************
	 * replyListJson 첨부파일 리스트
	 * @param link
	 * @param request
	 * @param model
	 * @return List<?>
	 * @throws Exception
	 ***********************************************************/
	@RequestMapping(value="/fileListJson", method=RequestMethod.GET)
	public @ResponseBody List<?> replyListJson(@ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception{
		//기본 셋팅
		link.setInParam(request);

		return (List<?>)baseService.getListFiles(link);
	}
	
}
