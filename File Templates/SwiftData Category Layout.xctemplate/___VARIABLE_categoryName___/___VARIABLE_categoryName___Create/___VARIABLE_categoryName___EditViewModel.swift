// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeResources
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___EditViewModel: ViewModelProtocol {
    @Bindable var state: ___VARIABLE_categoryName___EditViewState

    @Dependency(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService

    public init(state: ___VARIABLE_categoryName___EditViewState) {
        self.state = state
    }

    public func reduce(_ action: ___VARIABLE_categoryName___EditTypes.Action) {
        switch action {
        case .onTapSave:
            save___VARIABLE_categoryName___()
        case .onTapCancel:
            state.destination = nil // This would typically trigger navigation back
        }
    }
}

private extension ___VARIABLE_categoryName___EditViewModel {
    func save___VARIABLE_categoryName___() {
        guard state.isValid else { return }

        Task {
            do {
                let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___

                if let existing___VARIABLE_categoryName___ = state.___VARIABLE_categoryVariableName___ {
                    // Edit existing ___VARIABLE_categoryVariableName___
                    ___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryName___(
                        id: existing___VARIABLE_categoryName___.id,
                        name: state.name,
                        emoji: state.emoji.isEmpty ? nil : state.emoji,
                        color: state.selectedColor,
                        date: existing___VARIABLE_categoryName___.date,
                        note: state.note.isEmpty ? nil : state.note,
                        isFavorite: state.isFavorite,
                        viewCount: existing___VARIABLE_categoryName___.viewCount,
                        index: state.index
                    )
                } else {
                    // Create new ___VARIABLE_categoryVariableName___
                    ___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryName___(
                        name: state.name,
                        emoji: state.emoji.isEmpty ? nil : state.emoji,
                        color: state.selectedColor,
                        date: Date(),
                        note: state.note.isEmpty ? nil : state.note,
                        isFavorite: state.isFavorite,
                        viewCount: 0,
                        index: state.index
                    )
                }

                try await ___VARIABLE_categoryVariableName___StorageService.save(___VARIABLE_categoryVariableName___)

                await MainActor.run {
                    state.hud = .success(state.isEditMode ? "___VARIABLE_categoryName___ updated" : "___VARIABLE_categoryName___ created")
                    
                    // Navigate back after successful save
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        state.destination = nil
                    }
                }
            } catch {
                logError("Error saving ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.alert = .init(error: error)
                }
            }
        }
    }
}

public enum ___VARIABLE_categoryName___EditTypes {
    public enum Action: Sendable {
        case onTapSave
        case onTapCancel
    }
}