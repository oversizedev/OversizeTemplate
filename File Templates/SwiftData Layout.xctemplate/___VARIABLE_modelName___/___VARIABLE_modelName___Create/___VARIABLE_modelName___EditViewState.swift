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
public final class ___VARIABLE_modelName___EditViewState: Sendable {
    /// Forms
    public var name: String = .init()
    public var note: String = .init()
    public var color: Color = .blue
    public var url: URL?
    public var date: Date = Date()
    #if os(macOS)
    public var image: NSImage?
    #else
    public var image: UIImage?
    #endif

    /// User Interface
    public var ___VARIABLE_modelVariableName___State: LoadingViewState<___VARIABLE_modelName___> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = false
    public var isDeleting: Bool = false
    public var alert: AppAlert?
    public var destination: ___VARIABLE_modelName___Destinations?
    public var isShowingDeleteConfirmation: Bool = false
    public var isShowingDiscardConfirmation: Bool = false

    /// Constants
    public let mode: EditMode
    public let ___VARIABLE_modelVariableName___Id: UUID
    public let callback: ((___VARIABLE_modelName___) -> Void)?

    /// Validation
    public var nameError: String?
    public var noteError: String?
    public var dateError: String?
    
    /// Original values for comparison
    private var originalName: String = ""
    private var originalNote: String = ""
    private var originalColor: Color = .blue
    private var originalUrl: URL?
    private var originalDate: Date = Date()
    private var originalImage: Data?

    /// Checks
    var isEmptyForm: Bool {
        name.isEmpty && note.isEmpty && url == nil && !hasChangedFromOriginal
    }

    var hasChangedFromOriginal: Bool {
        name != originalName ||
        note != originalNote ||
        color != originalColor ||
        url != originalUrl ||
        date != originalDate ||
        imageData != originalImage
    }

    var isValidForm: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        nameError == nil &&
        noteError == nil &&
        dateError == nil
    }

    var imageData: Data? {
        #if os(macOS)
        return image?.tiffRepresentation
        #else
        return image?.pngData()
        #endif
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
    public init(_ mode: EditMode, callback: ((___VARIABLE_modelName___) -> Void)? = nil) {
        self.mode = mode
        self.callback = callback
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
        url = nil // Add URL field to model if needed
        date = ___VARIABLE_modelVariableName___.date
        
        #if os(macOS)
        if let imageData = ___VARIABLE_modelVariableName___.imageData {
            image = NSImage(data: imageData)
        }
        #else
        if let imageData = ___VARIABLE_modelVariableName___.imageData {
            image = UIImage(data: imageData)
        }
        #endif
        
        // Store original values
        originalName = name
        originalNote = note
        originalColor = color
        originalUrl = url
        originalDate = date
        originalImage = ___VARIABLE_modelVariableName___.imageData
        
        // Clear any validation errors
        clearValidationErrors()
    }
    
    func validateName() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty {
            nameError = "Name is required"
        } else if trimmedName.count > 100 {
            nameError = "Name cannot exceed 100 characters"
        } else {
            nameError = nil
        }
    }
    
    func validateNote() {
        if note.count > 500 {
            noteError = "Note cannot exceed 500 characters"
        } else {
            noteError = nil
        }
    }
    
    func validateDate() {
        if date > Date() {
            dateError = "Date cannot be in the future"
        } else {
            dateError = nil
        }
    }
    
    func validateAll() {
        validateName()
        validateNote()
        validateDate()
    }
    
    func clearValidationErrors() {
        nameError = nil
        noteError = nil
        dateError = nil
    }
    
    func resetForm() {
        name = ""
        note = ""
        color = .blue
        url = nil
        date = Date()
        image = nil
        clearValidationErrors()
        focusedField = .name
    }
    
    func resetToOriginal() {
        guard case let .edit(___VARIABLE_modelVariableName___) = mode else { return }
        setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
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

// MARK: - Callback Events

public extension ___VARIABLE_modelName___EditViewState {
    enum CallbackEvent {
        case saved(___VARIABLE_modelName___)
        case deleted(___VARIABLE_modelName___)
        case cancelled
    }
    
    func triggerCallback(_ event: CallbackEvent) {
        switch event {
        case .saved(let ___VARIABLE_modelVariableName___):
            callback?(___VARIABLE_modelVariableName___)
        case .deleted, .cancelled:
            break
        }
    }
}
