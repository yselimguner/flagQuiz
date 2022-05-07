//
//  Flags.swift
//  Flag Contest
//
//  Created by Yavuz Güner on 7.05.2022.
//

import Foundation

class Flags:Equatable,Hashable {
    var flag_id:Int?
    var flag_name:String?
    var flag_image:String?
    
    init() {
        
    }
    
    init(flag_id:Int, flag_name:String, flag_image:String) {
        self.flag_id = flag_id
        self.flag_name = flag_name
        self.flag_image = flag_image
    }
    
    var hashValue: Int {
        get {
            return flag_id.hashValue //Bayrak_id'ye göre kıyaslama yapacağız. Bunu dedik. Çünkü view Controller'da yazdığımızda set bizden bunu istiyordu.
        }
    }
    
    static func == (lhs:Flags,rhs:Flags) -> Bool {
        return lhs.flag_id == rhs.flag_id
    }
    
}
