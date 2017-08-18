(function() {
  var userId = parseInt(
    window.location.pathname.replace('/admin_refactor/users/', ''),
    10
  )

  var state = {
    messages: []
  }

  $(document).ready(function() {
    alert('HI')
    startFetchingMessages()

    $(".is-sendingMessage").click(function(event) {
      sendMessage()
    })
  })

  function scrollToBottom() {
    $(".messaging-history").scrollTop($(".messaging-history")[0].scrollHeight)
  }

  function sendMessage() {
    $.ajax({
      url: '/api/v2/messages/',
      method: 'POST',
      data: {
        user_id: userId,
        body: $('.messaging-textArea').val()
      }
    }).done(function () {
      fetchMessages()
      clearMessageInput()
    })
  }

  function clearMessageInput() {
    $('.messaging-textArea').val('')
  }

  function formatDate(date) {
    return date
  }

  function renderMessage(message) {
    $(".messages-container").append(
      "<li class='clearfix'> \
        <div class='message-data messageDirection-from--" + message.sender + "'> \
          <span class='message-data-name'> \
            " + message.sender + " \
          </span> \
          <span class='message-data-time'> \
            " + formatDate(message.created_at) + " \
          </span> \
        </div> \
        <div class='message-bubble messageBubble-from--" + message.sender + "'> \
          " + message.body + " \
        </div> \
      </li>"
    )
  }

  function renderMessages(messages) {
    $(".messages-container").empty()
    messages.forEach(renderMessage)
  }

function fetchMessages() {
    console.log('HI')
    $.ajax({
      url: "/chat/all_messages/",
      method: 'GET',
      data: {}
    }).done(function(response) {
      alert('DONE.')
      renderMessages(response.messages.data)
    })
  }

  function startFetchingMessages() {
    setInterval(fetchMessages, 1000)
  }
}())
;
