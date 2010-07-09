require "apidoc"
require "apidoc/parser"
require "apidoc/writer"
require "thor"

class APIDoc::CLI < Thor

  method_option :output, :type => :string, :aliases => "-o"

  desc "generate", "Generate API documentation from source files"

  def generate(*files)
    error("No files specified.") if files.length.zero?

    output_dir = options[:output] || "doc/"

    docs = APIDoc::Parser.parse(files)
    require "pp"
    pp docs
    APIDoc::Writer.new(docs).write(output_dir)
  end

private ######################################################################

  def error(message)
    puts "ERROR: #{message}"
    exit 1
  end

end
