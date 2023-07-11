<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Set Password</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
<%@ include file="./components/navbar.jsp"%>
<div class="container-fluid">
  <div class="row mt-2">
       <div class="col-md-4 offset-md-4 admin" >
            <div class="card">
                <%@ include file="./components/message.jsp"%>
                <div class="card-body px-5">
                    <img src="resources/images/registerphoto.jpeg" class="rounded mx-auto d-block" alt="img" height="90px" width="90px">
                    <h3 class="text-center my-3">Set Password</h3>
            <form action="setpassword" method="post">
                 <div class="form-group">
                     <label for="email">Enter OTP</label>
                     <input type="text" class="form-control" id="username" aria-describedby="emailHelp" name="otp" placeholder="Enter OTP" required>
                 </div>
              
                 <div class="form-group">
                     <label for="password">New Password</label>
                     <input type="password" class="form-control" id="password" aria-describedby="emailHelp" name="password" placeholder="Enter new password.." required>
                 </div>
        
                <div class="container text-center">
                      <button class="btn custom-bg-2 text-white"><b>Verify & Set Passowrd</b></button>
                </div>
                 
            </form>
                </div>
            </div>
           
            
       </div>
  </div>
</div>
</body>
</html>