import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]

  initialize() {
    this.resize()
  }

  resize() {
    const value = this.selectTarget.value
    var s = document.createElement('span');
    s.textContent = value

    document.body.appendChild(s);

    this.selectTarget.style.width = s.offsetWidth + "px"

    document.body.removeChild(s);
  }
}
