package com.studentApp;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DeleteStudentServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String id = request.getParameter("id");

	    try {
	        Connection conn = DBUtil.getConnection();
	        String sql = "DELETE FROM students WHERE id=?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, Integer.parseInt(id));

	        int rows = stmt.executeUpdate();
	        conn.close();

	        response.setContentType("application/json");
	        PrintWriter out = response.getWriter();

	        if (rows > 0) {
	            out.print("{\"status\":\"success\"}");
	        } else {
	            out.print("{\"status\":\"error\",\"message\":\"Student not found.\"}");
	        }
	        out.flush();

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.setContentType("application/json");
	        PrintWriter out = response.getWriter();
	        out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
	        out.flush();
	    }
	}

}
