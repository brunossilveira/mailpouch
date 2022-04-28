import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
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
