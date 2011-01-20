# -*- ruby -*-

require 'rubygems'
require 'hoe'

# Hoe.plugin :rubyforge
# Hoe.plugin :website

Hoe.spec 'retroactive_module_inclusion' do
  developer('Adriano Mitre', 'adriano.mitre@gmail.com')
  
  self.version = '1.0.1' # FIX, FIXME: remove this! Include the constant in the module itself!
  
  self.post_install_message = 'PostInstall.txt' # FIX, FIXME, TODO remove if post-install message not required
  self.rubyforge_name       = self.name # FIX, FIXME, TODO this is default value
  self.extra_deps         = [['cartesian','>= 0.5.0']]

  self.readme_file = 'README.rdoc'
  self.history_file = 'History.rdoc'
  self.extra_rdoc_files += ['README.rdoc', 'History.rdoc']
  self.extra_rdoc_files << ['Wishlist.rdoc'] if File.exist? 'Wishlist.rdoc'

  # self.rubyforge_name = 'retroactive_module_inclusionx' # if different than 'retroactive_module_inclusion'
end

# vim: syntax=ruby

task :tests => [:test] do
  # aliasing :test with :tests for RVM ('rvm tests')
end

# TODO, FIX, FIXME - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]

task :chdir do
  Dir.chdir File.dirname(File.expand_path(__FILE__))
end

task :render_docs => [:chdir] do
  system %q{ rm -rf doc/ }
  system %q{ rdoc README.rdoc lib/*.rb }
end

task :render_website => [:chdir, :docs] do |t|
  system %q{ script/txt2html website/index.txt website/template.html.erb > website/index.html }
  system %q{ rm -rf website/doc; cp -R doc website }
end
