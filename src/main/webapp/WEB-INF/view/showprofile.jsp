<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show Profile</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<div class="container-fluid">
  <div class="row mt-2">
       <div class="col-md-4 offset-md-4" >
            <div class="card border-color">
                <%@ include file="./components/message.jsp"%>
                <div class="card-body px-5 text-color">
                <form>
                <h1 class="text-color">Student Profile</h1>
				<div class="form-group mt-3">
					<div class="form-group">
						<label for="inputEmail4">First Name</label> <input type="text"
							class="form-control" id="inputEmail4"
							value="<%=student.getFirstname()%>"
							readonly>
					</div>
					<div class="form-group">
						<label for="inputEmail4">Last Name</label> <input type="text"
							class="form-control" id="inputEmail4"
							value="<%=student.getLastname()%>"
							readonly>
					</div>
					<div class="form-group">
						<label for="inputPassword4">Email</label> <input type="email"
							class="form-control" id="inputPassword4"
							value="<%=student.getEmailid()%>"
							readonly>
					</div>
					<div class="form-group">
						<label for="inputPassword4">Phone</label> <input type="text"
							class="form-control" id="inputPassword4"
							value="<%=student.getMobileno()%>"
							readonly>
					</div>

					<div class="form-group">
						<label for="inputAddress">Address</label>
						<textarea class="form-control" id="inputAddress" rows="3" readonly>
							<%=student.getStreet()+" "+student.getCity()+" "+student.getPincode()%>
						</textarea>
					</div>
				</div>
			</form>
		</div>
	</div>
	</div>
	</div>
	</div>
</body>
</html>