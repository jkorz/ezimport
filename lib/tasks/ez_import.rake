desc "Exports a specific model or models to xml"
task :ez_export => :environment do
  ARGV.shift
  exported = false
  while name = ARGV.shift
    EzImport::Main.export(name)
    task name.to_sym do ; end
    exported = true
  end
  unless exported
    puts "Usage: \n rake ez_export model1 model2 model3 etc..."
  end
end

desc "Imports a specific model or models from saved xml"
task :ez_import => :environment do
  ARGV.shift
  imported = false
  while name = ARGV.shift
    EzImport::Main.import(name)
    task name.to_sym do ; end
    imported = true
  end
  unless imported
    puts "Usage: \n rake ez_import model1 model2 model3 etc..."
  end
end

namespace :ez_import do

	desc "Imports all models defined in config/initializers/ez_import.rb"
	task :all => :environment do
		EzImport::Main.models.each do |model|
			EzImport::Main.import(model)
		end
  end
end

namespace :ez_export do
  desc "Exports all models defined in config/initializers/ez_import.rb"
  task :all => :environment do
    EzImport::Main.models.each do |model|
      EzImport::Main.export(model)
    end
  end
end
