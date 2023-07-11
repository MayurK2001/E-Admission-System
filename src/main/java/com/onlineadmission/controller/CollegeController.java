package com.onlineadmission.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.onlineadmission.dao.AppliedCollegeDao;      
import com.onlineadmission.dao.CollegeAvailableCourseDao;
import com.onlineadmission.dao.CollegeDao;
import com.onlineadmission.dao.CourseDao;
import com.onlineadmission.dao.StudentDao;
import com.onlineadmission.model.AppliedCollege;
import com.onlineadmission.model.College;
import com.onlineadmission.model.CollegeAvailableCourse;
import com.onlineadmission.model.Course;
import com.onlineadmission.model.Student;
import com.onlineadmission.utility.DBContants.IsSeatFull;
import com.onlineadmission.utility.DBContants.SelectionStatus;

@Controller
public class CollegeController {

	private static Logger LOG = LogManager.getLogger(CollegeController.class);

	@Autowired
	private CollegeDao collegeDao;

	@Autowired
	private CourseDao courseDao;

	@Autowired
	private CollegeAvailableCourseDao collegeAvailableCourseDao;

	@Autowired
	private AppliedCollegeDao appliedCollegeDao;

	@Autowired
	private StudentDao studentDao;

	@GetMapping("/collegelogin")
	public String goToAdminLoginPage() {
		LOG.info("Redirecting to College Login Page.");
		return "collegelogin";
	}

	@GetMapping("/collegeregister")
	public String goToAdminRegisterPage() {
		LOG.info("Redirecting to College register Page.");
		return "collegeregister";
	}

	@PostMapping("/collegeregister")
	public ModelAndView registerAdmin(@ModelAttribute College college) {
		ModelAndView mv = new ModelAndView();

		college.setSeatFull(IsSeatFull.NO.value());
		college.setAvailableSeat(college.getTotalSeat());

		if (this.collegeDao.save(college) != null) {
			mv.addObject("status", college.getName() + " College Successfully Registered");
			mv.setViewName("index");
		}

		else {
			mv.addObject("status", "Failed to Register College");
			mv.setViewName("collegeregister");
		}

		return mv;
	}

	@PostMapping("/collegelogin")
	public ModelAndView loginCollege(HttpServletRequest request, @RequestParam("email") String email,
			@RequestParam("password") String password) {
		ModelAndView mv = new ModelAndView();
		College college = this.collegeDao.findByEmailAndPassword(email, password);
		if (college != null) {
			HttpSession session = request.getSession();
			session.setAttribute("active-user", college);
			session.setAttribute("user-login", "college");
			mv.addObject("status", "College Successfully Logged in");
			mv.setViewName("index");
		}

		else {
			mv.addObject("status", " Failed to Login as College");
			mv.setViewName("collegelogin");
		}
		return mv;
	}

	@GetMapping("/addcollegecourse")
	public String goToAddcollegecourse() {
		LOG.info("Redirecting to addcollegecourse Page.");
		return "addcollegecourse";
	}

	@PostMapping("/addcollegecourse")
	public ModelAndView addCourseForCollege(@RequestParam("code") String code,
			@RequestParam("courseId") String courseId,
			@RequestParam("listOfCourseIdInString") String listOfCourseIdInString,
			@RequestParam("selectCourse") String currentCourseToDisplay) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("addcollegecourse");

		String listOfCourseToDisplay = null;

		College college = collegeDao.findByCode(code.trim());
		Course course = courseDao.findById(Integer.parseInt(courseId.trim())).get();

		if (college == null) {
			mv.addObject("listOfCourseIdInString", "");
			mv.addObject("listOfCourseToDisplay", "");
			mv.addObject("status", "No College found with CODE " + code);
			return mv;
		}

		String[] listOfIds = null;

		if (!listOfCourseIdInString.isEmpty()) {
			listOfIds = listOfCourseIdInString.split(",");

			if (listOfIds != null) {

				for (String id : listOfIds) {

					if (courseId.equals(id.trim())) {
						mv.addObject("listOfCourseIdInString", listOfCourseIdInString);
						mv.addObject("listOfCourseToDisplay", currentCourseToDisplay);
						mv.addObject("status", "Course Already Added!");
						mv.addObject("collegeCode", code);

					}

					else {
						mv.addObject("listOfCourseIdInString", listOfCourseIdInString + "," + courseId);
						mv.addObject("listOfCourseToDisplay", currentCourseToDisplay + ", " + course.getName());
						mv.addObject("collegeCode", code);
					}

				}

			}

		}

