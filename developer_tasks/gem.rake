namespace :gem do
  begin
    require 'jeweler'
    Jeweler::Tasks.new do |gemspec|
      gemspec.name = "xebec"
      gemspec.summary = "Navigation helpers"
      gemspec.description = "Helpers for generating navigation bars"
      gemspec.email = "james.a.rosen@gmail.com"
      gemspec.homepage = "http://github.com/jamesarosen/xebec"
      gemspec.authors = ["James Rosen"]
      gemspec.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Xebec Documentation", "--charset", "utf-8"]
      gemspec.platform = Gem::Platform::RUBY
      gemspec.add_development_dependency 'shoulda', '~> 2.10.3'
      gemspec.add_development_dependency 'mocha', '~> 0.9.8'
      gemspec.add_development_dependency 'redgreen', '~> 1.2.2'
    end
  rescue LoadError
    puts "Jeweler not available. Install it with [sudo] gem install jeweler -s http://gemscutter.org"
  end
  
  task :push do
    command = ('gem push')
    command << " -p $#{ENV['http_proxy']}" if ENV['http_proxy']
    command << " #{latest_gem}"
    puts "Pushing gem..."
    IO.popen(command) { |io| io.each { |line| puts '  ' + line } }
  end
  
  def latest_gem
    result = File.expand_path(Dir.glob(File.join(File.dirname(__FILE__), '..', 'pkg', '*.gem')).sort.last)
    abort "No gems found in pkg/. Did you run gem:build?" if result.nil?
    result
  end
end
