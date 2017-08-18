class MockTestItems
  class << self
    def user1(id = 1, username = 'abc')
      User.new(id: id, username: username)
    end

    def user2(id = 2, username = 'def')
      User.new(id: id, username: username)
    end

    def user3(id = 3, username='fgh')
      User.new(id: id, username: username)
    end

    def example_messages
      messages = []
      messages.append(Message.create(user_id: 1, to_id: 2, body: 'Hello user 2, its user 1'))
      messages.append(Message.create(user_id: 2, to_id: 1, body: 'Hello user 1, its user 2. Good morning.'))
      messages.append(Message.create(user_id: 1, to_id: 3, body: 'Hello user 3, its user 1'))
      messages.append(Message.create(user_id: 2, to_id: 3, body: 'Hello user 3, its user 2'))
      messages.append(Message.create(user_id: 3, to_id: 2, body: 'Hello user 2. Good Morning.'))
      messages.append(Message.create(user_id: 1, to_id: 2, body: 'Good Morning to you too.'))
      messages.append(Message.create(user_id: 1, to_id: 1, body: 'Note to self: Buy Groceries.'))
      messages
    end
  end
end

