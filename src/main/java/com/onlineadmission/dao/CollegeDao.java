package com.onlineadmission.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.onlineadmission.model.College;

@Repository("collegeDao")
public interface CollegeDao extends JpaRepository<College, Integer> {
	
	College findByEmailAndPassword(String email , String password);
    College findByCode(String code);
	
}
