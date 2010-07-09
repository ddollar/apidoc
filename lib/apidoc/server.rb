require "apidoc"
require "apidoc/parser"
require "sinatra"

class APIDoc::Server < Sinatra::Application

  def initialize(files)
    set :docs,     APIDoc::Parser.parse(files).docs
    set :sections, sections_in(settings.docs)
    super()
  end

  get "/" do
    haml :index, :locals => { 
      :docs     => settings.docs,
      :sections => settings.sections
    }
  end

  get "/docs.css" do
    content_type "text/css"
    sass :docs
  end

  get "/:section" do |section|
    haml :section, :locals => { 
      :docs     => docs_in_section(settings.docs, section), 
      :sections => settings.sections,
      :section  => settings.sections.detect { |s| urlize_section(s) == section }
    }
  end

  helpers do

    include Rack::Utils

    def code(code)
      Haml::Filters::Preserve.render(Haml::Filters::Escaped.render(code))
    end

    def doc(page, title)
      active = (env["PATH_INFO"] == "/#{page}") ? "active" : ""
      %{ <li class="#{active}"><a href="/#{page}">#{title}</a></li> }
    end

    def docs_in_section(docs, section)
      docs.select { |doc| urlize_section(doc[:section]) == section }
    end

    def sections_in(docs)
      docs.map { |doc| doc[:section] }.uniq.compact
    end

    def urlize_section(section)
      section.downcase.gsub(" ", "_")
    end

  end

end
