document.addEventListener("turbo:load", function() {
  // Selecciona todos los elementos de alerta
  var noticeMessage = document.getElementById("notice-message");
  var alertMessage = document.getElementById("alert-message");
  var errorMessage = document.getElementById("error-message");

  // Función para cerrar la alerta
  function closeAlert(alertElement) {
    if (alertElement) {
      setTimeout(function() {
        var alert = new bootstrap.Alert(alertElement);
        alert.close();
      }, 3000); // 3 segundos
    }
  }

  // Cierra las alertas de manera unificada
  closeAlert(noticeMessage);
  closeAlert(alertMessage);
  closeAlert(errorMessage);
});