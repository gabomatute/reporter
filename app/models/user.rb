class User < ActiveRecord::Base
  establish_connection ENV['REPORTER_USERS_DB']
  self.table_name = ENV['REPORTER_USERS_TABLE']

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable, :timeoutable
end
