class MessageWrapper
  attr_reader :body,
              :created_at,
              :direction,
              :sender

  # rubocop:disable Metrics/ParameterLists
  def initialize(
    body:,
    created_at:,
    direction:,
    sender:
  )
    @body = body
    @created_at = created_at
    @direction = direction
    @sender = sender
  end
end
