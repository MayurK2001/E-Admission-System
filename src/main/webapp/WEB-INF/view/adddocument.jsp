<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Student Document</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4">
				<div class="card border-color">
					<%@ include file="./components/message.jsp"%>
					<div class="card-body px-5 text-color">

						<h3 class="text-center my-3">Add Student Document</h3>
						
							<form action="addstudentdocument" method="post"
								enctype="multipart/form-data">

								<div class="form-group ml-4">
									<label for="email">Standard</label> <select name="standard"
										class="form-control">
										<option value="0">Select Standard</option>
										<%
										for (DBContants.Standard s : DBContants.Standard.values()) {
										%>
										<option value="<%=s.value()%>"><%=s.value()%></option>
										<%
										}
										%>
									</select>
								</div>

								<div class="form-group">
									<label for="password">Percentage</label> <input type="text"
										class="form-control" id="password"
										aria-describedby="emailHelp" name="percentage"
										placeholder="Enter percentage.." required>
								</div>

								<div class="form-group">
									<label for="password">Passing Year</label> <input type="text"
										class="form-control" id="password"
										aria-describedby="emailHelp" name="yearOfPassing"
										placeholder="Enter percentage.." required>
								</div>

								<div class="form-group">
									<label>Upload Document</label><br> <input type="file"
										class="form-control" name="document" required>
								</div>

								<div class="container text-center">
									<button class="btn custom-bg-2 text-white">
										<b>Add Document</b>
									</button>
								</div>

							</form>
						
					</div>
				</div>

			</div>
		</div>
	</div>
</body>
</html>