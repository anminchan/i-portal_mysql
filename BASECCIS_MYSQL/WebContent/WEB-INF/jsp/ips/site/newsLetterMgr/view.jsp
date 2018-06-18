<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/newsLetterMgr/act" method="POST">
<input type="hidden" id="menuId" name="menuId" value="${param.menuId}"/>

<input type="hidden" id="siteId" name="siteId" value="${result[0].SITEID}"/>
<input type="hidden" id="state" name="state" value="T"/>
<input type="hidden" id="newsLetterId" name="newsLetterId" value="${result[0].NEWSLETTERID}"/>
<input type="hidden" id="newsLetterBodyId" name="newsLetterBodyId" value="${result[0].NEWSLETTERBODYID}"/>

<fieldset>
	<legend>뉴스레터 정보 입력</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<table class="tstyle_view">
		<caption>
			사이트, 등록자, 공개여부, 발송예정일, 제목, 템플릿 선택, 내용입력
		</caption>
		<colgroup>
			<col class="col-sm-2"/>
			<col class="col-sm-4"/>
			<col class="col-sm-2"/>
			<col class="col-sm-4"/>
		</colgroup>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="siteIdSel">사이트</label></th>
			<td><select name="siteIdSel" id="siteIdSel"></select></td>
			<th scope="row"><span class="point01">*</span> <label for="insuserName">등록자</label></th>
			<td>
				<input type="text" id="insuserName" name="insuserName" value="${empty result[0].INSUSERNAME ? ADMUSER.userName : result[0].INSUSERNAME }" readOnly="readOnly" />
				<input type="hidden" id="insuserId" name="insuserId" value="${empty result[0].INSUSERID ? ADMUSER.userId : result[0].INSUSERID }" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="openYn">공개여부</label></th>
			<td>
				<input type="radio" id="openYn1" name="openYn" value="Y" <c:if test="${empty result[0].OPENYN or result[0].OPENYN eq 'Y'}">checked</c:if> />공개
				<input type="radio" id="openYn2" name="openYn" value="N" <c:if test="${result[0].OPENYN eq 'N'}">checked</c:if> />비공개
			</td>
			<th scope="row"><label for="KName">발송예정일</label></th>
			<td>
				<input type="text" name="sendDueDate" id="sendDueDate" value="${result[0].SENDDUEDATE}"/>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="point01">*</span> <label for="KName">제목</label></th>
			<td colspan="3"><input type="text" id="KName" name="KName" value="${result[0].KNAME}" class="input_mid02" maxlength="30" title="제목" /></td>
		</tr>
		<tr>
			<th scope="row"><label for="KName">템플릿</label></th>
			<td colspan="3">
				<select id="template" name="template" >
					<option value="1">템플릿1</option>
					<option value="TYPE02">템플릿2</option>
					<option value="TYPE03">템플릿3</option>
					<option value="TYPE04">템플릿4</option>
				</select>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="kHtml">내용</label></th>
			<td colspan="3">
				<!-- 왼쪽 콘텐츠  STYLE -->	
				<div style="float:left; width:500px;">
					<h2 style="height:38px; margin:0; padding-left: 27px; background:url('images/mdi/vol_bg.png') no-repeat; font-size:14px; color:#fff; line-height: 2.7;">[제37호] <span style="color:#92c7eb;">발행일 : 2014년 10월 27일</span></h2>
					<!-- 1단략 -->
					<div style="margin:40px 36px 30px 25px;">
						<h3 style="margin:0 0 10px; padding:0;"><img src="images/mdi/newsletter_title01.png" alt="01 정부/유관기관 주요 공지사항" /></h3>
						<p style="padding-left: 12px;  color: #6c6d70; line-height: 1.8; letter-spacing: -0.8px; font-size: 11px;">
							가. 보건신기술 인증표시의 부정사용에 대한 조치 내용 삭제<br/>
							나. 보건신기술 인증취소의 경우 신청자격 제한
						</p>
						<p style=" margin: 5px 0; padding: 0 0 0 5px; background: url('images/mdi/dot.gif') no-repeat 2px 7px; "><a style=" display: block; color: #252525;  text-decoration: none;  font-weight: bold;" href="http://medicaldevice.khidi.or.kr/board.es?mid=a10105000000&amp;bid=0006&amp;act=view&amp;list_no=2396&amp;nPage=1" target="_blank">「장애인 전동보장구 급여품목 및 결정가격 고시」일부 개정</a>
						<span style="display: block; margin: 8px 0 0 10px; color: #6c6d70;  font-size: 11px; ">전동휠체어를 포함한 3개 제품 신설</span></p>					
						<h4 style="margin:15px 0; padding:12px 0 0; border-top: dashed 1px #c4c4c8;"><img alt="식품의약품안전처" src="images/mdi/mfds.png"></h4>
						<p style=" margin: 5px 0; padding: 0 0 0 12px; background: url('images/mdi/dot.gif') no-repeat 2px 7px; "><a style=" display: block; color: #252525;  text-decoration: none;  font-weight: bold;" href="#" target="_blank">2015년도 제1차 식품의약품안전처 용역연구개발과제 주관연구기관 공모 공고</a>
						<span style="display: block; margin: 8px 0 0; color: #6c6d70;  font-size: 11px; ">공모대상과제 : 의료기기 등 안전관리를 포함한 6개 분야<br />공고 및 접수기간 : 2014년 10월 20일 ~ 2014년 11월 18일</span></p>
		
						<h4 style="margin:15px 0; padding:12px 0 0; border-top: dashed 1px #c4c4c8;"><img src="images/mdi/msip.png"  alt="미래창조과학부" /></h4>
						<p style=" margin: 5px 0; padding: 0 0 0 12px; background: url('images/mdi/dot.gif') no-repeat 2px 7px; "><a style=" display: block; color: #252525;  text-decoration: none;  font-weight: bold;" href="#" target="_blank"> 2014년도 한-러시아 과학기술 공동연구사업 신규과제 공모</a>
						<span style="display: block;  margin: 8px 0 0;  color: #6c6d70;  font-size: 11px; ">러시아와의 공동연구를 통해 국내 연구자의 역량 제고 및 양국간 협력 네트워크 강화 <br /><strong>접수기간</strong> : 2014년 10월 29일(수), 18:00까지</span></p>
		
						<h4 style="margin:15px 0; padding:12px 0 0; border-top: dashed 1px #c4c4c8;"><img  src="images/mdi/wmit.png" alt="원주의료기기테크노밸리"/></h4>
						<p style=" margin: 5px 0; padding: 0 0 0 12px; background: url('images/mdi/dot.gif') no-repeat 2px 7px; "><a style=" display: block; color: #252525;  text-decoration: none;  font-weight: bold;" href="#" target="_blank">[강원]지역특화산업육성사업 마케팅 지원사업 (해외서비스센타구축지원) </a>
						<span style="display: block;  margin: 8px 0 0;  color: #6c6d70;  font-size: 11px; "> 지역 일자리 창출 확대 및 지역내 기업의 매출 신장 등 지역경제 활성화에 기여<br /><strong>신청기간</strong> : 2014년 10월 16일 ~ 2014년 10월 31일</span></p>
					</div>			
					<!-- //1단략 -->
					<!-- 2단략 -->
					<div style="margin:0 40px 0 25px;">
						<h3 style="margin:0 0 10px; padding:0;"><img src="images/mdi/newsletter_title02.png" alt="02 국내외 의료기기&middot;IT헬스 산업 동향" /></h3>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.bosa.co.kr/umap/sub.asp?news_pk=569597" target="_blank">세계 최대 의료기기전시회 ‘MEDICA’ 내달 개최</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">(디지틀보사 10.23)</span> 
							<span style="display: inline-block; padding-left: 8px; color: #6c6d70; font-size: 11px;">전시규모 11만6000㎡…65개국서 4500개 업체 출품 예정</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://news.kmib.co.kr/article/view.asp?arcid=0922819713&amp;code=14130000&amp;sid1=hea" target="_blank">모바일 헬스케어 지금부터 시작</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">(국민일보 10.21)</span> 
							<span style="display: inline-block; color: #6c6d70; padding-left: 8px; font-size: 11px;">진흥원 박순만실장, 지금은 출발점이기 때문에 선도적으로 나가야한다고 강조</span>
						</p>
		
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.e-healthnews.com/news/article_view.php?art_id=114107" target="_blank">"인구대국 印泥에 한국산 의료기기를..."</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">(E헬스통신 10.21)</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">한국의료기기협동조합, 워싱턴 DC에서 '의료기기 미국 수출컨소시엄' 행사 개최</span>
						</p>	
		
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.etnews.com/20141021000275" target="_blank">
								원격의료시장 성장한다는데…국내는?
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(메디파나뉴스 10.21)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								세계원격의료 시장, 2019년까지 연평균 17.7% 성장할 것
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.bosa.co.kr/umap/sub.asp?news_pk=569339" target="_blank">
								얼라이브코 등 올 5개 진단社 유망주
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(디지틀보사 10.20)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								아이리듬. 애스튜트. 인프라레딕스, 코어테크스 등
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://news20.busan.com/controller/newsController.jsp?newsId=20141024000200" target="_blank">해양원격진료시스템 개발 원양 선원에 의료 서비스</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(부산일보 10.24)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								박익민 신임 부산대병원 융합의학기술원장
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.docdocdoc.co.kr/news/newsview.php?newscd=2014102400019" target="_blank">
								가톨릭의대 의료정보학교실, 국제세미나 개최
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(청년의사 10.24)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								해외 모바일 헬스 연구 기반 아동·청소년 비만 관리 방안 모색
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; letter-spacing: -2px; font-weight: bold; text-decoration: none;" href="http://www.dailymedi.com/news/view.html?smode=&amp;skey=%BF%B5%BB%F3%C0%E5%BA%F1+%BB%E7%BF%EB&amp;x=0&amp;y=0§ion=1&amp;category=8&amp;no=785499" target="_blank">
								영상장비 사용연한·품질별 '수가 차등' 추진
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(데일리메디 10.17)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								CT·MRI·PET 23% 10년이상 노후…손명세 심평원장 "관리방안 마련"
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.yonhapnews.co.kr/bulletin/2014/10/17/0200000000AKR20141017074800017.HTML?from=search" target="_blank">
								보건의료 R&amp;D 전략회의 출범…"총괄 관리"
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(연합뉴스 10.17)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								 회의를 통해 도출된 혁신적 전략이 R&amp;D 선진국 도약의 전환점이 될 것
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.newsis.com/ar_detail/view.html?ar_id=NISX20141024_0013252726&amp;cID=10811&amp;pID=10800" target="_blank">
								부산 벡스코서 ITU 특별행사 ‘헬스 IT 융합전시회’
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(뉴시스 10.24)
							</span>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								오는 27부터 29일, 벡스코 제2전시장에서 국내 최초로 개최
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://news.sbs.co.kr/news/endPage.do?news_id=N1002645465&amp;plink=ORI&amp;cooper=NAVER" target="_blank">
								'15분 안에 감염 확인'…프랑스서 에볼라 진단기구 개발
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(SBS 10.22)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								혈액이나 소변에 단일클론항체가 반응을 나타내는지에 따라 에볼라 감염 여부를 확인
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.doctorsnews.co.kr/news/articleView.html?idxno=99513" target="_blank">
								마취약리학회, 25일 의료기기 심포지엄 개최
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(의협뉴스 10.20)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								의학생리 강의를 추가해 지난 심포지엄보다 내용면에서 더욱 풍성할 것
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://medipana.com/news/news_viewer.asp?NewsNum=157318&amp;MainKind=A&amp;NewsKind=5&amp;vCount=12&amp;vKind=1" target="_blank">
								명지병원, 국내 최초 구글 글라스 스마트ER 시연
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(메디파나뉴스 10.21)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								구급차 이송 중 환자상태 실시간 전송 및 응급처치 지도
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.hkn24.com/news/articleView.html?idxno=137451" target="_blank">
								치과산업의 새로운 도전 … IDEX 2014 한달 앞으로
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(헬스코리아뉴스 10.17)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								‘국민-치과-산업’ 선순환 발전 이룬다
							</span>
						</p>			
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.yonhapnews.co.kr/bulletin/2014/10/20/0200000000AKR20141020058600062.HTML?from=search" target="_blank">
								'강원의료기기전시회' 원주서 24∼25일 열려
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(연합뉴스 10.20)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								국내 73개, 국외 9개 등 82개사가 참가
		
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.docdocdoc.co.kr/news/newsview.php?newscd=2014102100011" target="_blank">
								"대형병원 국산 의료장비 외면…빅5 사용률 5%"
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(청년의사 10.21)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								국산 의료기기의 사용률 제고를 위한 대책 마련이 시급
							</span>
						</p>
		
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.dailymedi.com/news/view.html?smode=&amp;skey=2020%B3%E2+%BC%BC%B0%E8+7%B4%EB&amp;x=0&amp;y=0§ion=1&amp;category=8&amp;no=785550" target="_blank">
								"2020년 세계 7대 의료기기 강국" 선포했지만…
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(데일리메디 10.20)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								복지부 "정부 내 산업 육성 필요성 공감대 형성됐지만 예산 확충 쉽지 않아"
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://news.mk.co.kr/newsRead.php?year=2014&amp;no=1333648" target="_blank">
								기업 발목잡는 `규제 5敵`
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(매일경제 10.20)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								의료기기법에 막힌 갤노트4·국내선 사업시작도 못한 드론
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://jhealthmedia.joins.com/news/articleView.html?idxno=13721" target="_blank">
								부산 의료기기 리베이트 받은 의사들 중형 선고
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(중앙일보헬스미디어 10.21)
							</span> 
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								공무원 신분엔 뇌물죄도 추가 적용
							</span>
						</p>
					</div>			
					<!-- //2단략 -->			
					<!-- 3단략 -->
					<div style="position:relative; z-index:100; margin:35px 40px 0 25px;">
						<h3 style="margin:0 0 10px; padding:0;"><img src="images/mdi/newsletter_title03.png" alt="03 수출마케팅 협의체 및 CEO 포럼 참여기업 동향" /></h3>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.monews.co.kr/news/articleView.html?idxno=77714" target="_blank">
								보령수앤수, 휴대 심전도 측정기 '명품 의료기기' 선정
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(메디칼업저버 10.17)
							</span>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								한국전자정보통신산업진흥회 주관…특별상 수상
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.e-healthnews.com/news/article_view.php?art_id=113996&amp;cd=20" target="_blank">
								메인텍, NET인증 실런더펌프 'Anyfusion' 출시
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(E헬스통신 10.17)
							</span>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								 기존의 Infusion pump와 syringe pump를 통합한 펌프로 국내 핵심원천기술로 개발
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.yakup.com/news/index.html?mode=view&amp;cat=14&amp;nid=178724" target="_blank">
								루트로닉, ‘한국IR대상’ 코스닥 분야 우수상 수상
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(약업신문 10.22)
							</span>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								" 투명하고 효과적인 커뮤니케이션 위해 노력할 것”
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.newspim.com/view.jsp?newsId=20141016000332" target="_blank">
								인포피아, 2014KES 명품 국산의료기기 특별상 수상
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(뉴스핌 10.16)
							</span>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								mhealthGate App, 혈당, 혈압 등을 관리할 수 있도록 돕는 스마트폰 애플리케이션
							</span>
						</p>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">
							<a style="color: #252525; font-weight: bold; text-decoration: none;" href="http://www.e-healthnews.com/news/article_view.php?art_id=114121&amp;cd=20" target="_blank">
								세원셀론텍, 농식품부 연구개발과제 사업자 선정
							</a>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								(E헬스통신 10.21)
							</span>
							<span style="display: inline-block; color: #6c6d70; font-size: 11px;">
								"오리발에서 바이오콜라겐 대량생산한다"
							</span>
						</p>
					</div>  
					<!-- //3단략 -->
					<!-- 4단략 -->
					<div style="width: 405px; margin:35px 40px 0 25px;">
						<h3 style="margin:0 0 10px; padding:0;"><img src="images/mdi/newsletter_title04.png" alt="04 보건산업진흥원 사업 동향" /></h3>
						<p style="margin: 5px 0; padding-left: 8px;  line-height: 1.8; letter-spacing: -0.04em; font-size: 12px;">					
							<span style="display:block; float: left; width: 100px; height: 65px; margin-right: 10px;  border: solid 1px #dddedf; border-right-color: #c9cacc; 	border-bottom-color: #c9cacc;overflow: hidden;"><a href=""><img src="/resources/images/common/@ex/pic_visualmain_02.jpg" alt=""/></a></span>
							<span style="position: relative; overflow: hidden;">
								<a href="" style="color: #6c6d70; text-decoration: none; line-height: 1.4; font-size: 11px;"><strong style="display: block; margin-bottom: 5px; color: #252525;">진흥원-영국 MRC와 보건의료 국제협력 체결</strong>
								영국서 대한민국 보건의료 위상 커졌다. 보건산업진흥원, 영국 MRC와 보건의료 국제협력 체결 성과관리 및 과제선정 노하우 전수키로 : 5년간의 노력의..</a>
							</span>
						</p>
						<h4 style="margin: 18px 0 5px; padding: 0; color: #252525;">보건산업진흥원 신규 발간자료</h4>
						<p style="margin: 0; padding: 0; color: #6c6d70;">
							[발간지]  글로벌 보건산업 동향 (Vol.128, 2014.10.17) new  <br/>
							[발간지]  주간 보건산업 동향 (Vol.129, 2014.10.20)  new   <br/>
							[발간지]  월간 보건산업 통계앤이슈 (Vol.2 No.14_2014.10)  new<br/>   
							[KHIDI브리프]  글로벌 의료기기 기업 주요 동향 - 상위 10대 기업을 중심으로<br/>  
							월간브리프]  의료기기 주요품목 시장분석(캡슐내시경)  <br/>
							[월간브리프]  의료기기 해외시장 진출정보(중국)  <br/>
							[월간브리프]  의료기기 주요품목 시장분석(환자감시장치)<br/>  
							[월간브리프]  의료기기 해외시장 진출정보(아랍에미리트)  <br/>
							[연구보고서]  해외지사 자체사업 결과보고서  <br/>
							[연구보고서]  국제조달시장 참여 활성화 방안 수립  
						</p>
					</div>
					<!-- //4단략 -->
				</div>
				<!-- //왼쪽 콘텐츠  STYLE -->	
				<!-- 오른쪽 콘텐츠  STYLE -->	
				<div style="float:left; width:300px;">
					<p style="margin: 0 0 20px; padding:0;"><a href="http://medicaldevice.khidi.or.kr" target="_blank" title="새창으로 열림"><img src="images/mdi/newsletter_sitelink.gif" alt="의료기기화장품산업단 홈페이지 바로가기" border="0"/></a></p>
					<!--부처별 지원사업 공고 -->	
					<div style="padding-bottom: 142px; background:url('images/mdi/newsletter_right_bottom.png') no-repeat 0 bottom;">
						<h3 style="margin:0; padding:0;"><img src="images/mdi/newsletter_right_top.gif" alt="부처별 지원사업 공고" /></h3>
						<div style="width:224px; margin: 0; padding: 20px 20px 0; background: #fff;">
							<dl>
								<dt style="margin: 0 0 10px; padding: 0; color: #037bc1; line-height: 1.8; letter-spacing: 0; font-size: 14px;  font-weight: bold;">[복지부, 보건산업진흥원]</dt>
								<dd style="margin: 0; padding: 0; font-size: 11px; line-height: 1.5;">
								<a href="" style="margin: 0; padding: 0;  line-height: 1.5; text-decoration: none;"><strong style="color: #45474d;">2014년 제2차 연구중심병원 육성 R&amp;D <br/>사업 신규지원 대상과제 공고 </strong>
								<span style="display: block; margin: 5px 0 0; padding: 12px 8px; background: #dbecf0; color: #616265;">지원규모 : 총 정부출연금 23.3억원<br/>전산입력기한:  2014.11.10(월)까지</span></a></dd>
								<dd style="margin: 15px 0 0; padding: 0; font-size: 11px; line-height: 1.5;">
								<a href="" style="margin: 0; padding: 0;  line-height: 1.5;  text-decoration: none;"><strong style="color: #45474d;">2014년 제2차 연구중심병원 육성 R&amp;D <br/>사업 신규지원 대상과제 공고 </strong>
								<span style="display: block; margin: 5px 0 0; padding: 12px 8px; background: #dbecf0; color: #616265;">지원규모 : 총 정부출연금 23.3억원<br/>전산입력기한:  2014.11.10(월)까지</span></a></dd>
		
								<dt style="margin: 30px 0 10px; padding: 0; color: #037bc1; line-height: 1.8; letter-spacing: 0; font-size: 14px;  font-weight: bold;">[복지부, 보건산업진흥원]</dt>
								<dd style="margin: 0; padding: 0; font-size: 11px; line-height: 1.5;">
								<a href="" style="margin: 0; padding: 0;  line-height: 1.5; text-decoration: none;"><strong style="color: #45474d;">2014년 제2차 연구중심병원 육성 R&amp;D <br/>사업 신규지원 대상과제 공고 </strong>
								<span style="display: block; margin: 5px 0 0; padding: 12px 8px; background: #dbecf0; color: #616265;">지원규모 : 총 정부출연금 23.3억원<br/>전산입력기한:  2014.11.10(월)까지</span></a></dd>
								<dd style="margin: 15px 0 0; padding: 0; font-size: 11px; line-height: 1.5;">
								<a href="" style="margin: 0; padding: 0;  line-height: 1.5;  text-decoration: none;"><strong style="color: #45474d;">2014년 제2차 연구중심병원 육성 R&amp;D <br/>사업 신규지원 대상과제 공고 </strong>
								<span style="display: block; margin: 5px 0 0; padding: 12px 8px; background: #dbecf0; color: #616265;">지원규모 : 총 정부출연금 23.3억원<br/>전산입력기한:  2014.11.10(월)까지</span></a></dd>
							</dl>
							<h3 style="margin: 40px 0 0; padding:0;"><img src="images/mdi/title_edu.gif" alt="교육 및 세미나" /></h3>
							<dl>
								<dt style="margin: 0 0 10px; padding: 0; color: #037bc1; line-height: 1.8; letter-spacing: 0; font-size: 14px;  font-weight: bold;">[한국보건산업진흥원] </dt>
								<dd style="margin: 0; padding: 0; font-size: 11px; line-height: 1.5;">
								<a href="" style="margin: 0; padding: 0;  line-height: 1.5; text-decoration: none;"><strong style="color: #45474d;">2014년 제2차 연구중심병원 육성 R&amp;D <br/>사업 신규지원 대상과제 공고 </strong>
								<span style="display: block; margin: 5px 0 0; padding: 12px 8px; background: #dbecf0; color: #616265;">지원규모 : 총 정부출연금 23.3억원<br/>전산입력기한:  2014.11.10(월)까지</span></a></dd>
								<dd style="margin: 15px 0 0; padding: 0; font-size: 11px; line-height: 1.5;">
								<a href="" style="margin: 0; padding: 0;  line-height: 1.5;  text-decoration: none;"><strong style="color: #45474d;">2014년 제2차 연구중심병원 육성 R&amp;D <br/>사업 신규지원 대상과제 공고 </strong>
								<span style="display: block; margin: 5px 0 0; padding: 12px 8px; background: #dbecf0; color: #616265;">지원규모 : 총 정부출연금 23.3억원<br/>전산입력기한:  2014.11.10(월)까지</span></a></dd>
		
								<dt style="margin: 30px 0 10px; padding: 0; color: #037bc1; line-height: 1.8; letter-spacing: 0; font-size: 14px;  font-weight: bold;">[한국의료기기공업협동조합] </dt>
								<dd style="margin: 0; padding: 0; font-size: 11px; line-height: 1.5;">
								<a href="" style="margin: 0; padding: 0;  line-height: 1.5; text-decoration: none;"><strong style="color: #45474d;">2014년 제2차 연구중심병원 육성 R&amp;D <br/>사업 신규지원 대상과제 공고 </strong>
								<span style="display: block; margin: 5px 0 0; padding: 12px 8px; background: #dbecf0; color: #616265;">지원규모 : 총 정부출연금 23.3억원<br/>전산입력기한:  2014.11.10(월)까지</span></a></dd>
								<dd style="margin: 15px 0 0; padding: 0; font-size: 11px; line-height: 1.5;">
								<a href="" style="margin: 0; padding: 0;  line-height: 1.5;  text-decoration: none;"><strong style="color: #45474d;">2014년 제2차 연구중심병원 육성 R&amp;D <br/>사업 신규지원 대상과제 공고 </strong>
								<span style="display: block; margin: 5px 0 0; padding: 12px 8px; background: #dbecf0; color: #616265;">지원규모 : 총 정부출연금 23.3억원<br/>전산입력기한:  2014.11.10(월)까지</span></a></dd>
							</dl>
						</div>
					</div>			
					<!-- //부처별 지원사업 공고 -->	
				</div>		
				<!-- //오른쪽 콘텐츠  STYLE -->	
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="divFile1">첨부파일</label></th>
			<td colspan="3">
				<div id="divFile1" style="border: 1px solid #97b4cc; width:100%; height:200px"></div>
                <br />
                <div id="divInnoFD1" style="border: 1px solid #97b4cc; width:100%; height:200px"></div>
                <br />
                <input class="innoGreenBtn" type="button" value="파일추가" onClick="File.OpenFileDialog('InnoDS1');" />
                <input class="innoBlueBtn" type="button" value="선택파일 다운로드" onClick="File.ComplexSelectDownload('InnoFD1','InnoDS1');" />
                <input class="innoBlueBtn" type="button" value="선택제거" onClick="File.RemoveSelectedItems('InnoDS1');" />
			</td>
		</tr>
	</table>
