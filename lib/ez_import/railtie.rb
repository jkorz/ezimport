require 'ez_import'
require 'rails'
module EzImport
  class Railtie < Rails::Railtie
    railtie_name :ezimport

    rake_tasks do
      load "tasks/my_plugin.rake"
    end
  end
end