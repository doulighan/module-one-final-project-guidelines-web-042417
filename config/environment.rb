require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
<<<<<<< HEAD
require_all 'config'
=======
>>>>>>> e4680c39be322d2bd817c2c617528d048e84613b
