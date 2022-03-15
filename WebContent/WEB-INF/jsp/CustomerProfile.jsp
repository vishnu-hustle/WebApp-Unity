<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="edu.groupc.project.beans.UserValueBean" %>
<%@ page import="edu.groupc.project.beans.CustomerDetailsValueBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank Portal</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src=https://code.jquery.com/jquery-1.12.4.js></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!-- Load an icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%
UserValueBean userValueBean = (UserValueBean)request.getSession().getAttribute("user");
CustomerDetailsValueBean customerProfile=(CustomerDetailsValueBean)userValueBean.getCustomerDetailsValueBean();

%>
<div class="navbar">
  <a class="active" href="./AccountDetailsController"><i class="fa fa-fw fa-institution"></i> Home</a>
  <a href="./CustomerProfileController"><i class="fa fa-fw fa-user-circle-o"></i> Customer Profile</a>
  <a href="./AccountDetailsController"><i class="fa fa-fw fa-group"></i> Account Details</a>
  <a href="./FundTransferController"><i class="fa fa-fw fa-dollar"></i> Fund Transfer</a>
  <a href="./LoginController"><i class="fa fa-fw fa-user"></i> Logout</a>
</div>
<form name="customerProfile" action="./registrationController" method="post">
<div id="details">
<h1>Customer Details</h1><input type="button"  id="edit" value="edit"/>
<p><strong>First Name :</strong> <%=customerProfile.getFirstName() %></p><br>
<p><strong>Last Name :</strong> <%=customerProfile.getLastName() %></p><br>
<p><strong>Address :</strong> <%=customerProfile.getAddress() %></p><br>
<p><strong>Date Of Birth :</strong> <%=customerProfile.getDateOfBirth() %></p><br>
<p><strong>Email Id :</strong> <%=customerProfile.getEmail() %></p><br>
<p><strong>UserName :</strong> <%=customerProfile.getUserName() %></p><br>
<p><strong>Phone number :</strong> <%=customerProfile.getPhoneNumber() %></p><br>
</div>
<div id="editDetails" style="display:none;">
<label for="firstname">First Name : </label>
<input type="text" id="firstname" name="firstname" value="<%=customerProfile.getFirstName()%>"/><br><br>
<label for="lastname">Last Name : </label>
<input type="text" id="lastname" name="lastname" value="<%=customerProfile.getLastName()%>"/><br><br>
<label for="address">Address : </label>
<input type="text" id="address" name="address" value="<%=customerProfile.getAddress()%>"/><br><br>
<label for="datepicker">Date Of Birth : </label>
<input type="text" id="datepicker" name="datepicker" value="<%=customerProfile.getDateOfBirth()%>"/>
<input type="hidden" id="dob" name="dob" value="<%=customerProfile.getDateOfBirth()%>"/>
<br><br>
<label for="emailId">Email Id : </label>
<input type="text" id="emailId" name="emailId" value="<%=customerProfile.getEmail()%>"/><br><br>
<label for="username">Username : </label>
<input type="text" id="username" name="username" value="<%=customerProfile.getUserName()%>"/><br><br>
<label for="phoneNumber">Phone number : </label>
<input type="text" id="phoneNumber" name="phoneNumber" value="<%=customerProfile.getPhoneNumber()%>"/><br><br>
<input type="submit" value="update"/>
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