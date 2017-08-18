class User < ActiveRecord::Base
  attr_writer :current_step
  has_many :messages
  
  def steps
    %w[enter_email, enter_friend, chat_together]
  end

  def current_step
    @current_step ||= steps.first
  end

  def next_step
    self.current_step = steps[steps.index(current_step) + 1]
  end
end