import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hideBeforeRender(event) {
    console.log('shit')
    if (this.isOpen()) {
      event.preventDefault()
      this.element.addEventListener('hidden.bs.modal', event.detail.resume)
      this.modal.hide()
    }
  }

  isOpen() {
    console.log('shit')
    return this.element.classList.contains("show")
  }

  close() {
    this.element.remove()
  }

  closee() {
    if (event.keyCode == 27) {
      document
        .querySelectorAll('[data-toggle-name]')
        .forEach((target) => {
          target.classList.add('hidden')
        })
    }
  }

  toggle() {
    const targets = event.currentTarget.dataset.toggleTarget.split(",");

    targets.forEach((target) =>
      document
        .querySelectorAll(`[data-toggle-name="${target}"]`)
        .forEach((target) => target.classList.toggle('hidden'))
    );
  }
}
