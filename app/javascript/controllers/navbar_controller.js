import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu", "content"];
  isOpen = false;

  connect() {
    console.log("asdsad");
    document.addEventListener("keydown", this.handleEscape);
    document.addEventListener("click", this.handleClickOutside);
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleEscape);
    document.removeEventListener("click", this.handleClickOutside);
  }

  openMenu(event) {
    event.stopPropagation();

    this.menuTarget.classList.remove("hidden");

    setTimeout(() => {
      this.contentTarget.classList.remove(
        "opacity-0",
        "translate-y-[50px]",
        "scale-95"
      );
      this.contentTarget.classList.add(
        "opacity-100",
        "translate-y-0",
        "scale-100"
      );
    }, 10);
  }

  handleEscape = (event) => {
    if (event.key === "Escape") this.closeMenu();
  };

  handleClickOutside = (event) => {
    console.log(event.target);
    console.log("menu target", this.menuTarget);
    if (!this.contentTarget.contains(event.target)) {
      console.log(close);
      this.closeMenu();
    }
  };

  closeMenu() {
    this.contentTarget.classList.add(
      "opacity-0",
      "translate-y-[50px]",
      "scale-95"
    );
    this.contentTarget.classList.remove(
      "opacity-100",
      "translate-y-0",
      "scale-100"
    );
    setTimeout(() => {
      this.menuTarget.classList.add("hidden");
    }, 200);
  }
}
