<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<table class="table table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Mobile</th>
            <th>Gender</th>
            <th>DOB</th>
            <th>Class</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/studentdb", "root", "12345678");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM students");

        while (rs.next()) {
            int id = rs.getInt("id");
%>
        <tr data-id="<%=id%>">
            <td><%= id %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("mobile") %></td>
            <td><%= rs.getString("gender") %></td>
            <td><%= rs.getString("dob") %></td>
            <td><%= rs.getString("class") %></td>
            <td>
                <a href="#" class="btnEdit" data-id="<%=id%>">Edit</a> |
                <a href="#" class="btnDelete" data-id="<%=id%>">Delete</a>
            </td>
        </tr>
<%
        }
        conn.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
    </tbody>
</table>
