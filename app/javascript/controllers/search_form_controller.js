import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-form"
export default class extends Controller {
  connect() {
    console.log('controller connected: ', this.element)
  }

  submit() {
    this.element.submit()
  }
}
