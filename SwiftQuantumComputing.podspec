Pod::Spec.new do |s|
  s.name         = "SwiftQuantumComputing"
  s.version      = "20.0.0"
  s.summary      = "Quantum circuit simulator in Swift."
  s.description  = <<-DESC
  A quantum circuit simulator written in Swift. It also counts with a genetic algorithm to automatically generate circuits and a few other useful algorithms for quantum computing.
                   DESC
  s.homepage     = "https://github.com/indisoluble/SwiftQuantumComputing"
  s.license      = "Apache License, Version 2.0"
  s.author       = { "Enrique de la Torre" => "indisoluble_dev@me.com" }

  s.ios.deployment_target = "11.4"
  s.osx.deployment_target = "10.13"
  
  s.source = { :git => "https://github.com/indisoluble/SwiftQuantumComputing.git", :tag => "#{s.version}" }

  s.source_files     = "Sources/SwiftQuantumComputing/**/*.swift"
  s.ios.source_files = "Sources/SwiftQuantumComputing_iOS/**/*.swift"
  s.osx.source_files = "Sources/SwiftQuantumComputing_macOS/**/*.swift"
  s.swift_version    = '5.1'

  s.ios.resources = "Sources/SwiftQuantumComputing_iOS/**/*.xib"
  s.osx.resources = "Sources/SwiftQuantumComputing_macOS/**/*.xib"

  s.frameworks = 'Accelerate'
end