</fieldset>
</spform:form>

<div class="btn_area_form">
	<span class="float_right">
		<button type="button" class="btn_colorType01 ${!empty result[0].newsLetterId ? 'roleMODIFY' : 'roleWRITE'}" id="btnSave">저장</button>
		<c:if test="${!empty result[0].newsLetterId}">
		<button type="button" class="btn_colorType01 roleDELETE" id="btnDelete">삭제</button>
		</c:if>
		<button type="button" class="btn_colorType01" id="btnList">목록</button>
	</span>
</div>

							
<script type="text/javascript">
$(function() {
	
	gfnSiteAdminComboList($("#siteIdSel"), "", "사이트 선택", "${result[0].SITEID}"); // 사이트 select세팅
	$('#siteIdSel').on("change", function() { // 사이트 이벤트
		$("#siteId").val($(this).val());
	});
	
	//달력 세팅
	$( "#sendDueDate" ).datepicker({
    	showOtherMonths:true,
    	selectOtherMonths:true,
        showButtonPanel: true,
    	changeYear:true,
    	changeMonth:true,
    	showOn: 'both',
    	buttonImageOnly: true,
		buttonImage: "${contextPath}/resources/images/ips/sub/icon_calendar.gif"
    });
	
	var cusUploadURL = "${contextPath }/fileUpload?fileGubun=common&menuId=newsLetterMgr";		//${contextPath }/fileUpload	${contextPath }/resources/component/innoRix/InnoDS/result.jsp
	var cusResultURL = "${ctxMgr }/newsLetterMgr/act";											//${ctxMgr }/popupZoneMgr/act	${contextPath }/resources/component/innoRix/InnoDS/result.jsp
	innoInit({
        ContainElementID : "divFile1",		// 컴포넌트 출력객체 ID
		ActionElementID : "insertForm",		// 메타정보 전송폼 ID
		UploadURL : cusUploadURL,			// 업로드 처리 페이지	
		ResultURL : cusResultURL,			// 업로드 결과 페이지	
		MaxTotalSize : "5GB",				// 첨부가능 전체용량
		MaxFileSize : "5GB",				// 첨부가능 1개파일 용량
		TransferMode : "innods",			// InnoDS 업로드 모드 설정
		ExtFilter : ["파일", "${extFilterInclude}"],
        ComponentSize : ["1px", "1px"]
	    //, ExtFilter : ["그림파일", "*.png; *.gif; *.jpg; *.jpeg; *.bmp;"]
    }, 'InnoDS1');
	innoInit({
	    ContainElementID : "divInnoFD1", // 컴포넌트 출력 객체 ID
	    ActionElementID : "insertForm",         // 메타정보 전송폼 ID
	    UploadURL : cusUploadURL,               // 업로드 처리 페이지
	    ResultURL : cusResultURL,
	    ComponentSize : ["1px", "1px"],
	    TransferMode : "innofd"                 // InnoFD 다운로드 모드 설정
	},"InnoFD1");

	innoOnEvent = function(msgEvent, arrParam, objName)
	{

		if (msgEvent == Event.msgLoadComplete && objName == "InnoDS1") // 컴포넌트 로딩 완료 이벤트
		{ 
			// 가상파일 추가			
			<c:if test="${!empty(resultFile) && fn:length(resultFile) > 0 }">			
				File.AddVirtualFiles([
				//  ["파일명", 용량, "파일구분ID(FILEPATH)"],
				<c:forEach items="${resultFile }" var="fileList" varStatus="status">
					["${fileList.ORIGNL_FILE_NM}", "${fileList.FILE_SIZE}", "common@@newsLetterMgr@@${fileList.STRE_FILE_NM}@@InnoDS1"],
				</c:forEach>	
				], "InnoDS1");
			</c:if>
		}
	}
    
	$("#btnSave").click(function(){
		if($("#siteIdSel option:selected").val() == "") {
			alert("사이트를 선택하세요.");
			$("#siteIdSel").focus();
			return false;
		}
		if($("#KName").val().length <= 0) {
			alert("제목을 입력하세요.");
			$("#KName").focus();
			return false;
		}
/* 		if($("#sendDueDate").val().length <= 0) {
			alert("발송예정일을 입력하세요.");
			$("#startTime").focus();
			return false;
		}
		if($("#divFile1 >span").length <= 0){
			if($("#imageUserFileName").val().length <= 0) {
				alert("이미지를 입력하세요.");
				$("#imageUserFileName").focus();
				return false;
			}
		}
		if($("#KDesc").val().length <= 0) {
			alert("내용을 입력하세요.");
			$("#KDesc").focus();
			return false;
		}
 */
 		$("#kHtml1").val(CrossEditor1.GetBodyValue());
 
		if(!confirm("등록하시겠습니까?")) {
			
			return false;
		}
		File.Upload();
	});

	$("#btnDelete").click(function(){
		if(!confirm("삭제하시겠습니까?")) {
			return false;
		}
		$("#insertForm").attr('action', '${ctxMgr }/popupZoneMgr/delete');
		$("#insertForm").submit();
	});
	
	$("#btnList").click(function(){
		/* $("#insertForm").attr('action', '${ctxMgr }/popupZoneMgr');
		$("#insertForm").submit(); */

		location.href="${contextPath}/mgr/newsLetterMgr?${link}";
	});
	
});

//등록된 파일 태그 삭제
function fileDelete(){
	$("#divFile1 >span").remove();
}
</script>
