# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string
#  created_at :datetime
#  updated_at :datetime
#


class User < ActiveRecord::Base

  has_many :posts
  has_many :comments

end
