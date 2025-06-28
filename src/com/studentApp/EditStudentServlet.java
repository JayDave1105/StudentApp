package com.studentApp;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class EditStudentServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String gender = request.getParameter("gender");
		String dob = request.getParameter("dob");
		String studentClass = request.getParameter("class");
		
		if (mobile == null || !mobile.matches("[0-9]{10}")) {
			out.println("<h3>Invalid mobile number. Must be exactly 10 digits.</h3>");
            return;
		}
		
		try {
            Connection conn = DBUtil.getConnection();
            String sql = "UPDATE students SET name=?, mobile=?, gender=?, dob=?, class=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, mobile);
            stmt.setString(3, gender);
            stmt.setString(4, dob);
            stmt.setString(5, studentClass);
            stmt.setInt(6, Integer.parseInt(id));

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("index.jsp");
            } else {
                out.println("<h3>Error updating student record.</h3>");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Database Error: " + e.getMessage() + "</h3>");
        }
	}
}
