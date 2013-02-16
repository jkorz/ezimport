require "ez_import/version"
require "ez_import/main"
require "ez_import/railtie.rb"

module EzImport

  def models
    Main.models
  end

  def models=(m)
    Main.models = m
  end

  def xmlpath
    Main.xmlpath
  end

  def xmlpath=(p)
    Main.xmlpath = p
  end

end