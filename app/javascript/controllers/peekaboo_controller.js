import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sticky", "button"]

  onScroll(event) {
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 200) {
      console.log(this.buttonTarget)
      this.buttonTarget.classList.remove('bottom-20')
    } else {
      this.buttonTarget.classList.add('bottom-20')
    }

    if(window.pageYOffset > 0) {
      this.stickyTarget.classList.add('block')
      this.stickyTarget.classList.remove('hidden')
    } else {
      this.stickyTarget.classList.add('hidden')
      this.stickyTarget.classList.remove('block')
    }
  }
}
