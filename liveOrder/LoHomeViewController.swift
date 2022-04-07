//
//  LoHomeViewController.swift
//  liveOrder
//
//  Created by PraveenMac on 01/10/21.
//

import UIKit
import Alamofire
import NotificationBannerSwift

class LoHomeViewController: UITabBarController {
    var loged :Int?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBar.items![2].badgeValue = "1"
        self.tabBar.barTintColor = UIColor.init(hexString: "674cf3")
        if loged == 1{
            let banner = NotificationBanner(title: "Message", subtitle: "OTP verified and Logged successfully!", style: .info)
            banner.showToast(message: "OTP verified and Logged successfully!" , view: self.view)
            self.selectedIndex = 0

        }else if loged == 0{
            let banner = NotificationBanner(title: "Message", subtitle: "Logged successfully!", style: .info)
            banner.showToast(message: "Logged successfully!" , view: self.view)
            self.selectedIndex = 0

        }else if loged == 2{
            self.selectedIndex = 2
        }else{
            self.selectedIndex = 0

        }
        
        
        

        // Do any additional setup after loading the view.
    }
   
  
    

}
