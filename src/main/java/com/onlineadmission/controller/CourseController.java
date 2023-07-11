package com.onlineadmission.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.onlineadmission.dao.CourseDao;
import com.onlineadmission.model.Course;

@Controller
public class CourseController {
	
	private static Logger LOG = LogManager.getLogger(CourseController.class);
	
	@Autowired
	private CourseDao courseDao;
	
	@GetMapping("/addcourse")
	public String goToAddCoursePage() {
		LOG.info("Redirecting to Add Course Page.");
		return "addcourse";
	}
	
	@PostMapping("/addcourse")
	public ModelAndView addCourse(@ModelAttribute Course course) {
		ModelAndView mv = new ModelAndView();
		if(this.courseDao.save(course)!=null) {
			mv.addObject("status", "Course Added Successfully!");
			mv.setViewName("index");
		}
		
		else {
			mv.addObject("status", "Failed to add course.");
			mv.setViewName("index");
		}
		
		return mv;
	}
	

}
