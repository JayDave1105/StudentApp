<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal-header">
  <h5 class="modal-title">Add New Student</h5>
  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>

<div class="modal-body">
  <form id="addStudentForm">
    Name:
    <input type="text" name="name" class="form-control" required><br>
    Mobile:
    <input type="text" name="mobile" class="form-control" pattern="\\d{10}" maxlength="10" required><br>
    Gender:
    <select name="gender" class="form-select">
      <option value="Male">Male</option>
      <option value="Female">Female</option>
    </select><br>
    DOB:
    <input type="date" name="dob" class="form-control"><br>
    Class:
    <input type="text" name="class" class="form-control"><br>
  </form>
</div>

<div class="modal-footer">
  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
  <button type="button" class="btn btn-primary" id="btnSaveStudent">Save</button>
</div>
