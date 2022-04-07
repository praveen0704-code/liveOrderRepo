//
//  CartEmptyView.swift
//  liveOrder
//
//  Created by PraveenMac on 11/03/22.
//

import UIKit

class CartEmptyView: UIView {

    @IBOutlet weak var mainEmptyView: UIView!
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        mainEmptyView.clipsToBounds = true
        mainEmptyView.layer.cornerRadius = 30
        mainEmptyView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.addGestureRecognizer(swipeDown)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
                
                // 2. add the gesture recognizer to a view
        self.addGestureRecognizer(tapGesture)
       

}
    //MARK: - Swipe guster
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
                self.removeFromSuperview()
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.removeFromSuperview()
        }

}
