package com.onlineadmission.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.lowagie.text.DocumentException;
import com.onlineadmission.dao.AppliedCollegeDao;
import com.onlineadmission.dao.CollegeDao;
import com.onlineadmission.dao.CourseDao;
import com.onlineadmission.dao.StudentApplicationDao;
import com.onlineadmission.dao.StudentDao;
import com.onlineadmission.dao.StudentDocumentsDao;
import com.onlineadmission.model.Course;
import com.onlineadmission.model.Student;
import com.onlineadmission.model.StudentApplication;
import com.onlineadmission.model.StudentDocuments;
import com.onlineadmission.utility.BillExporter;
import com.onlineadmission.utility.DBContants;
import com.onlineadmission.utility.DBContants.IsAmountPaid;
import com.onlineadmission.utility.DBContants.IsDocumentUploaded;
import com.onlineadmission.utility.DBContants.Standard;
import com.onlineadmission.utility.DBContants.Subject;

@Controller
@MultipartConfig
public class StudentApplicationContoller {

	private static Logger LOG = LogManager.getLogger(StudentApplicationContoller.class);

	@Autowired
	private StudentApplicationDao studentApplicationDao;

	@Autowired
	private StudentDocumentsDao studentDocumentsDao;

	@Autowired
	private CourseDao courseDao;

	@Autowired
	private StudentDao studentDao;
	
	@Autowired
	private CollegeDao collegeDao;
	
    @Autowired
    private AppliedCollegeDao appliedCollegeDao;

	@GetMapping("/registerStudentApplication")
	public String goToRegisterStudentApplicationPage() {
		LOG.info("Redirecting to student application register page.");
		return "registerstudentapplication";
	}
	
	@GetMapping("/addstudentdocument")
	public String goToAddDocumentPage() {
		LOG.info("Redirecting to Add document page.");
		return "adddocument";
	}
	
	@GetMapping("/paymentpage")
	public String goToPaymentPage() {
		LOG.info("Redirecting to payment page.");
		return "paymentpage";
	}

