$(document).ready(function() {
  $(".submit-doctor").click(function(event) {
    var name = $("#doctor-name").val()
    var specialty = $("#doctor-specialty").val()
    if (name.length === 0 || specialty.length === 0) {
      $("#doctor-alert").show();
      event.preventDefault()
      return
    }
  });

  $(".submit-patient").click(function(event) {
    var name = $("#patient-name").val()
    var birthday = $("#patient-birthday").val()
    if (name.length === 0 || birthday.length !== 10) {
      $("#patient-alert").show();
      event.preventDefault()
      return
    }
  });
});
