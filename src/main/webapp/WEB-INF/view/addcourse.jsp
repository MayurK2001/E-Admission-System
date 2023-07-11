<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Course</title>
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
                    <h3 class="text-center my-3">Add Course</h3>
            <form action="addcourse" method="post">
                 <div class="form-group">
                     <label for="email">Course Name</label>
                     <input type="text" class="form-control" id="username" aria-describedby="emailHelp" name="name" placeholder="Enter course name.." required>
                 </div>
              
                 <div class="form-group ml-4">
                  <label for="email">Minimum Qualification</label>
                   <select name="minimumQualification" class="form-control">
                       <option value="0">Select Minimum Qualification</option>
                      <%
                           
                           for(DBContants.Qualification q : DBContants.Qualification.values())
                           {
                       %>
                             <option value="<%=q.value()%>"><%=q.value() %></option>
                       <%
                           }
                       %>
                   </select>
                 </div>  
                 
                 <div class="form-group ml-4">
                  <label for="email">Subject Criteria</label>
                   <select name="subjectCriteria" class="form-control">
                       <option value="0">Select Subject Criteria</option>
                      <%
                           
                           for(DBContants.Subject s : DBContants.Subject.values())
                           {
                       %>
                             <option value="<%=s.value()%>"><%=s.value() %></option>
                       <%
                           }
                       %>
                   </select>
                 </div>  
                 
                 
        
                <div class="container text-center">
                      <button class="btn custom-bg-2 text-white"><b>Add Course</b></button>
                </div>
                 
            </form>
                </div>
            </div>
           
            
       </div>
  </div>
</div>
</body>
</html>