package com.onlineadmission.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.onlineadmission.model.Course;

@Repository
public interface CourseDao extends JpaRepository<Course, Integer> {

}
