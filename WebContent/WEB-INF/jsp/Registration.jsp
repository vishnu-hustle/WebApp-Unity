<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank Portal</title>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src=https://code.jquery.com/jquery-1.12.4.js></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<body>
<form name="registrationForm" action="./registrationController" method="post">
<h1>Registration Form</h1>
<label for="firstname">First Name : </label>
<input type="text" id="firstname" name="firstname"/><br><br>
<label for="lastname">Last Name : </label>
<input type="text" id="lastname" name="lastname"/><br><br>
<label for="address">Address : </label>
<input type="text" id="address" name="address"/><br><br>
<label for="datepicker">Date Of Birth : </label>
<input type="text" id="datepicker" name="datepicker">
<input type="hidden" id="dob" name="dob">
<br><br>
<label for="emailId">Email Id : </label>
<input type="text" id="emailId" name="emailId"/><br><br>
<label for="username">Username : </label>
<input type="text" id="username" name="username"/><br><br>
<label for="password">New Password : </label>
<input type="password" id="password" name="password"/><br><br>
<label for="confirmPassword">Confirm Password : </label>
<input type="password" id="confirmPassword" name="confirmPassword"/><br><br>
<label for="phoneNumber">Phone number : </label>
<input type="text" id="phoneNumber" name="phoneNumber"/><br><br>
<input type="submit" value="submit"/>

</form>
<script>
$( function() {
    $.datepicker.setDefaults({
        onClose:function(date, inst){
            $("#dob").val(date);
        }
    });
 
    $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' , maxDate: new Date() });
});
</script>
</body>
</html>