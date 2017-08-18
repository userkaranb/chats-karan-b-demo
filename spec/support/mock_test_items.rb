class MockTestItems
  class << self
    def user1(id = 1, username1 = 'abc')
      User.new(id: 1, username: username1)
    end

    def user2(id = 2, username2 = 'def')
      User.new(id: 2, username: username2)
    end
  end
end

