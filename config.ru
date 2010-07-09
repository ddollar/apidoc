BASE_PATH = File.dirname(__FILE__)

$:.unshift File.join(BASE_PATH, 'lib')

require "apidoc/server"

run APIDoc::Server.new(Dir[File.join(BASE_PATH, 'example', '*')])
