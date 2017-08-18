class MessageSerializer
  include JSONAPI::Serializer

  attribute :body
  attribute :sender

  attribute :created_at do
    object.created_at.strftime('%b %e, %l:%M %p')
  end

  attribute :direction do
    object.direction
  end
end
