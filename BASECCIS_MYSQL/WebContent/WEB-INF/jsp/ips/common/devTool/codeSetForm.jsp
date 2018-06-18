<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<spform:form id="insertForm" name="insertForm" action="${contextPath }/mgr/devToolMgr/codeSetAct" method="post">
<fieldset>
	<legend>사이트 정보 입력</legend>
	<p><span class="point01">*</span> 필수입력항목 입니다.</p>
	<div class="table">
		<table class="tstyle_view" summary="등록일, 이름, 이메일, 담당부서, 제목, 내용에 따른 게시물상세 안내">
			<caption>
				사이트 상세 정보 입력
			</caption>
			<colgroup>
				<col width="10%" />
				<col />
			</colgroup>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="projectPath">프로젝트경로</label></th>
				<td>
					<input type="text" name="projectPath" id="projectPath" class="input_long" disabled="disabled" title="프로젝트경로" value="${projectPath }" />
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="siteKey">사이트키</label></th>
				<td>
					<select name="siteIdSel" id="siteIdSel"></select>
					<input type="text" name="siteKey" id="siteKey" readonly="readonly" title="사이트키" value="" />
				</td>
			</tr>
			<tr id="positionTr" style="display: none;">
				<th scope="row"><span class="point01">*</span> <label for="position">생성위치</label></th>
				<td>
					<input type="checkbox" name="position" value="admin" title="관리자" /><label for="admin">관리자</label>
					<input type="checkbox" name="position" value="user" title="사용자" /><label for="user">사용자</label>
					<input type="hidden" name="ipsPkgPath" value="src\kr\plani\ccis\ips\{#mvcDir#}\{#siteKey#}" title="관리자패키지경로"/>
					<input type="hidden" name="sitePkgPath" value="src\kr\plani\ccis\{#siteKey#}\{#mvcDir#}" title="사용자패키지경로"/>
					<input type="hidden" name="ipsJspPath" value="WebContent\WEB-INF\jsp\ips\{#siteKey#}\{#mvcDir#}" title="jsp경로"/>
					<input type="hidden" name="siteJspPath" value="WebContent\WEB-INF\jsp\{#siteKey#}\{#mvcDir#}" title="jsp경로"/>
					<p>관리자 : src.kr.plani.ccis.ips.mvc폴더.사이트키</p>
					<p>사용자 : src.kr.plani.ccis.사이트키.mvc폴더</p>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="tableKind">테이블종류</label></th>
				<td>
					<select name="tableName">
						<option>선택하세요.</option>
						<c:forEach items="${rtnTableList }" var="list" varStatus="loop">
							<option value="${list.TABLE_NAME }">${list.TABLE_NAME }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><span class="point01">*</span> <label for="javaName">기능명</label></th>
				<td>
					<input type="text" name="fnName" id="fnName" title="기능명" value="" />
					<span>**Controller.java, **.java, **Mapper.java, **Service.java, **.mapper.xml</span>
				</td>
			</tr>
			<!-- <tr>
				<th scope="row"><span class="point01">*</span> <label for="txtareaCodeCtrl"></label></th>
				<td>
				</td>
			</tr> -->
		</table>
	</div>
</fieldset>
</spform:form>

<div class="btn_area">	
	<button type="button" class="btn btn_type02" id="btnSave">저장</button>
</div>

<script type="text/javascript">
$(function() {
	gfnSiteKeyComboList($("#siteIdSel"), "", "사이트 선택", ""); // 사이트 select세팅
	
	$('#siteIdSel').on("change", function() { // 사이트 이벤트	
		if($(this).val() != 'ips')$("#positionTr").show();
		else $("#positionTr").hide();
		
		$("#siteKey").val($(this).val());
	});
	
	$("#btnSave").click(function(){
		$("#insertForm").submit();
	});

});

</script>
