require 'rubygems'
require 'rack'

$:.unshift(File.dirname(__FILE__) + '/lib')
require 'static_ish'

site = StaticIsh::Site.new('test-site')
puts "test site started: #{site.root}"

builder = Rack::Builder.new do
  run StaticIsh::Application.new(site)
end

Rack::Handler::Mongrel.run builder, :Port => 4000
