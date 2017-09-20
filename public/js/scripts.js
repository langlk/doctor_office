$(document).ready(function() {
  $(".submit-doctor").click(function(event) {
    var name = $("#doctor-name").val()
    var specialty = $("#doctor-specialty").val()
    if (name.length === 0 || specialty.length === 0) {
      $("#doctor-alert").show();
      event.preventDefault()
      return;
    }
  });

  $(".submit-patient").click(function(event) {
    var name = $("#patient-name").val()
    var birthday = $("#patient-birthday").val()
    if (name.length === 0 || birthday.length === 0) {
      $("#patient-alert").show();
      event.preventDefault()
      return;
    }
  });

  $(".submit-portal").click(function(event) {
    var name = $("#portal-name").val()
    if (name.length === 0) {
      $("#portal-alert").show();
      event.preventDefault();
      return;
    }
  });

  $("button.delete").click(function(event) {
    var deleteConfirm = confirm("Are you sure you want to delete this user?")
    if (!deleteConfirm) {
      event.preventDefault();
      return;
    }
  });
});
