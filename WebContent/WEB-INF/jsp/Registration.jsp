<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank Portal - GROUP C</title>
</head>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<script src=https://code.jquery.com/jquery-1.12.4.js></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

<body
	style="background-color: #ADD9F4; display: flex; align-items: center; justify-content: center; height: auto;">


	<form name="registrationForm" action="./registrationController"
		method="post">
		<%
			String responseStr = (String) request.getAttribute("status");
			request.removeAttribute("status");
		%>
		<div class="container-fluid">
			<h1>Registration Form</h1>
			<br />

			<div class="row">
				<label class="col-sm-3 col-md-6" for="firstname" class="form-label">First
					Name</label>
				<div class="col-sm-3 col-md-6">
					<input type="text" class="form-control" id="firstname"
						placeholder="First Name" name="firstname" pattern="[a-zA-Z]+"
						required
						oninvalid="this.setCustomValidity('Enter Valid First Name Here')"
						oninput="this.setCustomValidity('')">
				</div>
			</div>

			<div class="row mt-2">
				<label class="col-sm-3 col-md-6" for="lastname" class="form-label">Last
					Name</label>
				<div class="col-sm-3 col-md-6">
					<input type="text" class="form-control" id="lastname"
						placeholder="Last Name" name="lastname" pattern="[a-zA-Z]+"
						required
						oninvalid="this.setCustomValidity('Enter Valid Last Name Here')"
						oninput="this.setCustomValidity('')">
				</div>
			</div>

			<div class="row mt-2">
				<label class="col-sm-3 col-md-6" for="address" class="form-label">Address</label>
				<div class="col-sm-3 col-md-6">
					<input type="text" class="form-control" id="address"
						placeholder="Address" name="address" required
						oninvalid="this.setCustomValidity('Enter Valid Address Here')"
						oninput="this.setCustomValidity('')">
				</div>
			</div>

			<div class="row mt-2">
				<label class="col-sm-3 col-md-6" for="datepicker" class="form-label">Date
					of Birth</label>
				<div class="col-sm-3 col-md-6">
					<input type="text" class="form-control" id="datepicker"
						placeholder="Datepicker" name="datepicker" required
						oninvalid="this.setCustomValidity('Enter Valid Date of Birth Here')"
						oninput="this.setCustomValidity('')" readonly> <input
						type="hidden" id="dob" name="dob">
				</div>
			</div>

			<div class="row mt-2">
				<label class="col-sm-3 col-md-6" for="emailId" class="form-label">Email
					Id</label>
				<div class="col-sm-3 col-md-6">
					<input type="email"
						pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
						class="form-control" id="emailId" placeholder="Email Id"
						name="emailId" required
						oninvalid="this.setCustomValidity('Enter Valid Email Id Here')"
						oninput="this.setCustomValidity('')">
				</div>
			</div>

			<div class="row mt-2">
				<label class="col-sm-3 col-md-6" for="username" class="form-label">Username</label>
				<div class="col-sm-3 col-md-6">
					<input type="text" class="form-control" id="username"
						placeholder="Username" name="username" pattern="[a-zA-Z0-9 ]+"
						required
						oninvalid="this.setCustomValidity('Enter Valid Username Here')"
						oninput="this.setCustomValidity('')">
				</div>
			</div>

			<div class="row mt-2">
				<label class="col-sm-3 col-md-6" for="password" class="form-label">New
					Password</label>
				<div class="col-sm-3 col-md-6">
					<input type="password" class="form-control" id="password"
						placeholder="Password" name="password"
						pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required
						oninvalid="this.setCustomValidity('Enter Valid New Password Here')"
						oninput="this.setCustomValidity('')" onblur="checkPassword()">
				</div>
			</div>

			<div class="row mt-2">
				<label class="col-sm-3 col-md-6" for="confirmPassword"
					class="form-label">Confirm Password</label>
				<div class="col-sm-3 col-md-6">
					<input type="password" class="form-control" id="confirmPassword"
						placeholder="Confirm Password"
						pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
						name="confirmPassword" required
						oninvalid="this.setCustomValidity('Enter Valid Confirm Password Here')"
						oninput="this.setCustomValidity('')" onblur="checkPassword()">
				</div>
			</div>

			<div class="row mt-2">
				<label class="col-sm-3 col-md-6" for="phoneNumber"
					class="form-label">Phone Number</label>
				<div class="col-sm-3 col-md-6">
					<input type="text" minlength="10" maxlength="10"
						class="form-control" id="phoneNumber" placeholder="phoneNumber"
						name="phoneNumber" pattern="[0-9]+" required
						oninvalid="this.setCustomValidity('Enter Valid Phone Number Here')"
						oninput="this.setCustomValidity('')">
				</div>
			</div>

			<input type="submit" class="btn btn-success mt-2" value="Submit" />

		</div>
	</form>
	<%
		if (responseStr != null) {
	%>
	<br />
	<div
		class="alert alert-danger alert-dismissible d-flex align-items-center fade show">
		<i class="bi-exclamation-octagon-fill"></i> <strong class="mx-2">Error!</strong>
		<%=responseStr%>
		<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
	</div>

	<%
		}
	%>
	<script>
		$(function() {
			$.datepicker.setDefaults({
				onClose : function(date, inst) {
					$("#dob").val(date);
				}
			});

			$("#datepicker").datepicker({
				dateFormat : 'yy-mm-dd',
				maxDate : new Date()
			});

		});
		function checkPassword() {
			var password = document.getElementById("password").value;
			var cPassword = document.getElementById("confirmPassword").value;

			if (password != cPassword) {
				alert("Password not Matched!!!");
			}
		}
	</script>
</body>
</html>