<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/includes/taglib.jsp" %>

	<table class="tstyle_view" id="tblContent" summary="콘텐츠 내용">
		<caption>
			HtmlEditor Type 입력
		</caption>
		<colgroup>
			<col width="100" />
			<col />
		</colgroup>
		<tr>
			<td colspan="2">
			<div>
				<textarea id="html" name="html" rows="" cols="" style="display: none;"></textarea>
				<!-- ▼ 에디터 -->
				<script type="text/javascript">
					// 부모창의 htmlId 에서 데이터를 조회하여 세팅
					$("#html").val($('#${htmlId}', opener.document).val());

					var CrossEditor = new NamoSE('namoeditor');
					CrossEditor.params.ImageSavePath = "${editorImgPath}";
					CrossEditor.params.UploadFileExecutePath = "${editorUploadFileExePath}";

					CrossEditor.params.Width = "100%";
					CrossEditor.EditorStart();

					function OnInitCompleted(e){
						e.editorTarget.SetBodyValue(document.getElementById("html").value);
					}
					//화면 크기 수정
					CrossEditor.SetBodyValue($("#html").val());
				</script>
				<!-- ▲ 에디터  -->
			</div>
			</td>
		</tr>
	</table>

	<div class="btn_area_right">
		<button type="button" class="btn_colorType01 roleWRITE" id="btnSave">적용</button>
		<button type="button" class="btn_colorType01 roleDELETE" id="btnClose">닫기</button>
	</div>

	<script type="text/javascript">
		$(function() {

			$("#btnSave").click(function(){

				var html = CrossEditor.GetBodyValue();

				if ( $(html).size() < 1 )
				{
					alert("내용을 입력하세요");
					return false;
				}

				$('#${htmlId}', opener.document).val(html);

				self.close();
			});

			$("#btnClose").click(function(){
				self.close();
			});
		});
	</script>