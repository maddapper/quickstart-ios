//
//  Copyright (c) 2015 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import Firebase
import GoogleMobileAds
import FSAdSDK
import SnapKit

@objc(ViewController)  // match the ObjC symbol name inside Storyboard
class ViewController: UIViewController {
    var bannerView: (UIView & FSBanner)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = FSAdProvider.createBanner(withIdentifier: "swingu_app_300x250_Mid", size: kGADAdSizeMediumRectangle, adUnitId: "/15184186/swingu_app_300x250_Mid", registrationDelegate: nil, eventHandler: {
            (methodName: String!, params: [ String : Any]) in
            print(methodName!)
            print(params)
            if let error = params["error"] {
                print(error)
            }
        })
        
        bannerView?.rootViewController = self
        bannerView?.load(DFPRequest())
        view.addSubview(bannerView!)
        bannerView?.snp.makeConstraints{make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.bringSubviewToFront(bannerView!)
        
//        bannerView?.pauseRefresh()
    }
    
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        
//    bannerView?.resumeRefresh()

    recordScreenView()

    // [START custom_event_swift]
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterItemID: "id-\(title!)",
      AnalyticsParameterItemName: title!,
      AnalyticsParameterContentType: "cont"
      ])
    // [END custom_event_swift]
  }

  func recordScreenView() {
    // These strings must be <= 36 characters long in order for setScreenName:screenClass: to succeed.
    guard let screenName = title else {
      return
    }
    let screenClass = classForCoder.description()

    // [START set_current_screen]
    Analytics.setScreenName(screenName, screenClass: screenClass)
    // [END set_current_screen]
  }
}
