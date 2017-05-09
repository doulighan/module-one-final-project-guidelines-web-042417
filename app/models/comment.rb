
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :children,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id

  belongs_to :parent,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id

  def ancestors
    ancestors_array = []
    return ancestors_array if self.parent_id.nil?
    self.parent.ancestors + [self.parent]
  end

  def descendants
    return [] if self.children.empty?
    self.children + self.children.map { |child| child.all_descendants }
  end
end

# belongs_to :parent_comment

# def ancestors
#   ancestors_array = []
#   return ancestors_array if self.parent_id.nil?
#   ancestors_array.concat([self.parent] + [self.parent.ancestors])
# end
#
# def all_descendants
#   children_array = self.children
#   return [] if self.children.empty?
#   children_array.concat(children_array.map { |child| child.all_descendants } )
#
# end
# [c3] + [c3].children.map { |child| child.all_descendants}
# [c3] + ([c4] + [c4].children.map { |child| child.all_descendants})
# [c3] + [c4] + ([c5] + [c5].children.map { |child| child.all_descendants})
# [c3] + [c4] + [c5] + ([c6] + c6.children.map { |child| child.all_descendants})
# [c3] + [c4] + [c5] + [c6] + []

=begin
c2.all_descendants

children_array = [c3]
return [c3] if self.children == []
[c3].concat([c3].map { |child| c3.all_descendants })

[c3].concat(c3.all_descendants)

c3.all_descendants
children_array = [c4]
return [c4] if self.children == []
[c4].concat([c4].map { |child| c4.all_descendants })

[c4].concat(c4.all_descendants)

c4.all_descendants
children_array = [c5]
return [c5] if self.children == []
[c5].concat([c5].map { |child| c5.all_descendants })

[c5].concat(c5.all_descendants)

c5.all_descendants
children_array = [c6]
return [c6] if self.children == []
[c6].concat([c6].map { |child| c6.all_descendants })

return [c6]



=end


#
#  c6.ancestors
# [] + [c5] +  // "[c5.ancestors]" [c4] + "[c4.ancestors]" + [c3] + "[c3.ancestors]" + [c2] + "[c2.ancestors]" + [c1]
# + "[c1.ancestors]"=> ancestors_array = []
# [] + [c5] + [c4] + [c3] + [c2] + [c1]
>>>>>>> models
