import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    const targets = event.currentTarget.dataset.toggleTarget.split(",");

    targets.forEach((target) =>
      document
        .querySelectorAll(`[data-toggle-name="${target}"]`)
        .forEach((target) => target.classList.toggle('hidden'))
    );
  }
}
