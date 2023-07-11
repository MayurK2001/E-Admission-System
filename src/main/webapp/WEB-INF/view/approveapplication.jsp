<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Approve Application Form</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<%@ include file="./components/message.jsp"%>
	<%
	student = (Student) request.getAttribute("student");

	StudentApplication app = applicationDao.findByStudentId(student.getId());
	StudentDocuments doc10 = documentDao.findByStandardAndStudentId(DBContants.Standard.TENTH.value(), student.getId());
	StudentDocuments doc12 = documentDao.findByStandardAndStudentId(DBContants.Standard.TWELVETH.value(), student.getId());
	Optional<Course> optional = courseDao.findById(app.getCourseId());
	Course course = null;

	if (optional.isPresent()) {
		course = (Course) optional.get();
	}
	%>

	<div class="container-fluid md-5 text-color">
	 <h3 class="text-center">Approve Student Application</h3>
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4">
				<div class="card border-color">
				    <h3 class="text-center">Student Information</h3>
				
					<form>
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

					</form>

					

				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid md-5 text-color">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4">
				<div class="card border-color">
					<form>
						<div class="text-center">
							<h2>10th Document</h2>
						</div>
						<div class="row ml-4">
							<div class="form-group">
								<label for="email">Year Of Passing</label> <input type="email"
									class="form-control" aria-describedby="emailHelp"
									value="<%=doc10.getYearOfPassing()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Percentage</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=doc10.getPercentage()%>" readonly required>
							</div>
						</div>

						<div class="row ml-4">
							<div class="form-group">
								<label for="email">Is Document Uploaded?</label> <input
									type="email" class="form-control" aria-describedby="emailHelp"
									value="<%=doc10.getIsDocumentUploaded()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Document Upload Date</label> <input
									type="text" class="form-control" aria-describedby="emailHelp"
									value="<%=doc10.getUploadedDate()%>" readonly required>
							</div>
						</div>

						<div class="row ml-4">
							<div class="form-group">
								<label for="email">Document: </label> <a
									href="downloadDocument?studentId=<%=student.getId()%>&standard=<%=doc10.getStandard()%>"><button
										type="button" class="btn custom-bg-2 text-white">Download
										Document</button> </a>
							</div>
							<div class="form-group ml-4"></div>
						</div>

					</form>

					<div class="text-center mb-3">
						<a href="approvedocument?studentId=<%=student.getId()%>&standard=<%=DBContants.Standard.TENTH.value()%>&approvalStatus=<%=DBContants.ApprovalStatus.APPROVED.value()%>"><button
								type="button" class="btn custom-bg-2 text-white">Approve</button> </a>
					    <a href="approvedocument?studentId=<%=student.getId()%>&standard=<%=DBContants.Standard.TENTH.value()%>&approvalStatus=<%=DBContants.ApprovalStatus.DENY.value()%>"><button
								type="button" class="btn custom-bg-2 text-white">Deny</button> </a>
								
					</div>



				</div>
			</div>
		</div>
	</div>
	
	<div class="container-fluid md-5 text-color">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4">
				<div class="card border-color md-3">
					<form>
						<div class="text-center">
							<h2>12th Document</h2>
						</div>
						<div class="row ml-4">
							<div class="form-group">
								<label for="email">Year Of Passing</label> <input type="email"
									class="form-control" aria-describedby="emailHelp"
									value="<%=doc12.getYearOfPassing()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Percentage</label> <input type="text"
									class="form-control" aria-describedby="emailHelp"
									value="<%=doc12.getPercentage()%>" readonly required>
							</div>
						</div>

						<div class="row ml-4">
							<div class="form-group">
								<label for="email">Is Document Uploaded?</label> <input
									type="email" class="form-control" aria-describedby="emailHelp"
									value="<%=doc12.getIsDocumentUploaded()%>" readonly required>
							</div>
							<div class="form-group ml-4">
								<label for="email">Document Upload Date</label> <input
									type="text" class="form-control" aria-describedby="emailHelp"
									value="<%=doc12.getUploadedDate()%>" readonly required>
							</div>
						</div>

						<div class="row ml-5">
							<div class="form-group">
								<label for="email">Document: </label> <a
									href="downloadDocument?studentId=<%=student.getId()%>&standard=<%=doc12.getStandard()%>"><button
										type="button" class="btn custom-bg-2 text-white">Download
										Document</button> </a>
							</div>
							<div class="form-group ml-4"></div>
						</div>

					</form>

					<div class="text-center mb-3">
						<a href="approvedocument?studentId=<%=student.getId()%>&standard=<%=DBContants.Standard.TWELVETH.value()%>&approvalStatus=<%=DBContants.ApprovalStatus.APPROVED.value()%>"><button
								type="button" class="btn custom-bg-2 text-white">Approve</button> </a>
					    <a href="approvedocument?studentId=<%=student.getId()%>&standard=<%=DBContants.Standard.TWELVETH.value()%>&approvalStatus=<%=DBContants.ApprovalStatus.DENY.value()%>"><button
								type="button" class="btn custom-bg-2 text-white">Deny</button> </a>	
					</div>



				</div>
			</div>
		</div>
	</div>
	
	<div class="text-center mt-5 text-color">
						<h1>
							Course : <span style="color: green">
								<%
								if (course != null) {
								%><%=course.getName()%>
								<%
								}
								%>
							</span>
						</h1>
						<h2>
							Application Fees : <span style="color: green"><%=DBContants.applicationAmount%></span>
						</h2>

						<h2>
							Is Amount Paid : <span style="color: green"><%=app.getIsAmountPaid()%></span>
						</h2>
					</div>

					<div class="card-footer bg-white text-center mb-5">
						<a href="approveStudentApplication?studentId=<%=student.getId()%>&approvalStatus=<%=DBContants.ApprovalStatus.APPROVED.value()%>"><button
								type="button" class="btn custom-bg-2 text-white">Approve Application</button> </a>
					</div>

</body>
</html>