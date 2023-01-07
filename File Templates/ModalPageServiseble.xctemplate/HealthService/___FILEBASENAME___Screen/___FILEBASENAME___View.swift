//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeServices
import OversizeUI
import SwiftUI
import EventKit

struct ___FILEBASENAMEASIDENTIFIER___: View {
    @StateObject var viewModel: ___FILEBASENAMEASIDENTIFIER___Model
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        _viewModel = StateObject(wrappedValue: ___FILEBASENAMEASIDENTIFIER___Model())
    }
    
    var body: some View {
        PageView("") {
            Group {
                switch viewModel.state {
                case .initial:
                    placeholder()
                        .onAppear {
                            Task {
                                await viewModel.fetchData()
                            }
                        }
                case .loading:
                    placeholder()
                case let .result(data):
                    content(data: data)
                case let .error(error):
                    ErrorView(error)
                }
            }
        }
        .leadingBar {
            BarButton(type: .close)
        }
        .trailingBar {
            BarButton(type: .secondary(L10n.Button.save, action: {
                Task {
                    let result = await viewModel.save()
                    switch result {
                    case let .success(data):
                        log("✅ ___VARIABLE_productType___ saved")
                    case let .failure(error):
                        log("❌ ___VARIABLE_productType___ not saved (\(error.title))")
                    }
                }
            }))
        }
        .sheet(item: $viewModel.sheet) { sheet in
            resolveSheet(sheet: sheet)
        }
    }
    
    @ViewBuilder
    private func content(data: [___VARIABLE_productType___]) -> some View {
        
    }
    
    @ViewBuilder
    private func placeholder() -> some View {
        
    }
}

struct ___FILEBASENAMEASIDENTIFIER____Previews: PreviewProvider {
    static var previews: some View {
        ___FILEBASENAMEASIDENTIFIER___()
    }
}
