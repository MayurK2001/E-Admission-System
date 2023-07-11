package com.onlineadmission.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.onlineadmission.model.StudentDocuments;

@Repository
public interface StudentDocumentsDao extends JpaRepository<StudentDocuments, Integer>{
	
	List<StudentDocuments> findByStudentId(int studentId);
	StudentDocuments findByStandardAndStudentId(String standard, int studentId);

}
