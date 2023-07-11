<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Login</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-2">
			<div class="col-md-4 offset-md-4">
				<div class="card border-color">
					<%@ include file="./components/message.jsp"%>
					<div class="card-body text-color px-5">
						
							<form action="forgetpassword" method="post">
                               <h1>Forget Password</h1>
								<div class="form">

									<div class="form-group ">
										<label for="inputPassword4">Username</label> <input type="text"
											class="form-control" id="text" name="username">
									</div>
									<div class="form-group ">
										<label for="inputPassword4">Mobile No</label> <input type="text"
											class="form-control" id="phone" name="mobile">
									</div>
								</div>

								<div class="container text-center">

									<input type="submit" class="btn custom-bg-2 text-white"
										value="Proceed">

								</div>
							</form>
						
					</div>
				</div>


			</div>
		</div>
	</div>
</body>
</html>