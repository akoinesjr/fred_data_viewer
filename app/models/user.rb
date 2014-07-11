class User < ActiveRecord::Base
  has_many :user_datasets
  has_many :datasets, :through => :user_datasets
    # users.password_hash in the database is a :string
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  #TODO : Use bcrypt to store hashed passwords and authenticate users
end
