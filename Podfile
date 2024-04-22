# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'StarzPlay' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for StarzPlay
  pod 'Moya'
  pod 'SDWebImage'

  target 'StarzPlayTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'StarzPlayUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
