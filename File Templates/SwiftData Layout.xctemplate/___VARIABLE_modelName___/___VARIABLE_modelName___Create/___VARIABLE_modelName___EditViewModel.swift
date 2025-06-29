// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

@Observable
public final class ___VARIABLE_modelName___EditViewModel {
    // Edit mode
    public let mode: ___VARIABLE_modelName___EditViewModel.EditMode

    // Forms
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

    // Page
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    public init(_ mode: EditMode) {
        self.mode = mode
        setFields(mode: mode)
    }
}

public extension ___VARIABLE_modelName___EditViewModel {
    // Checks
    var isEmptyForm: Bool {
        name.isEmpty && note.isEmpty && url == nil
    }

    var isValidForm: Bool {
        !name.isEmpty && url != nil
    }

    // View
    var title: String {
        switch mode {
        case .create:
            "Create link"
        case .edit:
            "Edit link"
        }
    }
}

// MARK: - Init Fields

private extension ___VARIABLE_modelName___EditViewModel {
    private func setFields(mode: EditMode) {
        switch mode {
        case let .edit(___VARIABLE_modelVariableName___):
            name = ___VARIABLE_modelVariableName___.name
            color = ___VARIABLE_modelVariableName___.color
            note = ___VARIABLE_modelVariableName___.note ?? ""
            url = ___VARIABLE_modelVariableName___.url
            if let data = ___VARIABLE_modelVariableName___.imageData {
                #if os(macOS)
                image = NSImage(data: data)
                #else
                image = UIImage(data: data)
                #endif
            }
            date = ___VARIABLE_modelVariableName___.date
        case .create:
            break
        }
    }
}

// MARK: - EditMode types

public extension ___VARIABLE_modelName___EditViewModel {
    enum EditMode {
        case create, edit(___VARIABLE_modelName___)
    }
}
