<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Login</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
<%@ include file="./components/navbar.jsp"%>
<div class="container-fluid">
  <div class="row mt-2">
       <div class="col-md-4 offset-md-4" >
            <div class="card border-color">
                <%@ include file="./components/message.jsp"%>
                <div class="card-body px-5 text-color">
                    <img src="resources/images/registerphoto.jpeg" class="rounded mx-auto d-block" alt="img" height="90px" width="90px">
                    <h3 class="text-center my-3">Mobile Verification</h3>
                    
                    <%
                        Student s = (Student)request.getAttribute("student"); 
                    %>
                    
            <form action="verify-and-register-student" method="post">
              
                 <div class="form-group">
                     <label for="otp">OTP</label>
                     <input type="number" class="form-control" id="otp" aria-describedby="emailHelp" name="otp" placeholder="Enter OTP.." required>
                 </div>
        
                <div class="container text-center">
                      <button class="btn custom-bg-2 text-white"><b>Verify And Register</b></button>
                </div>
                 
            </form>
                </div>
            </div>
           
            
       </div>
  </div>
</div>
</body>
</html>