require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')


task :copy_upstream_spec do
  puts 'copying upstream spec'
  source_dir = Gem.loaded_specs['cashier'].full_gem_path + '/spec/lib'
  dst_dir = './spec/upstream_spec'

  FileUtils.rm_r dst_dir
  FileUtils.cp_r source_dir, dst_dir
end

task :spec => :copy_upstream_spec
task :default => :spec