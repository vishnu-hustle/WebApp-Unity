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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- Load an icon library -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


	<style type="text/css">
.navbar{
	background-color: #ADD9F4;
	border-radius: 4px;
    display: flex;
    justify-content: space-around;
    align-items: center;
}
.navbar a{
color: black;
letter-spacing: 2px;
text-decoration: none;
}

#formContainer {

background-color: #DAF7DC; 
display: flex; 
justify-content:center; 
min-height: 100vh; 
}

.editBtn, .submitBtn, .accountBtn, .removeBtn {
letter-spacing: 2px;
border-radius: 10px;
}

.tableData{

}
</style>

</head>
<body>

<div class="navbar">
		<a class="active" href="./AccountHomeController"><i class="fa fa-fw fa-institution"></i>
			Home</a> <a href="./CustomerProfileController"><i
			class="fa fa-fw fa-user-circle-o"></i> Customer Profile</a> <a
			href="./AccountDetailsController"><i class="fa fa-fw fa-group"></i>
			Account Details</a> <a href="./FundTransferController"><i class="fa fa-fw fa-dollar"></i>
			Fund Transfer</a> <a href="./LoginController"><i class="fa fa-fw fa-user"></i> Logout</a>
	</div>
	
<div class="container mt-5">	
<form name="accountDetails" id="accountDetails" action="./AccountDetailsController"
		method="post">
	<%
UserValueBean userValueBean = (UserValueBean)request.getSession().getAttribute("user");
	

	String name=userValueBean.getCustomerDetailsValueBean().getFirstName() + " "+ userValueBean.getCustomerDetailsValueBean().getLastName();
%>
	<div class = "panel panel-default">
         <div class = "panel-heading">
            <h3 class = "panel-title">
               Welcome <%=name %> !!
            </h3>
         </div>
      </div>
	<table class="table">
	<thead>
		<tr>
		 	<th scope="col">#</th>
			<th>Accounts</th>
			<th>IFSC CODE</th>
			<th>Branch Name</th>
			<th>Balance</th>

		</tr>
	</thead>
	 <tbody>
		<%
int i=0;
for (Entry<String, AccountDetailsValueBean> entry : userValueBean.getAccountDetailsValueBean().entrySet()) {



	AccountDetailsValueBean accountDetailsValueBean = (AccountDetailsValueBean) entry.getValue();
	%>
		<tr>
			<td><% out.print(i+1); %></td>
			<td><%
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
 </tbody>
	</table>
	
	
	</form>
	</div>
	
</body>
</html>