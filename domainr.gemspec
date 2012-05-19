Gem::Specification.new do |s|
  s.name    = 'Domainr'
  s.version = '1.1'
  s.summary = 'Domai.nr is a web page which allows you to search nice domains'
  s.description = 'Domai.nr (http://domai.nr) is a web page which allows you to search nice domains. This is a gem which uses it\'s API'

  s.authors  = ['Pablo Merino']
  s.email    = ['pablo.perso1995@gmail.com']
  s.homepage = 'https://github.com/pablo-merino/domainr-gem'

  s.files    = Dir['./**/*']

  # Supress the warning about no rubyforge project
  s.rubyforge_project = 'nowarning'
  s.executables   = `ls bin/*`.split("\n").map{ |f| File.basename(f) }

end
