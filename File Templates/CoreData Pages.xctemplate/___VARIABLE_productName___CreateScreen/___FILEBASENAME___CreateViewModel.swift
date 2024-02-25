// ___FILEHEADER___

import Combine
import Database
import Models
import OversizeCore
import OversizeUI
import SwiftUI

@MainActor
public class ___FILEBASENAMEASIDENTIFIER___: ObservableObject {
    
    @Published internal var name: String = .init()
    @Published internal var description: String = .init()
    
    @Published internal var isEmptyForm: Bool = true
    @Published internal var isFormValid: Bool = true

    internal let editingMode: EditingMode

    private var cancellable = Set<AnyCancellable>()

    public init(_ mode: EditingMode) {
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

public extension ___FILEBASENAMEASIDENTIFIER___ {
    enum EditingMode {
        case create, update(___VARIABLE_CoreDataModel___)
    }
}
