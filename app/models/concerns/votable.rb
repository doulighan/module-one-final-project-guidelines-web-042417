module Votable

  def upvote
    self.popularity += 1
  end

  def downvote
    self.popularity -= 1
  end

end
