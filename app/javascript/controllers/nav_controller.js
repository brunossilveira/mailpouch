import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["profile", "mobile", "button"]

  toggleProfile(event) {
    this.profileTarget.classList.toggle('hidden')
  }

  toggleMobile() {
    this.buttonTargets.forEach((element) => {
      element.classList.toggle('hidden')
    })
    this.mobileTarget.classList.toggle('hidden')
  }

  hideElement() {
   // this.profileTarget.classList.add('hidden')
  }
}

