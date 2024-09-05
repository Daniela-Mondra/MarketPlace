import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.carouselElement = this.containerTarget
    this.carouselWidth = this.carouselElement.querySelector(".carousel-inner").scrollWidth
    this.cardWidth = this.carouselElement.querySelector(".carousel-item").offsetWidth
    this.scrollPosition = 0
  }

  scrollNext() {
    if (this.scrollPosition < this.carouselWidth - this.cardWidth * 3) {
      this.scrollPosition += this.cardWidth
      this.carouselElement.querySelector(".carousel-inner").scroll({
        left: this.scrollPosition,
        behavior: "smooth"
      })
    }
  }

  scrollPrev() {
    if (this.scrollPosition > 0) {
      this.scrollPosition -= this.cardWidth
      this.carouselElement.querySelector(".carousel-inner").scroll({
        left: this.scrollPosition,
        behavior: "smooth"
      })
    }
  }
}
