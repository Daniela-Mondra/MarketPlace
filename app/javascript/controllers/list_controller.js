import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]
  connect() {
    this.containerTarget.scrollIntoView({behavior: "smooth"});
  }

}
