require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task :copy_upstream_spec do
  source_dir = Gem.loaded_specs['cashier'].full_gem_path + '/spec/lib'
  dst_dir = './spec/upstream_spec'

  FileUtils.ln_s source_dir, dst_dir, :force => true
end

task :spec => :copy_upstream_spec
task :default => :spec