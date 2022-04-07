//
//  MoreOptionView.swift
//  liveOrder
//
//  Created by Data Prime on 27/08/21.
//
protocol sbSearchTxt{
    func searchTxt(Txt:String)
}
import UIKit
import SwiftUI

class MoreOptionView: UIView {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var optionTableVIew: UITableView!
    @IBOutlet weak var txtView: UIView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var SrchTxtField: UITextField!
    @IBOutlet weak var removeView: UIView!
    
    var delegate : sbSearchTxt?
    var moreList : [SBListData]?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     
    }

    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
        SrchTxtField.delegate = self
        txtView.layer.cornerRadius = 8
        self.frame = UIScreen.main.bounds
        optionTableVIew.dataSource = self
        optionTableVIew.delegate = self
        optionTableVIew.register(UINib(nibName: "MoreOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreOptionTableViewCell")
//        overView.layer.borderWidth = 1
//        overView.layer.borderColor = UIColor.white.cgColor
//        overView.clipsToBounds = true
//        overView.layer.cornerRadius = 30
//        overView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeDown.direction = .down
            self.overView.addGestureRecognizer(swipeDown)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(taped))
        removeView.addGestureRecognizer(tapgesture)
        
    }
    @objc func taped(sender: UITapGestureRecognizer) {
        self.removeFromSuperview()
        }
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
}

extension MoreOptionView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreList?.count  ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreOptionTableViewCell") as! MoreOptionTableViewCell
        cell.optionLbl.text = "ShortBook List Of \(moreList?[indexPath.row].cItemName ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let searchName = (moreList?[indexPath.row].cItemName ?? "").prefix(4)
        
        delegate?.searchTxt(Txt: String(searchName) )
        
        self.removeFromSuperview()
    }
}

extension MoreOptionView : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        SrchTxtField.resignFirstResponder()
        self.removeFromSuperview()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SrchTxtField.resignFirstResponder()
        self.removeFromSuperview()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if SrchTxtField.text!.count >= 3{
            delegate?.searchTxt(Txt: SrchTxtField.text! + string)
        }else{
//            delegate?.searchTxt(Txt: "")
        }
        return true
    }
}
