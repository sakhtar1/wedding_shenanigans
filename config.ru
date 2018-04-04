require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::Static, :root => 'public', :urls => ['/images', '/stylesheets']

use Rack::MethodOverride
use UsersController
use ListsController
run ApplicationController
