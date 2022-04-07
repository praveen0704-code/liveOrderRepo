//
//  SecondIntroViewController.swift
//  liveOrder
//
//  Created by PraveenMac on 30/06/21.
//

import UIKit

class SecondIntroViewController: UIViewController {
    @IBOutlet weak var introimgView: UIImageView!
    @IBOutlet weak var introLbl: UILabel!
    @IBOutlet weak var introdescriptionLbl: UILabel!
    @IBOutlet weak var prrviousBtn: UIButton!
    @IBOutlet weak var blueLbl: UILabel!
    @IBOutlet weak var brwnLbl: UILabel!
    
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var brwnThreeLbl: UILabel!
    @IBOutlet weak var brwnFourLbl: UILabel!
    @IBOutlet weak var brwnFiveLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
           swipeRight.direction = .right
           self.view!.addGestureRecognizer(swipeRight)
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeleft.direction = .left
           self.view!.addGestureRecognizer(swipeleft)
        setup()
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            let transition:CATransition = CATransition()
                   transition.duration = 0.5
                   transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                   transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromLeft
                   self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                   self.navigationController?.popViewController(animated: false)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ThirdIntroVc") as? ThirdIntroVc)!
           
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromRight
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    func setup(){
        blueLbl.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        blueLbl.layer.cornerRadius = 4
        blueLbl.layer.masksToBounds = true
        brwnLbl.layer.cornerRadius = brwnLbl.frame.height/2
        brwnLbl.layer.masksToBounds = true
        brwnThreeLbl.layer.cornerRadius = brwnLbl.frame.height/2
        brwnThreeLbl.layer.masksToBounds = true
        brwnFourLbl.layer.cornerRadius = brwnLbl.frame.height/2
        brwnFourLbl.layer.masksToBounds = true
        brwnFiveLbl.layer.cornerRadius = brwnLbl.frame.height/2
        brwnFiveLbl.layer.masksToBounds = true
        
    }

    @IBAction func skipBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func previousBtn(_ sender: Any) {
        
        let transition:CATransition = CATransition()
               transition.duration = 0.5
               transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
               transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
               self.navigationController?.view.layer.add(transition, forKey: kCATransition)
               self.navigationController?.popViewController(animated: false)
    }
   
    @IBAction func nextBtnAct(_ sender: Any) {
        let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ThirdIntroVc") as? ThirdIntroVc)!
       
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
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
