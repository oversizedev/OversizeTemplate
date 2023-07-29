// ___FILEHEADER___

import Combine
import OversizeCore
import OversizeUI
import SwiftUI

@MainActor
class ___FILEBASENAMEASIDENTIFIER___: ObservableObject {
    
    // Fields
    @Published var name: String = .init()
    @Published var description: String = .init()
    
    // Form state
    @Published var isEmptyForm: Bool = true
    @Published var isFormValid: Bool = true
    
    // Sheet
    @Published var sheet: Screen?
    @Published var sheetDetents: Set<PresentationDetent> = []
    @Published var dragIndicator: Visibility = .automatic
    @Published var dismissDisabled: Bool = false

    let editingMode: EditingMode

    private var cancellable = Set<AnyCancellable>()

    init(_ mode: EditingMode) {
        editingMode = mode
        set___VARIABLE_CoreDataModel___(mode: mode)

        isEmptyFormPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEmptyForm, on: self)
            .store(in: &cancellable)

        isValidFormPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellable)
    }
}

extension ___FILEBASENAMEASIDENTIFIER___ {
    var isEmptyNamePublisher: AnyPublisher<Bool, Never> {
        $name
            .map { name in
                name.isEmpty
            }
            .eraseToAnyPublisher()
    }

    var isEmptyDescriptionPublisher: AnyPublisher<Bool, Never> {
        $description
            .map { description in
                description.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    var isEmptyFormPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isEmptyNamePublisher,
            isEmptyDescriptionPublisher
        )
        .map { isEmptyName, isEmptyDescription in
            !(isEmptyName == false || isEmptyDescription == false)
        }
        .eraseToAnyPublisher()
    }

    var isValidFormPublisher: AnyPublisher<Bool, Never> {
        $name
            .map { name in
                name.isEmpty == false
            }
            .eraseToAnyPublisher()
    }
}

extension ___FILEBASENAMEASIDENTIFIER___ {
    func set___VARIABLE_CoreDataModel___(mode: EditingMode) {
        switch mode {
        case .create:
            break
        case let .update(___VARIABLE_CoreDataModelVariable___):
            name = ___VARIABLE_CoreDataModelVariable___.name ?? ""
            //description = ___VARIABLE_CoreDataModelVariable___.description ?? ""
        }
    }
}

extension ___FILEBASENAMEASIDENTIFIER___ {
    enum EditingMode {
        case create, update(___VARIABLE_CoreDataModel___)
    }
}
