#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'rake/testtask'

Rake::TestTask.new do |t|
 t.libs << 'test'
end

desc "Run tests"
task :default => :spec

RSpec::Core::RakeTask.new('spec')
