<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

<p class="txt_center">읍/면/동 이름을 입력하시고 주소찾기 버튼을 클릭하세요.</p>
<div class="search_area">
        <form id="zipcode_form" name="zipcode_form" method="post">
            <fieldset>
                <legend>지역명으로 우편번호 찾기</legend>
                    <div>
                        <label for="keyword"><strong>지역명</strong></label>
                        <input type="text" name="keyword" id="keyword" title="검색어" class="input_mid"/>
                        <span class="btnstyle2"><button type="button">주소찾기</button></span>
                    </div>
            </fieldset>
        </form>
        <div class="post_code_ex">지역명 예: 청량리동, 청량리</div>
</div>
<div class="result">
    <p>&quot;<strong>가장동</strong>&quot;(으)로 <strong class="color_point02">12</strong>개가 검색되었습니다.</p>
    <form id="zipcode_result_form" name="zipcode_form" method="post">
        <fieldset>
            <legend>우편번호 검색결과</legend>
            <table class="tstyle_list">
                <caption>
                우편번호 검색결과
                </caption>
                <colgroup>
                    <col width="20%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th scope="col" class="none">우편번호</th>
                    <th scope="col">주소</th>
                </tr>
                <tr>
                    <td class="none num">363-973</td>
                    <td class="txt_left">대전시 유성구 가장동</td>
                </tr>
            </table>
        </fieldset>
    </form>
</div>