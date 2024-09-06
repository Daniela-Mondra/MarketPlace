import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]
  connect() {
    console.log("conectado")
    console.log(this.element)
    const shouldScroll = this.element.dataset.scroll === "true";
    if (shouldScroll)
      { this.element.scrollIntoView({ behavior: 'smooth' }); }
  }
}
