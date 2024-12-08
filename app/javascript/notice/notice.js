document.addEventListener("turbo:load", function() {
  var noticeMessage = document.getElementById("notice-message");

  if (noticeMessage) {
    // Cerrar la alerta después de 3 segundos
    setTimeout(function() {
      var alert = new bootstrap.Alert(noticeMessage);
      alert.close(); // Cierra la alerta de Bootstrap
    }, 3000); // 3 segundos
  }
});

document.addEventListener("turbo:load", function() {
  var alertMessage = document.getElementById("alert-message");

  if (alertMessage) {
    // Cerrar la alerta después de 3 segundos
    setTimeout(function() {
      var alert = new bootstrap.Alert(alertMessage);
      alert.close(); // Cierra la alerta de Bootstrap
    }, 3000); // 3 segundos
  }
});

document.addEventListener("turbo:load", function() {
  var alertMessage = document.getElementById("error-message");

  if (alertMessage) {
    // Cerrar la alerta después de 3 segundos
    setTimeout(function() {
      var alert = new bootstrap.Alert(alertMessage);
      alert.close(); // Cierra la alerta de Bootstrap
    }, 3000); // 3 segundos
  }
});
