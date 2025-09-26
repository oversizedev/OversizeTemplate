//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryEditViewState.swift, created on 27.07.2025
//

import Database
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeNavigation
import SwiftUI

@Observable
public final class MealProductCategoryEditViewState: ViewStateProtocol {
    /// Forms
    public var name: String = .init()
    public var note: String = .init()
    public var emoji: String = .init("🥕")
    public var color: Color = .blue
    public var url: URL?
    public var date: Date?
    #if os(macOS)
    public var image: NSImage?
    #else
    public var image: UIImage?
    #endif

    /// User Interface
    public var mealProductCategoryState: LoadingState<MealProductCategory> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = .init()
    public var isDismissed: Bool = .init()
    public var isEmptyForm: Bool = true
    public var isValidForm: Bool = false
    public var hud: OversizeNavigation.HUD?

    public let emojis = "🍏🍎🍐🍊🍋🍋‍🟩🍌🍉🍇🍓🫐🍈🍒🍑🥭🍍🥥🥝🍅🍆🥑🫛🥦🥬🥒🌶🫑🌽🥕🫒🧄🧅🥔🫜🍠🫚🥐🥯🍞🥖🥨🧀🥚🍳🧈🥞🧇🥓🥩🍗🍖🦴🌭🍔🍟🍕🫓🥪🥙🧆🌮🌯🫔🥗🥘🫕🥫🫙🍝🍜🍲🍛🍣🍱🥟🦪🍤🍙🍚🍘🍥🥠🥮🍢🍡🍧🍨🍦🥧🧁🍰🎂🍮🍭🍬🍫🍿🍩🍪🌰🥜🫘🍯🥛🫗🍼🫖☕️🍵🧃🥤🧋🍶🍺🍻🥂🍷🥃🍸🍹🧉🍾🧊🥄🍴🍽🥣🥡🥢🧂🐰🐮🐷🐤🪿🦆🫎🐝🐙🦑🦐🦞🦀🐠🐟🍄‍🟫"

    /// Constants
    public let source: MealProductCategoryEditInput.Source?
    public let mealProductCategoryId: UUID

    /// View
    var title: String {
        if source == nil {
            "Create mealProductCategory"
        } else {
            "Edit \(mealProductCategoryState.successResult?.name ?? "")"
        }
    }

    /// Initialization
    public init(input: MealProductCategoryEdit.Input?) {
        source = input?.source

        switch input?.source {
        case let .category(mealProductCategory):
            mealProductCategoryId = mealProductCategory.id
            mealProductCategoryState = .result(mealProductCategory)
            setFields(mealProductCategory: mealProductCategory)
        case let .id(id):
            mealProductCategoryId = id
        case .none:
            mealProductCategoryId = UUID()
        }
    }
}

// MARK: - User Actions

public extension MealProductCategoryEditViewState {
    func setFields(mealProductCategory: MealProductCategory) {
        name = mealProductCategory.name
        emoji = mealProductCategory.emoji ?? "🥕"
        note = mealProductCategory.note ?? ""
        color = mealProductCategory.color
        date = mealProductCategory.date
        if let data = mealProductCategory.imageData {
            #if os(macOS)
            image = NSImage(data: data)
            #else
            image = UIImage(data: data)
            #endif
        }
    }
}

// MARK: - Supporting types

public extension MealProductCategoryEditViewState {
    /// FocusFields
    enum FocusField: String, Hashable, Sendable {
        case name, note, url
    }
}
