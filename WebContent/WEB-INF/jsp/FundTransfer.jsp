<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="edu.groupc.project.beans.UserValueBean"%>
<%@ page import="edu.groupc.project.beans.AccountDetailsValueBean"%>
<%@ page import="java.util.Map.Entry"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank Portal - GROUP C</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src=https://code.jquery.com/jquery-1.12.4.js></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

<!-- Load an icon library -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<style type="text/css">
.navbar {
	background-color: #ADD9F4;
	border-radius: 4px;
	display: flex;
	justify-content: space-around;
	align-items: center;
}

.navbar a {
	color: black;
	letter-spacing: 2px;
	text-decoration: none;
}

#formContainer {
	background-color: #DAF7DC;
	display: flex;
	justify-content: center;
	min-height: 100vh;
}

.editBtn, .submitBtn, .accountBtn, .removeBtn {
	letter-spacing: 2px;
	border-radius: 10px;
}

.tableData {
	
}
</style>


</head>
<body>
	<div class="navbar">
		<a class="active" href="./AccountHomeController"><i
			class="fa fa-fw fa-institution"></i> Home</a> <a
			href="./CustomerProfileController"><i
			class="fa fa-fw fa-user-circle-o"></i> Customer Profile</a> <a
			href="./AccountDetailsController"><i class="fa fa-fw fa-group"></i>
			Account Details</a> <a href="./FundTransferController"><i
			class="fa fa-fw fa-dollar"></i> Fund Transfer</a> <a
			href="./LoginController"><i class="fa fa-fw fa-user"></i> Logout</a>
	</div>

	<div class="container mt-5">
		<form name="fundTransfer" id="fundTransfer"
			action="./FundTransferController" method="post">
			<%
				UserValueBean userValueBean = (UserValueBean) request.getSession().getAttribute("user");
				String responseStr = (String) request.getAttribute("status");
				request.removeAttribute("status");
			%>

			<table class="table">
				<thead>
					<tr>
						<th></th>
						<th>Accounts</th>
						<th>IFSC CODE</th>
						<th>Branch Name</th>
						<th>Balance</th>
					</tr>
				</thead>
				<tbody>

					<%
						int i = 0;
						for (Entry<String, AccountDetailsValueBean> entry : userValueBean.getAccountDetailsValueBean().entrySet()) {

							AccountDetailsValueBean accountDetailsValueBean = (AccountDetailsValueBean) entry.getValue();
					%>
					<tr>
						<td><input class="form-check-input" type="radio" id="accNum"
							name="accNum"
							value="<%=accountDetailsValueBean.getAccountNumber() + "#" +accountDetailsValueBean.getBalance() %>" /></td>
						<td>
							<%
								out.print(accountDetailsValueBean.getAccountNumber());
							%>
						</td>

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
				</tbody>
			</table>

			<div class="mt-4">
				<input type="button" class="btn btn-primary accountBtn"
					id="transferButton" value="Transfer" /> <input type="button"
					class="btn btn-warning accountBtn" id="CreditDebitButton"
					value="Credit/Debit" />
				<%
					if (responseStr != null) {
				%>
				<br />
				<br />
				<div
					class="alert alert-success alert-dismissible d-flex align-items-center fade show">
					<i class="bi-check-circle-fill"></i> <strong class="mx-2">Success!</strong>
					<%=responseStr%>
					<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				</div>

				<%
					}
				%>
				<input type="hidden" id="flow" name="flow" value="" />
				<div id="transferDiv" class="mt-4">

					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="transferType"
							id="transferType" value="1" checked> <label
							class="form-check-label" for="inlineRadio1">TO MY ACCOUNT</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="transferType"
							id="transferType" value="2"> <label
							class="form-check-label" for="inlineRadio1">TO OTHER
							ACCOUNT</label>
					</div>

					<input type="hidden" id="fromAccount" name="fromAccount" value="" />
					<input type="hidden" id="tranTypeHidden" name="tranTypeHidden" value="1" />

					<div class="row mt-2">
						<label for="accountNumber" class="form-label">Account
							Number : </label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="accountNumber"
								name="accountNumber" placeholder="Account Number" value="" pattern="[a-zA-Z0-9 ]+" required
								oninvalid="this.setCustomValidity('Enter Valid Account Number Here')"
								oninput="this.setCustomValidity('')">
						</div>
					</div>

					<div class="row mt-2">
						<label for="accountNumberConfirm" class="form-label">ReEnter
							Account Number :</label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="accountNumberConfirm"
								name="accountNumberConfirm" placeholder="ReEnter Account Number"
								value="" pattern="[a-zA-Z0-9 ]+" required
								oninvalid="this.setCustomValidity('Enter Valid Account Number Here')"
								oninput="this.setCustomValidity('')">
						</div>
					</div>

					<div class="row mt-2">
						<label for="ifscCode" class="form-label">IFSC code :</label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="ifscCode"
								name="ifscCode" placeholder="IFSC Code" value="" pattern="[a-zA-Z0-9 ]+" required
								oninvalid="this.setCustomValidity('Enter Valid IFSC code Here')"
								oninput="this.setCustomValidity('')">
						</div>
					</div>

					<div class="row mt-2">
						<label for="branchName" class="form-label">Branch Name : </label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="branchName"
								name="branchName" placeholder="Branch Name" value="" 
								pattern="[a-zA-Z]+" required
								oninvalid="this.setCustomValidity('Enter Valid Branch Name Here')"
								oninput="this.setCustomValidity('')">
						</div>
					</div>

					<div class="row mt-2">
						<label for="amount" class="form-label">Amount : </label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="amount" name="amount"
								placeholder="Amount" value="" pattern="(\d{3})([\.])(\d{2})" required
						oninvalid="this.setCustomValidity('Enter Valid Amount Here')"
						oninput="this.setCustomValidity('')">
								
						</div>
					</div>
					<br> <input type="button" class="btn btn-success" id="send"
						value="Send" />
				</div>

				<div id="creditDebitDiv" class="mt-4">
					<div class="form-check form-check-inline">
						<input class="form-check-input"  type="radio" 
							name="transactionType" id="transactionType" value="1" checked> <label
							class="form-check-label" for="inlineRadio1" >CREDIT</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="transactionType" id="transactionType" value="2"> <label
							class="form-check-label" for="inlineRadio1">DEBIT</label>
					</div>

					<input type="hidden" id="fromAccountCash" name="fromAccountCash"
						value="" />

					<div class="row mt-2">
						<label for="amountCash" class="form-label">Amount : </label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="amountCash"
								name="amountCash" placeholder="Amount Cash" value="" pattern="(\d{3})([\.])(\d{2})" required
						oninvalid="this.setCustomValidity('Enter Valid Amount Here')"
						oninput="this.setCustomValidity('')">
						</div>
					</div>

					<br> <input type="button" class="btn btn-success"
						id="complete" value="Complete" />
				</div>
			</div>
		</form>
	</div>
	<script>
		$(function() {
			$("#transferDiv").hide();
			$("#creditDebitDiv").hide();
			$('#transferButton').prop('disabled', true);
			$('#CreditDebitButton').prop('disabled', true);
			$('input:radio[name="accNum"]').change(function() {
				$('#transferButton').prop('disabled', false);
				$('#CreditDebitButton').prop('disabled', false);
			});
			$("#transferButton").click(function() {
				$("#transferDiv").show();
				$("#send").prop('disabled', true);
				$("#creditDebitDiv").hide();
				$('#CreditDebitButton').prop('disabled', true);

			});
			$('input:radio[name="transferType"]').change(function() {
				$("#send").prop('disabled', false);
			});

			$("#send").click(function() {
				var res =document.querySelector('input[name="accNum"]:checked').value.split("#");
				//alert(document.querySelector('input[name="transferType"]:checked').value);
				var res =document.querySelector('input[name="accNum"]:checked').value.split("#");
				if(document.querySelector('input[name="transferType"]:checked').value==2 && res[1]< document.getElementById("amount").value){
					alert("Transfer amount is greater than present balance");
				}else{
					document.getElementById("tranTypeHidden").value=document.querySelector('input[name="transferType"]:checked').value;
				document.getElementById("fromAccount").value=res[0];
				$("#flow").val("transfer");
				$('#fundTransfer').submit();
				}

			});
			$("#CreditDebitButton").click(function() {
				$("#transferDiv").hide();
				$('#transferButton').prop('disabled', true);
				$("#creditDebitDiv").show();
				$('#CreditDebitButton').prop('disabled', false);
			});
			$("#complete").click(
					function() {
						$('#fundTransfer').attr('action',
								'./CashTransactionController');
						$("#flow").val("cash");
						var res =document.querySelector('input[name="accNum"]:checked').value.split("#");
						if(document.querySelector('input[name="transactionType"]:checked').value==2 && res[1]< document.getElementById("amountCash").value){
							alert(" Debit amount is greater than present balance");
						}else{
						document.getElementById("fromAccountCash").value=res[0];
						$('#fundTransfer').submit();
						}

					});
		});
	</script>
</body>
</html>