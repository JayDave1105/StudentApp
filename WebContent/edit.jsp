<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String id = request.getParameter("id");
    String name = "";
    String mobile = "";
    String gender = "";
    String dob = "";
    String studentClass = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/studentdb", "root", "12345678");

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM students WHERE id=?");
        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            mobile = rs.getString("mobile");
            gender = rs.getString("gender");
            dob = rs.getString("dob");
            studentClass = rs.getString("class");
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p>Error loading data: " + e.getMessage() + "</p>");
    }
%>

<div class="modal-header">
  <h5 class="modal-title">Edit Student</h5>
  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>

<div class="modal-body">
  <form id="editStudentForm">
    <input type="hidden" name="id" value="<%= id %>">
    Name:
    <input type="text" name="name" class="form-control" value="<%= name %>" required><br>
    Mobile:
    <input type="text" name="mobile" class="form-control" value="<%= mobile %>" pattern="\\d{10}" maxlength="10" required><br>
    Gender:
    <select name="gender" class="form-select">
      <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
      <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
    </select><br>
    DOB:
    <input type="date" name="dob" class="form-control" value="<%= dob %>"><br>
    Class:
    <input type="text" name="class" class="form-control" value="<%= studentClass %>"><br>
  </form>
</div>

<div class="modal-footer">
  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
  <button type="button" class="btn btn-primary" id="btnUpdateStudent">Save Changes</button>
</div>
