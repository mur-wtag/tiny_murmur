import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: Number, murmurId: Number, liked: Boolean }
  static targets = ["button", "count"]

  toggle(event) {
    event.preventDefault()

	  const url = this.likedValue
		  ? `/api/murmurs/${this.murmurIdValue}/likes/${this.idValue}`
		  : `/api/murmurs/${this.murmurIdValue}/likes`
    const method = this.likedValue ? "DELETE" : "POST"

    fetch(url, {
      method: method,
      headers: { "X-CSRF-Token": this.getMetaValue("csrf-token") }
    })
    .then(res => res.json())
    .then(data => {
      if (data.success) {
	      this.likedValue = !this.likedValue
	      this.countTarget.textContent = data.likes_count
	      if (data.like_id) this.idValue = data.like_id
	      this.updateButton()
      } else {
				console.log("You are not able to like your own murmur!")
      }
    })
  }

  updateButton() {
    if (this.hasButtonTarget) {
      this.buttonTarget.classList.toggle("btn-error", this.likedValue)
      this.buttonTarget.classList.toggle("btn-outline", !this.likedValue)
    }
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element?.getAttribute("content") || ""
  }
}
