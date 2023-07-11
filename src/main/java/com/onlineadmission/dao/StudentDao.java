package com.onlineadmission.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.onlineadmission.model.Student;

@Repository("studentDao")
public interface StudentDao extends JpaRepository<Student, Integer>{
	
	Student findByUsernameAndPassword(String username , String password);
	Student findByUsernameAndMobileno(String username, String phone);

}
