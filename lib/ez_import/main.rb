
module EzImport
  require 'hpricot'
  class Main

    @@models = []
    @@xmlpath = "db/ez_import"

    cattr_accessor :models
    cattr_accessor :xmlpath

    def self.export(model_name_original)
      model_name, model_obj = self.get_model(model_name_original)
      raise "Model '#{model_name_original}' not found" if model_obj.nil?
      unless File.directory?(@@xmlpath)
        Dir.mkdir(@@xmlpath)
        puts "create #{@@xmlpath}"
      end
      filepath = "#{@@xmlpath}/#{model_name.underscore.pluralize}.xml"
      File.open(filepath, 'w') {|f| f << model_obj.all.to_xml}
      puts "write     #{filepath}"
    end

    def self.get_model(model_name)
      model_name = model_name.downcase.gsub('_','')
      Dir.glob("#{Rails.root}/app/models/**/*rb").each{|m| require_or_load m }
      model_list = {}
      ActiveRecord::Base.subclasses.each {|m| model_list[m.to_s.downcase] = m}
      m1 = model_list[model_name].to_s.underscore
      m2 = model_list[model_name]
      [m1, m2]
    end

    def self.import(model_name_original)
      model_name, model = self.get_model(model_name_original)
      raise "Model '#{model_name_original}' not found" if model.nil?
      model.delete_all
      puts "\n"
      puts "Load #{model_name.pluralize}.xml"
      file_content = File.read("#{@@xmlpath}/#{model_name.pluralize}.xml")
      file_content.gsub!("&amp;", "&")
      count = 0
      Hpricot(file_content).search(model_name.gsub('_', '-')).each do |record|
        model.new do |new_instance|
          model.columns.each do |col|
            n = col.name.gsub('_', '-')
            eval('new_instance.' + col.name + " = (record/n).innerHTML")
          end
          new_instance.save( validate: false )
        end
        count += 1
      end
      puts "\t#{count} records loaded"
      if model.methods.include?(:after_ezimport)
        puts "Running #{model_name}.after_ezimport..."
        model.after_ezimport
      end
    end


  end

end