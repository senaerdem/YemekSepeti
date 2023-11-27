//
//  Order.swift
//  Pods
//
//  Created by Sena Nur Erdem  on 06.11.2023.
//

import Foundation

class Order: Identifiable {
    
    
    var id: String!
    var customerId: String!
    var orderItems: [Food] = []
    var amount :Double!
    var customerName : String = ""
    var isCompleted: Bool!
    
    func saveOrderToFirestore() {
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self)) {
            error in
            if error != nil
            {
                print("error saving order to firestore: ", error!.localizedDescription)
            }        }
    }
}

func orderDictionaryFrom(_ order: Order) -> [String : Any] {
    var allItemIds: [String] = []
    for item in order.orderItems {
        allItemIds.append(item.id)
    }
    return NSDictionary(objects: [
        order.id,
        order.customerId,
        allItemIds,
        order.amount,
        order.customerName,
        order.isCompleted
        
    ],   forKeys: [kID as NSCopying,
                   kCUSTOMERID as NSCopying,
                   kITEMIDS as NSCopying,
                   kAMOUNT as NSCopying,
                   kCUSTOMERNAME as NSCopying,
                   kISCOMPLETED as NSCopying
]) as! [String : Any]
}
