platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  # TODO: Remove or update the version of `1.8.0` to the newest version (not 1.8.1) when init a new project.
  # Currently, there is a bug on `1.8.1` - the newest version.
  pod 'Sourcery', '1.8.0'
  pod 'SwiftFormat/CLI'
end

target 'Survey' do
  # UI
  pod 'Kingfisher'
  pod 'SnapKit'
  pod 'ShimmerView'
  pod 'SwiftUI-Pull-To-Refresh', '~> 1.1.8'

  # Storage
  pod 'KeychainAccess'

  # Networking
  pod 'Alamofire'
  pod 'Japx'

  # Tools
  pod 'Firebase/Crashlytics'
  pod 'IQKeyboardManagerSwift'
  pod 'NimbleExtension', :git => 'https://github.com/nimblehq/NimbleExtension', :branch => 'master'
  pod 'R.swift'
  pod 'Resolver' # Needs Cocoapods on iOS 11 to support Resolver

  # Development
  pod 'SwiftLint'
  pod 'Wormholy', :configurations => ['Debug Staging', 'Debug Production']

  target 'SurveyTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'SurveyUITests' do
    testing_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
