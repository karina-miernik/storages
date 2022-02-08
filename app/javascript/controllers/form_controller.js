import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("form controller connected")
  }

  close(){
   this.element.remove()
  }
}
