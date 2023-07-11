<%@page import="com.onlineadmission.utility.DBContants.ApprovalStatus"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Application Form</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<%
	StudentApplication app = applicationDao.findByStudentId(student.getId());
	%>

	<div class="container-fluid md-5">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4">
			
				<%
				   if(app!= null){
					   
					   List<StudentDocuments> docs = documentDao.findByStudentId(student.getId());
						Optional<Course> optional = courseDao.findById(app.getCourseId());
						Course course = null;

						if (optional.isPresent()) {
							course = (Course) optional.get();
						}
				%>
			
				<div class="card border-color text-color mb-4">
					<form class="text-color">
						<div class="text-center">
							<img src="resources/studentPics/<%=app.getStudentPhoto()%>"
								class="rounded mx-auto d-block" alt="img" height="90px"
								width="90px">
						</div>
						<div class="row ml-4">
							<div class="form-group">
								<label for="email">First Name</label> <input type="email"
									class="form-control" aria-describedby="emailHelp"
									value="<%=student.getFirstname()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Last Name</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=student.getLastname()%>" readonly required>
							</div>
						</div>

						<div class="row ml-4">
							<div class="form-group">
								<label for="email">Mobile No</label> <input type="email"
									class="form-control" aria-describedby="emailHelp"
									value="<%=student.getMobileno()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Email Id</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=student.getEmailid()%>" readonly required>
							</div>
						</div>

						<div class="row ml-4">
							<div class="form-group">
								<label for="email">Father Name</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getFatherName()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Mother Name</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getMotherName()%>" readonly required>
							</div>
						</div>

						<div class="row ml-4">
							<div class="form-group">
								<label for="email">City</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getCity()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">State</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getState()%>" readonly required>
							</div>
						</div>

						<div class="row ml-4">
							<div class="form-group">
								<label for="email">Country</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=app.getCountry()%>" readonly required>
							</div>
							<div class="form-group"></div>
						</div>
						
						<hr> <div class="text-center text-color"><h4>Qualification Detail</h4></div>
						<hr>
						<div class="text-color ml-5"><h5>10th Detail</h5></div>
						<%
						    StudentDocuments tenDoc = documentDao.findByStandardAndStudentId(DBContants.Standard.TENTH.value(), student.getId());
						%>
						
						<div class="text-center md-5">
							<p>
								Percentage :<%if(tenDoc!= null) {%><%=tenDoc.getPercentage()%><%} else{%><span style="color: red">Not Filled</span><%}%>
							</p>

							<p>
								Year Of Passing : <%if(tenDoc!= null) {%><%=tenDoc.getYearOfPassing()%><%} else{%><span style="color: red">Not Filled</span> <%}%>
							</p>
						</div>
						
						<div class="text-center md-5">
							<p>
								Document Uploaded? :<%if(tenDoc!= null) {%><%=tenDoc.getIsDocumentUploaded()%><%}else{%><span style="color: red">Not Filled</span><%}%>
							</p>

							<p>
								Document Approved? : <%if(tenDoc!= null) { if(tenDoc.getIsApproved().equals(ApprovalStatus.APPROVED.value())) {%><span style="color: green"><%=tenDoc.getIsApproved()%></span><%}else if(!tenDoc.getIsApproved().equals(ApprovalStatus.APPROVED.value())){%><span style="color:red"><%=tenDoc.getIsApproved()%></span> <% } } else {%><span style="color: red">Not Filled</span><%}%>
							</p>
						</div>
						
						<%
						    if(tenDoc == null){   
						%>
						    <div class="text-center md-5"><a href="addstudentdocument"> click here add document</a> </div>
						<%
						   }
						
						    else if(tenDoc != null && !tenDoc.getIsApproved().equals(DBContants.ApprovalStatus.APPROVED.value()) && !tenDoc.getIsApproved().equals(DBContants.ApprovalStatus.APPROVAL_PENDIND.value())) {
						%>
						   <div class="text-center md-5"> <a href="addstudentdocument"> click here to add document</a> </div>
						<%
						    }
						
						    if(tenDoc != null) {
						%>
                           <div class="text-center mt-3">
						   <a href="downloadDocument?studentId=<%=student.getId()%>&standard=<%=tenDoc.getStandard()%>"><button
									type="button" class="btn custom-bg-2 text-white">Download Document</button></a>
									</div>
						<%
						    }
						%>
						
						<hr>
						<div class="text-color ml-5"><h5>12th Detail</h5></div>
						<%
						    StudentDocuments twelveDoc = documentDao.findByStandardAndStudentId(DBContants.Standard.TWELVETH.value(), student.getId());
						%>
						
						<div class="text-center md-5">
							<p>
								Percentage :<%if(twelveDoc!= null) {%><%=twelveDoc.getPercentage()%><%} else{%><span style="color: red">Not Filled</span><%}%>
							</p>

							<p>
								Year Of Passing : <%if(twelveDoc!= null) {%><%=twelveDoc.getYearOfPassing()%><%} else{%><span style="color: red">Not Filled</span> <%}%>
							</p>
						</div>
						
						<div class="text-center md-5">
							<p>
								Document Uploaded? :<%if(twelveDoc!= null) {%><%=twelveDoc.getIsDocumentUploaded()%><%}else{%><span style="color: red">Not Filled</span><%}%>
							</p>

							<p>
								Document Approved? : <%if(twelveDoc!= null) { if(twelveDoc.getIsApproved().equals(ApprovalStatus.APPROVED.value())) {%><span style="color: green"><%=twelveDoc.getIsApproved()%></span><%}else if(!twelveDoc.getIsApproved().equals(ApprovalStatus.APPROVED.value())){%><span style="color:red"><%=twelveDoc.getIsApproved()%></span> <% } } else {%><span style="color: red">Not Filled</span><%}%>
							</p>
						</div>
						
						<%
						    if(twelveDoc == null){   
						%>
						    <div class="text-center md-5"> <a href="addstudentdocument"> click here to add document</a> </div>
						<%
						   }
						
						    else if(twelveDoc != null && !twelveDoc.getIsApproved().equals(DBContants.ApprovalStatus.APPROVED.value()) && !twelveDoc.getIsApproved().equals(DBContants.ApprovalStatus.APPROVAL_PENDIND.value())) {
						%>
						    <div class="text-center md-5"> <a href="addstudentdocument"> click here to add document</a> </div>
						<%
						    }
						
						    if(twelveDoc != null) {
						%>
						<div class="text-center mt-3">
						   <a href="downloadDocument?studentId=<%=student.getId()%>&standard=<%=twelveDoc.getStandard()%>"><button
									type="button" class="btn custom-bg-2 text-white">Download Document</button></a>
									</div>
						<%
						    }
						%>
						
						<hr>

						<div class="text-center md-5">
							<h2>
								Course : <span style="color: green"><%if(course!= null) {%><%=course.getName()%><%} %></span>
							</h2>

							<h2>
								Amount Paid : <span style="color: green"><%=app.getIsAmountPaid()%></span>
							</h2>
							
							<%
						    if(app.getIsAmountPaid().equals(DBContants.IsAmountPaid.NO.value())){   
						%>
						    <a href="paymentpage"> click here to add application fee.</a> 
						<%
						   }
							%>
							
							<h2>
								Approval Status : <%=app.getIsApproved()%>
							</h2>
							
						</div>

						<div class="card-footer bg-white text-center">
							<a href="downloadform?studentId=<%=student.getId()%>"><button
									type="button" class="btn custom-bg-2 text-white">Download Application</button>
						    </a>
						</div>
						
					</form>

				</div>
				<%
				   }
				   else {
				%>
				<div class="card">
				<div class="text-center">
				       <h2 class="text-danger">Your Application Form Submission is Pending...</h2>
				       <p><a href="registerStudentApplication">click here to fill your application.</a></p>
				     </div>
				     </div>
				<%
				   }
				%>
			</div>
		</div>
	</div>

</body>
</html>