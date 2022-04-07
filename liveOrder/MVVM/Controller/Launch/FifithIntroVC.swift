//
//  FifithIntroVC.swift
//  liveOrder
//
//  Created by Data Prime on 06/07/21.
//

import UIKit

class FifithIntroVC: UIViewController {
    @IBOutlet weak var introImgView: UIImageView!
    @IBOutlet weak var introLbl: UILabel!
    @IBOutlet weak var introDesLbl: UILabel!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var brwnOneLbl: UILabel!
    @IBOutlet weak var brwntwoLbl: UILabel!
    @IBOutlet weak var brwnThreeLbl: UILabel!
    @IBOutlet weak var brwnFourLbl: UILabel!
    @IBOutlet weak var blueLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipBtn.isHidden = true

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
            print("Swipe Right")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
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
        brwnOneLbl.layer.cornerRadius = brwnOneLbl.frame.height/2
        brwnOneLbl.layer.masksToBounds = true
        brwnThreeLbl.layer.cornerRadius = brwnThreeLbl.frame.height/2
        brwnThreeLbl.layer.masksToBounds = true
        brwnFourLbl.layer.cornerRadius = brwnFourLbl.frame.height/2
        brwnFourLbl.layer.masksToBounds = true
        brwntwoLbl.layer.cornerRadius = brwntwoLbl.frame.height/2
        brwntwoLbl.layer.masksToBounds = true
    }
    
    @IBAction func previousBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FourthIntroVC") as? FourthIntroVC
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
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    @IBAction func skipBtnAct(_ sender: Any) {
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
