//
//  SmartCartVC.swift
//  liveOrder
//
//  Created by Data Prime on 13/10/21.
//

import UIKit

class SmartCartVC: UIViewController {
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var smartCartLbl: UILabel!
    @IBOutlet weak var consView: UIView!
    
    
    
    let UnderConstructView = UINib(nibName: "UnderConstructView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? UnderConstructView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup(){
         
        topview.clipsToBounds = true
        topview.layer.cornerRadius = 30
        topview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topview.gradientBackground(from: UIColor(hexString: "674cf3"), to: UIColor(hexString: "6c19d8"), direction: .leftToRight)
        UnderConstructView!.frame = CGRect(x: 0, y: 0, width: self.consView.frame.size.width, height: self.consView.frame.size.height)
         
        self.consView.addSubview(UnderConstructView!)
         
      //  topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
