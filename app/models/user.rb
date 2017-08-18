class User < ActiveRecord::Base
  has_many :messages
  validate :username_not_empty

  private

  def username_not_empty
  	binding.pry
  	not username.nil? and not username.empty?
  end
end