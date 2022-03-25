<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="edu.groupc.project.beans.UserValueBean"%>
<%@ page import="edu.groupc.project.beans.AccountDetailsValueBean"%>
<%@ page import="java.util.Map.Entry"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank Portal</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src=https://code.jquery.com/jquery-1.12.4.js></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<!-- Load an icon library -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<form name="fundTransfer" id="fundTransfer" action="./FundTransferController"
		method="post">
	<%
UserValueBean userValueBean = (UserValueBean)request.getSession().getAttribute("user");
String responseStr=(String)request.getAttribute("status");
request.removeAttribute("status");
System.out.println(responseStr);
%>
	<div class="navbar">
		<a class="active" href="./AccountHomeController"><i class="fa fa-fw fa-institution"></i>
			Home</a> <a href="./CustomerProfileController"><i
			class="fa fa-fw fa-user-circle-o"></i> Customer Profile</a> <a
			href="./AccountDetailsController"><i class="fa fa-fw fa-group"></i>
			Account Details</a> <a href="./FundTransferController"><i class="fa fa-fw fa-dollar"></i>
			Fund Transfer</a> <a href="./LoginController"><i class="fa fa-fw fa-user"></i> Logout</a>
	</div>
	<%if(responseStr!=null) {%>
	<h3>
		<%
            out.print(responseStr);
        %>
	</h3>
	<%} %>
	<table width="900" cellspacing="0" cellpadding="0">
		<tr>
			<td>Accounts</td>
			<td>IFSC CODE</td>
			<td>Branch Name</td>
			<td>Balance</td>

		</tr>
		<%
int i=0;
for (Entry<String, AccountDetailsValueBean> entry : userValueBean.getAccountDetailsValueBean().entrySet()) {



	AccountDetailsValueBean accountDetailsValueBean = (AccountDetailsValueBean) entry.getValue();
	%>
		<tr>
			<td><input type="radio" id="accNum" name="accNum"
				value="<%=accountDetailsValueBean.getAccountNumber()%>" /><%
            out.print(accountDetailsValueBean.getAccountNumber());
        %></td>

			<td>
				<%
            out.print(accountDetailsValueBean.getIfscCode());
        %>
			</td>
			<td>
				<%
            out.print(accountDetailsValueBean.getBranchName());
        %>
			</td>
			<td>
				<%
            out.print(accountDetailsValueBean.getBalance());
        %>
			</td>

		</tr>




		<%
	i++;
}
%>
	</table>
	
		<input type="button" id="transferButton" value="Transfer" />
		<input type="button" id="CreditDebitButton" value="Credit/Debit" />
		<input type="hidden" id="flow" name="flow" value=""/>
		<div id="transferDiv">
		<input type="radio" id="transferType"  name="transferType" value=1 />TO MY ACCOUNT
		<input type="radio" id="transferType"  name="transferType" value=2 />TO OTHER ACCOUNT
		<input type="hidden" id="fromAccount" name="fromAccount" value=""/>
		<label for="accountNumber">Account Number : </label> <input
			type="text" id="accountNumber" name="accountNumber" value="" /><br>
		<br> <label for="accountNumberConfirm">ReEnter Account
			Number : </label> <input type="text" id="accountNumberConfirm"
			name="accountNumberConfirm" value="" /><br>
		<br> <label for="ifscCode">IFSC code : </label> <input
			type="text" id="ifscCode" name="ifscCode" value="" /><br>
		<br> <label for="branchName">Branch Name : </label> <input
			type="text" id="branchName" name="branchName" value="" /><br>
			<label for="amount">Amount : </label> <input
			type="text" id="amount" name="amount" value="" /><br>
		<br> <input type="submit" id="send" value="Send" />
		</div>
		<div id="creditDebitDiv">
		<input type="radio" id="transactionType" name="transactionType" value=1 />CREDIT
		<input type="radio" id="transactionType" name="transactionType" value=2 />DEBIT
		<input type="hidden" id="fromAccountCash" name="fromAccountCash" value=""/>
		<label for="amountCash">Amount : </label> <input
			type="text" id="amountCash" name="amountCash" value="" /><br>
		<br> <input type="submit" id="complete" value="Complete" />
		</div>
	</form>
	<script>
$( function() {
	$( "#transferDiv" ).hide();
	$( "#creditDebitDiv" ).hide();
	$('#transferButton').prop('disabled', true);
	$('#CreditDebitButton').prop('disabled', true);	
		$('input:radio[name="accNum"]').change(
			    function(){
			    	$( "#fromAccount" ).val($(this).val());
			    	 $( "#fromAccountCash" ).val($(this).val());
    	$('#transferButton').prop('disabled', false);	
    	$('#CreditDebitButton').prop('disabled', false);	
    });
	 $( "#transferButton" ).click(function() {
		 	$( "#transferDiv" ).show();
		 	 $( "#send" ).prop('disabled', true);
		 	$( "#creditDebitDiv" ).hide();
		 	$('#CreditDebitButton').prop('disabled', true);	
	    	
	    });
	$('input:radio[name="transferType"]').change(
			    function(){
		 $( "#send" ).prop('disabled', false);
	 });
	 
	 $( "#send" ).click(function() {
		 $( "#flow" ).val("transfer");
	 });
	 $( "#CreditDebitButton" ).click(function() {
		 $( "#transferDiv" ).hide();
		 $('#transferButton').prop('disabled', true);
	 	$( "#creditDebitDiv" ).show();
	 	$('#CreditDebitButton').prop('disabled', false);	
	 });
	 $( "#complete" ).click(function() {
		 $('#fundTransfer').attr('action', './CashTransactionController');
		 $( "#flow" ).val("cash");
		 $( "#fromAccountCash" ).val($( "#accNum" ).val());
	 });
});
</script>
</body>
</html>