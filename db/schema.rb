# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 6) do

  create_table "comments", primary_key: "comment_id", id: :text, force: :cascade do |t|
    t.string "parent_id"
    t.string "post_id"
    t.string "body"
    t.string "author"
    t.integer "score"
    t.index ["author"], name: "index_comments_on_author"
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["comment_id"], name: "sqlite_autoindex_comments_1", unique: true
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["score"], name: "index_comments_on_score"
  end

  create_table "posts", primary_key: "post_id", id: :text, force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "subreddit_id"
    t.index ["author"], name: "index_posts_on_author"
    t.index ["post_id"], name: "index_posts_on_post_id"
    t.index ["post_id"], name: "sqlite_autoindex_posts_1", unique: true
    t.index ["score"], name: "index_posts_on_score"
  end

  create_table "subreddit", id: false, force: :cascade do |t|
    t.text "subreddit_id"
    t.text "title"
  end

end
