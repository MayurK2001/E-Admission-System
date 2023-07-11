package com.onlineadmission.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.onlineadmission.model.Admin;

@Repository("adminDao")
public interface AdminDao extends JpaRepository<Admin, Integer> {
	
	Admin findByUsernameAndPassword(String username , String password);

}
