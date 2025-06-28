<%@ page import="java.sql.*" %> <%@ page import="java.util.*" %> <%@ page
language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="ISO-8859-1" />
    <title>Student Data</title>

    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </head>
  <body>
    <h2>Student List</h2>
    <button type="button" class="btn btn-success" id="btnAddStudent">
      + Add Student
    </button>
    <br />
    <div id="studentTable"></div>

    <div class="modal fade" id="studentModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content" id="studentModalContent"></div>
      </div>
    </div>

    <script>
      $(document).ready(function () {
        $("#studentTable").load("studentTable.jsp");

        $("#btnAddStudent").click(function () {
          $("#studentModalContent").html("Loading...");
          $("#studentModal").modal("show");

          $("#studentModalContent").load("add.jsp");
        });
        $(document).on("click", "#btnSaveStudent", function () {
          var formData = $("#addStudentForm").serialize();

          $.ajax({
            url: "add", // Your AddStudentServlet mapping
            type: "POST",
            data: formData,
            success: function (response) {
              $("#studentModal").modal("hide");
              refreshTable();
            },
            error: function () {
              alert("Error adding student!");
            },
          });
        });

        function refreshTable() {
          $("#studentTable").load("studentTable.jsp");
        }

        $(document).on("click", ".btnEdit", function (e) {
          e.preventDefault();

          var studentId = $(this).data("id");
          $("#studentModalContent").html("Loading...");
          $("#studentModal").modal("show");

          $("#studentModalContent").load("edit.jsp?id=" + studentId);
        });

        $(document).on("click", "#btnUpdateStudent", function () {
          var formData = $("#editStudentForm").serialize();

          $.ajax({
            url: "edit", // This should match your EditStudentServlet mapping
            type: "POST",
            data: formData,
            success: function (response) {
              $("#studentModal").modal("hide");
              refreshTable();
            },
            error: function () {
              alert("Error updating student!");
            },
          });
        });

        $(document).on("click", ".btnDelete", function (e) {
          e.preventDefault();

          var studentId = $(this).data("id");

          if (confirm("Are you sure you want to delete this student?")) {
            $.ajax({
              url: "delete",
              type: "GET",
              dataType: "json",
              data: { id: studentId },
              success: function (response) {
                if (response.status === "success") {
                  $("tr[data-id='" + studentId + "']").remove();
                } else {
                  alert("Delete failed: " + response.message);
                }
              },
              error: function () {
                alert("Error deleting student!");
              },
            });
          }
        });
      });
    </script>
  </body>
</html>
