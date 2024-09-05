import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]
  connect() {
    console.log("conectado")
    this.containerTarget.scrollIntoView({behavior: "smooth"});
  }

}
