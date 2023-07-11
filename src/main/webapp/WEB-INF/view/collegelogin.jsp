<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>College Login</title>
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
                    <img src="resources/images/adminregister.jpeg" class="rounded mx-auto d-block" alt="img" height="90px" width="90px">
                    <h3 class="text-center my-3">College Login</h3>
            <form action="collegelogin" method="post">
                 <div class="form-group">
                     <label for="email">College Email Id</label>
                     <input type="text" class="form-control" id="username" aria-describedby="emailHelp" name="email" placeholder="Enter email id.." required>
                 </div>
              
                 <div class="form-group">
                     <label for="password">Password</label>
                     <input type="password" class="form-control" id="password" aria-describedby="emailHelp" name="password" placeholder="Enter password.." required>
                     <small id="passwordHelpInline" class="text-muted">
                        Must be 8-20 characters long.
                     </small>
                 </div>
        
                <div class="container text-center">
                      <button class="btn custom-bg-2 text-white"><b>Login</b></button>
                </div>
                 
            </form>
                </div>
            </div>
           
            
       </div>
  </div>
</div>
</body>
</html>