// ___FILEHEADER___

import OversizeUI
import OversizeKit
import OversizeLocalizable
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {

    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ___FILEBASENAMEASIDENTIFIER___Model
    @FocusState private var focusedField: FocusField?

    init(_ mode: ___FILEBASENAMEASIDENTIFIER___Model.EditingMode) {
        _viewModel = StateObject(wrappedValue: ___FILEBASENAMEASIDENTIFIER___Model(mode))
    }

    var body: some View {
        LayoutView(title) {
            content()
        }
        .leadingBar {
            BarButton(.closeAction {
                if viewModel.isEmptyForm {
                    router.dismiss()
                } else {
                    router.presentAlert(.dismiss {
                        router.dismiss()
                    })
                }
            })
        }
        .trailingBar {
            BarButton(viewModel.isFormValid ? .accent(L10n.Button.save, action: {
                save___VARIABLE_CoreDataModel___()
            }) : .disabled(L10n.Button.save))
        }
        .onChange(of: viewModel.isEmptyForm) { router.dismissDisabled(!$0) }
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack(spacing: .small) {
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(.placeholder("Jhon"))
                .focused($focusedField, equals: .name)
                .submitLabel(.continue)
                .onSubmit {
                    focusedField = .description
                }
            
            TextField("Description", text: $viewModel.description)
                .textFieldStyle(.placeholder("Description"))
                .focused($focusedField, equals: .description)
                .submitLabel(.done)
            
        }
        .paddingContent()
    }
    
    func save___VARIABLE_CoreDataModel___() {
        if viewModel.isFormValid {
            let ___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___
            switch viewModel.editingMode {
            case .create:
                ___VARIABLE_CoreDataModelVariable___ = ___VARIABLE_CoreDataModel___(context: viewContext)
                ___VARIABLE_CoreDataModelVariable___.id = UUID()
            case let .update(old___VARIABLE_CoreDataModel___):
                ___VARIABLE_CoreDataModelVariable___ = old___VARIABLE_CoreDataModel___
            }
            ___VARIABLE_CoreDataModelVariable___.name = viewModel.name
            //___VARIABLE_CoreDataModelVariable___.description = viewModel.description
            viewContext.saveContext()
            router.dismiss()
        }
    }
    
    var title: String {
        switch viewModel.editingMode {
        case .create:
            return "Create ___VARIABLE_CoreDataModelVariable___"
        case .update:
            return "Edit ___VARIABLE_CoreDataModelVariable___"
        }
    }
}

extension ___FILEBASENAMEASIDENTIFIER___ {
    enum FocusField: Hashable {
        case name, description
    }
}

struct ___FILEBASENAMEASIDENTIFIER____ViewPreviews: PreviewProvider {
    static var previews: some View {
        ___FILEBASENAMEASIDENTIFIER___(.create)
    }
}
