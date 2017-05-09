alex = User.new(username: "Alex", id: 1)
devin = User.new(username: "Devin", id: 2)

post = Post.new(title: "greeting", body: "hello world", user_id: 1)
repl = Comment.new(body: "shut up", user_id: 2, post_id: 1)
repl2 = Comment.new(body: "hello to you, too", user_id: 1, post_id: 1, id: 1)
repl3 = Comment.new(body: "Yo", parent_id: 1, user_id: 2)
