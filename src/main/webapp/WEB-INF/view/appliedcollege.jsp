<%@page import="com.onlineadmission.utility.DBContants.SelectionStatus"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Applied College - Online Admission</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>

	<%
	Integer sId = (Integer) request.getAttribute("studentId");

	List<AppliedCollege> appliedColleges = appliedCollegeDao.findByStudentId(sId);
	List<College> colleges =  new ArrayList<>();

	College allotedCollege = null;

	if (!appliedColleges.isEmpty()) {
		for (AppliedCollege appliedCollege : appliedColleges) {
			College myAppliedCollege = collegeDao.findById(appliedCollege.getCollegeId()).get();
			
			colleges.add(myAppliedCollege);
		}
	}

	AppliedCollege allotedAppliedCollege = appliedCollegeDao.findByStudentIdAndAllotmentStatus(sId,
			SelectionStatus.SELECTED.value());

	if (allotedAppliedCollege != null) {
		allotedCollege = collegeDao.findById(allotedAppliedCollege.getCollegeId()).get();

	}
	%>

	<div class="ml-3 mr-3">

		<div class="table-responsive mt-5">
			<table class="table">
				<thead class="custom-bg-2 text-white">
					<tr>
						<th scope="col">Name</th>
						<th scope="col">Email Id</th>
						<th scope="col">Address</th>
						<th scope="col">Location</th>
						<th scope="col">Phone No</th>
						<th scope="col">College Code</th>
						<th scope="col">Total Seat</th>
						<th scope="col">Available Seat</th>
						<th scope="col">Booked Seat</th>
					</tr>
				</thead>

				<tbody class="text-color">

					<%
					if (colleges != null) {
						for (College c : colleges) {
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
						<td class="mid-align"><%=c.getTotalSeat() - c.getAvailableSeat()%></td>
					</tr>
					<%
					}
					}
					%>
				</tbody>


			</table>

			<%
					if(colleges == null) {
					%>
			<div class="text-center text-danger">
				<h2>College Not Applied till now.</h2>
			</div>
			<%
					}
					%>
		</div>
		<br>
		<br>
		<div class="text-center text-color">
			<h1>Alloted College</h1>
		</div>

		<div class="table-responsive mt-1">
			<table class="table">
				<thead class="custom-bg-2 text-white">
					<tr>
						<th scope="col">Name</th>
						<th scope="col">Email Id</th>
						<th scope="col">Address</th>
						<th scope="col">Location</th>
						<th scope="col">Phone No</th>
						<th scope="col">College Code</th>
						<th scope="col">Total Seat</th>
						<th scope="col">Available Seat</th>
						<th scope="col">Booked Seat</th>
						
					</tr>
				</thead>

				<tbody class="text-color">
					<%
					if (allotedCollege != null) {
					%>
					<tr class="text-center">
						<td class="mid-align"><%=allotedCollege.getName()%></td>
						<td class="mid-align"><%=allotedCollege.getEmail()%></td>
						<td class="mid-align"><%=allotedCollege.getAddress()%></td>
						<td class="mid-align"><%=allotedCollege.getLocation()%></td>
						<td class="mid-align"><%=allotedCollege.getPhoneNo()%></td>
						<td class="mid-align"><%=allotedCollege.getCode()%></td>
						<td class="mid-align"><%=allotedCollege.getTotalSeat()%></td>
						<td class="mid-align"><%=allotedCollege.getAvailableSeat()%></td>
						<td class="mid-align"><%=allotedCollege.getTotalSeat() - allotedCollege.getAvailableSeat()%></td>
					
					</tr>

					<%
					} 
					%>
				</tbody>
			</table>
			
			
			<%
					if(allotedCollege == null) {
					%>
			<div class="text-center text-danger">
				<h2>No College Alloted</h2>
			</div>
			<%
					}
					%>
			
		</div>
		
		<br>
		<br>
  
        <div class="text-center text-color">
        <a
						href="downloadform?studentId=<%=sId%>"><button
								type="button" class="btn custom-bg-2 text-white">Download
								Application</button></a>
        </div>
		
	</div>
</body>
</html>