package com.onlineadmission.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Course {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String name;
	private String minimumQualification;
	private String subjectCriteria;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMinimumQualification() {
		return minimumQualification;
	}
	public void setMinimumQualification(String minimumQualification) {
		this.minimumQualification = minimumQualification;
	}
	public String getSubjectCriteria() {
		return subjectCriteria;
	}
	public void setSubjectCriteria(String subjectCriteria) {
		this.subjectCriteria = subjectCriteria;
	}

	
}
