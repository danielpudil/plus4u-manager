require 'bundler/cli'
Bundler::CLI.start(['install'])
Bundler.reset!
Bundler.setup

require 'rack'

Rack::Server.start(config: "#{File.dirname(__FILE__)}/config.ru", Port: 6221, Host: '0.0.0.0')


