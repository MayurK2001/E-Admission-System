<%@page import="com.onlineadmission.utility.DBContants.SelectionStatus"%>
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
	
	List<Student> students = (List<Student>)request.getAttribute("students");
	List<Student> selectedStudents = (List<Student>)request.getAttribute("selectedStudents");
	%>
	
	<div class="text-center text-color"><h1>Total Applied Students</h1></div>

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
					<th scope="col">Download Form</th>					
					<th scope="col">Allotment Status</th>
					<th scope="col">Allot</th>
				</tr>
			</thead>

			<tbody class="text-color">

				<%
			

				for (Student s : students) {

					StudentApplication app = applicationDao.findByStudentId(s.getId());

					if (app != null) {

						StudentDocuments doc10 = documentDao.findByStandardAndStudentId(DBContants.Standard.TENTH.value(), s.getId());
						StudentDocuments doc12 = documentDao.findByStandardAndStudentId(DBContants.Standard.TWELVETH.value(),
						s.getId());
						Optional<Course> optional = courseDao.findById(app.getCourseId());
						Course course = null;
						
						AppliedCollege appliedC = appliedCollegeDao.findByStudentIdAndAllotmentStatus(s.getId(), SelectionStatus.SELECTED.value());
						
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
						<a
									href="downloadDocument?studentId=<%=s.getId()%>&standard=<%=doc10.getStandard()%>"><button
										type="button" class="btn custom-bg-2 text-white">Download
										Document</button> </a>
					</td>
					<td class="mid-align">
						<a
									href="downloadDocument?studentId=<%=s.getId()%>&standard=<%=doc12.getStandard()%>"><button
										type="button" class="btn custom-bg-2 text-white">Download
										Document</button> </a>
					</td>
					<td class="mid-align"><%=course.getName()%></td>
					
					<td class="mid-align"><a
						href="downloadform?studentId=<%=s.getId()%>"><button
								type="button" class="btn custom-bg-2 text-white">Download
								Application</button></a></td>
					<td class="mid-align">
					   <%
                          if(appliedC != null && appliedC.getAllotmentStatus().equals(SelectionStatus.SELECTED.value())) {
                        	
                       %>
                           <span class="text-success">ALLOTED</span>   
                       <%
                          }
                       
                          else {
                       %>
                         <span class="text-danger">NOT ALLOTED</span>   
                       <%
                          }
                       %>
                    </td>
                    
                    <td class="mid-align">
                       
                       <%
                          if(appliedC != null && appliedC.getAllotmentStatus().equals(SelectionStatus.SELECTED.value())) {
                        	
                       %>
                       <span class="text-success">ALLOTED</span>   
                       <%
                          }
                       
                          else {
                       %>
                        
                          <a
						href="allotStudent?studentId=<%=s.getId()%>"><button
								type="button" class="btn custom-bg-2 text-white">Allot</button></a>
                       <%
                          }
                       %>
                    
                        
				    </td>

				</tr>
				<%
				}
				}
				%>
			</tbody>


		</table>
	</div>

    <br>
    <br>
    
    <div class="text-center text-color"><h1>Selected Students</h1></div>

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
					<th scope="col">Download Form</th>					
				
				</tr>
			</thead>

			<tbody class="text-color">

				<%
				
				for (Student s : selectedStudents) {

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
						<a
									href="downloadDocument?studentId=<%=s.getId()%>&standard=<%=doc10.getStandard()%>"><button
										type="button" class="btn custom-bg-2 text-white">Download
										Document</button> </a>
					</td>
					<td class="mid-align">
						<a
									href="downloadDocument?studentId=<%=s.getId()%>&standard=<%=doc12.getStandard()%>"><button
										type="button" class="btn custom-bg-2 text-white">Download
										Document</button> </a>
					</td>
					<td class="mid-align"><%=course.getName()%></td>
					
					<td class="mid-align"><a
						href="downloadform?studentId=<%=s.getId()%>"><button
								type="button" class="btn custom-bg-2 text-white">Download
								Application</button></a></td>
					

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