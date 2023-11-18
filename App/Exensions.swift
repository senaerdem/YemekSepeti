//
//  Exensions.swift
//  App
//
//  Created by Sena Nur Erdem  on 05.11.2023.
//

import Foundation

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
