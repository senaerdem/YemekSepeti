//
//  BasketListener.swift
//  App
//
//  Created by Sena Nur Erdem  on 05.11.2023.
//
import Foundation
import Firebase

class BasketListener: ObservableObject {
    
    @Published var orderBasket: OrderBasket!
    
    
    init() {
        downloadBasket()
    }
    
    func downloadBasket() {
        
        if FUser.currentUser() != nil {
            FirebaseReference(.Basket).whereField(kOWNERID, isEqualTo: FUser.currentId()).addSnapshotListener { (snapshot, error) in
                
                
                guard let snapshot = snapshot else { return }
                
                if !snapshot.isEmpty {
                    
                    let basketData = snapshot.documents.first!.data()
                    
                    getItemsFromFirestore(withIds: basketData[kITEMIDS] as? [String] ?? []) { (allDrinks) in
                        
                        let basket = OrderBasket()
                        basket.ownerId = basketData[kOWNERID] as? String
                        basket.id = basketData[kID] as? String
                        basket.items = allDrinks
                        self.orderBasket = basket
                    }
                }
            }

        }
    }
}


func getItemsFromFirestore(withIds: [String], completion: @escaping (_ itemArray: [Food]) -> Void) {
    
    var count = 0
    var itemArray: [Food] = []
    
    
    if withIds.count == 0 {
        completion(itemArray)
        return
    }
    
    for itemId in withIds {
        
        FirebaseReference(.Menu).whereField(kID, isEqualTo: itemId).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                let itemData = snapshot.documents.first!
                
                itemArray.append(Food(id: itemData[kID] as? String ?? UUID().uuidString,
                                        name: itemData[kNAME] as? String ?? "Bilinmeyen",
                                        imageName: itemData[kIMAGENAME] as? String ?? "Bilinmeyen",
                                        category: Category(rawValue: itemData[kCATEGORY] as? String ?? "food") ?? .food1,
                                        description: itemData[kDESCRIPTION] as? String ?? "Açıklama Eksik",
                                        price: itemData[kPRICE] as? Double ?? 0.00))
                
                count += 1
                
            } else {
                print("Yemek yok")
                completion(itemArray)
            }
            
            
            if count == withIds.count {
                completion(itemArray)
            }
            
        }

    }
    
    
    
}
