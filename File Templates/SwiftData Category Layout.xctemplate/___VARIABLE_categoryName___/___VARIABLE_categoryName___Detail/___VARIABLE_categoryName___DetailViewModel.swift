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

public struct ___VARIABLE_categoryName___DetailViewModel: ViewModelProtocol {
    @Bindable var state: ___VARIABLE_categoryName___DetailViewState

    @Dependency(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService

    public init(state: ___VARIABLE_categoryName___DetailViewState) {
        self.state = state
    }

    public func reduce(_ action: ___VARIABLE_categoryName___DetailTypes.Action) {
        switch action {
        case .onAppear:
            load___VARIABLE_categoryName___()
            increment___VARIABLE_categoryName___ViewCount()
        case .onRefresh:
            load___VARIABLE_categoryName___()
        case .onTapEdit:
            if case let .result(___VARIABLE_categoryVariableName___) = state.___VARIABLE_categoryVariableName___State {
                state.destination = .edit___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
            }
        case .onTapDelete:
            delete___VARIABLE_categoryName___()
        case .onTapDuplicate:
            duplicate___VARIABLE_categoryName___()
        case .onToggleFavorite:
            toggleFavorite()
        }
    }
}

private extension ___VARIABLE_categoryName___DetailViewModel {
    func load___VARIABLE_categoryName___() {
        Task {
            do {
                let ___VARIABLE_categoryVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.fetch(by: state.___VARIABLE_categoryVariableName___Id)
                await MainActor.run {
                    if let ___VARIABLE_categoryVariableName___ {
                        state.___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
                    } else {
                        state.___VARIABLE_categoryVariableName___State = .error(AppError.custom("___VARIABLE_categoryName___ not found"))
                    }
                }
            } catch {
                logError("Error loading ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.___VARIABLE_categoryVariableName___State = .error(error)
                }
            }
        }
    }

    func increment___VARIABLE_categoryName___ViewCount() {
        Task {
            do {
                try await ___VARIABLE_categoryVariableName___StorageService.incrementViewCount(state.___VARIABLE_categoryVariableName___Id)
            } catch {
                logError("Error incrementing view count for ___VARIABLE_categoryVariableName___: \(error)")
            }
        }
    }

    func delete___VARIABLE_categoryName___() {
        guard case let .result(___VARIABLE_categoryVariableName___) = state.___VARIABLE_categoryVariableName___State else { return }
        
        Task {
            do {
                try await ___VARIABLE_categoryVariableName___StorageService.delete(___VARIABLE_categoryVariableName___)
                await MainActor.run {
                    state.hud = .success("___VARIABLE_categoryName___ deleted")
                    // Navigate back after deletion
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // This would typically trigger navigation back
                    }
                }
            } catch {
                logError("Error deleting ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.alert = .init(error: error)
                }
            }
        }
    }

    func duplicate___VARIABLE_categoryName___() {
        guard case let .result(___VARIABLE_categoryVariableName___) = state.___VARIABLE_categoryVariableName___State else { return }
        
        Task {
            do {
                let duplicated___VARIABLE_categoryName___ = ___VARIABLE_categoryName___(
                    name: "\(___VARIABLE_categoryVariableName___.name) Copy",
                    emoji: ___VARIABLE_categoryVariableName___.emoji,
                    color: ___VARIABLE_categoryVariableName___.color,
                    date: Date(),
                    note: ___VARIABLE_categoryVariableName___.note,
                    isFavorite: false,
                    viewCount: 0,
                    index: ___VARIABLE_categoryVariableName___.index
                )
                try await ___VARIABLE_categoryVariableName___StorageService.save(duplicated___VARIABLE_categoryName___)
                await MainActor.run {
                    state.hud = .success("___VARIABLE_categoryName___ duplicated")
                }
            } catch {
                logError("Error duplicating ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.alert = .init(error: error)
                }
            }
        }
    }

    func toggleFavorite() {
        guard case let .result(___VARIABLE_categoryVariableName___) = state.___VARIABLE_categoryVariableName___State else { return }
        
        Task {
            do {
                try await ___VARIABLE_categoryVariableName___StorageService.toggleFavorite(___VARIABLE_categoryVariableName___)
                load___VARIABLE_categoryName___() // Reload to get updated state
            } catch {
                logError("Error toggling favorite for ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.alert = .init(error: error)
                }
            }
        }
    }
}

public enum ___VARIABLE_categoryName___DetailTypes {
    public enum Action: Sendable {
        case onAppear
        case onRefresh
        case onTapEdit
        case onTapDelete
        case onTapDuplicate
        case onToggleFavorite
    }
}