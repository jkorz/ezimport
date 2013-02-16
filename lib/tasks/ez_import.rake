namespace :ez_import do

	desc "Imports all models defined in EzImport.models"
	task :all => :environment do
		EzImport::Main.models.each do |model|
			EzImport::Main.import(model)
		end
  end
end

namespace :ez_export do
  desc "Exports all models defined in EzImport.models"
  task :all => :environment do
    EzImport::Main.models.each do |model|
      EzImport::Main.export(model)
    end
  end
end
