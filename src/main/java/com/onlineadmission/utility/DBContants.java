package com.onlineadmission.utility;

public class DBContants {
	
	public final static String apiKey = "CVTU1rpPf5yYcPQYZuyZFvHWTUmqF0fQIELCYt0ZBIBmGkp6cgj8uWbHEEOd";
	public final static String applicationAmount = "200.00";
	
	public enum Qualification {
		TWELVETH("12th");
		
		private String qualification;

	    private Qualification(String qualification) {
	      this.qualification = qualification;
	    }

	    public String value() {
	      return this.qualification;
	    }

	    public boolean equals(String qualification) {
	      return this.qualification.equals(qualification.toUpperCase());
	    }
	}
	
	public enum Standard {
		TENTH("10th"),
		TWELVETH("12th");
		
		private String standard;

	    private Standard(String standard) {
	      this.standard = standard;
	    }

	    public String value() {
	      return this.standard;
	    }

	    public boolean equals(String standard) {
	      return this.standard.equals(standard.toUpperCase());
	    }
	}
	
	public enum Subject {
		NONE("None"),
		PCM("PCM"),
		PCB("PCB");
		
		private String subject;

	    private Subject(String subject) {
	      this.subject = subject;
	    }

	    public String value() {
	      return this.subject;
	    }

	    public boolean equals(String subject) {
	      return this.subject.equals(subject.toUpperCase());
	    }
	}
	
	public enum City {
		MUMBAI("Mumbai"),
		PUNE("Pune");
		private String city;

	    private City(String city) {
	      this.city = city;
	    }

	    public String value() {
	      return this.city;
	    }

	    public boolean equals(String city) {
	      return this.city.equals(city.toUpperCase());
	    }
	}
	
	public enum State {
		MAHARASHTRA("Maharashtra"),
		UP("UP"),
		MP("MP");
		
		private String state;

	    private State(String state) {
	      this.state = state;
	    }

	    public String value() {
	      return this.state;
	    }

	    public boolean equals(String state) {
	      return this.state.equals(state.toUpperCase());
	    }
	}
	
	public enum Country {
		INDIA("India");
		
		private String country;

	    private Country(String country) {
	      this.country = country;
	    }

	    public String value() {
	      return this.country;
	    }

	    public boolean equals(String country) {
	      return this.country.equals(country.toUpperCase());
	    }
	}
	
	public enum Course {
		BE("BE"),
		BTECH("BTECH"),
		DIPLOMA_ENGG("Diploma(Engg)"),
		BPHARM("BPHARM"),
		DPHARM("DPHARM");
		
		private String course;

	    private Course(String course) {
	      this.course = course;
	    }

	    public String value() {
	      return this.course;
	    }

	    public boolean equals(String course) {
	      return this.course.equals(course.toUpperCase());
	    }
	}
	
	public enum IsMobileVerified {
		YES(1),
		NO(0);
		
		private int status;

	    private IsMobileVerified(int status) {
	      this.status = status;
	    }

	    public int value() {
	      return this.status;
	    }

	}
	
	public enum IsAmountPaid {
		YES("Yes"),
		NO("No");
		
		private String status;

	    private IsAmountPaid(String status) {
	      this.status = status;
	    }

	    public String value() {
	      return this.status;
	    }
	}
	
	public enum IsDocumentUploaded {
		YES("Yes"),
		NO("No");
		
		private String status;

	    private IsDocumentUploaded(String status) {
	      this.status = status;
	    }

	    public String value() {
	      return this.status;
	    }

	}
	
	public enum ApprovalStatus {
		APPROVAL_PENDIND("Approval Pending"),
		APPROVED("Approved"),
		DENY("Deny");
		
		private String status;

	    private ApprovalStatus(String status) {
	      this.status = status;
	    }

	    public String value() {
	      return this.status;
	    }

	}
	
	public enum IsSeatFull {
		YES("Yes"),
		NO("No");
		
		private String status;

	    private IsSeatFull(String status) {
	      this.status = status;
	    }

	    public String value() {
	      return this.status;
	    }

	}
	
	public enum SelectionStatus {
		SELECTED("Selected"),
		NOT_SELECTED("Not Selected"),
		PENDING("PENDING");
		
		private String status;

	    private SelectionStatus(String status) {
	      this.status = status;
	    }

	    public String value() {
	      return this.status;
	    }

	}
	
}
