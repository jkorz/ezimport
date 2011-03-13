module EzImport
	
	def self.export(model_name)
		model = eval(model_name)
		File.open("db/seed_data/#{model.underscore.pluralize}.xml", 'w') {|f| f << model.all.to_xml}
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
		Hpricot(File.read("db/seed_data/#{model_name.pluralize}.xml")).search(model_name.gsub('_', '-')).each do |record|
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