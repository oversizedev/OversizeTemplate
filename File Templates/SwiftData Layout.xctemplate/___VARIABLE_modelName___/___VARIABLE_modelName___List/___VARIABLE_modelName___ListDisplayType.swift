// ___FILEHEADER___

import Foundation
import SwiftUI

public enum ___VARIABLE_modelName___ListDisplayType: String, CaseIterable, Identifiable, Sendable {
    case list, grid

    public var title: String {
        rawValue.capitalizingFirstLetter()
    }

    public var id: String {
        rawValue
    }

    public var icon: Image {
        switch self {
        case .list:
            Image.GridsAndLayout.List.mini
        case .grid:
            Image.GridsAndLayout.Grid.mini
        }
    }
}