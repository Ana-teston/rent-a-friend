import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {

  static targets = [ "startTime", "endTime" ]

  connect() {
    console.log(this.startTimeTarget, this.endTimeTarget)
    flatpickr(this.startTimeTarget, {
      minDate: "today",
    })
    flatpickr(this.endTimeTarget, {
      minDate: new Date().fp_incr(1),
    })
  }
}
