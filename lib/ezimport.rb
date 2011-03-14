class EzImport
	
	@@models = []
	@@xmlpath = "db/ezimport"
	
	cattr_accessor :models
	cattr_accessor :xmlpath
	
	def self.export(model_name)
		model_name, model_obj = self.get_model(model_name)
		unless File.directory?(@@xmlpath)
			Dir.mkdir(@@xmlpath)
			puts "create #{@@xmlpath}"
		end
		filepath = "#{@@xmlpath}/#{model_name.underscore.pluralize}.xml"
		File.open(filepath, 'w') {|f| f << model_obj.all.to_xml}
		puts "write     #{filepath}"
	end
	
	def self.get_model(model_name)
		Dir.glob("#{RAILS_ROOT}/app/models/**/*rb").each{|m| require_or_load m }
		model_list = {}
		ActiveRecord::Base.subclasses.each {|m| model_list[m.to_s.downcase] = m}
		[model_list[model_name.downcase].to_s.underscore, model_list[model_name.downcase]]
	end
	
	def self.import(model_name)
		model_name, model = self.get_model(model_name)
		model.delete_all
		puts "\n\n"
		puts "Load #{model_name.pluralize}.xml"
		file_content = File.read("#{@@xmlpath}/#{model_name.pluralize}.xml")
		file_content.gsub!("&amp;", "&")
		Hpricot(file_content).search(model_name.gsub('_', '-')).each do |record|
			model.new do |new_instance|
				model.columns.each do |col|
					n = col.name.gsub('_', '-')
					eval('new_instance.' + col.name + " = (record/n).innerHTML")
				end
				new_instance.save
			end
			puts "Added #{model_name}: #{(record/:name).innerHTML}" unless (record/:name).innerHTML.blank?
		end
		if model.methods.include?(:after_ezimport)
			puts "Running #{model_name}.after_ezimport..."
			model.after_ezimport
		end
	end
	

end
