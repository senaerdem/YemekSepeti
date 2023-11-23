//
//  ItemItem.swift
//  App
//
//  Created by Sena Nur Erdem  on 05.11.2023.
//

import SwiftUI

struct FoodItem: View {
    var food: Food
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16)
            {
            Image(food.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 178)
                .cornerRadius(10)
                .shadow(radius: 10 )
            
            VStack(alignment: .leading, spacing: 5){
                Text(food.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(food.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .frame(height:40)
            }
        }
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem(food: foodData[0])
    }
}
