//
//  NotificationLOViewController.swift
//  liveOrder
//
//  Created by PraveenMac on 26/03/22.
//

import UIKit

class NotificationLOViewController: UIViewController {

    
    @IBOutlet weak var nBackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   //MARK: - Back Action
    
    @IBAction func nBackAction(_ sender: Any) {
        let loHome = self.storyboard?.instantiateViewController(withIdentifier: "LoHomeViewController") as! LoHomeViewController
        self.navigationController?.pushViewController(loHome, animated: true)
    }
    
}
