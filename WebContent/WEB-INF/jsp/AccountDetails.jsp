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
			class="fa fa-fw fa-institution"></i>Home</a> <a
			href="./CustomerProfileController"><i
			class="fa fa-fw fa-user-circle-o"></i> Customer Profile</a> <a
			href="./AccountDetailsController"><i class="fa fa-fw fa-group"></i>Account
			Details</a> <a href="./FundTransferController"><i
			class="fa fa-fw fa-dollar"></i>Fund Transfer</a> <a
			href="./LoginController"><i class="fa fa-fw fa-user"></i> Logout</a>
	</div>

	<div class="container pt-5">
		<form name="accountDetails" id="accountDetails"
			action="./AccountDetailsController" method="post">
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
							value="<%=accountDetailsValueBean.getAccountNumber()%>" /></td>
						<td>
							<%
								out.print(accountDetailsValueBean.getAccountNumber());
							%>
						</td>

						<td class="tableData">
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

			<div class="addAccountForm mt-4">
				<input type="button" id="addAccount" name="addAccount"
					class="btn btn-primary accountBtn" value="Add Account" /> <input
					type="submit" id="removeAccount" class="btn btn-danger removeBtn"
					value="Remove Account" /> <input type="hidden" id="flagSubmit"
					name="flagSubmit" value="" /> <input type="hidden"
					id="removeAccNum" name="removeAccNum" value="" />
				<%
					if (responseStr != null) {
				%>
				<br /> <br />
				<div
					class="alert alert-success alert-dismissible d-flex align-items-center fade show">
					<i class="bi-check-circle-fill"></i> <strong class="mx-2">Success!</strong>
					<%=responseStr%>
					<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				</div>

				<%
					}
				%>
				<div id="addDiv" class="mt-4">
					<div class="row">
						<label for="accountNumber" class="form-label">Account
							Number : </label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="accountNumber"
								name="accountNumber" placeholder="Account Number" value=""
								pattern="[a-zA-Z0-9 ]+" required
								oninvalid="this.setCustomValidity('Enter Valid Account Number Here')"
								oninput="this.setCustomValidity('')">
						</div>
					</div>
					<div class="row mt-2">
						<label for="accountNumberConfirm" class="form-label">ReEnter
							Account Number : </label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="accountNumberConfirm"
								name="accountNumberConfirm" placeholder="ReEnter Account Number"
								value="" pattern="[a-zA-Z0-9 ]+" required
								oninvalid="this.setCustomValidity('Enter Valid Account Number Here')"
								oninput="this.setCustomValidity('')">
						</div>
					</div>
					<div class="row mt-2">
						<label for="ifscCode" class="form-label">IFSC code : </label>
						<div class="col-lg-6">
							<input type="text" class="form-control" id="ifscCode"
								name="ifscCode" placeholder="IFSC Code" value=""
								pattern="[a-zA-Z0-9 ]+" required
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
					<input type="button" class="btn btn-success mt-2 submitBtn"
						id="add" value="Add" />
				</div>
			</div>
		</form>
	</div>
	<script>
		$(function() {
			$('#removeAccount').prop('disabled', true);
			$('#addAccount').prop('disabled', false);
			$("#addDiv").hide();
			$("#addAccount").click(function() {
				$("#addDiv").show();
			});
			$("#add")
					.click(
							function() {
								$("#flagSubmit").val("add");
								var accNum = document
										.getElementById("accountNumber").value;
								var reAccNum = document
										.getElementById("accountNumberConfirm").value;
								var ifscCode = document
										.getElementById("ifscCode").value;
								var branchName = document
										.getElementById("branchName").value;
								if (accNum != "" && reAccNum != ""
										&& ifscCode != "" && branchName != "") {
									if (validate()) {
										$("#accountDetails").submit();
									}
								}
							});
			$("#removeAccount").click(function() {
				$("#flagSubmit").val("remove");
				//$("#removeAccNum").val($("#accNum").val());
				document.getElementById("removeAccNum").value=document.querySelector('input[name="accNum"]:checked').value;
				$("#accountDetails").submit(); 
			});
			$('input:radio[name="accNum"]').change(function() {
				$("#removeAccNum").val($(this).val());
				$("#addDiv").hide();
				$('#removeAccount').prop('disabled', false);
				$('#addAccount').prop('disabled', false);

			});
		});
		function validate() {
			var accNum = document.getElementById("accountNumber").value;
			var reAccNum = document.getElementById("accountNumberConfirm").value;

			if (accNum != reAccNum) {
				alert("Account Number not Matched!!!");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>