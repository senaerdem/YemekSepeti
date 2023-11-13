//
//  Item.swift
//  App
//
//  Created by Sena Nur Erdem  on 04.11.2023.
//

import Foundation
import SwiftUI



enum Category  : String,CaseIterable,Codable, Hashable {
    case food1
    case food2
    case food3
}

struct Food: Identifiable,Hashable {
    var id: String
    var name:  String
    var imageName: String
    var category : Category
    var description : String
    var price:  Double
    
  
}

func foodDictionaryFrom(food: Food) -> [String : Any] {
    
    //NSDictionary:Referans semantiği gerektiren durumlarda Sözlük sabiti yerine kullanılmak üzere anahtar-değer çiftlerinin statik bir koleksiyonunu temsil eden bir nesne.
    return NSDictionary(objects: [food.id,
                                  food.name,
                                  food.imageName,
                                  food.category.rawValue,
                                  food.description,
                                  food.price
                                ],
                        //NSCopying: Nesnelerin kendilerinin işlevsel kopyalarını sağlamak için benimsediği bir protokoldür.
                        forKeys: [kID as NSCopying,
                                  kNAME as NSCopying,
                                  kIMAGENAME as NSCopying,
                                  kCATEGORY as NSCopying,
                                  kDESCRIPTION as NSCopying,
                                  kPRICE as NSCopying
    ]) as! [String : Any]
}


func createMenu() {
    
    for food in foodData {
        //firebase bağlama
        FirebaseReference(.Menu).addDocument(data: foodDictionaryFrom(food: food))
    }
    
}

let foodData = [
    
    
    Food(id: UUID().uuidString, name: "Sepet Menü 25.50₺", imageName: "12", category: Category.food1, description: "Size Aşk nedir? diye soranlara bu sepeti gösterin.🤤 Restoranlarımız paket servise devam ediyor. Dilediğiniz zaman sipariş verebilirsiniz.", price: 29.90),
    
    Food(id: UUID().uuidString, name: "Kebabların Şahı 33.90₺", imageName: "11", category: Category.food1, description: "Restoranlarımız paket servise devam ediyor. Dilediğiniz zaman sipariş verebilirsiniz.", price:33.90 ),
    
    Food(id: UUID().uuidString, name: "Sufle 15.50₺", imageName: "13", category: Category.food1, description: "Starbucks lezzetin Yemeksepeti ile dakikalar içerisinde kapında.", price: 15.50),
    
    Food(id: UUID().uuidString, name: "Pizza 22.90₺", imageName: "10", category: Category.food1, description: "İndirimli yemek yemenin formülü çok açık:", price: 22.90),
        
    
    //
                    
    Food(id: UUID().uuidString, name: "Karışık Yemekler 102.00₺", imageName: "9", category: Category.food3, description: " Tek bir pikseli bile canını çektirmeye yeter.", price: 102.00),
    
    Food(id: UUID().uuidString, name: "Kahvaltılık Çeşitleri 44.00₺", imageName: "8", category: Category.food3, description: "Tam yağlı az tuzlu inek sütünden elde edilen çeçil peyniri hem kahvaltılık hem tosta hemde mıhlama ve kuymakda kullanabilirsiniz", price: 44.00),

    Food(id: UUID().uuidString, name: "Hamburger Cola 15.00₺", imageName: "7", category: Category.food3, description: "İndirim Yağmuru ile 2000’den fazla restorandan en az %25 indirimle doya doya ye,", price: 15.00),

    Food(id: UUID().uuidString, name: "Hamburger Ayran 13.00₺", imageName: "6", category: Category.food3, description: "İndirim Yağmuru ile 2000’den fazla restorandan en az %25 indirimle doya doya ye,", price: 102.00),

    
    
    //
    Food(id: UUID().uuidString, name: "Balık 25.00₺", imageName: "5", category: Category.food2, description: "sevgi lezzetini artıran en önemli unsur, içindeki %25 indirimdir.doya doya ye,", price: 25.00),
    
    Food(id: UUID().uuidString, name: "Sufle 14.90₺", imageName: "4", category: Category.food2, description: "Çok sevdiğin zaman her yerde onu görürsün.", price: 14.90),
    
    Food(id: UUID().uuidString, name: "Paket Yemek 33.00₺", imageName: "3", category: Category.food2, description: "Kalbe iki kez tıkla, gizli lezzeti gör.", price: 33.00),
    
    Food(id: UUID().uuidString, name: "Süpriz Yiyecekler 102.00₺", imageName: "2", category: Category.food2, description: "  Kokoreç, midye, ıslak hamburger...", price: 102.00),
    
    Food(id: UUID().uuidString, name: "HakikiKahvaltı 102.50₺", imageName: "1", category: Category.food2, description: " İndirim Yağmuru ile 2000’den fazla restorandan en az %25 indirimle doya doya ye,", price: 102.50)
    
]

struct Drink_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
