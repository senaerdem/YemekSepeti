//
//  FirebaseReference.swift
//  App
//
//  Created by Sena Nur Erdem  on 04.11.2023.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference : String {
    case User
    case Menu
    case Order
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
