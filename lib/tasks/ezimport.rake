namespace :ezimport do
	
	desc "Imports all models defined in EzImport::Models"
	task :all => :environment do
		EzImport::Models.each do |model|
			EzImport.import(model)
		end
	end
	
	namespace :export do
		desc "Exports all models defined in EzImport::Models"
		task :all => :environment do
			EzImport::Models.each do |model|
				EzImport.export(model)
			end
		end
	end
	
end