		else {
			listOfCourseIdInString = courseId;

			listOfCourseToDisplay = course.getName();
			mv.addObject("listOfCourseIdInString", listOfCourseIdInString);
			mv.addObject("listOfCourseToDisplay", listOfCourseToDisplay);
			mv.addObject("collegeCode", code);
		}

		return mv;
	}

	@PostMapping("/addAllCollegeCourse")
	public ModelAndView addAllCollegeCourse(@RequestParam("allCourseIds") String allCourseIds,
			@RequestParam("collegeCode") String code) throws IOException {
		LOG.info("add all college course");

		System.out.println(code);
		System.out.println(allCourseIds);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("addcollegecourse");

		if (code == null) {
			mv.addObject("status", "College Code Not present!!!");
			return mv;
		}

		if (allCourseIds == null) {
			mv.addObject("status", "Course not found to add!!!");
			return mv;
		}

		String[] listOfIds = allCourseIds.trim().split(",");

		College college = collegeDao.findByCode(code.trim());

		if (listOfIds != null) {

			for (String id : listOfIds) {

				Course course = courseDao.findById(Integer.parseInt(id.trim())).get();

				CollegeAvailableCourse collegeAvailableCourse = new CollegeAvailableCourse();
				collegeAvailableCourse.setCourseId(course.getId());
				collegeAvailableCourse.setCollegeId(college.getId());
				collegeAvailableCourseDao.save(collegeAvailableCourse);

			}

			mv.setViewName("index");
			mv.addObject("status", "Selected Course added!!!");
			return mv;

		}

		else {
			mv.addObject("status", "Course not found to add!!!");
			return mv;
		}

	}

	@GetMapping("/allcollege")
	public ModelAndView allCollege() {
		ModelAndView mv = new ModelAndView();

		List<College> colleges = this.collegeDao.findAll();
		mv.addObject("colleges", colleges);
		mv.setViewName("viewallcollege");

		return mv;
	}

	@GetMapping("/applycollege")
	public ModelAndView goToApplycollege() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("applycollege");
		mv.addObject("selectedCollegeId", "NA");

		return mv;
	}

	// for student
	@GetMapping("/appliedcollege")
	public ModelAndView goToAppliedcollege(HttpSession session) {
		ModelAndView mv = new ModelAndView();

		Student student = (Student) session.getAttribute("active-user");

		mv.setViewName("appliedcollege");
		mv.addObject("studentId", student.getId());
		return mv;
	}

	@GetMapping("/studentAppliedCollege")
	public ModelAndView goToStudentAppliedcollege(@RequestParam("studentId") int studentId) {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("appliedcollege");
		mv.addObject("studentId", studentId);
		return mv;
	}

	@PostMapping("/addcollege")
	public ModelAndView addCollege(HttpSession session, @RequestParam("collegeId") int collegeId,
			@RequestParam("selectedCollegeIds") String selectedCollegeIds) {

		ModelAndView mv = new ModelAndView();
		System.out.println(selectedCollegeIds);
		if (selectedCollegeIds.equals("NA")) {
			mv.addObject("selectedCollegeId", String.valueOf(collegeId));
			mv.setViewName("applycollege");
			return mv;
		}

		String collegeIds[] = selectedCollegeIds.split(",");

		if (collegeIds.length == 10) {
			mv.addObject("status", "Can't add more than 10 college.");
			mv.addObject("selectedCollegeId", selectedCollegeIds);
			mv.setViewName("applycollege");
			return mv;
		}

		for (String id : collegeIds) {
			if (collegeId == Integer.parseInt(id.trim())) {
				mv.addObject("selectedCollegeId", selectedCollegeIds);
				mv.addObject("status", "college already added.");
				mv.setViewName("applycollege");
				return mv;
			}
		}

		College c = collegeDao.findById(collegeId).get();

		if (c.getAvailableSeat() == 0) {
			mv.addObject("status", "No seat available for selected college.");
			mv.setViewName("applycollege");
			mv.addObject("selectedCollegeId", selectedCollegeIds);

			return mv;
		}

		mv.addObject("selectedCollegeId", selectedCollegeIds + "," + String.valueOf(collegeId));
		mv.setViewName("applycollege");

		return mv;
	}

	@PostMapping("/applyColleges")
	public ModelAndView applyColleges(HttpSession session, @RequestParam("selectedCollege") String selectedCollegeIds) {

		Student student = (Student) session.getAttribute("active-user");

		ModelAndView mv = new ModelAndView();
		System.out.println(selectedCollegeIds);
		if (selectedCollegeIds.equals("NA")) {
			mv.addObject("status", "Please select college above before Applying college");
			mv.setViewName("applycollege");
			return mv;
		}

		String collegeIds[] = selectedCollegeIds.split(",");

		if (collegeIds.length == 10) {
			mv.addObject("status", "Can't add more than 10 college.");
			mv.addObject("selectedCollegeId", selectedCollegeIds);
			mv.setViewName("applycollege");
			return mv;
		}

		for (String id : collegeIds) {

			if (id.trim() == null || id.trim().equals("")) {
				continue;
			}

			AppliedCollege appliedCollege = new AppliedCollege();
			appliedCollege.setCollegeId(Integer.parseInt(id));
			appliedCollege.setStudentId(student.getId());
			appliedCollege.setAllotmentStatus(SelectionStatus.PENDING.value());
			appliedCollegeDao.save(appliedCollege);
		}

		mv.addObject("status", "College Applied successfully.");
		mv.setViewName("index");

		return mv;
	}

	@GetMapping("/appliedStudents")
	public ModelAndView appliedStudents(HttpSession session) {
		ModelAndView mv = new ModelAndView();

		College college = (College) session.getAttribute("active-user");

		List<AppliedCollege> appliedColleges = appliedCollegeDao.findByCollegeId(college.getId());
		List<AppliedCollege> appliedCollegesSelectedStudents = appliedCollegeDao
				.findByCollegeIdAndAllotmentStatus(college.getId(), SelectionStatus.SELECTED.value());

		List<Student> students = new ArrayList<>();
		List<Student> selectedStudents = new ArrayList<>();

		for (AppliedCollege appliedCollege : appliedColleges) {
			Student student = new Student();
			student = studentDao.findById(appliedCollege.getStudentId()).get();
			students.add(student);
		}

		for (AppliedCollege appliedCollege : appliedCollegesSelectedStudents) {
			Student student = new Student();
			student = studentDao.findById(appliedCollege.getStudentId()).get();
			selectedStudents.add(student);
		}

		mv.addObject("students", students);
		mv.addObject("selectedStudents", selectedStudents);
		mv.setViewName("ourappliedcollege");

		return mv;
	}

	@GetMapping("/allotStudent")
	public ModelAndView allotStudent(HttpSession session, @RequestParam("studentId") int studentId) {
		ModelAndView mv = new ModelAndView();

		College college = (College) session.getAttribute("active-user");

		List<AppliedCollege> appliedColleges = appliedCollegeDao.findByCollegeId(college.getId());
		List<AppliedCollege> appliedCollegesSelectedStudents = appliedCollegeDao
				.findByCollegeIdAndAllotmentStatus(college.getId(), SelectionStatus.SELECTED.value());
		List<Student> students = new ArrayList<>();
		List<Student> selectedStudents = new ArrayList<>();

		for (AppliedCollege appliedC : appliedColleges) {
			Student student = new Student();
			student = studentDao.findById(appliedC.getStudentId()).get();
			students.add(student);
		}

		for (AppliedCollege appliedC : appliedCollegesSelectedStudents) {
			Student student = new Student();
			student = studentDao.findById(appliedC.getStudentId()).get();
			selectedStudents.add(student);
		}

		if (college.getAvailableSeat() < 1) {
			mv.addObject("students", students);
			mv.addObject("selectedStudents", selectedStudents);
			mv.addObject("status", "No Available Seat to Allot");
			mv.setViewName("ourappliedcollege");
		}

		AppliedCollege appliedCollege = appliedCollegeDao.findByStudentIdAndCollegeId(studentId, college.getId());
		appliedCollege.setAllotmentStatus(SelectionStatus.SELECTED.value());
		appliedCollegeDao.save(appliedCollege);

		college.setAvailableSeat(college.getAvailableSeat() - 1);
		collegeDao.save(college);

		mv.addObject("students", students);
		mv.addObject("selectedStudents", selectedStudents);
		mv.addObject("status", "Student Alloted");
		mv.setViewName("ourappliedcollege");

		return mv;
	}

}
