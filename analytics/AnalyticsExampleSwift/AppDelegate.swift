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
import PrebidMobileFS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // [START tracker_swift]
    FirebaseApp.configure()
    // [END tracker_swift]
                    
    PBLogManager.setPBLogLevel(PBLogLevel.debug)
    FSAdSDK.overrideBundleIdentifier("com.smallbusinessvictory.SwingBySwing")
    FSRegistration.register { (status, adUnits) in
      // optional for first ad load
      if (status == .success) {
        // status or informational
        for adUnit in adUnits! {
          print("\(adUnit.identifier!) | \(adUnit.adSizes!)")
        }
      }
    }
    
    return true
  }

}
