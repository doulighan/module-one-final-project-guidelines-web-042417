require 'bundler'
Bundler.require



ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

#ActiveRecord::Base.logger = old_logger