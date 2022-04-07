//
//  SearchPopView.swift
//  liveOrder
//
//  Created by Data Prime on 23/07/21.
//

import UIKit
import Alamofire
protocol searchDelegate {
    func onPizzaReady(type: String)
}

class SearchPopView: UIView {
    @IBOutlet weak var overAllVie: UIView!
    @IBOutlet weak var TxtLbl: UIView!
    
    @IBOutlet weak var removeView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var searchTbleView: UITableView!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var txtViewHeight: NSLayoutConstraint!
    
    
    var delegate: searchDelegate?
    var btn : Int?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
       super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.removeView.addGestureRecognizer(gesture)
    
        overAllVie.layer.cornerRadius = 10
        TxtLbl.layer.cornerRadius = 4

        searchTbleView.dataSource = self
        searchTbleView.delegate = self
        
        self.frame = UIScreen.main.bounds
        searchTbleView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }

    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        txtViewHeight.constant = 56
        TxtLbl.layoutIfNeeded()

        self.removeFromSuperview()
    }
    @IBAction func crossBtnAct(_ sender: Any) {
        txtViewHeight.constant = 0
        TxtLbl.layoutIfNeeded()
       
    }
   
    @IBAction func resetBtnAct(_ sender: Any) {
    }
    
    
}
extension SearchPopView:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        if indexPath.row == 0{
            cell.searchTxtField.placeholder = "e.g. Dolo 650 mg, Telpres 40 mg"

        }else{
            cell.searchTxtField.placeholder = ""
        }
        if btn == 1{
            delegate?.onPizzaReady(type: cell.searchTxtField.text ?? "")
        }
        
               return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}

