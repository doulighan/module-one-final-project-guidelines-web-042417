# == Schema Information
#
# Table name: posts
#
#  post_id    :text             not null, primary key
#  title      :string
#  body       :string
#  author     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base

  has_many :comments,
  class_name: "Comment",
  foreign_key: :post_id




end
