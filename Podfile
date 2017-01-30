# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'iFactory' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'EZSwiftExtensions'
  #pod 'EZSwiftExtensions', :git => 'https://github.com/goktugyil/EZSwiftExtensions.git', :branch => 'Swift2.3' #For Swift 2.3
  pod 'AssociatedValues'
  #pod 'PropertyExtensions'
  #pod 'PropertyExtensions', '1.0.4'
  #pod 'SwiftString'
  #pod 'SwiftFilePath'
  pod 'LTInfiniteScrollView'
  # Pods for iFactory
  post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end
