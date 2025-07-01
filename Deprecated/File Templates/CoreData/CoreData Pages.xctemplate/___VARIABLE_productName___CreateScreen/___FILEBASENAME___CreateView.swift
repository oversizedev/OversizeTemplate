// ___FILEHEADER___

import Database
import Env
import OversizeCore
import OversizeKit
import OversizeUI
import OversizeLocalizable
import SwiftUI

public struct ___FILEBASENAMEASIDENTIFIER___: View {

    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ___FILEBASENAMEASIDENTIFIER___Model
    @FocusState private var focusedField: FocusField?

    public init(_ mode: ___FILEBASENAMEASIDENTIFIER___Model.EditingMode) {
        _viewModel = StateObject(wrappedValue: ___FILEBASENAMEASIDENTIFIER___Model(mode))
    }

    public var body: some View {
        Page(title) {
            content()
        }
        .largeTitle()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if viewModel.isEmptyForm {
                        router.back()
                    } else {
                        router.presentAlert(.dismiss {
                            router.back()
                        })
                    }
                } label: {
                    Image.Base.arrowLeft.icon()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    save___VARIABLE_CoreDataModel___()
                } label: {
                    Text(L10n.Button.save)
                }
                .disabled(!viewModel.isFormValid)
            }
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
    
    private func save___VARIABLE_CoreDataModel___() {
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
            switch viewModel.editingMode {
            case .create:
                router.presentHud("Saved")
                router.back()
            case .update:
                router.presentHud("Edited")
                router.back()
            }
        } else {
            router.presentHud("Errors in the fields")
        }
    }
    
    private var title: String {
        switch viewModel.editingMode {
        case .create:
            return "Create"
        case .update:
            return "Edit"
        }
    }
}

public extension ___FILEBASENAMEASIDENTIFIER___ {
    enum FocusField: Hashable {
        case name, description
    }
}

struct ___FILEBASENAMEASIDENTIFIER____ViewPreviews: PreviewProvider {
    static var previews: some View {
        ___FILEBASENAMEASIDENTIFIER___(.create)
    }
}
