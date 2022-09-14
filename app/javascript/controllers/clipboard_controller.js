import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

export default class extends Controller {
  static targets = ["source", "copy", "copied"]

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.innerHTML)

    this.copiedTarget.classList.remove('hidden')
    this.copyTarget.classList.add('hidden')

    leave(this.copyTarget)
    enter(this.copiedTarget)

    setTimeout(() => {
      this.copiedTarget.classList.add('hidden')
      this.copyTarget.classList.remove('hidden')

      enter(this.copyTarget)
      leave(this.copiedTarget)

    }, 2000);
  }
}
