import { Controller } from "stimulus"
var authenticity_token = $('[name="csrf-token"]')[0].content

export default class extends Controller {
  static targets = ["searchTerm", "searchField", "searchResults", "friendsList", "friend", "foundFriends", "addedFriends", "expertId"]

  connect() {
    self = this
    console.log("Hello, Stimulus!", self.element)
    self.targets.addedFriends = []
    self.targets.foundFriends = []
  }

  searchToAdd() {
    self.searchResultsTarget.innerHTML = `<div class="alert alert-info">Loading...</div>`
    fetch(`/experts/${self.expertIdTarget.value}/friend_search?term=${self.searchTermTarget.value}&field=name`)
    .then(response => response.json())
    .then(json => {
      self.targets.foundFriends = json
      self.updateFoundFriendList()
    })
  }

  addFriend() {
    const friend_id = event.currentTarget.getAttribute("value")
    fetch(`/experts/${self.expertIdTarget.value}/add_friend`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({friend_id: friend_id, authenticity_token: authenticity_token}),
    })
    .then((response) => response.json())
    .then((json) => {
      addFriendTemplate(json)
      self.targets.foundFriends = self.targets.foundFriends.filter(function( friend ) {
        return friend.id !== json.id;
      });
      self.targets.addedFriends.push(json)
      self.updateFoundFriendList()
      self.updateAddedFriendList()
    })
  }

  updateFoundFriendList() {
    if (!self.targets.foundFriends.length) {
      self.searchResultsTarget.innerHTML = `<div class="alert alert-info">None Found</div>`
      return
    }
    let foundFriendHtml = ""
    self.targets.foundFriends.forEach((friend) => {
      foundFriendHtml += searchFriendTemplate(friend)
    })
    self.searchResultsTarget.innerHTML = foundFriendHtml;
  }

  updateAddedFriendList() {
    if (!self.targets.addedFriends.length) {
      return
    }
    let addedFriendHtml = ""
    self.targets.addedFriends.forEach((friend) => {
      addedFriendHtml += addFriendTemplate(friend)
    })
    self.friendsListTarget.innerHTML = addedFriendHtml;
  }
}



function searchFriendTemplate(friend) {
  console.log(friend.name)
  return `
    <li class="list-group-item">
      <a class="btn btn-secondary btn-sm text-light" data-target="experts.friend" data-action="click->experts#addFriend" value="${friend.id}">Add ${friend.name}</a>
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