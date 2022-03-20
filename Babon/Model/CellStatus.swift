//
//  CellStatus.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import Foundation
import SwiftUI

enum CellStatus: String{
    case neutral
    case red
    case blue
    
    var name: String{
        rawValue.capitalized
    }
}
