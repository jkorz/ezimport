require "ez_import/version"
require "ez_import/main"
require "ez_import/railtie.rb"

module EzImport

  def self.models
    Main.models
  end

  def self.models=(m)
    Main.models = m
  end

  def self.xmlpath
    Main.xmlpath
  end

  def self.xmlpath=(p)
    Main.xmlpath = p
  end

end