// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

@MainActor
@Observable
public final class ___VARIABLE_modelName___EditViewModel {
    /// Edit mode
    public let mode: EditMode
    public var state: LoadingViewState<StateModel> = .idle
    public var isSaving: Bool = false

    /// Forms
    public var name: String = .init()
    public var note: String = .init()
    public var color: Color = .blue
    public var url: URL?
    public var date: Date?
    #if os(macOS)
    public var image: NSImage?
    #else
    public var image: UIImage?
    #endif

    /// Page
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    /// Initialization
    public init(_ mode: EditMode) {
        self.mode = mode
        setFields(mode: mode)
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___EditViewModel {
    func fetchData() async {
        let result = await fetch___VARIABLE_modelName___()
        switch result {
        case let .success(___VARIABLE_modelVariableName___):
            state = .result(.init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___))
            setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case let .failure(error):
            state = .error(error)
        }
    }

    func fetch___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        guard case let .editId(id) = mode
        else { return .failure(AppError.network(type: .unknown)) }
        return .failure(AppError.network(type: .unknown))
    }
    
    func create___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        guard case let .editId(id) = mode
        else { return .failure(AppError.network(type: .unknown)) }
        return .failure(AppError.network(type: .unknown))
    }
}

public extension ___VARIABLE_modelName___EditViewModel {
    /// Checks
    var isEmptyForm: Bool {
        name.isEmpty && note.isEmpty && url == nil
    }

    var isValidForm: Bool {
        !name.isEmpty && url != nil
    }

    /// View
    var title: String {
        switch mode {
        case .create:
            "Create ___VARIABLE_modelVariableName___"
        case .edit, .editId:
            "Edit ___VARIABLE_modelVariableName___"
        }
    }
}

// MARK: - Init Fields

private extension ___VARIABLE_modelName___EditViewModel {
    private func setFields(mode: EditMode) {
        switch mode {
        case let .edit(___VARIABLE_modelVariableName___):
            state = .result(.init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___))
            setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case let .editId(id):
            Task {
                await fetchData()
            }
        case .create:
            break
        }
    }

    func setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
//        name = .init()
//        color = Color.blue
//        note = .init()
//        url = nil
//        #if os(macOS)
//        image = NSImage()
//        #else
//        image = UIImage()
//        #endif
//        date = Date()
    }
}

// MARK: - EditMode types

public extension ___VARIABLE_modelName___EditViewModel {
    enum EditMode {
        case create, edit(___VARIABLE_modelName___), editId(String)
    }

    struct StateModel {
        public let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    }

    /// FocusFields
    enum FocusField: Hashable {
        case name, note, url
    }
}
