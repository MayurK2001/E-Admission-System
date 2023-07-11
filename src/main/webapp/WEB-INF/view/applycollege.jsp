<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Apply College</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>

	<%
	String selectedCollegeId = null;
	selectedCollegeId = (String) request.getAttribute("selectedCollegeId");
	System.out.println("Printing in web");
	System.out.println(selectedCollegeId);
	%>

	<div class="container-fluid ml-3 mr-3">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-2">
				<div class="card border-color" style="width: 1300px;">
				
				<%
				Long appliedCollegeCount = appliedCollegeDao.countByStudentId(student.getId());
				
				if(appliedCollegeCount == 0) {
				
				%>
				
					<%@ include file="./components/message.jsp"%>
					<div class="card-body px-5 text-color">
						
						<h3 class="text-center my-3">Apply College</h3>
						<form action="addcollege" method="post">
						  <input type="hidden" name="selectedCollegeIds" value="<%=selectedCollegeId%>">

							<div class="form-group ml-4">
								<label for="email">College</label>
								 <select name="collegeId"
									class="form-control">
									<option value="0">Select College</option>
									<%
									for (College c : collegeDao.findAll()) {
									%>
									<option value="<%=c.getId()%>"><%="[ " + c.getCode() + " ] " + c.getName()%></option>
									<%
									}
									%>
								</select>
							</div>


							<div class="container text-center">
								<button class="btn custom-bg-2 text-white">
									<b>Add College</b>
								</button>
							</div>
						</form>
						<br>
						<hr>
						<div class="text-center">Selected Colleges</div>
						
						<div class="table-responsive mt-5">
		<table class="table">
			<thead class="custom-bg-2 text-white">
				<tr>
					<th scope="col">College Name</th>
					<th scope="col">Email Id</th>
					<th scope="col">Address</th>
					<th scope="col">Location</th>
					<th scope="col">Phone No</th>
					<th scope="col">College Code</th>
					<th scope="col">Total Seat</th>
					<th scope="col">Available Seat</th>
				
				</tr>
			</thead>

			<tbody class="text-color">

				<%
				if (!selectedCollegeId.equals("NA")) {
					
					String collegeIds[] = selectedCollegeId.split(",");
					
					for (String id : collegeIds) {
				
				     College c = collegeDao.findById(Integer.parseInt(id)).get();
				%>
				<tr class="text-center">
					<td class="mid-align"><%=c.getName()%></td>
					<td class="mid-align"><%=c.getEmail()%></td>
					<td class="mid-align"><%=c.getAddress()%></td>
					<td class="mid-align"><%=c.getLocation()%></td>
					<td class="mid-align"><%=c.getPhoneNo()%></td>
					<td class="mid-align"><%=c.getCode()%></td>
					<td class="mid-align"><%=c.getTotalSeat()%></td>
					<td class="mid-align"><%=c.getAvailableSeat()%></td>
				</tr>
				<%
				}
				}
				%>
			</tbody>


		</table>
	</div>
						
						<form action="applyColleges" method="post">
						  <input type="hidden" name="selectedCollege" value="<%=selectedCollegeId%>">
						  <button class="btn custom-bg-2 text-white">
									<b>Apply College</b>
								</button>
						</form>
					</div>
					
					
					<%
				}
				
				else {
				
					%>
				 
				  <div class="text-center text-color">
				  
				  <h2>
				     You have already applied for College.
				     <span><a href="appliedcollege">click here check allotment status</a>
				  </span>
				  </h2>
				  
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