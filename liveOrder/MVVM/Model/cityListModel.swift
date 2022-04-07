//
//  userModel.swift
//  liveOrder
//
//  Created by Data Prime on 12/07/21.
//


import Foundation
import UIKit


     
class city : Encodable{
       var c_city_code : String?
       var c_city_name : String?
        init(cityCode:String , cityName : String){
            c_city_code = cityCode
            c_city_name = cityName
        }
        
}


class cityClass : NSObject{
       var c_city_code : String?
       var c_city_name : String?
      
        
}

class Areaclass : NSObject{
       var c_area_code : String?
       var c_area_name : String?
      
        
}

class Stateclass : NSObject{
       var c_state_code : String?
       var c_state_name : String?
        
}

class S_seller_lists : NSObject{
    
    var c_seller_code : String?
    
    var c_seller_image : String?
    
    var c_seller_name : String?
    
}

class MostOrderList : NSObject{
    
    var ac_thumbnail_images : String?
    
    var c_contain_name : String?
    
    var c_discount_status : String?
    var c_item_code : String?
    var c_item_name : String?
    var c_pack_name : String?
    var c_shortbook_status : String?
    var c_watchlist_status : String?
    var n_max_mrp : String?
    
    
}

class NewLaunchlist : NSObject{
    
    var ac_thumbnail_images : String?
    
    var c_contain_name : String?
    
    var c_discount_status : String?
    var c_item_code : String?
    var c_item_name : String?
    var c_pack_name : String?
    var c_shortbook_status : String?
    var c_watchlist_status : String?
    var n_max_mrp : String?
    
    
}

