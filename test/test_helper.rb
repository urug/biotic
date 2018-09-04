# frozen_string_literal: true

require 'bundler'
Bundler.require(:test)
require 'minitest/autorun'
require 'minitest/spec'

Dir['./lib/*.rb'].each { |file| require file }
