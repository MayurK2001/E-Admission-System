package com.onlineadmission.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.onlineadmission.model.AppliedCollege;

@Repository("appliedCollegeDao")
public interface AppliedCollegeDao extends JpaRepository<AppliedCollege, Integer>  {
	
	List<AppliedCollege> findByStudentId(int studentId);
	List<AppliedCollege> findByCollegeId(int college);
	Long countByStudentId(int college);
	AppliedCollege findByStudentIdAndAllotmentStatus(int studentId, String allotmentStatus);
	List<AppliedCollege> findByCollegeIdAndAllotmentStatus(int collegeId, String allotmentStatus);
	AppliedCollege findByStudentIdAndCollegeId(int studentId, int collegeId);
}
