//
//  OtherWalletVC.swift
//  liveOrder
//
//  Created by Data Prime on 03/09/21.
//

import UIKit

class OtherWalletVC: UIViewController {
    @IBOutlet weak var otherWalletTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bacBtn: UIButton!
    @IBOutlet weak var otherWalletLbl: UILabel!
    @IBOutlet weak var manageLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    func setup(){
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        otherWalletTableView.dataSource = self
        otherWalletTableView.delegate = self
    }
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
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
extension OtherWalletVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            otherWalletTableView.register(UINib(nibName: "OtherWalletCell", bundle: nil), forCellReuseIdentifier: "OtherWalletCell")

                let addCardCell = tableView.dequeueReusableCell(withIdentifier: "OtherWalletCell", for: indexPath)as! OtherWalletCell
           
           
                return addCardCell
                
           
}


}
