require 'rake/testtask'

project_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

lib_directories = FileList.new do |fl|
  fl.include "#{project_root}/lib"
  fl.include "#{project_root}/test/lib"
end
 
test_files = FileList.new do |fl|
  fl.include "#{project_root}/test/**/*_test.rb"
  fl.exclude "#{project_root}/test/test_helper.rb"
  fl.exclude "#{project_root}/test/lib/**/*.rb"
end

Rake::TestTask.new(:test) do |t|
  t.libs = lib_directories
  t.test_files = test_files
  t.verbose = true
end
