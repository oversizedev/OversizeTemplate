// ___FILEHEADER___

import Database
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
public final class MealProductEditViewState: Sendable {
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

    /// User Interface
    public var mealProductState: LoadingViewState<MealProduct> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = false

    /// Constants
    public let mode: EditMode
    public let mealProductId: UUID

    /// Checks
    var isEmptyForm: Bool {
        name.isEmpty && note.isEmpty && url == nil
    }

    var isValidForm: Bool {
        !name.isEmpty
    }

    /// View
    var title: String {
        switch mode {
        case .create:
            "Create mealProduct"
        case .edit, .editId:
            "Edit mealProduct"
        }
    }

    /// Initialization
    public init(_ mode: EditMode) {
        self.mode = mode
        switch mode {
        case let .edit(mealProduct):
            mealProductId = mealProduct.id
            mealProductState = .result(mealProduct)
            setFields(mealProduct: mealProduct)
        case let .editId(id):
            mealProductId = id
        case .create:
            mealProductId = UUID()
        }
    }
}

// MARK: - User Actions

public extension MealProductEditViewState {
    func update(_ handler: @Sendable @MainActor (MealProductEditViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }

    func setFields(mealProduct: MealProduct) {
        // Uncomment and modify based on your model properties
        // name = mealProduct.name ?? ""
        // note = mealProduct.note ?? ""
        // color = Color(mealProduct.color ?? "blue")
        // url = mealProduct.url
        // date = mealProduct.date
    }
}

// MARK: - EditMode types

public extension MealProductEditViewState {
    enum EditMode {
        case create, edit(MealProduct), editId(UUID)
    }

    /// FocusFields
    enum FocusField: Hashable, Sendable {
        case name, note, url
    }
}
