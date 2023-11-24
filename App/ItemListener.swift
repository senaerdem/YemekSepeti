//
//  ItemListener.swift
//  App
//
//  Created by Sena Nur Erdem  on 05.11.2023.
//

import Foundation
import Firebase

class ItemListener: ObservableObject {
    @Published var items: [Food] = []
    
    
    
    init () {downloadItems()
        
    }
    
    
    func downloadItems() {
        FirebaseReference(.Menu).getDocuments { (snapshot, error) in
            guard let snapshot =  snapshot else {return}
            if !snapshot.isEmpty{
                self.items = ItemListener.itemFromDictionary(snapshot)
            }
        }
    
}

static func itemFromDictionary (_ snapshot: QuerySnapshot) -> [Food] {
    var allItems:  [Food] = []
    for snapshot in snapshot.documents {
        
        let  itemData = snapshot.data()
        allItems.append(Food(id: itemData[kID ] as? String ?? UUID().uuidString,
                             name:  itemData[kNAME ] as? String ?? "Bilinmiyor",
                             imageName: itemData[kIMAGENAME ] as? String ?? "Bilinmiyor",
                             category: Category(rawValue: itemData[kCATEGORY] as? String ?? "food1") ?? .food1,
                             description: itemData[kDESCRIPTION] as? String ?? "Açıklama Boş", price: itemData[kPRICE] as? Double ?? 0.0))
    }
    return allItems
}
    
}
