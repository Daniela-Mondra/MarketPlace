// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = ["item", "container"]

//   connect() {
//     this.initializeCarousel()
//   }

//   initializeCarousel() {
//     const items = this.itemTargets
//     const minPerSlide = 3

//     items.forEach((el) => {
//       let next = el.nextElementSibling
//       for (let i = 1; i < minPerSlide; i++) {
//         if (!next) {
//           next = items[0]
//         }
//         let cloneChild = next.cloneNode(true)
//         el.appendChild(cloneChild.children[0])
//         next = next.nextElementSibling
//       }
//     })
//   }

//   previous() {
//     this.containerTarget.carousel('prev')
//   }

//   next() {
//     this.containerTarget.carousel('next')
//   }
// }
// app/javascript/controllers/carousel_controller.js
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
    if (this.scrollPosition < this.carouselWidth - this.cardWidth * 4) {
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
