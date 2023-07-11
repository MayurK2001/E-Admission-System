package com.onlineadmission.dao;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.onlineadmission.model.CollegeAvailableCourse;

@Repository
public interface CollegeAvailableCourseDao extends JpaRepository<CollegeAvailableCourse, Integer> {
	
	List<CollegeAvailableCourseDao> findByCollegeId(int collegeId);
	List<CollegeAvailableCourseDao> findByCourseId(int courseId);

}
