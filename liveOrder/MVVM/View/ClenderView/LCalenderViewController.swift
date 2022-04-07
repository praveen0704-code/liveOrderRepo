//
//  LCalenderViewController.swift
//  liveOrder
//
//  Created by PraveenMac on 07/02/22.
//


import UIKit
import FSCalendar
protocol fromToDateDelegate{
    func passFromToData(fromDateStr:String,toDateStr:String)
    func passDate(dateStr:String)
}

class LCalenderViewController: UIViewController {
    
    
    @IBOutlet weak var lCalenderView: FSCalendar!
    @IBOutlet weak var dateView: UIView!
    
    @IBOutlet weak var calenderDoneButton: UIButton!
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]?
    var dateDelegare:fromToDateDelegate?
    var firstDateStr = String()
    var lastDateStr = String()

        var isProfileInfoInt = Int()
    @IBOutlet weak var fromDateToDateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lCalenderView.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")

        self.lCalenderView.delegate = self
            self.lCalenderView.dataSource = self
        dateView.isHidden = true
        if isProfileInfoInt == 1{
            self.lCalenderView.allowsMultipleSelection = false

        }else{
            self.lCalenderView.allowsMultipleSelection = true

        }
    

        // Do any additional setup after loading the view.
    }
    //MARK: - Button Actions
    
    @IBAction func calenderDoneAction(_ sender: Any) {
        
        if isProfileInfoInt == 1{
            let profileInfoVc =  self.storyboard?.instantiateViewController(withIdentifier: "ProfileInfoVC") as! ProfileInfoVC
            
            profileInfoVc.validOne = firstDateStr
            
            print(firstDateStr)
            dateDelegare?.passDate(dateStr: firstDateStr)
            
            self.navigationController?.pushViewController(profileInfoVc, animated: false)
            
        }else{
            dateDelegare?.passFromToData(fromDateStr:firstDateStr, toDateStr: lastDateStr)
            let loTabBarVC  = self.storyboard?.instantiateViewController(withIdentifier: "LoHomeViewController") as! LoHomeViewController
            loTabBarVC.loged = 2
            self.navigationController?.pushViewController(loTabBarVC, animated: false)
        }
        
        
    }
    

    

}
extension LCalenderViewController: FSCalendarDelegate, FSCalendarDataSource,FSCalendarDelegateAppearance{
   
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
           let cell: FSCalendarCell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
           let dateFromStringFormatter = DateFormatter();
           dateFromStringFormatter.dateFormat = "YYYY-MM-dd";
           
    
           return cell
     
     }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            // nothing selected:
        if isProfileInfoInt == 1{
            
            self.firstDateStr = datePickerDateFormat(date:(date) as! Date)
        }else{
            if firstDate == nil {
                firstDate = date
                datesRange = [firstDate!]

                print("datesRange contains: \(datesRange!)")

                return
            }

            // only first date is selected:
            if firstDate != nil && lastDate == nil {
                // handle the case of if the last date is less than the first date:
                if date <= firstDate! {
                    calendar.deselect(firstDate!)
                    firstDate = date
                    datesRange = [firstDate!]

                    print("datesRange contains: \(datesRange!)")

                    return
                }

                let range = datesRangee(from: firstDate!, to: date)

                lastDate = range.last

                for d in range {
                    calendar.select(d)
                }

                datesRange = range

                print("datesRange contains: \(datesRange!)")

                self.firstDateStr = datePickerDateFormat(date:(datesRange?.first) as! Date)
                self.lastDateStr = datePickerDateFormat(date:(datesRange?.last) as! Date)
                self.fromDateToDateLabel.text = "From Date \(firstDateStr) ToDate \(lastDateStr)"
                dateView.isHidden = false


               
                
                

                return
            }

            // both are selected:
            if firstDate != nil && lastDate != nil {
                for d in calendar.selectedDates {
                    calendar.deselect(d)
                }

                lastDate = nil
                firstDate = nil

                datesRange = []

                print("datesRange contains: \(datesRange!)")
            }
        }
        }

        func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
            // both are selected:

            // NOTE: the is a REDUANDENT CODE:
            if firstDate != nil && lastDate != nil {
                for d in calendar.selectedDates {
                    calendar.deselect(d)
                }

                lastDate = nil
                firstDate = nil

                datesRange = []
                print("datesRange contains: \(datesRange!)")
            }
        }
        
        func datesRangee(from: Date, to: Date) -> [Date] {
            if from > to { return [Date]() }
            var tempDate = from
            var array = [tempDate]
            while tempDate < to {
                tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
                array.append(tempDate)
            }
            return array
        }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
    {
        if date .compare(Date()) == .orderedAscending {
            return false
        }
        else
        {
            return true
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {

        if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedAscending {
                
                    return .gray
                
                 }else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedDescending{
                
                    return .black
                
                 } else {
                
                    return .black

                 }
                        
              }
   

}
