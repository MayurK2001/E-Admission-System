<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View All College - Online Admission</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>

	<%
	List<College> colleges = (List<College>) request.getAttribute("colleges");
	%>

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
	</div>


</body>
</html>