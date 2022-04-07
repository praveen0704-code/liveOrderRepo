//
//  PrefrdPaymntsVC.swift
//  liveOrder
//
//  Created by Data Prime on 01/09/21.
//

import UIKit

class PrefrdPaymntsVC: UIViewController {
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var paymentLbl: UILabel!
    @IBOutlet weak var chooseLbl: UILabel!
    var checkbox : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        topview.clipsToBounds = true
        topview.layer.cornerRadius = 30
        topview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topview.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        paymentTableView.dataSource = self
        paymentTableView.delegate = self
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
extension PrefrdPaymntsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            paymentTableView.register(UINib(nibName: "PaymentsCellOne", bundle: nil), forCellReuseIdentifier: "PaymentsCellOne")

                let paycell = tableView.dequeueReusableCell(withIdentifier: "PaymentsCellOne", for: indexPath)as! PaymentsCellOne
            paycell.selectBtn.addTarget(self, action: #selector(selectbtncheck), for: .touchUpInside)
            if checkbox == 1{
                paycell.selectBtn.isChecked = true
            }else{
                paycell.selectBtn.isChecked = false
            }
           
                return paycell
                
            }
        if indexPath.row == 1 {
            paymentTableView.register(UINib(nibName: "PaymentsCellTow", bundle: nil), forCellReuseIdentifier: "PaymentsCellTow")

                let paycell = tableView.dequeueReusableCell(withIdentifier: "PaymentsCellTow", for: indexPath)as! PaymentsCellTow
            paycell.selectBtnone.addTarget(self, action: #selector(selectbtnone), for: .touchUpInside)
            if checkbox == 2{
                paycell.selectBtnone.isChecked = true
            }else{
                paycell.selectBtnone.isChecked = false
            }
           
                return paycell
                
            }
        if indexPath.row == 2 {
            paymentTableView.register(UINib(nibName: "PaymentsCellThree", bundle: nil), forCellReuseIdentifier: "PaymentsCellThree")

                let paycell = tableView.dequeueReusableCell(withIdentifier: "PaymentsCellThree", for: indexPath)as! PaymentsCellThree
            paycell.selectBtn.addTarget(self, action: #selector(selectbtntwo), for: .touchUpInside)
            if checkbox == 3{
                paycell.selectBtn.isChecked = true
            }else{
                paycell.selectBtn.isChecked = false
            }
                return paycell
                
            }
        return UITableViewCell()
    }
    @objc func selectbtncheck(){
        checkbox = 1
        paymentTableView.reloadData()
    }
    @objc func selectbtnone(){
        checkbox = 2
        paymentTableView.reloadData()
    }
    @objc func selectbtntwo(){
        checkbox = 3
        paymentTableView.reloadData()
    }
}
