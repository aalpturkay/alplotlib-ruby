import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["box"];

  connect() {
    this.timeout = setTimeout(() => {
      this.hide();
    }, 3000);

    document.addEventListener("keydown", this.onKeydown);
  }

  disconnect() {
    clearTimeout(this.timeout);
    document.removeEventListener("keydown", this.onKeydown);
  }

  hide() {
    this.boxTarget.classList.add("opacity-0", "-translate-y-4");
    setTimeout(() => {
      this.boxTarget.remove();
    }, 300);
  }

  onKeydown = (event) => {
    if (event.key === "Escape") {
      this.hide();
    }
  };
}
