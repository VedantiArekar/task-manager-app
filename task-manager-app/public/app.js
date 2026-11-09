// Ask for confirmation before submitting any form that has a data-confirm attribute
// (used by the Delete buttons).
document.addEventListener("submit", function (event) {
  var message = event.target.getAttribute("data-confirm");

  if (message && !window.confirm(message)) {
    event.preventDefault();
  }
});

// Hide success messages after a few seconds.
document.addEventListener("DOMContentLoaded", function () {
  var messages = document.querySelectorAll(".message.success");

  messages.forEach(function (element) {
    setTimeout(function () {
      element.style.display = "none";
    }, 4000);
  });
});
