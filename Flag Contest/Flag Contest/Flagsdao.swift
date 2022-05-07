//
//  Flagsdao.swift
//  Flag Contest
//
//  Created by Yavuz Güner on 7.05.2022.
//

import Foundation

class Flagsdao {
    let db:FMDatabase?
    
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbURL = URL(fileURLWithPath: targetPath).appendingPathComponent("flagquiz.db")
        
        db = FMDatabase(path: dbURL.path)
    }
    
    
    //5 tane rastgele bayrak seçimi yapacağız.
    func get5RandomFlags() ->[Flags] {
        var list = [Flags]()
        
        db?.open()
        
        do {
            //Veritabanından verileri getirecek yer burası.
            let rs = try db!.executeQuery("SELECT * FROM flags ORDER BY RANDOM() LIMIT 5", values: nil)
            
            while(rs.next()){
                let flag = Flags(flag_id: Int(rs.string(forColumn: "flag_id"))!, flag_name: rs.string(forColumn: "flag_name")!, flag_image: rs.string(forColumn: "flag_image")!)
                
                list.append(flag)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
    
    //Rastgele 3 tane seçenek alacak. Fakat doğru cevap şıklar içerisinde olmayacak.
    func get3WrongFlags(flag_id:Int) ->[Flags] {
        var list = [Flags]()
        
        db?.open()
        
        do {
            //Veritabanından verileri getirecek yer burası. Aşağıda where ile bir şart yazarız.
            //Bu şart iki tane aynı şık olmaması için yazılır. != kullandık.
            let rs = try db!.executeQuery("SELECT * FROM flags WHERE flag_id != ? ORDER BY RANDOM() LIMIT 3 ", values: [flag_id])
            
            while(rs.next()){
                let flag = Flags(flag_id: Int(rs.string(forColumn: "flag_id"))!, flag_name: rs.string(forColumn: "flag_name")!, flag_image: rs.string(forColumn: "flag_image")!)
                
                list.append(flag)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return list
    }
}
