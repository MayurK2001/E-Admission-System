package com.onlineadmission.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.onlineadmission.model.StudentApplication;

@Repository
public interface StudentApplicationDao extends JpaRepository<StudentApplication, Integer> {
	
	StudentApplication findByStudentId(int studentId);

}
