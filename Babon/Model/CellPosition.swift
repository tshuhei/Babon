//
//  CellPosition.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import Foundation

enum CellPosition{
    case up
    case down
    
    var rev: CellPosition{
        switch self{
        case .up:
            return .down
        case .down:
            return .up
        }
    }
}
