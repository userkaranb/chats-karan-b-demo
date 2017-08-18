(function() {
  $(document).ready(function() {
    startFetchingMessages()

    $(".is-sendingMessage").click(function(event) {
      sendMessage()
    })
  })

  function sendMessage() {
    $.ajax({
      url: '/message',
      method: 'POST',
      data: {
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

  function renderMessage(message) {
    $(".messages-container").append(
      "<li> \
        <div> \
          <span> \
            " + message.sender + " \
          </span> \
          <span> \
            " + message.created_at + " \
          </span> \
        </div> \
        <div> \
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
    $.ajax({
      url: "/message",
      method: 'GET',
      data: {}
    }).done(function(response) {
      renderMessages(response)
    })
  }

  function startFetchingMessages() {
    setInterval(fetchMessages, 1000)
  }
}())