<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>College Register</title>
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
                    <h3 class="text-center my-3">Register College</h3>
            <form action="collegeregister" method="post">
            
                 <div class="form-group">
                     <label for="name">Name</label>
                     <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="name" placeholder="Enter college name.." required>
                 </div>
                 
                  <div class="form-group">
                     <label for="name">Email Id</label>
                     <input type="text" class="form-control" id="email" aria-describedby="emailHelp" name="email" placeholder="Enter email id.." required>
                 </div>
             
          
                 <div class="form-group">
                     <label for="email">Password</label>
                     <input type="password" class="form-control" id="password" aria-describedby="emailHelp" name="password" placeholder="Enter password.." required>
                 </div>
                 
                 <div class="form-group">
                     <label for="email">Address</label>
                     <textarea class="form-control" id="address" aria-describedby="emailHelp" name="address" placeholder="Enter college address.." required> </textarea>
                 </div>
           
          
                  <div class="form-group">
                     <label for="email">Location</label>
                     <textarea class="form-control" id="location" aria-describedby="emailHelp" name="location" placeholder="Enter college location.." required> </textarea>
                 </div>
                 
                  <div class="form-group">
                     <label for="name">Phone No</label>
                     <input type="text" class="form-control" id="phoneNo" aria-describedby="emailHelp" name="phoneNo" placeholder="Enter phone no.." required>
                 </div>
                 
             
                 <div class="form-group">
                     <label for="name">College Code</label>
                     <input type="text" class="form-control" id="code" aria-describedby="emailHelp" name="code" placeholder="Enter college code.." required>
                 </div>
                 
                 <div class="form-group">
                     <label for="email">Total Seat</label>
                     <input type="number" class="form-control" id="totalSeat" aria-describedby="emailHelp" name="totalSeat" placeholder="Enter total Seat.." required>
                 </div>
            
                <div class="container text-center">
                      <button class="btn custom-bg-2 text-white"><b>Register College</b></button>
                 </div>
                 
            </form>
                </div>
            </div>
           
            
       </div>
  </div>
</div>
</body>
</html>