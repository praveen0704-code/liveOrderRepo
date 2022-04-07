//
//  MainLaunchViewController.swift
//  liveOrder
//
//  Created by PraveenMac on 12/02/22.
//

import UIKit
import Foundation
import SwiftyJSON
import Lottie
class MainLaunchViewController: UIViewController {
    private var animationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // Live-order-Illustration
        loadAimation()
        
        
       
    }
    func loadAimation(){
        // 2. Start AnimationView with animation name (without extension)
          
          animationView = .init(name: "Live-order-Illustration")
          
          animationView!.frame = view.bounds
          
          // 3. Set animation content mode
          
          animationView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
          animationView!.loopMode = .loop
          
          // 5. Adjust animation speed
          
          animationView!.animationSpeed = 0.5
          
          view.addSubview(animationView!)
          
          // 6. Play animation
          
          animationView!.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            print(UserDefaults.standard.integer(forKey: "data"))
            if  UserDefaults.standard.integer(forKey: "data") == 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(vc!, animated: true)
            }else{
                if  UserDefaults.standard.integer(forKey: "data") == 2{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController

                    self.navigationController?.pushViewController(vc!, animated: true)

                }else{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
                    self.navigationController?.navigationBar.isHidden = true
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
        })

        
    }


    
    
}
