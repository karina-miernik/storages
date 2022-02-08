import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("form controller connected")
  }

  close(){
    this.element.style.transition = "opacity "+0.5+"s ease";
    this.element.style.opacity=0;
      setTimeout(()=>{
        this.element.remove()
      },1000)
  }
}
