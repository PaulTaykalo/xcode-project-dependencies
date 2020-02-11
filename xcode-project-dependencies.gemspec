Gem::Specification.new do |s|
  s.name        = 'xcode-project-dependencies'
  s.version     = '0.1.0'
  s.date        = '2018-10-13'
  s.summary     = 'Xcode Project Dependencies visualiese'
  s.description = <<-THEEND
Tool that allows to generate graphical visualization of xcode Project dependencies (targets)
For usages examples run:
xcode-project-dependencies
THEEND
  s.authors     = ['Paul Taykalo']
  s.email       = 'tt.kilew@gmail.com'
  s.files       = Dir['lib/**/*.*']
  s.homepage    =
      'https://github.com/PaulTaykalo/xcode-project-dependencies'
  s.license       = 'MIT'
  s.executables << 'xcode-project-dependencies'
  s.add_runtime_dependency 'xcodeproj', '~> 1.5', '>= 1.5.3'
end