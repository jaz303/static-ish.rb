$:.unshift(File.dirname(__FILE__) + '/lib')

require 'lib/static_ish'

app = StaticIsh::Application.new
loader = app.create_page_loader

p loader.load('test.page')
