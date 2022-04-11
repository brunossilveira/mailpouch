import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hint", "username"]

  showHint() {
    const username = this.usernameTarget.value

    this.hintTarget.innerHTML = "Your newsletters address: " + username + "@inbox.mailpouch.app"
  }
}
