import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hint", "username", "domain", "xunda"]

  showHint() {
    const username = this.usernameTarget.value
    const domain = this.domainTarget.innerHTML

    this.hintTarget.innerHTML = "Your newsletters address: " + username + "@" + domain
  }
}
