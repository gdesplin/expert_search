import { Controller } from "stimulus"
var authenticity_token = $('[name="csrf-token"]')[0].content

export default class extends Controller {
  static targets = ["searchTerm", "searchField", "searchResults", "friend", "friends", "expertId"]

  connect() {
    console.log("Hello, Stimulus!", this.element)
    console.log(authenticity_token)
  }

  searchToAdd() {
    this.searchResultsTarget.innerHTML =`<li>Loading</li>`
    fetch(`/experts.json?term=${this.searchTermTarget.value}&field=name`)
    .then(response => response.json())
    .then(json => {
      let searchResultsHtml = ""
      json.forEach((friend) => {
        searchResultsHtml += searchFriendTemplate(friend)
      })
      this.searchResultsTarget.innerHTML = searchResultsHtml;
    })
  }

  addFriend() {
    const friend_id = event.currentTarget.getAttribute("value")
    fetch(`/experts/${this.expertIdTarget.value}/add_friend`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({friend_id: friend_id, authenticity_token: authenticity_token}),
    })
    .then((response) => response.json())
    .then((data) => {
      console.log('Success:', data);
      addFriendTemplate(data)
    })
  }
}

function searchFriendTemplate(friend) {
  console.log(friend.name)
  return `
    <li class="list-group-item">
      <a class="btn btn-secondary" data-target="experts.friend" data-action="click->experts#addFriend" value="${friend.id}">Add ${friend.name}</a>
    </li>
  `
}

function addFriendTemplate(friend) {
  return `
    <li class="list-group-item">
      ${friend.name}
    </li>
  `
}