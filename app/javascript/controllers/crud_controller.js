import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["id", "name", "records"]

  connect() {
    // Initial records are rendered by the server.
    // No need to fetch them again on connect.
  }

  loadRecords() {
    fetch("/crud", {
      headers: {
        "Accept": "application/json"
      }
    })
    .then(response => response.json())
    .then(data => {
      this.renderRecords(data)
    })
    .catch(error => console.error("Error loading records:", error));
  }

  renderRecords(data) {
    this.recordsTarget.innerHTML = ""
    data.forEach(record => {
      const rowHTML = `
        <tr>
          <td>${record.name}</td>
          <td>
            <button data-action="click->crud#edit" data-id="${record.id}" data-name="${record.name}">Edit</button>
            <button data-action="click->crud#destroy" data-id="${record.id}">Delete</button>
          </td>
        </tr>
      `
      this.recordsTarget.insertAdjacentHTML("beforeend", rowHTML)
    })
  }

  save(event) {
    event.preventDefault()
    const id = this.idTarget.value
    const name = this.nameTarget.value
    const url = id ? `/crud/${id}` : "/crud"
    const method = id ? "PATCH" : "POST"

    fetch(url, {
      method: method,
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        "Accept": "application/json"
      },
      body: JSON.stringify({ record: { name: name } })
    })
    .then(response => {
      if (response.ok) {
        return response.json()
      } else {
        throw new Error("Save operation failed.")
      }
    })
    .then(() => {
      this.loadRecords()
      this.idTarget.value = ""
      this.nameTarget.value = ""
    })
    .catch(error => console.error("Error saving record:", error));
  }

  edit(event) {
    event.preventDefault();
    this.idTarget.value = event.target.dataset.id
    this.nameTarget.value = event.target.dataset.name
  }

  destroy(event) {
    event.preventDefault();
    const id = event.target.dataset.id
    if (!confirm("Are you sure you want to delete this record?")) {
      return;
    }

    fetch(`/crud/${id}`, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token")
      }
    })
    .then(response => {
      if (response.ok) {
        this.loadRecords()
      } else {
        throw new Error("Delete operation failed.")
      }
    })
    .catch(error => console.error("Error deleting record:", error));
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element ? element.getAttribute("content") : null
  }
}
