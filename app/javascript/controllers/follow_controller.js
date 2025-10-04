import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static values = { followedId: Number, following: Boolean }
	static targets = ["button", "count"]

	connect() {
		this.updateButton()
	}

	toggle(event) {
		event.preventDefault()

		const url = `/api/users/${this.followedIdValue}/follows`
		const method = this.followingValue ? "DELETE" : "POST"

		fetch(url, {
			method: method,
			headers: { "X-CSRF-Token": this.getMetaValue("csrf-token") }
		})
			.then(res => res.json())
			.then(data => {
				if (data.success) {
					this.followingValue = !this.followingValue
					this.countTarget.textContent = data.follower_count

          this.updateButton();
				} else {
					console.log("You are not allowed to follow yourself!")
				}
			})
	}

	updateButton() {
		if (this.hasButtonTarget) {
			this.buttonTarget.textContent = this.followingValue ? "Unfollow" : "Follow"
			this.buttonTarget.classList.toggle("btn-outline", !this.followingValue)
			this.buttonTarget.classList.toggle("btn-error", this.followingValue)
		}
	}

	getMetaValue(name) {
		const element = document.head.querySelector(`meta[name="${name}"]`)
		return element?.getAttribute("content") || ""
	}
}
