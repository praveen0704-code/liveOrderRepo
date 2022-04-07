//
//  LoWalletVC.swift
//  liveOrder
//
//  Created by Data Prime on 03/09/21.
//

import UIKit

class LoWalletVC: UIViewController {
    @IBOutlet weak var lotableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBttn: UIButton!
    @IBOutlet weak var loWalletLbl: UILabel!
    @IBOutlet weak var manageLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        lotableView.dataSource = self
        lotableView.delegate = self
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
extension LoWalletVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            lotableView.register(UINib(nibName: "LoWalletCell", bundle: nil), forCellReuseIdentifier: "LoWalletCell")

                let addCardCell = tableView.dequeueReusableCell(withIdentifier: "LoWalletCell", for: indexPath)as! LoWalletCell
           
           
                return addCardCell
                
            }
        
        return UITableViewCell()
}


}
