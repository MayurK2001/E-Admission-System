package com.onlineadmission.utility;

import java.awt.Color;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.draw.VerticalPositionMark;
import com.onlineadmission.dao.AppliedCollegeDao;
import com.onlineadmission.dao.CollegeDao;
import com.onlineadmission.model.AppliedCollege;
import com.onlineadmission.model.College;
import com.onlineadmission.model.Course;
import com.onlineadmission.model.Student;
import com.onlineadmission.model.StudentApplication;
import com.onlineadmission.model.StudentDocuments;
import com.onlineadmission.utility.DBContants.SelectionStatus;

public class BillExporter {

	private AppliedCollegeDao appliedCollegeDao;

	private CollegeDao collegeDao;

	private Course course;

	private List<StudentDocuments> studentDocument;

	private StudentApplication studentApplication;

	private Student student;
	
	public BillExporter(Course course, List<StudentDocuments> studentDocument, StudentApplication studentApplication,
			Student student, CollegeDao collegeDao, AppliedCollegeDao appliedCollegeDao) {
		super();
		this.course = course;
		this.studentDocument = studentDocument;
		this.studentApplication = studentApplication;
		this.student = student;
		this.appliedCollegeDao = appliedCollegeDao;
		this.collegeDao = collegeDao;
	}

	public void export(HttpServletResponse response) throws DocumentException, IOException {
		Document document = new Document(PageSize.A4);

		PdfWriter.getInstance(document, response.getOutputStream());
		document.open();
		Image image = Image.getInstance("classpath:images/studentlogo.png");
		image.scalePercent(4.0f, 4.0f);
		document.add(image);

		Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
		headerFont.setSize(25);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pHeader = new Paragraph("Student Application \n", headerFont);
		pHeader.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(pHeader);

		headerFont.setSize(13);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pD = new Paragraph("Student Id: " + student.getId(), headerFont);
		pD.setAlignment(Paragraph.ALIGN_RIGHT);
		document.add(pD);

		Image imageP = Image.getInstance("classpath:studentPics/" + studentApplication.getStudentPhoto());
		imageP.scalePercent(13.0f, 13.0f);
		document.add(imageP);

		headerFont.setSize(18);
		headerFont.setColor(new Color(77, 2, 105));
		Chunk glue = new Chunk(new VerticalPositionMark());
		Paragraph pp = new Paragraph("\nStudent Details:", headerFont);
		pp.add(new Chunk(glue));
		pp.add("Parent Details:");
		document.add(pp);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Chunk glueN = new Chunk(new VerticalPositionMark());
		Paragraph pN = new Paragraph("Name: " + student.getFirstname() + " " + student.getLastname(), headerFont);
		pN.add(new Chunk(glueN));
		pN.add("Father Name: " + studentApplication.getFatherName());
		document.add(pN);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Chunk glueA = new Chunk(new VerticalPositionMark());
		Paragraph pA = new Paragraph("Email Id: " + student.getEmailid(), headerFont);
		pA.add(new Chunk(glueA));
		pA.add("Mother Name: " + studentApplication.getMotherName());
		document.add(pA);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Paragraph pBG = new Paragraph("Mobile No: " + student.getMobileno(), headerFont);
		pBG.setAlignment(Paragraph.ALIGN_LEFT);
		document.add(pBG);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Paragraph pE = new Paragraph(
				"Address: " + student.getStreet() + " " + student.getCity() + " " + student.getPincode(), headerFont);
		pE.setAlignment(Paragraph.ALIGN_LEFT);
		document.add(pE);

		headerFont.setSize(25);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pQHeader = new Paragraph("Qualification \n", headerFont);
		pQHeader.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(pQHeader);

		StudentDocuments doc10 = studentDocument.get(0);

		headerFont.setSize(20);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pD1Header = new Paragraph("10th Document \n", headerFont);
		pD1Header.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(pD1Header);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Paragraph pper = new Paragraph("Percentage : " + doc10.getPercentage(), headerFont);
		pper.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(pper);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Paragraph ppass = new Paragraph("Passing Year : " + doc10.getYearOfPassing(), headerFont);
		ppass.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(ppass);

		headerFont.setSize(13);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pTook = new Paragraph("\nDocuments Uploaded : " + doc10.getIsDocumentUploaded(), headerFont);
		pTook.setAlignment(Paragraph.ALIGN_RIGHT);
		document.add(pTook);

		headerFont.setSize(13);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pApprove = new Paragraph("\nDocuments Approved : " + doc10.getIsApproved(), headerFont);
		pApprove.setAlignment(Paragraph.ALIGN_RIGHT);
		document.add(pApprove);

		StudentDocuments doc12 = studentDocument.get(0);

		headerFont.setSize(20);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pD2Header = new Paragraph("12th Document \n", headerFont);
		pD2Header.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(pD2Header);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Paragraph pper12 = new Paragraph("Percentage : " + doc12.getPercentage(), headerFont);
		pper12.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(pper12);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Paragraph ppass12 = new Paragraph("Passing Year : " + doc12.getYearOfPassing(), headerFont);
		ppass12.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(ppass12);

		headerFont.setSize(13);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pTook12 = new Paragraph("\nDocuments Uploaded : " + doc12.getIsDocumentUploaded(), headerFont);
		pTook12.setAlignment(Paragraph.ALIGN_RIGHT);
		document.add(pTook12);

		headerFont.setSize(13);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pApprove12 = new Paragraph("\nDocuments Approved : " + doc12.getIsApproved(), headerFont);
		pApprove12.setAlignment(Paragraph.ALIGN_RIGHT);
		document.add(pApprove12);

		headerFont.setSize(25);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph p2Header = new Paragraph("Course Detail \n", headerFont);
		p2Header.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(p2Header);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Paragraph p = new Paragraph("Course Name : " + course.getName(), headerFont);
		p.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(p);

		headerFont.setSize(13);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph pMedicines = new Paragraph("\nApplication Form Amount Rs " + DBContants.applicationAmount
				+ "/- Paid? : " + studentApplication.getIsAmountPaid(), headerFont);
		pMedicines.setAlignment(Paragraph.ALIGN_RIGHT);
		document.add(pMedicines);

		headerFont.setSize(25);
		headerFont.setColor(new Color(77, 2, 105));
		Paragraph applicationForm = new Paragraph("Application Approval Status \n", headerFont);
		applicationForm.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(applicationForm);

		headerFont.setSize(12);
		headerFont.setColor(Color.BLACK);
		Paragraph applicationFormP = null;
		if (studentApplication == null || studentApplication.getId() == 0) {
			applicationFormP = new Paragraph("Is Application Approved? : No", headerFont);
		}

		else {
			applicationFormP = new Paragraph("Is Application Approved? : " + studentApplication.getIsApproved(),
					headerFont);
		}
		applicationFormP.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(applicationFormP);

		Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
		font.setSize(25);
		font.setColor(new Color(77, 2, 105));
		Paragraph allotedCollege = new Paragraph("\nAlloted College\n", font);
		allotedCollege.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(allotedCollege);

		PdfPTable table = new PdfPTable(5);
		table.setWidthPercentage(100f);
		table.setWidths(new float[] { 3.0f, 2.5f, 2.5f, 2.7f, 1.5f });
		table.setSpacingBefore(10);

		writeTableHeader(table);
		writeTableData(table);

		document.add(table);

		document.close();

	}

