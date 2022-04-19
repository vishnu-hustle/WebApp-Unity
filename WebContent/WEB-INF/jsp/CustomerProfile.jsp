<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="edu.groupc.project.beans.UserValueBean" %>
<%@ page import="edu.groupc.project.beans.CustomerDetailsValueBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank Portal - GROUP C</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src=https://code.jquery.com/jquery-1.12.4.js></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- Load an icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.navbar{
	background-color: #ADD9F4;
	border-radius: 4px;
    display: flex;
    justify-content: space-around;
    align-items: center;
    width: 100%;
}
.navbar a{
color: black;
letter-spacing: 2px;
text-decoration: none;
}

#formContainer {

display: flex; 
justify-content:center; 
min-height: 100vh; 
}

.editBtn, .submitBtn {
letter-spacing: 2px;
border-radius: 10px;
}

</style>
</head>
<body>

<%
UserValueBean userValueBean = (UserValueBean)request.getSession().getAttribute("user");
CustomerDetailsValueBean customerProfile=(CustomerDetailsValueBean)userValueBean.getCustomerDetailsValueBean();
String responseStr=(String)request.getAttribute("status");
request.removeAttribute("status");
%>
<div class="navbar">
  <a class="active" href="./AccountHomeController"><i class="fa fa-fw fa-institution"></i> Home</a>
  <a href="./CustomerProfileController"><i class="fa fa-fw fa-user-circle-o"></i> Customer Profile</a>
  <a href="./AccountDetailsController"><i class="fa fa-fw fa-group"></i> Account Details</a>
  <a href="./FundTransferController"><i class="fa fa-fw fa-dollar"></i> Fund Transfer</a>
  <a href="./LoginController"><i class="fa fa-fw fa-user"></i> Logout</a>
</div>

<div id="formContainer">
<form name="customerProfile" class="container-fluid" action="./CustomerProfileController" method="post">
<div id="details" class="container-fluid">
<div class="mt-5 bg-light text-dark mx-auto" style="padding-left:200px;"><strong>Customer Details</strong></div>
<div class="row">
	<div class="col-sm-3 col-md-6"><strong>First Name :</strong></div>
	<div class="col-sm-3 col-md-6"><%=customerProfile.getFirstName() %></div>
</div>
<div class="row mt-2">
	<div class="col-sm-3 col-md-6"><strong>Last Name :</strong></div>
	<div class="col-sm-3 col-md-6"><%=customerProfile.getLastName() %></div>
</div>
<div class="row mt-2">
	<div class="col-sm-3 col-md-6"><strong>Address :</strong></div>
	<div class="col-sm-3 col-md-6"><%=customerProfile.getAddress() %></div>
</div>
<div class="row mt-2">
	<div class="col-sm-3 col-md-6"><strong>Date of Birth :</strong></div>
	<div class="col-sm-3 col-md-6"><%=customerProfile.getDateOfBirth() %></div>
</div>
<div class="row mt-2">
	<div class="col-sm-3 col-md-6"><strong>Email Id :</strong></div>
	<div class="col-sm-3 col-md-6"><%=customerProfile.getEmail() %></div>
</div>
<div class="row mt-2">
	<div class="col-sm-3 col-md-6"><strong>UserName :</strong></div>
	<div class="col-sm-3 col-md-6"><%=customerProfile.getUserName() %></div>
</div>
<div class="row mt-2">
	<div class="col-sm-3 col-md-6"><strong>Phone number :</strong></div>
	<div class="col-sm-3 col-md-6"><%=customerProfile.getPhoneNumber() %></div>
