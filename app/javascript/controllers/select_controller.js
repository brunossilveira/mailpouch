import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["options", "selected"]

  handleSelect(event) {
    this.optionsTarget.classList.toggle('hidden')
  }

  submit(event) {
    this.selectedTarget.innerHTML = event.target.innerHTML
    this.optionsTarget.classList.toggle('hidden')
  }
}
