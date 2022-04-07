//
//  FourthIntroVC.swift
//  liveOrder
//
//  Created by Data Prime on 06/07/21.
//

import UIKit

class FourthIntroVC: UIViewController {
    @IBOutlet weak var introImgView: UIImageView!
    @IBOutlet weak var introLbl: UILabel!
    @IBOutlet weak var introDescriptionLbl: UILabel!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var brwnoneLbl: UILabel!
    @IBOutlet weak var brwnTwoLbl: UILabel!
    @IBOutlet weak var brwnThreeLbl: UILabel!
    @IBOutlet weak var blueLbl: UILabel!
    @IBOutlet weak var brwnFourLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
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
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FifithIntroVC") as? FifithIntroVC
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromRight
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            let transition:CATransition = CATransition()
                   transition.duration = 0.5
                   transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                   transition.type = CATransitionType.fade
                   transition.subtype = CATransitionSubtype.fromLeft
                   self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                   self.navigationController?.popViewController(animated: false)
          
        }
        
    }
    func setup(){
        blueLbl.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        blueLbl.layer.cornerRadius = 4
        blueLbl.layer.masksToBounds = true
        brwnoneLbl.layer.cornerRadius = brwnoneLbl.frame.height/2
        brwnoneLbl.layer.masksToBounds = true
        brwnTwoLbl.layer.cornerRadius = brwnTwoLbl.frame.height/2
        brwnTwoLbl.layer.masksToBounds = true
        brwnThreeLbl.layer.cornerRadius = brwnThreeLbl.frame.height/2
        brwnThreeLbl.layer.masksToBounds = true
        brwnFourLbl.layer.cornerRadius = brwnFourLbl.frame.height/2
        brwnFourLbl.layer.masksToBounds = true
    }
    

    @IBAction func previousBtnAct(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ThirdIntroVc") as? ThirdIntroVc
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        let transition:CATransition = CATransition()
               transition.duration = 0.5
               transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
               transition.type = CATransitionType.fade
               transition.subtype = CATransitionSubtype.fromLeft
               self.navigationController?.view.layer.add(transition, forKey: kCATransition)
               self.navigationController?.popViewController(animated: false)
    }
    @IBAction func nextBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FifithIntroVC") as? FifithIntroVC
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    @IBAction func skipBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
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
