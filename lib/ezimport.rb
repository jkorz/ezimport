module EzImport
	
	Models = []
	XMLPath = "db/ezimport"
	
	def self.export(model_name)
		model_name, model = self.get_model(model_name)
		unless File.directory?(XMLPath)
			Dir.mkdir(XMLPath)
			puts "create #{XMLPath}"
		end
		filepath = "#{XMLPath}/#{model_name.underscore.pluralize}.xml"
		File.open(filepath, 'w') {|f| f << model.all.to_xml}
		puts "write     #{filepath}"
	end
	
	def self.get_model(model_name)
		Dir.glob("#{RAILS_ROOT}/app/models/**/*rb").each{|m| require_or_load m }
		models = {}
		ActiveRecord::Base.subclasses.each {|m| models[m.to_s.downcase] = m}
		[models[model_name.downcase].to_s.underscore, models[model_name.downcase]]
	end
	
	def self.import(model_name)
		model_name, model = self.get_model(model_name)
		model.delete_all
		puts "\n\n"
		puts "Load #{model_name.pluralize}.xml"
		Hpricot(File.read("#{XMLPath}/#{model_name.pluralize}.xml")).search(model_name.gsub('_', '-')).each do |record|
			model.new do |new_instance|
				model.columns.each do |col|
					n = col.name.gsub('_', '-')
					eval('new_instance.' + col.name + " = (record/n).innerHTML")
				end
				new_instance.save
			end
			puts "Added #{model_name}: #{(record/:name).innerHTML}" unless (record/:name).innerHTML.blank?
		end
	end
	

end
