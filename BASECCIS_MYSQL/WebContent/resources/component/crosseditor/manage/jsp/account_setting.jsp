<%@page contentType="text/html;charset=utf-8" %>
<%@include file = "./include/session_check.jsp"%>
<%@include file = "manager_util.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Namo CrossEditor : Admin</title>
	<script type="text/javascript"> var pe_mH = "pe_uU"; </script>
	<script type="text/javascript" src="../manage_common.js"></script>
	<script type="text/javascript" language="javascript" src="../../js/namo_cengine.js"></script>
	<script type="text/javascript" language="javascript" src="../manager.js"></script>
	<link href="../css/common.css" rel="stylesheet" type="text/css">
</head>

<body>

<%@include file = "../include/top.html"%>

<div id="pe_Tf" class="pe_ei">	
	<table class="pe_lr">
	  <tr>
		<td class="pe_ei">
		
			<table id="Info">
				<tr>
					<td style="padding:0 0 0 10px;height:30px;text-align:left">
					<font style="font-size:14pt;color:#3e77c1;font-weight:bold;text-decoration:none;"><span id="pe_uW"></span></font></td>
					<td id="InfoText"><span id="pe_pj"></span></td>
				</tr>
				<tr>
					<td colspan="2"><img id="pe_pV" src="../images/title_line.jpg" alt="" /></td>
				</tr>
			</table>
		
		</td>
	  </tr>
	  <tr>
		<td class="pe_ei">
			
				<form method="post" id="pe_adJ" action="account_proc.jsp" onsubmit="return pe_J(this);">
				<table class="pe_hA" >
				  <tr>
					<td>

						<table class="pe_cc">
						  <tr><td class="pe_dy" colspan="3"></td></tr>
						</table>
						 
						<table class="pe_cc" >
						  <tr>
							<td class="pe_ca">&nbsp;&nbsp;&nbsp;&nbsp;<b><span id="pe_rz"></span></b></td>
							<td class="pe_bQ"></td>
							<td class="pe_bN">
								<input type="hidden" name="u_id" id="u_id" value="<%=detectXSSEx(session.getAttribute("memId").toString())%>" autocomplete="off"/>
								<input type="password" name="passwd" id="passwd" value="" class="pe_ik" autocomplete="off"/>
							</td>
						  </tr>
						  <tr>
							<td class="pe_bU" colspan="3"></td>
						  </tr>
						  <tr>
							<td class="pe_ca">&nbsp;&nbsp;&nbsp;&nbsp;<b><span id="pe_wd"></span></b></td>
							<td class="pe_bQ"></td>
							<td class="pe_bN">
								<input type="password" name="newPasswd" id="newPasswd" value="" class="pe_ik" autocomplete="off"/>
							</td>
						  </tr>
						  <tr>
							<td class="pe_bU" colspan="3"></td>
						  </tr>
						  <tr>
							<td class="pe_ca">&nbsp;&nbsp;&nbsp;&nbsp;<b><span id="pe_we"></span></b></td>
							<td class="pe_bQ"></td>
							<td class="pe_bN">
								<input type="password" name="newPasswdCheck" id="newPasswdCheck" value="" class="pe_ik" autocomplete="off"/>
							</td>
						  </tr>
						</table>
					
						<table class="pe_cc">
						  <tr><td class="pe_dy" colspan="3"></td></tr>
						</table>
								
					</td>
				  </tr>
				  <tr id="pe_xP">
					<td id="pe_xN">
						<ul style="margin:0 auto;width:170px;">
							<li class="pe_dZ">
								<input type="submit" id="pe_vo" value="" class="pe_dV pe_di" style="width:66px;height:26px;" />
							</li>
							<li class="pe_dZ"><input type="button" id="pe_oL" value="" class="pe_dV pe_di" style="width:66px;height:26px;"></li>
						</ul>
					</td>
				  </tr>
				</table>
				</form>
		
		</td>
	  </tr>
	</table>

</div>

<%@include file = "../include/bottom.html"%>

</body>
<script>
var webPageKind = '<%=detectXSSEx(session.getAttribute("webPageKind").toString())%>'
topInit();
pe_z();
</script>

</html>

	
	

