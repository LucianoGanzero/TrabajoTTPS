// controllers/search_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.timeout = null;
  }

  search(event) {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.element.requestSubmit(); // Envía el formulario automáticamente
    }, 300); // Retraso de 300ms para no enviar cada vez que se escribe
  }
}
