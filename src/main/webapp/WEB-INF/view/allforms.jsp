<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Student Applications</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<%@ include file="./components/message.jsp"%>
	<%
	List<Student> students = studentDao.findAll();
	%>

	<div class="table-responsive mt-5">
		<table class="table">
			<thead class="custom-bg-2 text-white">
				<tr>
					<th scope="col">Photo</th>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Mobile</th>
					<th scope="col">Email Id</th>
					<th scope="col">Father Name</th>
					<th scope="col">Mother Name</th>
					<th scope="col">10th Document</th>
					<th scope="col">12th Document</th>
					<th scope="col">Course</th>
					<th scope="col">Form Fee</th>
					<th scope="col">Amount Paid</th>
					<th scope="col">Approval Status</th>
					<th scope="col">Download Form</th>
					<th scope="col">Approve</th>
					<th scope="col">Allotment Status</th>
				</tr>
			</thead>

			<tbody class="text-color">

				<%
				List<Integer> listOfProductId = new ArrayList<>();

				for (Student s : students) {

					StudentApplication app = applicationDao.findByStudentId(s.getId());

					if (app != null) {

						StudentDocuments doc10 = documentDao.findByStandardAndStudentId(DBContants.Standard.TENTH.value(), s.getId());
						StudentDocuments doc12 = documentDao.findByStandardAndStudentId(DBContants.Standard.TWELVETH.value(),
						s.getId());
						Optional<Course> optional = courseDao.findById(app.getCourseId());
						Course course = null;

						if (optional.isPresent()) {
					course = (Course) optional.get();
						}
				%>
				<tr class="text-center">
					<td><img
						style="max-height: 100px; max-width: 70px; width: auto;"
						class="img-fluid mx-auto d-block"
						src="resources/studentPics/<%=app.getStudentPhoto()%>"
						alt="users_pic"></td>
					<td class="mid-align"><%=s.getFirstname()%></td>
					<td class="mid-align"><%=s.getLastname()%></td>
					<td class="mid-align"><%=s.getMobileno()%></td>
					<td class="mid-align"><%=s.getEmailid()%></td>
					<td class="mid-align"><%=app.getFatherName()%></td>
					<td class="mid-align"><%=app.getMotherName()%></td>
					<td class="mid-align">
						<%
						if (doc10 != null) {
						%> <%=DBContants.IsDocumentUploaded.YES.value()%>
						<%
						} else {
						%> DBContants.IsDocumentUploaded.NO.value() <%
						}
						%>
					</td>
					<td class="mid-align">
						<%
						if (doc12 != null) {
						%> <%=DBContants.IsDocumentUploaded.YES.value()%>
						<%
						} else {
						%> <%=DBContants.IsDocumentUploaded.NO.value()%> <%
						}
						%>
					</td>
					<td class="mid-align"><%=course.getName()%></td>
					<td class="mid-align"><%=DBContants.applicationAmount%></td>
					<td class="mid-align"><%=app.getIsAmountPaid()%></td>
					<td class="mid-align"><%=app.getIsApproved()%></td>
					<td class="mid-align"><a
						href="downloadform?studentId=<%=s.getId()%>"><button
								type="button" class="btn custom-bg-2 text-white">Download
								Application</button></a></td>
					<td class="mid-align text-success">
					
				   <%
				        if(app.getIsApproved().equals(DBContants.ApprovalStatus.APPROVED.value())) {
				    %>
					       <b><%=DBContants.ApprovalStatus.APPROVED.value()%></b>
					<%
				        }
				     
				        else {
					%>
					<a
						href="approveapplication?studentId=<%=s.getId()%>"><button
								type="button" class="btn custom-bg-2 text-white">Approve
								Application</button> </a>
				    
                    <%
				        }
                    %>
                    </td>
                    
                    <td class="mid-align"><a
						href="studentAppliedCollege?studentId=<%=s.getId()%>"><button
								type="button" class="btn custom-bg-2 text-white">Check Status</button></a></td>

				</tr>
				<%
				}
				}
				%>
			</tbody>


		</table>
	</div>

</body>
</html>