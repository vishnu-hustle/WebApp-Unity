<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank Portal - GROUP C</title>
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

</head>
<body
	style="background-color: #ADD9F4; display: flex; align-items: center; align-contents: center; justify-content: center; height: 100vh;">
	<div>
		<%
			String responseStr = (String) request.getAttribute("status");
			request.removeAttribute("status");
			System.out.println(responseStr);
		%>


		<h2 style="text-align: center;">Welcome</h2>
		<form action="./LoginController" method="post" class="">
			<div class="row">
				<label for="username" class="form-label">Username</label>
				<div class="col-lg-12">
					<input type="text" class="form-control" id="username"
						placeholder="username" name="username" required
						oninvalid="this.setCustomValidity('Enter Username Here')"
						oninput="this.setCustomValidity('')">
				</div>

			</div>
			<div class="row mt-2">
				<label for="password" class="form-label">Password</label>
				<div class="col-lg-12">
					<input type="password" class="form-control" id="password"
						placeholder="password" name="password" required
						oninvalid="this.setCustomValidity('Enter Password Here')"
						oninput="this.setCustomValidity('')">
				</div>

			</div>

			<h5 class="mt-3">
				Not yet registered? <strong><u><a
						href="./registrationController">click here</a></u></strong>
			</h5>
			<input type="submit" class="btn btn-success" value="Submit" />
		</form>
		<%
			if (responseStr != null && responseStr.indexOf("Invalid")!=-1) {
		%>
		<br />
		<div
			class="alert alert-danger alert-dismissible d-flex align-items-center fade show">
			<i class="bi-exclamation-octagon-fill"></i> <strong class="mx-2">Error!</strong>
			<%=responseStr%>
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
		</div>


		<%
		responseStr=null;
			}else{
				%>
		<br />  <br />
		<div
			class="alert alert-success alert-dismissible d-flex align-items-center fade show">
			<i class="bi-check-circle-fill"></i> <strong class="mx-2">Success!</strong>
			<%=responseStr%>
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
		</div>

		<%
			}
		
		%>
	</div>
</body>
</html>