</div><br/>
<input type="button" class="btn btn-primary editBtn"  id="edit" value="Edit"/>
<%
if (responseStr != null) {
		%>
		<br /><br/>
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


<div id="editDetails" style="display:none;" class="container-fluid">
<div class="mt-5 bg-light text-dark mx-auto" style="padding-left:200px;"><strong>Customer Details</strong></div>
<div class="row">
	<label class="col-sm-3 col-md-6" for="firstname" class="form-label">First Name</label>
	<div class="col-sm-3 col-md-6">
   		<input type="text" class="form-control" id="firstname" name="firstname" placeholder="firstname" value="<%=customerProfile.getFirstName()%>" pattern="[a-zA-Z]+" required
						oninvalid="this.setCustomValidity('Enter Valid First Name Here')"
						oninput="this.setCustomValidity('')">
	</div>
</div>

<div class="row mt-2">
	<label class="col-sm-3 col-md-6" for="lastname" class="form-label">Last Name</label>
	<div class="col-sm-3 col-md-6">
   		<input type="text" class="form-control" id="lastname" placeholder="firstname" name="lastname" value="<%=customerProfile.getLastName()%>" pattern="[a-zA-Z]+"required
						oninvalid="this.setCustomValidity('Enter Valid Last Name Here')"
						oninput="this.setCustomValidity('')">
	</div>
</div>

<div class="row mt-2">
	<label class="col-sm-3 col-md-6" for="address" class="form-label">Address</label>
	<div class="col-sm-3 col-md-6">
   		<input type="text" class="form-control" id="address" placeholder="address" name="address" value="<%=customerProfile.getAddress()%>" required
						oninvalid="this.setCustomValidity('Enter Valid Address Here')"
						oninput="this.setCustomValidity('')">
	</div>
</div>

<div class="row mt-2">
	<label class="col-sm-3 col-md-6" for="datepicker" class="form-label">Date of Birth</label>
	<div class="col-sm-3 col-md-6">
   		<input type="text" class="form-control" id="datepicker" name="datepicker" placeholder="datepicker"  value="<%=customerProfile.getDateOfBirth()%>" required
						oninvalid="this.setCustomValidity('Enter Valid Date of Birth Here')"
						oninput="this.setCustomValidity('')" readonly>
   		<input type="hidden" id="dob" name="dob" value="<%=customerProfile.getDateOfBirth()%>"/>
	</div>
</div>

<div class="row mt-2">
	<label class="col-sm-3 col-md-6" for="emailId" class="form-label">Email Id</label>
	<div class="col-sm-3 col-md-6">
   		<input type="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"  class="form-control" id="emailId" name="emailId" placeholder="emailId" value="<%=customerProfile.getEmail()%>" required
						oninvalid="this.setCustomValidity('Enter Valid Email Id Here')"
						oninput="this.setCustomValidity('')">
	</div>
</div>

<div class="row mt-2">
	<label  class="col-sm-3 col-md-6" for="username" class="form-label">Username</label>
	<div class="col-sm-3 col-md-6">
   		<input type="text" class="form-control" id="username" name="username" placeholder="username" value="<%=customerProfile.getUserName()%>" pattern="[a-zA-Z0-9 ]+" required
						oninvalid="this.setCustomValidity('Enter Valid Username Here')"
						oninput="this.setCustomValidity('')">
	</div>
</div>

<div class="row mt-2">
	<label class="col-sm-3 col-md-6" for="phoneNumber" class="form-label">Phone Number</label>
	<div class="col-sm-3 col-md-6">
   		<input type="text" type="text" minlength="10" maxlength="10" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="phoneNumber" value="<%=customerProfile.getPhoneNumber()%>" pattern="[0-9]+" required
						oninvalid="this.setCustomValidity('Enter Valid Phone Number Here')"
						oninput="this.setCustomValidity('')">
	</div>
</div>

<input type="submit" class="btn btn-success mt-2 submitBtn" value="Update"/>
</div>
</div>
</form>

			
<script>
$( function() {
	 $( "#details" ).show();
	 $( "#editDetails" ).hide();
    $.datepicker.setDefaults({
        onClose:function(date, inst){
            $("#dob").val(date);
        }
    });
 
    $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' , maxDate: new Date() });
    $( "#edit" ).click(function() {
    	 $( "#details" ).hide();
    	 $( "#editDetails" ).show();
    });
});
</script>
</body>
</html>