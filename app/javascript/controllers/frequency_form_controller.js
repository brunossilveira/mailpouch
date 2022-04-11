import { Controller } from "@hotwired/stimulus"
import { useDebounce } from 'stimulus-use'

export default class extends Controller {
  static targets = ["period", "onText", "icon"]
  static debounces = ["save"]

  connect() {
    this.updateForm()
    useDebounce(this, { wait: 500 })
  }

  save() {
    this.element.submit()

    this.iconTarget.classList.add('opacity-100');
    this.iconTarget.classList.remove('opacity-0');
    setTimeout(() => {
      this.iconTarget.classList.add('opacity-0')
      this.iconTarget.classList.remove('opacity-100')
    }, 2000);
  }

  updateForm() {
    if (this.periodTarget.value == "weekly") {
      this.onTextTarget.classList.remove('hidden')
    } else {
      this.onTextTarget.classList.add('hidden')
    }
  }
}
