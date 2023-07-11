<%@page import="com.onlineadmission.utility.DBContants.ApprovalStatus"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home- Online Admission</title>
<%@ include file="./components/common_cs_js.jsp"%>
</head>
<body>
	<%@ include file="./components/navbar.jsp"%>
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner" style="width: 100%">
			<div class="carousel-item active">
				<img class="d-block w-100" src="resources/images/slide1.jpg"
					alt="First slide">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="resources/images/slide2.jpg"
					alt="Second slide">
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="resources/images/slide3.jpg"
					alt="Third slide">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
	<%@ include file="./components/message.jsp"%>
   
   <%
    
   System.out.println(userType);
   
     if(userType != null && userType.equals("student")) {
    	System.out.println("user is not null");
    	StudentApplication studentApplication = applicationDao.findByStudentId(student.getId()); 
    	
    	
		if(studentApplication != null && studentApplication.getIsApproved().equals(ApprovalStatus.APPROVED.value())) {
			%>
		    <div class="text-center text-color">Your Application is <span class="text-success">APPROVED</span>,<a href="applycollege"><span class="text-danger">click here to Apply Colleges</span></a></div>

<%
}
	 }
   %>
   

    <div class="container-fluid mt-4 mb-5">
    <div class="row">
      <div class="col-md-2">
             <div class="list-group ">
                <a href="#" class="list-group-item  btn-primary"><h5>All Courses</h5></a>
               <%
               List<Course> courses = courseDao.findAll();
                    for(Course course: courses)
                    {    	
               %>      
                     <p class="border-b courses">
						<a href="#" class="list-group-item list-group-item-action"><%=course.getName()%></a>
					 </p>    
               <%
                    }
               %>
               </div>
         </div>
      
      
      <div class="col-md-10"> 
          <div class="container-fluid">

		<div class="row">
		
		    <div class="col-md-9">

				<div class="row ">
					<div class="col-md-7">
						<div class="mt-3 text-color">
							<h3>
								Application Form
							</h3>
						</div>
					</div>
				</div>

				<div class="text-color">
					<p class="paragraphtext">
						1) An admission management system is a digital solution to manage
						student enrollments in colleges, universities, and training
						institutions.<br>
						<br> 2) Educational institutions use Education CRM to
						distribute inquiries to counselors/admission teams, follow-up with
						leads, and complete the enrollment process digitally.
						<br><br>
						3) An admission management system is a digital solution to manage
						student enrollments in colleges, universities, and training
						institutions.<br>
						<br> 4) Educational institutions use Education CRM to
						distribute inquiries to counselors/admission teams, follow-up with
						leads, and complete the enrollment process digitally.
					</p>
				</div>
			</div>

			<div class="col-md-3">
				<img src="resources/images/landing_image.jpeg"
					style="max-height: 400px; max-width: 100%; width: auto;"
					class="card-img-top rounded mx-auto d-block m-2" alt="img">

			</div>

		</div>

	</div>

	<div class="container-fluid mt-3 mb-5">

		<div class="row mt-3">

			
			<div class="col-md-12">

				<div class="row ">
					<div class="col-md-7">
						<div class="mt-3 ">
							<h3 class="mt-3 text-color">
								About the sample university
							</h3>
						</div>
					</div>
				</div>

				<div class="text-color">
					<p class="paragraphtext">
						We are a unique university, the best in the world in the arena of Art and Design. We also top the arena of food processing technologies and rocket science. Enroll now in your favorite course and join the millions of successful experts
					</p>
				</div>
			</div>

		</div>

	</div>
      </div>
    </div>

	</div>
	
	<hr>
	
	 <%@ include file="./components/footer.jsp"%>

</body>
</html>