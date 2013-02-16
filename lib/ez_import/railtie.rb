require 'ez_import'
require 'rails'
module EzImport
  class Railtie < Rails::Railtie
    railtie_name :ezimport

    rake_tasks do
      load "tasks/ez_import.rake"
    end
  end
end