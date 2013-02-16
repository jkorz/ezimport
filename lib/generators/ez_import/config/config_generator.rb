module EzImport

  module Generators
    class ConfigGenerator < Rails::Generators::Base
      argument :models, :type => :array, :default => [], :banner => "ModelName1 ModelName2 etc..."

      desc "Creates an initializer for EzImport at /config/initializers/ez_import.rb"

      def self.source_root
        File.expand_path("../templates", __FILE__)
      end

      def create_initializer_file
        unless models.empty?
          @models = models.to_s
        end
        template 'initializer.rb.erb', File.join('config', 'initializers', 'ez_import.rb')
      end

    end
  end
end