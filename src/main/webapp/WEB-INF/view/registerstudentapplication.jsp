<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Application</title>
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
					   StudentApplication studentApplication = null;
					   if(student != null) {
						   studentApplication = applicationDao.findByStudentId(student.getId());
					   }
			
					   if(studentApplication == null) {
					%>
					
					<!--  -->
					<div class="card-body px-5 text-color">

						<h3 class="text-center my-3">Add Student Application</h3>
						<form action="addstudentapplication" method="post"
							enctype="multipart/form-data">

							<div class="form-group">
								<label for="name">First Name</label> <input type="text"
									class="form-control" id="firstname"
									aria-describedby="emailHelp"
									value="<%=student.getFirstname()%>" required>
							</div>

							<div class="form-group">
								<label for="name">Last Name</label> <input type="text"
									class="form-control" id="lastname" aria-describedby="emailHelp"
									value="<%=student.getLastname()%>" required>
							</div>

							<div class="form-group">
								<label for="email">Email</label> <input type="email"
									class="form-control" id="emailid" aria-describedby="emailHelp"
									value="<%=student.getEmailid()%>" required>
							</div>


							<div class="form-group">
								<label for="email">Mobile</label> <input type="number"
									class="form-control" id="mobileno" aria-describedby="emailHelp"
									value="<%=student.getMobileno()%>" required>
							</div>
							
							<div class="form-group">

							<label for="name">Father Name</label>
							<input type="text" class="form-control" id="firstname" aria-describedby="emailHelp"
								name="fathername" placeholder="Enter Father Name.." required>
					</div>

					<div class="form-group">
						<label for="name">Mother Name</label> <input type="text"
							class="form-control" id="lastname" aria-describedby="emailHelp"
							name="mothername" placeholder="Enter Mother Name.." required>
					</div>

					<div class="form-group">
						<label for="email">Date Of Birth</label> <input type="date"
							class="form-control" id="emailid" aria-describedby="emailHelp"
							name="dob" placeholder="Enter DOB (dd-mm-yy)" required>
					</div>
					
					<div class="form-group ml-4">
						<label for="email">Qualification</label> <select name="qualification"
							class="form-control">
							<option value="0">Select Qualification</option>
							<%
							for (DBContants.Qualification q : DBContants.Qualification.values()) {
							%>
							<option value="<%=q.value()%>"><%=q.value()%></option>
							<%
							}
							%>
						</select>
					</div>
					
					<div class="form-group ml-4">
						<label for="email">Subject</label> <select name="subject"
							class="form-control">
							<option value="0">Select Subject</option>
							<%
							for (DBContants.Subject s : DBContants.Subject.values()) {
							%>
							<option value="<%=s.value()%>"><%=s.value()%></option>
							<%
							}
							%>
						</select>
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
                           
					<div class="form-group ml-4">
						<label for="email">City</label> <select name="city"
							class="form-control">
							<option value="0">Select City</option>
							<%
							for (DBContants.City c : DBContants.City.values()) {
							%>
							<option value="<%=c.value()%>"><%=c.value()%></option>
							<%
							}
							%>
						</select>
					</div>

					<div class="form-group">
						<label for="name">Pin Code</label> <input type="text"
							class="form-control" id="street" aria-describedby="emailHelp"
							name="pincode" placeholder="Enter pincode.." required>
					</div>

					<div class="form-group ml-4">
						<label for="email">State</label> <select name="state"
							class="form-control">
							<option value="0">Select State</option>
							<%
							for (DBContants.State s : DBContants.State.values()) {
							%>
							<option value="<%=s.value()%>"><%=s.value()%></option>
							<%
							}
							%>
						</select>
					</div>

					<div class="form-group ml-4">
						<label for="email">Country</label> <select name="country"
							class="form-control">
							<option value="0">Select Country</option>
							<%
							for (DBContants.Country c : DBContants.Country.values()) {
							%>
							<option value="<%=c.value()%>"><%=c.value()%></option>
							<%
							}
							%>
						</select>
					</div>

					<div class="form-group">
						<label>Select Student Photo</label><br> <input type="file"
							class="form-control" name="studentPic" required>
					</div>

					<div class="container text-center">
						<button class="btn custom-bg-2 text-white">
							<b>Add Application</b>
						</button>
					</div>

					</form>
				</div>
				<!--  -->
				<%
					   }
					   
				       else {
				%>
				     <div class="text-center">
				       <h2 class="text-color">Your Application is Already registered:)</h2>
				       <p><a href="myapplication">click here to check your application.</a></p>
				     </div>
				<%
				       }
				%>
			</div>

		</div>
	</div>
	</div>
</body>
</html>