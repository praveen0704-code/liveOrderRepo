//
//  IntroViewController.swift
//  liveOrder
//
//  Created by Data Prime on 29/06/21.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var introImage: UIImageView!
    @IBOutlet weak var paraLabel: UILabel!
    
    @IBOutlet weak var txtLabel: UILabel!
    
    @IBOutlet weak var brwnLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var brwnThreeLbl: UILabel!
    @IBOutlet weak var brwntwoLbl: UILabel!
    @IBOutlet weak var brwnFourLbl: UILabel!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
           swipeRight.direction = .left
           self.view!.addGestureRecognizer(swipeRight)
        
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Right")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let viewController = storyBoard.instantiateViewController(withIdentifier: "SecondIntroViewController") as! SecondIntroViewController

               let transition = CATransition()
               transition.duration = 0.5
               transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
               transition.type = CATransitionType.fade
               transition.subtype = CATransitionSubtype.fromRight
               self.navigationController?.view.layer.add(transition, forKey: nil)
               self.navigationController?.pushViewController(viewController, animated: false)
        }

       
    }
    func setup(){
        blueLabel.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        blueLabel.layer.cornerRadius = 4
        blueLabel.layer.masksToBounds = true
        brwnLabel.layer.cornerRadius = brwnLabel.frame.height/2
        brwnLabel.layer.masksToBounds = true
        brwntwoLbl.layer.cornerRadius = brwntwoLbl.frame.height/2
        brwntwoLbl.layer.masksToBounds = true
        brwnThreeLbl.layer.cornerRadius = brwnThreeLbl.frame.height/2
        brwnThreeLbl.layer.masksToBounds = true
        brwnFourLbl.layer.cornerRadius = brwnFourLbl.frame.height/2
        brwnFourLbl.layer.masksToBounds = true
    }
    

   
    @IBAction func skipBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginVc") as? loginVc
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondIntroViewController") as? SecondIntroViewController
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let viewController = storyBoard.instantiateViewController(withIdentifier: "SecondIntroViewController") as! SecondIntroViewController

           let transition = CATransition()
           transition.duration = 0.0
           transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           transition.type = CATransitionType.fade
           transition.subtype = CATransitionSubtype.fromRight
           self.navigationController?.view.layer.add(transition, forKey: nil)
           self.navigationController?.pushViewController(viewController, animated: false)
        
    }
}
