require 'rubygems'
require 'bundler/setup'
require 'ruby2d'

WIDTH  = 960
HEIGHT = 720

set title: 'Music', width: WIDTH, height: HEIGHT

music = Music.new('music.mp3')
music.play

on :mouse_down do |e|
  puts 'Mouse down key event'
  music.play
end

show
