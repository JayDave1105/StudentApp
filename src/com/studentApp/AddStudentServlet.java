package com.studentApp;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;

public class AddStudentServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String gender = request.getParameter("gender");
		String dob = request.getParameter("dob");
		String studentClass = request.getParameter("class");
		
		if(mobile == null || !mobile.matches("\\d{10}")) {
			out.println("<h3>Invalid mobile number. Must be exactly 10 digits.</h3>");
		}
		
		try {
			Connection conn = DBUtil.getConnection();
			String sql = "INSERT INTO students (name, mobile, gender, dob, class) values (?,?,?,?,?)";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, mobile);
			stmt.setString(3, gender);
			stmt.setString(4, dob);
			stmt.setString(5, studentClass);
			
			int row = stmt.executeUpdate();
			
			if(row>0) {
				response.sendRedirect("index.jsp");
			}else {
				out.println("<h3>Error inserting student.</h3>");
			}
			
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			out.println("<h3>Database Error: " + e.getMessage() + "</h3>");
		}
	}	
}
