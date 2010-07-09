require "apidoc"

class APIDoc::Parser

  def self.parse(files)
    parser = self.new
    files.each { |file| parser.parse_file(file) }
    parser
  end

  attr_reader :docs

  def initialize
    @docs = []
    @section = "General"
  end

  def parse_file(file)
    File.read(file).split("\n").each do |line|
      case line.strip
        when /\A##\s*(.+)\Z/ then
          clear_comments
          parse_section($1)
        when /\A#(\s*.*)\Z/ then
          parse_comment($1)
        when /\A(get|post|put|delete)\s+"(.+)"/ then
          parse_method($1, $2)
        when '' then
        else
          clear_comments
      end
    end
  end

private ######################################################################

  def clear_comments
    @comments = []
  end

  def parse_section(section)
    @section = section.gsub("#", "").strip
  end

  def parse_comment(comment)
    @comments << comment
  end

  def parse_comments(comments)
    key = :description
    
    comments.inject({}) do |parsed, comment|
      case comment
        when /\A\s*@param\s+(.+?)\s+(.+)/ then
          parsed[:params] ||= []
          required = $1[0..0] == '<'
          name = $1[1..-2]
          parsed[:params] << { :name => name, :description => $2, :required => required }
        when /\A\s*@(\w+)\s*(.*)\Z/ then
          key = $1.to_sym
          parsed[key] ||= []
          parsed[key]  << $2 if $2
        else
          parsed[key] ||= []
          parsed[key]  << comment
      end
      parsed
    end.inject({}) do |flattened, (k, v)|
      case v.first
        when String then
          flattened[k] = strip_left(v.reject { |l| l.strip == "" }.join("\n"))
        else
          flattened[k] = v
      end
      flattened
    end
  end

  def parse_method(verb, uri)
    @docs << {
      :section => @section,
      :verb => verb,
      :uri  => uri,
    }.merge(parse_comments(@comments))

    clear_comments
  end

  def strip_left(code)
    first_line = code.split("\n").first
    num_spaces = first_line.match(/\A */)[0].length
    code.split("\n").map do |line|
      line[num_spaces..-1]
    end.join("\n")
  end

end
