<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>
<%@ include file="/includes/bbsContents.jsp" %>

<!-- 콘텐츠영역 --> 
<div class="month_schedule">
	<p class="month_num">${YEAR }.${MONTH }</p>
	<span class="btn_prev_m">
		<a href="${contextPath }/board?menuId=${obj.menuId }&YEAR=${prevYear}&MONTH=${prevMonth}">
			<img src="${contextPath }/resources/images/common/bbs/btn_prev_m.gif" alt="이전달" />
		</a>
	</span>
	<span class="btn_next_m">
		<a href="${contextPath }/board?menuId=${obj.menuId }&YEAR=${nextYear}&MONTH=${nextMonth}">
			<img src="${contextPath }/resources/images/common/bbs/btn_next_m.gif" alt="다음달" />
		</a>
	</span>
	<div class="m_schedule">
		<table class="tb_schedule">
			<caption>${YEAR }년 ${MONTH }월  주요일정</caption>
			<colgroup>
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="sun">Sun</th>
					<th scope="col">Mon</th>
					<th scope="col">Tue</th>
					<th scope="col">Wed</th>
					<th scope="col">Thu</th>
					<th scope="col">Fri</th>
					<th scope="col">Sat</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${obj.menuId ne 'MENU00390'}">
					<jsp:useBean id="now" class="java.util.Date" />
					<c:set var="classOn" value="" />
					<c:forEach items="${DAYS}" var="day" varStatus="daySt">
						<c:choose>
							<c:when test="${daySt.count == 1 && day[6] == ''}"></c:when>
							<c:when test="${daySt.count == 6 && day[0] == ''}"></c:when>
							<c:otherwise>
							<tr>
								<c:forEach begin="0" end="6" var="di" varStatus="st">
									<c:forEach items="${result}" var="item">
										<c:choose>
												<c:when test="${item.STARTTIME eq item.ENDTIME}">
													<c:if test="${day[di] eq item.STARTTIME}">
														<c:set var="classOn" value="on" />
													</c:if>
												</c:when>
												<c:otherwise>
													<c:if test="${day[di] >= item.STARTTIME && day[di] <= item.ENDTIME}">
														<c:set var="classOn" value="on" />
													</c:if>
												</c:otherwise>
										</c:choose>																	
									</c:forEach>
									<c:choose>
										<c:when test="${st.count == 1 && day[di] eq item.STARTTIME}">
											<td class="sun" id="day${day[di]}"><p class="day ${classOn}"><fmt:formatNumber value="${day[di]}" type="number"/></p>
										</c:when>
										<c:when test="${st.count == 7 && day[di] eq item.STARTTIME}">
											<td class="sat" id="day${day[di]}"><p class="day ${classOn}"><fmt:formatNumber value="${day[di]}" type="number"/></p>
										</c:when>
										<c:otherwise>
											<td id="day${day[di]}">
												<p class="day ${classOn}"><fmt:formatNumber value="${day[di]}" type="number"/></p>
												<c:set var="classOn" value="" />
										</c:otherwise>
									</c:choose>
									<c:forEach items="${result}" var="item">
										<c:choose>
											<c:when test="${item.STARTTIME eq item.ENDTIME}">										
												<c:if test="${day[di] eq item.STARTTIME}">
													<p><a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${item.NUM1 }&linkId=${item.LINKID }&YEAR=${YEAR }&MONTH=${MONTH}${link}">${item.KNAME }</a></p><br/>
												</c:if>
											</c:when>
											<c:otherwise>
												<fmt:parseNumber var="daySel" type="number" value="${day[di]}" />
												<fmt:parseNumber var="startT" type="number" value="${item.STARTTIME}" />
												<fmt:parseNumber var="endT" type="number" value="${item.ENDTIME}" />
												
												<c:if test="${daySel >= startT && daySel <= endT}">
													<p><a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${item.NUM1 }&linkId=${item.LINKID }&YEAR=${YEAR }&MONTH=${MONTH}${link}">${item.KNAME }</a></p><br/>
												</c:if>	
	<%-- 											<c:if test="${day[di] eq item.STARTTIME}">
													<p><a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${item.NUM1 }&linkId=${item.LINKID }&YEAR=${YEAR }&MONTH=${MONTH}${link}">${item.KNAME }</a></p><br/>
												</c:if>
	
											
												<c:if test="${day[di] eq item.ENDTIME}">
													<p><a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${item.NUM1 }&linkId=${item.LINKID }&YEAR=${YEAR }&MONTH=${MONTH}${link}">${item.KNAME }</a></p><br/>
												</c:if>	 --%>
											</c:otherwise>
									</c:choose>																	
									</c:forEach>
									</td>
								</c:forEach>
							</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
				<c:if test="${obj.menuId eq 'MENU00390'}">
					<c:forEach items="${DAYS}" var="day" varStatus="daySt">
						<c:choose>
							<c:when test="${daySt.count == 1 && day[6] == ''}"></c:when>
							<c:when test="${daySt.count == 6 && day[0] == ''}"></c:when>
							<c:otherwise>
							<tr>
								<c:forEach begin="0" end="6" var="di" varStatus="st">
									<fmt:formatNumber value="${day[di]}" pattern="00" var="patternDay" />
									<c:forEach items="${rtnCalendarList}" var="item">
										<c:if test="${fn:substring(item.D, 8, 10) == patternDay}">
											<c:set var="classOn" value="on" />
										</c:if>
									</c:forEach>
									<c:choose>
										<c:when test="${st.count == 1 && day[di] eq item.STARTTIME}">
											<td class="sun" id="day${day[di]}"><p class="day ${classOn}"><fmt:formatNumber value="${day[di]}" type="number"/></p>
										</c:when>
										<c:when test="${st.count == 7 && day[di] eq item.STARTTIME}">
											<td class="sat" id="day${day[di]}"><p class="day ${classOn}"><fmt:formatNumber value="${day[di]}" type="number"/></p>
										</c:when>
										<c:otherwise>
											<td id="day${day[di]}">
												<p class="day ${classOn}"><fmt:formatNumber value="${day[di]}" type="number"/></p>
												<c:set var="classOn" value="" />
										</c:otherwise>
									</c:choose>
									<c:forEach items="${rtnCalendarList}" var="item">
										<c:if test="${fn:substring(item.D, 8, 10) == patternDay}">
											<p><a href="${contextPath}/board/view?pageNum=${obj.pageNum }&rowCnt=${obj.rowCnt }&no1=${item.NUM1 }&linkId=${item.LINKID }&YEAR=${YEAR }&MONTH=${MONTH}${link}">${item.KNAME }</a></p><br/>
										</c:if>
									</c:forEach>
									</td>
								</c:forEach>
							</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<script type="text/javascript">
$(function(){
	//검사년도
	<c:forEach items="${DAYS}" var="day" varStatus="daySt">
		<c:forEach begin="0" end="6" var="di" varStatus="st">
			var holidayName = gfnIsHoliday("${YEAR}", "${MONTH}", "${day[di]}");
			if (holidayName != "") {
				$("#day${day[di]}").append('<p>'+holidayName+'</p>');
				$("#day${day[di]}").attr('class', 'sun');
			}
		</c:forEach>
	</c:forEach>
	
});

</script>
