import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "text"]

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.innerHTML)
    this.textTarget.innerHTML = 'Copied!'

    setTimeout(() => {
      this.textTarget.innerHTML = 'Copy'
    }, 2000);
  }
}
