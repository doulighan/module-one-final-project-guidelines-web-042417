class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :children,
    class_name: "Comment",
    foreign_key: :parent_id

  belongs_to :parent,
    class_name: "Comment",
    foreign_key: :parent_id
  # belongs_to :parent_comment

  # def ancestors
  #   ancestors_array = []
  #   return ancestors_array if self.parent_id.nil?
  #   ancestors_array.concat([self.parent] + [self.parent.ancestors])
  # end

  def ancestors
    ancestors_array = []
    return ancestors_array if self.parent_id.nil?
    self.parent.ancestors + [self.parent]
  end

  def all_descendants

  end

 #
 #  c6.ancestors
 # [] + [c5] +  // "[c5.ancestors]" [c4] + "[c4.ancestors]" + [c3] + "[c3.ancestors]" + [c2] + "[c2.ancestors]" + [c1]
 # + "[c1.ancestors]"=> ancestors_array = []
 # [] + [c5] + [c4] + [c3] + [c2] + [c1]






end
