<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"  %>

<script type="text/javascript">
<!--

$(function(){
	/* 
	// 댓글 입력시 글자 수 표시
	$('div.reply_write > .cmt_title > .float_right > strong').text($('#replyArea').val().length);
	*/
	
	/* 리플 리스트 */
	gfnReplyList($('#reply'), '${obj.linkId}');
});

//-->
</script>
<c:if test="${rtnSetting.commentYN eq 'Y'}">   
    <div class="reply_write">
        <div class="cmt_title">     
            <h2 class="title">댓글등록</h2>
            <p class="txt">로그인 또는 본인확인 후 작성 가능합니다.</p>
        </div>
        <div class="float_wrap">
	        <textarea name="reply_content" class="replyArea" id="replyArea" cols="40" rows="5"></textarea>
	        <c:if test="${(!empty USER.userId and USER.userId != '') or (!empty ADMUSER.userId and ADMUSER.userId != '')}">
	        	<button id="send" class="btn btn_basic" onclick="javascript:gfnReplyInsert($('#replyArea'), '${obj.linkId}')">입력</button>
	        </c:if>
	        <c:if test="${empty USER.userId and empty ADMUSER.userId}">
	        	<button id="send" class="btn_type01" onclick="javascript:if('${USER.userId}' == ''){alert('로그인이 필요합니다.');}else{gfnReplyInsert($('#replyArea'), '${obj.linkId}');}">입력</button>
	        </c:if>
        </div>
    </div>
    <ul class="recmt_list" id="reply"></ul>
</c:if>