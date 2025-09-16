// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

public extension ___VARIABLE_categoryName___EditViewModel {
    enum Action: Sendable {
        case onAppear
        case onCancel
        case onSave
        case onNameChanged(String)
        case onEmojiChanged(String)
        case onNoteChanged(String)
        case onColorChanged(Color)
        case onImageChanged(Data?)
    }
}

public actor ___VARIABLE_categoryName___EditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    /// ViewState
    public var state: ___VARIABLE_categoryName___EditViewState

    /// Initialization
    public init(state: ___VARIABLE_categoryName___EditViewState) {
        self.state = state
    }

    public func handleAction(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()
        case .onCancel:
            await onCancel()
        case .onSave:
            await onSave()
        case let .onNameChanged(name):
            await onNameChanged(name)
        case let .onEmojiChanged(emoji):
            await onEmojiChanged(emoji)
        case let .onNoteChanged(note):
            await onNoteChanged(note)
        case let .onColorChanged(color):
            await onColorChanged(color)
        case let .onImageChanged(imageData):
            await onImageChanged(imageData)
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___EditViewModel {
    func onAppear() async {
        if let ___VARIABLE_categoryVariableName___Id = await state.___VARIABLE_categoryVariableName___Id,
           await state.___VARIABLE_categoryVariableName___State.successResult == nil {
            await fetchCategory(___VARIABLE_categoryVariableName___Id: ___VARIABLE_categoryVariableName___Id)
        }
    }

    func onCancel() async {
        await state.set(\.isDismissed, true)
    }

    func onSave() async {
        await state.set(\.isSaving, true)
        
        do {
            if await state.isEdit {
                try await updateCategory()
            } else {
                try await createCategory()
            }
            
            await state.showHUD(.success(await state.isEdit ? "Category updated" : "Category created"))
            await state.set(\.isDismissed, true)
        } catch {
            await state.showHUD(.error(error.localizedDescription))
        }
        
        await state.set(\.isSaving, false)
    }

    func onNameChanged(_ name: String) async {
        await state.set(\.name, name)
        await state.checkFormValidation()
    }

    func onEmojiChanged(_ emoji: String) async {
        await state.set(\.emoji, emoji)
        await state.checkFormValidation()
    }

    func onNoteChanged(_ note: String) async {
        await state.set(\.note, note)
        await state.checkFormValidation()
    }

    func onColorChanged(_ color: Color) async {
        await state.set(\.color, color)
        await state.checkFormValidation()
    }

    func onImageChanged(_ imageData: Data?) async {
        await state.set(\.imageData, imageData)
        await state.checkFormValidation()
    }
}

// MARK: - Private Methods

private extension ___VARIABLE_categoryName___EditViewModel {
    func fetchCategory(___VARIABLE_categoryVariableName___Id: UUID) async {
        await state.set(\.___VARIABLE_categoryVariableName___State, .loading)
        
        do {
            let ___VARIABLE_categoryVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.getById(___VARIABLE_categoryVariableName___Id)
            await state.set(\.___VARIABLE_categoryVariableName___State, .result(___VARIABLE_categoryVariableName___))
            await state.setFields(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        } catch {
            await state.set(\.___VARIABLE_categoryVariableName___State, .error(error))
        }
    }

    func createCategory() async throws {
        let ___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryName___(
            imageData: await state.imageData,
            name: await state.name.trimmingCharacters(in: .whitespacesAndNewlines),
            emoji: await state.emoji.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : await state.emoji,
            color: await state.color,
            date: Date(),
            note: await state.note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : await state.note,
            isFavorite: false,
            viewCount: 0,
            index: 0
        )
        
        try await ___VARIABLE_categoryVariableName___StorageService.create(___VARIABLE_categoryVariableName___)
    }

    func updateCategory() async throws {
        guard let existing___VARIABLE_categoryName___ = await state.___VARIABLE_categoryVariableName___State.successResult else {
            throw NSError(domain: "CategoryEditError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Category not found"])
        }
        
        let updated___VARIABLE_categoryName___ = ___VARIABLE_categoryName___(
            id: existing___VARIABLE_categoryName___.id,
            imageData: await state.imageData,
            name: await state.name.trimmingCharacters(in: .whitespacesAndNewlines),
            emoji: await state.emoji.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : await state.emoji,
            color: await state.color,
            date: existing___VARIABLE_categoryName___.date,
            note: await state.note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : await state.note,
            isFavorite: existing___VARIABLE_categoryName___.isFavorite,
            viewCount: existing___VARIABLE_categoryName___.viewCount,
            index: existing___VARIABLE_categoryName___.index
        )
        
        try await ___VARIABLE_categoryVariableName___StorageService.update(updated___VARIABLE_categoryName___)
    }
}