	private void writeTableHeader(PdfPTable table) {
		PdfPCell cell = new PdfPCell();
		cell.setBackgroundColor(new Color(215, 196, 158));
		cell.setPadding(5);

		Font font = FontFactory.getFont(FontFactory.HELVETICA);
		font.setColor(new Color(77, 2, 105));

		cell.setPhrase(new Phrase("College Name", font));

		table.addCell(cell);

		cell.setPhrase(new Phrase("College Code", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Email Id", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Phone", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Location", font));
		table.addCell(cell);

	}

	private void writeTableData(PdfPTable table) {

		if (student != null) {
			
			AppliedCollege appliedCollege = appliedCollegeDao.findByStudentIdAndAllotmentStatus(student.getId(),
					SelectionStatus.SELECTED.value());

			if (appliedCollege != null) {
				College college = collegeDao.findById(appliedCollege.getCollegeId()).get();
				table.addCell(college.getName());
				table.addCell(college.getCode());
				table.addCell(college.getEmail());
				table.addCell(college.getPhoneNo());
				table.addCell(college.getLocation());
			}

			else {
				table.addCell("-");
				table.addCell("-");
				table.addCell("-");
				table.addCell("-");
				table.addCell("-");
			}
		}

		else {
			table.addCell("-");
			table.addCell("-");
			table.addCell("-");
			table.addCell("-");
			table.addCell("-");
		}
	}

}
