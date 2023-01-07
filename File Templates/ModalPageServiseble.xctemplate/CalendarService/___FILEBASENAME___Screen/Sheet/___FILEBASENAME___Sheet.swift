//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeCore
import SwiftUI

extension ___VARIABLE_productName:identifier___ViewModel {
    func present(_ sheet: ___VARIABLE_productName:identifier___ViewModel.Sheet) {
        self.sheet = sheet
    }
    
    func close() {
        sheet = nil
    }
}

extension ___VARIABLE_productName:identifier___ViewModel {
    enum Sheet {
        case empty
    }
}

extension ___VARIABLE_productName:identifier___ViewModel.Sheet: Identifiable {
    var id: String {
        switch self {
        case .empty:
            return "empty"
        }
    }
}

extension ___VARIABLE_productName:identifier___View {
    func resolveSheet(sheet: ___VARIABLE_productName:identifier___ViewModel.Sheet) -> some View {
        Group {
            switch sheet {
            case .empty:
                EmptyView()
                    .presentationDetents([.large])
            }
        }
        .systemServices()
    }
}
