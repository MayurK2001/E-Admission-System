<%@page import="com.onlineadmission.utility.DBContants.ApprovalStatus"%>
<%@ page import="com.onlineadmission.model.*"%>
<%@ page import="com.onlineadmission.dao.*"%>
<%@ page import="com.onlineadmission.utility.*"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>


<%
String userType = (String) session.getAttribute("user-login");
Admin admin = null;
Student student = null;
College college = null;
if (userType != null && userType.equals("admin")) {
	admin = (Admin) session.getAttribute("active-user");
}

else if (userType != null && userType.equals("student")) {
	student = (Student) session.getAttribute("active-user");
}

else if (userType != null && userType.equals("college")) {
	college = (College) session.getAttribute("college");
}

ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
StudentDao studentDao = context.getBean(StudentDao.class);
AdminDao adminDao = context.getBean(AdminDao.class);
CourseDao courseDao = context.getBean(CourseDao.class);
StudentApplicationDao applicationDao = context.getBean(StudentApplicationDao.class);
StudentDocumentsDao documentDao = context.getBean(StudentDocumentsDao.class);
CollegeAvailableCourseDao collegeAvailableCourseDao = context.getBean(CollegeAvailableCourseDao.class);
CollegeDao collegeDao = context.getBean(CollegeDao.class);
AppliedCollegeDao appliedCollegeDao = context.getBean(AppliedCollegeDao.class);
%>

<nav class="navbar navbar-expand-lg ">

	<div class="container-fluid">
		<img src="resources/images/studentlogo.png" width="35" height="35"
			class="d-inline-block align-top" alt=""> <a
			class="navbar-brand" href="/"><p class="appname">e-Admission
				System</p></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">


				<%
				if (userType != null && userType.equals("admin")) {
				%>
				<li class="nav-item active"><a class="nav-link" href="allforms"><span
						class="text-white">All Application Form</span> <span
						class="sr-only">(current)</span></a></li>

				<li class="nav-item active"><a class="nav-link"
					href="addcourse"><span class="text-white">Add Course</span> <span
						class="sr-only">(current)</span></a></li>

				<li class="nav-item active"><a class="nav-link"
					href="collegeregister"><span class="text-white">Register
							College</span> <span class="sr-only">(current)</span></a></li>

				<li class="nav-item active"><a class="nav-link"
					href="addcollegecourse"><span class="text-white">Add
							College Course</span> <span class="sr-only">(current)</span></a></li>

				<li class="nav-item active"><a class="nav-link"
					href="allcollege"><span class="text-white">View All
							College</span> <span class="sr-only">(current)</span></a></li>
				<%
				}

				if (userType != null && userType.equals("college")) {
				%>
				<li class="nav-item active"><a class="nav-link"
					href="appliedStudents"><span class="text-white">Applied
							Students</span> <span class="sr-only">(current)</span></a></li>
				<%
				}
				if (userType == null) {
				%>
				<li class="nav-item active"><a class="nav-link"
					href="adminlogin"><span class="text-white">Admin Login</span> <span
						class="sr-only">(current)</span></a></li>
						
						<li class="nav-item active"><a class="nav-link"
					href="collegelogin"><span class="text-white">College Login</span> <span
						class="sr-only">(current)</span></a></li>
				<%
				}
				%>

				<li class="nav-item active text-white ml-2" data-toggle="modal"
					data-target=".aboutusmodal">
					<div class="nav-link">
						<span class="text-white">About us</span>
					</div>
				</li>

				<li class="nav-item active text-white ml-2" data-toggle="modal"
					data-target=".contactusmodal">
					<div class="nav-link">
						<span class="text-white">Contact us</span>
					</div>
				</li>

			</ul>

			<%
			if (userType != null && userType.equals("student")) {
			%>
			<ul class="navbar-nav ml-auto">

				<%
				StudentApplication studentApplication = applicationDao.findByStudentId(student.getId());
				if (studentApplication != null && studentApplication.getIsApproved().equals(ApprovalStatus.APPROVED.value())) {
				%>

				<li class="nav-item active"><a class="nav-link"
					href="applycollege"><span class="text-white">Apply
							College</span></a></li>

				<li class="nav-item active"><a class="nav-link"
					href="appliedcollege"><span class="text-white">Applied
							College</span></a></li>

				<%
				}
				%>

				<li class="nav-item active"><a class="nav-link"
					href="registerStudentApplication"><span class="text-white">Register</span></a>
				</li>

				<li class="nav-item active"><a class="nav-link"
					href="addstudentdocument"><span class="text-white">Upload</span></a>
				</li>

				<li class="nav-item active"><a class="nav-link"
					href="myapplication"><span class="text-white">Application</span></a>
				</li>

				<li class="nav-item active"><a class="nav-link"
					href="myprofile"><span class="text-white">Profile</span></a></li>

				<li class="nav-item active"><a class="nav-link"
					href="changepassword"><span class="text-white">Change Password</span>
						<span class="sr-only">(current)</span></a></li>

			



				<%
				}

				 else if (userType == null) {
				%>


				<li class="nav-item active"><a class="nav-link"
					href="studentregister"><span class="text-white">Register</span></a>
				</li>

				<li class="nav-item active"><a class="nav-link"
					href="studentlogin"><span class="text-white">Login</span></a></li>
			</ul>

			<%
			}
			if(userType != null) {
			%>
			<li class="nav-item active" data-toggle="modal"
					data-target=".logout-modal"><a class="nav-link text-white"
					href="#"><span>Logout</span></a></li>
			<%
			}  
			
			%>

		</div>
	</div>
</nav>

<!-- Logout modal -->

<div class="modal fade logout-modal" tabindex="-1" role="dialog"
	aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header custom-bg-2 text-white text-center">
				<h5 class="modal-title" id="exampleModalLongTitle">Log Out</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body text-center text-color">
				<h5>Do you want to logout?</h5>

				<div class="text-center">
					<a href="logout"><button type="button"
							class="btn custom-bg-2 text-white">Yes</button></a>
					<button type="button" class="btn btn-secondary ml-5"
						data-dismiss="modal">No</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- *********** -->

<!-- About us modal -->

<div class="modal fade aboutusmodal" tabindex="-1" role="dialog"
	aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header custom-bg-2 text-white text-center">
				<h5 class="modal-title" id="exampleModalLongTitle">About Us</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container">
					<p class="paragraphtext text-color">We are a unique university,
						the best in the world in the arena of Art and Design. We also top
						the arena of food processing technologies and rocket science.
						Enroll now in your favorite course and join the millions of
						successful experts</p>
				</div>
			</div>
			<div class="modal-footer">
				<div class="text-center">
					<button type="button" class="btn  custom-bg-2 text-white"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ********** -->

<!-- Contact us modal -->

<div class="modal fade contactusmodal" tabindex="-1" role="dialog"
	aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header custom-bg-2 text-white text-center">
				<h5 class="modal-title" id="exampleModalLongTitle">Contact Us</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container text-center text-color">
					<p style="font-size: 23px;">
						<span> <img src="resources/images/phonee.png"
							style="width: 27px;" alt="img">+91 876XXXX594 / +91
							784XXXX32<br> <img src="resources/images/emaill.png"
							style="width: 29px;" alt="img">xxxx@gmail.com
						</span>
					</p>
				</div>
			</div>
			<div class="modal-footer">
				<div class="text-center">
					<button type="button" class="btn custom-bg-2 text-white"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ********** -->