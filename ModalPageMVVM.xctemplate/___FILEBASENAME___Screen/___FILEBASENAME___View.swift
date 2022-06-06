// ___FILEHEADER___

import OversizeCraft
import OversizeServices
import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    @StateObject var viewModel: ___FILEBASENAMEASIDENTIFIER___Model
    @Environment(\.presentationMode) var presentationMode

    init() {
        _viewModel = StateObject(wrappedValue: ___FILEBASENAMEASIDENTIFIER___Model())
    }

    var body: some View {
        switch viewModel.state {
        case .initial:
            ProgressView()
                .onAppear {
                    Task {
                        await viewModel.fetchData()
                    }
                }
        case .loading:
            ProgressView()
        case let .result(data):
            content(data: data)
        case let .error(error):
            ErrorView(error)
        }
    }

    @ViewBuilder
    private func content(data _: ___VARIABLE_productType___) -> some View {
        PageView("") {}
            .leadingBar {
                BarButton(type: .close)
            }
            .trailingBar {
                BarButton(type: .secondary(L10n.Button.save, action: {
                    Task {
                        let result = await viewModel.save()
                        switch result {
                        case let .success(data):
                            #if DEBUG
                                print("✅ ___VARIABLE_productType___ saved")
                            #endif
                        case let .failure(error):
                            #if DEBUG
                                print("❌ ___VARIABLE_productType___ not saved (\(error.title))")
                            #endif
                        }
                    }
                }))
            }
    }
}

struct ___FILEBASENAMEASIDENTIFIER____Previews: PreviewProvider {
    static var previews: some View {
        ___FILEBASENAMEASIDENTIFIER___()
    }
}
