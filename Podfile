platform :ios, '11.0'

def app_pods
  pod 'Alamofire'
  pod 'SVProgressHUD', '~> 2.1'
  pod 'AlamofireNetworkActivityIndicator', '~> 2.1'
end

def testing_pods
  pod 'Quick', '~> 1.1'
  pod 'Nimble', '~> 6.1'
  pod 'OHHTTPStubs', '~> 6.0'
  pod 'OHHTTPStubs/Swift'
end

target 'WunderTest' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WunderTest
  app_pods

  target 'WunderTestTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'WunderTestUITests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

end