	@PostMapping("/addstudentapplication")
	public ModelAndView addStudentApplication(HttpServletRequest request, HttpSession session)
			throws IOException, ServletException {
		ModelAndView mv = new ModelAndView();
		Student student = (Student) session.getAttribute("active-user");

		StudentApplication application = this.studentApplicationDao.findByStudentId(student.getId());

		if (application != null) {
			mv.addObject("status", "You already registered Student Application");
			mv.setViewName("index");
			return mv;
		}

		String fathername = request.getParameter("fathername");
		String mothername = request.getParameter("mothername");
		String city = request.getParameter("city");
		String dob = request.getParameter("dob");
		String state = request.getParameter("state");
		String country = request.getParameter("country");
		String pincode = request.getParameter("pincode");
		String qualification = request.getParameter("qualification");
		String subject = request.getParameter("subject");
		int courseId = Integer.parseInt(request.getParameter("courseId"));

		Optional<Course> optional = courseDao.findById(courseId);

		Course course = null;

		if (optional.isPresent()) {
			course = (Course) optional.get();
		}

		if (!qualification.equals(course.getMinimumQualification())) {
			mv.addObject("status", "Failed to Add Application, Qualification requirement failed.");
			mv.setViewName("registerstudentapplication");
			return mv;
		}
		
		else if(course.getSubjectCriteria().equals(Subject.NONE.value())){
			mv.addObject("status", "Please select valid subject.");
			mv.setViewName("registerstudentapplication");
			return mv;
		}

		else if (!subject.equals(course.getSubjectCriteria())) {
			mv.addObject("status", "Failed to Add application, Subject Criteria failed.");
			mv.setViewName("registerstudentapplication");
			return mv;
		}

		Part part = request.getPart("studentPic");

		String fileName = part.getSubmittedFileName();

		// upload in src/main/resources
		String uploadPath = "C:\\spring boot project\\online-admission\\src\\main\\resources\\studentPics\\"
				+ fileName;

		try {
			FileOutputStream fos = new FileOutputStream(uploadPath);
			InputStream is = part.getInputStream();

			byte[] data = new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		// upload in webapps/resources
		String webappsPath = "C:\\spring boot project\\online-admission\\src\\main\\resources\\studentPics\\"
				+ fileName;

		try {
			FileOutputStream fos = new FileOutputStream(webappsPath);
			InputStream is = part.getInputStream();

			byte[] data = new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		application = new StudentApplication();

		application.setStudentId(student.getId());
		application.setCity(city);
		application.setCountry(country);
		application.setCourseId(courseId);
		application.setDob(dob);
		application.setFatherName(fathername);
		application.setMotherName(mothername);
		application.setPinCode(pincode);
		application.setState(state);
		application.setStudentPhoto(fileName);
		application.setApplicationDate(LocalDateTime.now().toString());
		application.setIsAmountPaid(DBContants.IsAmountPaid.NO.value());
		application.setIsApproved(DBContants.ApprovalStatus.APPROVAL_PENDIND.value());

		studentApplicationDao.save(application);
		
		mv.addObject("status", "Please add the document.");
		mv.setViewName("adddocument");
		return mv;

	}

	@PostMapping("/addstudentdocument")
	public ModelAndView addStudentDocument(HttpServletRequest request, HttpSession session)
			throws IOException, ServletException {
		ModelAndView mv = new ModelAndView();

		long percentage = Long.parseLong(request.getParameter("percentage"));
		int yearOfPassing = Integer.parseInt(request.getParameter("yearOfPassing"));
		String standard = request.getParameter("standard");
		Student student = (Student) session.getAttribute("active-user");
		
		StudentDocuments document = null;
		
		document = this.studentDocumentsDao.findByStandardAndStudentId(standard,student.getId());
		
		if(document == null) {
			Part part = request.getPart("document");

			String fileName = part.getSubmittedFileName();

			String uploadPath = "C:\\spring boot project\\online-admission\\src\\main\\webapp\\resources\\documents\\"
					+ fileName;

			try {
				FileOutputStream fos = new FileOutputStream(uploadPath);
				InputStream is = part.getInputStream();

				byte[] data = new byte[is.available()];
				is.read(data);
				fos.write(data);
				fos.close();
			}

			catch (Exception e) {
				e.printStackTrace();
			}

			document = new StudentDocuments();
			document.setPercentage(percentage);
			document.setIsDocumentUploaded(IsDocumentUploaded.YES.value());
			document.setDocument(fileName);
			document.setStudentId(student.getId());
			document.setYearOfPassing(yearOfPassing);
			document.setStandard(standard);
			document.setUploadedDate(LocalDateTime.now().toString());
			document.setIsApproved(DBContants.ApprovalStatus.APPROVAL_PENDIND.value());

			studentDocumentsDao.save(document);
			
			if(standard.equals(Standard.TENTH.value())) {
				mv.addObject("status", "Document Uploaded");
				mv.setViewName("adddocument");
				return mv;
			}
			
			else if(standard.equals(Standard.TWELVETH.value())) {
				mv.addObject("status", "Document Uploaded, Pay the registration Fees and submit the form");
				mv.setViewName("paymentpage");
				return mv;
			}
			
		}
		
		if(document != null && document.getIsApproved().equals(DBContants.ApprovalStatus.APPROVED.value())) {
			mv.addObject("status", standard+" document already Uploaded and Approved:)");
			mv.setViewName("adddocument");
			return mv;
		}
		
		if(document != null && document.getIsApproved().equals(DBContants.ApprovalStatus.APPROVAL_PENDIND.value())) {
			mv.addObject("status", standard+" document already Uploaded:) Approval Pending from Admin Side!");
			mv.setViewName("adddocument");
			return mv;
		}
		
		if(document != null && document.getIsApproved().equals(DBContants.ApprovalStatus.DENY.value())) {
			Part part = request.getPart("document");

			String fileName = part.getSubmittedFileName();

			String uploadPath = "C:\\spring boot project\\online-admission\\src\\main\\webapp\\resources\\documents\\"
					+ fileName;

			try {
				FileOutputStream fos = new FileOutputStream(uploadPath);
				InputStream is = part.getInputStream();

				byte[] data = new byte[is.available()];
				is.read(data);
				fos.write(data);
				fos.close();
			}

			catch (Exception e) {
				e.printStackTrace();
			}

			document.setPercentage(percentage);
			document.setIsDocumentUploaded(IsDocumentUploaded.YES.value());
			document.setDocument(fileName);
			document.setStudentId(student.getId());
			document.setYearOfPassing(yearOfPassing);
			document.setStandard(standard);
			document.setUploadedDate(LocalDateTime.now().toString());

			studentDocumentsDao.save(document);
			
			if(standard.equals(Standard.TENTH.value())) {
				mv.addObject("status", "Document Uploaded");
				mv.setViewName("adddocument");
				return mv;
			}
			
			else if(standard.equals(Standard.TWELVETH.value())) {
				mv.addObject("status", "Document Uploaded, Pay the registration Fees and submit the form");
				mv.setViewName("paymentpage");
				return mv;
			}
			
		}

		return mv;

	}

	@PostMapping("/payamount")
	public ModelAndView addStudentDocument(@RequestParam("amount") String amount, HttpSession session)
			throws IOException, ServletException {
		ModelAndView mv = new ModelAndView();

		Student student = (Student)session.getAttribute("active-user");
		StudentApplication application = studentApplicationDao.findByStudentId(student.getId());
		
		List<StudentDocuments> documents = this.studentDocumentsDao.findByStudentId(student.getId());
		
		if(documents == null) {
			mv.addObject("status", "Documents Not Updated, Please upload the Documents before payment");
			mv.setViewName("adddocument");
			
			return mv;
		}
		
		if(documents.size() != 2) {
			mv.addObject("status", "All Documents Not Uploaded, Please upload the Documents before payment");
			mv.setViewName("adddocument");
			
			return mv;
		}
		
		for(StudentDocuments document : documents) {
			if(document.getIsDocumentUploaded().equals(DBContants.IsDocumentUploaded.NO.value())) {
				mv.addObject("status", "Documents Not Uploaded, Please upload the Documents before payment");
				mv.setViewName("adddocument");
				
				return mv;
			}
			
			if(document.getIsApproved().equals(DBContants.ApprovalStatus.DENY.value())) {
				mv.addObject("status", "Uploaded Document Not approved by Admin, Please upload the document before payment!");
				mv.setViewName("adddocument");
				
				return mv;
			}
			
		}
		
		if(application.getIsAmountPaid().equals(DBContants.IsAmountPaid.YES.value())) {
			mv.addObject("status", "Application fee already paid:)");
			mv.setViewName("myapplication");
			
			return mv;
		}
		
		application.setIsAmountPaid(IsAmountPaid.YES.value());

		studentApplicationDao.save(application);

		mv.addObject("status", "Application Submitted Successfully:)");
		mv.setViewName("index");

		return mv;

	}

	@GetMapping("/myapplication")
	public String goToApplicationPage() {
		LOG.info("Redirecting to My Application Page.");
		return "applicationform";
	}
	
	@GetMapping("/approveapplication")
	public ModelAndView goToApproveApplicationPage(@RequestParam("studentId") int studentId) {
		LOG.info("Redirecting to Approve Application Page.");
		ModelAndView mv = new ModelAndView();
		
		Optional<Student> optional = this.studentDao.findById(studentId);
		Student student = null;
		if(optional.isPresent()) {
			student = optional.get();
		}
		
		mv.setViewName("approveapplication");
        mv.addObject("student", student);
		return mv;
	}
	
	@GetMapping("/approvedocument")
	public ModelAndView approveDocumentPage(@RequestParam("studentId") int studentId, @RequestParam("standard") String standard,@RequestParam("approvalStatus") String approvalStatus) {
		LOG.info("Approve document page");
		ModelAndView mv = new ModelAndView();
		
		Optional<Student> optional = this.studentDao.findById(studentId);
		Student student = null;
		if(optional.isPresent()) {
			student = optional.get();
		}
		
		StudentDocuments documents = this.studentDocumentsDao.findByStandardAndStudentId(standard, studentId);
		
		if(documents == null) {
			mv.setViewName("approveapplication");
	        mv.addObject("status", student);
	        mv.addObject("status", "Can't Approve "+standard+" Document, Document not uploaded.");
			return mv;
		}
		
		documents.setIsApproved(approvalStatus);
		
		this.studentDocumentsDao.save(documents);
		
		mv.setViewName("approveapplication");
        mv.addObject("student", student);
        mv.addObject("status", standard+" Document Approval Status updated.");
		return mv;
	}

	@GetMapping("/allforms")
	public String goToAllFormPage() {
		LOG.info("Redirecting to All form Page.");
		return "allforms";
	}

	@GetMapping("/downloadform")
	public void downloadBill(@RequestParam("studentId") int studentId, HttpServletResponse response)
			throws DocumentException, IOException {

		Optional<Student> optional = studentDao.findById(studentId);
		Student student = null;

		if (optional.isPresent()) {
			student = (Student) optional.get();
		}

		StudentApplication application = studentApplicationDao.findByStudentId(studentId);
		List<StudentDocuments> document = studentDocumentsDao.findByStudentId(studentId);

		response.setContentType("application/pdf");
		String headerKey = "Content-Disposition";
		String headerValue = "attachment; filename=" + student.getFirstname() + "_Application.pdf";
		response.setHeader(headerKey, headerValue);

		Course course = null;

		Optional<Course> optionalC = courseDao.findById(application.getCourseId());
		if (optionalC.isPresent()) {
			course = (Course) optionalC.get();
		}

	    BillExporter exporter = new BillExporter(course, document, application, student,collegeDao, appliedCollegeDao);
	    exporter.export(response);
	}
	
	@GetMapping("/approveStudentApplication")
	public ModelAndView approveStudentApplication(@RequestParam("studentId") int studentId, @RequestParam("approvalStatus") String status) {
		LOG.info("Approve Student application");
		ModelAndView mv = new ModelAndView();
		
		Optional<Student> optional = this.studentDao.findById(studentId);
		Student student = null;
		if(optional.isPresent()) {
			student = optional.get();
		}
		
		List<StudentDocuments> documents = this.studentDocumentsDao.findByStudentId(studentId);
		
		if(documents == null) {
			mv.setViewName("approveapplication");
	        mv.addObject("student", student);
	        mv.addObject("status", "Can't approve application, Documents not uploaded.");
			return mv;
		}
		
		if(documents.size() != 2) {
			mv.setViewName("approveapplication");
	        mv.addObject("student", student);
	        mv.addObject("status", "Can't approve application,10th or 12th Documents not uploaded.");
			return mv;
		}
		
		for(StudentDocuments document : documents) {
			 if(!document.getIsApproved().equals(DBContants.ApprovalStatus.APPROVED.value())) {
				 mv.setViewName("approveapplication");
			        mv.addObject("student", student);
			        mv.addObject("status", "Can't approve application,"+document.getStandard()+" Documents not approved.");
					return mv;
			 }
		}
		
		StudentApplication application = this.studentApplicationDao.findByStudentId(student.getId());
		application.setIsApproved(status);
		
		this.studentApplicationDao.save(application);
		
		mv.setViewName("approveapplication");
        mv.addObject("student", student);
        mv.addObject("status", student.getFirstname()+"'s Application Approval Status updated.");
		return mv;
	}
	
	@GetMapping("/downloadDocument")
	public void downloadDocument(@RequestParam("studentId") int studentId, @RequestParam("standard") String standard, HttpServletResponse response) throws IOException {
		LOG.info("download document");
		
		Optional<Student> optional = this.studentDao.findById(studentId);
		Student student = null;
		if(optional.isPresent()) {
			student = optional.get();
		}
		
		StudentDocuments documents = this.studentDocumentsDao.findByStandardAndStudentId(standard, studentId);
		
		response.setContentType("text/plain");

        
        response.setHeader("Content-disposition","attachment; filename="+documents.getDocument());

        File my_file = new File("C:\\spring boot project\\online-admission\\src\\main\\webapp\\resources\\documents\\"+documents.getDocument());

        
        OutputStream out = response.getOutputStream();
        FileInputStream in = new FileInputStream(my_file);
        byte[] buffer = new byte[4096];
        int length;
        while ((length = in.read(buffer)) > 0){
           out.write(buffer, 0, length);
        }
        in.close();
        out.flush();
		
		
	}
	
}
