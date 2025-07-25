// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftUI

@MainActor
@Observable
public final class ___VARIABLE_modelName___EditViewState: ViewStateProtocol, Sendable {
    /// Forms
    public var name: String = .init()
    public var note: String = .init()
    public var color: Color = .blue
    public var url: URL?
    public var date: Date = Date()
    public var isFavorite: Bool = false
    public var isArchive: Bool = false
    #if os(macOS)
    public var image: NSImage?
    #else
    public var image: UIImage?
    #endif

    /// User Interface
    public var ___VARIABLE_modelVariableName___State: LoadingState<___VARIABLE_modelName___> = .idle
    public var focusedField: FocusField?

    public var alert: AppAlert?
    public var isDismissed: Bool = false

    /// Constants
    public let mode: EditMode
    public let ___VARIABLE_modelVariableName___Id: UUID

    /// Checks
    var isEmptyForm: Bool {
        name.isEmpty && note.isEmpty && url == nil
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

    /// Initialization
    public init(_ mode: EditMode) {
        self.mode = mode
        switch mode {
        case let .edit(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
            ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
            setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case let .editId(id):
            ___VARIABLE_modelVariableName___Id = id
        case .create:
            ___VARIABLE_modelVariableName___Id = UUID()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___EditViewState {
    func update(_ handler: @Sendable @MainActor (___VARIABLE_modelName___EditViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }

    func setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        name = ___VARIABLE_modelVariableName___.name
        note = ___VARIABLE_modelVariableName___.note ?? ""
        color = ___VARIABLE_modelVariableName___.color
        date = ___VARIABLE_modelVariableName___.date
        isFavorite = ___VARIABLE_modelVariableName___.isFavorite
        isArchive = ___VARIABLE_modelVariableName___.isArchive
        
        #if os(macOS)
        if let imageData = ___VARIABLE_modelVariableName___.imageData {
            image = NSImage(data: imageData)
        }
        #else
        if let imageData = ___VARIABLE_modelVariableName___.imageData {
            image = UIImage(data: imageData)
        }
        #endif
    }
    
    func resetForm() {
        name = ""
        note = ""
        color = .blue
        url = nil
        date = Date()
        isFavorite = false
        isArchive = false
        image = nil
    }
    
    var imageData: Data? {
        #if os(macOS)
        return image?.tiffRepresentation
        #else
        return image?.jpegData(compressionQuality: 0.8)
        #endif
    }
}

// MARK: - EditMode types

public extension ___VARIABLE_modelName___EditViewState {
    enum EditMode {
        case create, edit(___VARIABLE_modelName___), editId(UUID)
    }

    /// FocusFields
    enum FocusField: Hashable, Sendable {
        case name, note, url
    }
}
