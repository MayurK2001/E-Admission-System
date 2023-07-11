<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add College Available Course</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4 admin">
				<div class="card mb-2">
					<%@ include file="./components/message.jsp"%>
<%
   String listOfCourseToDisplay = (String)request.getAttribute("listOfCourseToDisplay");
   String listOfCourseIdInString = (String)request.getAttribute("listOfCourseIdInString");
   String collegeCode = (String)request.getAttribute("collegeCode");
   
%>
				
					<div class="card-body px-5 text-color">

						<h3 class="text-center my-3">Add College Course</h3>
						<form action="addcollegecourse" method="post" >
                           <input type="hidden" name="listOfCourseIdInString" value="<% if(listOfCourseIdInString != null) { %><%=listOfCourseIdInString%><% } else {%>""<% } %> "/>

							<div class="form-group">
								<label for="name">College Code</label> <input type="text"
									class="form-control" id="code" name="code"
									aria-describedby="emailHelp"
								    required value="<% if(collegeCode != null) {%> <%=collegeCode.trim() %> <% } %>" 
								    <% if(collegeCode != null) {%> readonly <% } %>
								    >
							</div>

						
					
					<%
					    List<Course> courses = courseDao.findAll();
					%>
					
					<div class="form-group ml-4">
						<label for="email">Course</label> <select name="courseId"
							class="form-control">
							<option value="0">Select Course</option>
							<%
							for (Course c : courses) {
							%>
							<option value="<%=c.getId()%>"><%=c.getName()%></option>
							<%
							}
							%>
						</select>
					</div>
					
					 <div class="form-group">
                     <label for="email">Selected Course</label>
                     <textarea class="form-control" id="selectCourse" aria-describedby="emailHelp" name="selectCourse" placeholder="selected course will be visible here...." required> 
                      <% if(listOfCourseToDisplay != null) { %>   <%=listOfCourseToDisplay %> <% } %>
                     </textarea>
                 </div>
                           
					
					   <div class="container text-center">
						<button class="btn custom-bg-2 text-white">
							<b>Add Course</b>
						</button>
					   </div>
					   
					   
					   
					   
					
					
					

					</form>
					
					<%
					      if(collegeCode != null) {
					   %>
					   <br>
					   <hr>
					<br> 
					   <form action="addAllCollegeCourse" method="post">
					      <div class="container text-center">
					     <input type="hidden" name="collegeCode" value="<%= collegeCode %>"/> 
					      <input type="hidden" name="allCourseIds" value="<%= listOfCourseIdInString %>"/>
						<button class="btn custom-bg-2 text-white">
							<b>Add Selected Course</b>
						</button>
					   </div>
					   </form>
					   <%
					      }
					   %>
				</div>
				
			</div>

		</div>
	</div>
	</div>
</body>
</html>