require 'bundler'
require 'require_all'
require 'active_record'
require 'json'
require 'rest-client'
# require 'pry'

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

require_all 'app'
require_all 'config'
require_all 'bin'

