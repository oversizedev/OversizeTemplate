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

public struct ___VARIABLE_categoryName___ListViewModel: ViewModelProtocol {
    @Bindable var state: ___VARIABLE_categoryName___ListViewState

    @Dependency(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService

    public init(state: ___VARIABLE_categoryName___ListViewState) {
        self.state = state
    }

    public func reduce(_ action: ___VARIABLE_categoryName___ListTypes.Action) {
        switch action {
        case .onAppear:
            load___VARIABLE_categoryPluralVariableName___()
        case .onRefresh:
            load___VARIABLE_categoryPluralVariableName___()
        case let .onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            state.destination = .detail___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onTapEdit___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            state.destination = .edit___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case .onTapCreate___VARIABLE_categoryName___:
            state.destination = .create___VARIABLE_categoryName___
        case let .onTapDelete___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            delete___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onTapDuplicate___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            duplicate___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onToggleFavorite(___VARIABLE_categoryVariableName___):
            toggleFavorite(___VARIABLE_categoryVariableName___)
        case let .onToggleArchive(___VARIABLE_categoryVariableName___):
            toggleArchive(___VARIABLE_categoryVariableName___)
        case let .onChangeSearchTerm(oldValue, newValue):
            searchTerm(oldValue: oldValue, newValue: newValue)
        case let .onChangeFilterType(type):
            state.filterType = type
            load___VARIABLE_categoryPluralVariableName___()
        case let .onChangeSortType(type):
            state.storage.sortType = type
            load___VARIABLE_categoryPluralVariableName___()
        case let .onChangeSortOrder(order):
            state.storage.sortOrder = order
            load___VARIABLE_categoryPluralVariableName___()
        case let .onChangeViewOption(option):
            state.storage.viewOption = option
        }
    }
}

private extension ___VARIABLE_categoryName___ListViewModel {
    func load___VARIABLE_categoryPluralVariableName___() {
        Task {
            do {
                state.___VARIABLE_categoryPluralVariableName___State = .loading
                let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.fetch(
                    searchTerm: state.searchTerm,
                    sortType: state.storage.sortType,
                    sortOrder: state.storage.sortOrder,
                    filterType: state.filterType
                )
                await MainActor.run {
                    state.___VARIABLE_categoryPluralVariableName___State = .result(___VARIABLE_categoryPluralVariableName___)
                }
            } catch {
                logError("Error loading ___VARIABLE_categoryPluralVariableName___: \(error)")
                await MainActor.run {
                    state.___VARIABLE_categoryPluralVariableName___State = .error(error)
                }
            }
        }
    }

    func delete___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        Task {
            do {
                try await ___VARIABLE_categoryVariableName___StorageService.delete(___VARIABLE_categoryVariableName___)
                await MainActor.run {
                    state.hud = .success("___VARIABLE_categoryName___ deleted")
                }
                load___VARIABLE_categoryPluralVariableName___()
            } catch {
                logError("Error deleting ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.alert = .init(error: error)
                }
            }
        }
    }

    func duplicate___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        Task {
            do {
                let duplicated___VARIABLE_categoryName___ = ___VARIABLE_categoryName___(
                    name: "\(___VARIABLE_categoryVariableName___.name) Copy",
                    color: ___VARIABLE_categoryVariableName___.color,
                    date: Date(),
                    note: ___VARIABLE_categoryVariableName___.note,
                    isFavorite: false,
                    viewCount: 0
                )
                try await ___VARIABLE_categoryVariableName___StorageService.save(duplicated___VARIABLE_categoryName___)
                await MainActor.run {
                    state.hud = .success("___VARIABLE_categoryName___ duplicated")
                }
                load___VARIABLE_categoryPluralVariableName___()
            } catch {
                logError("Error duplicating ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.alert = .init(error: error)
                }
            }
        }
    }

    func toggleFavorite(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        Task {
            do {
                try await ___VARIABLE_categoryVariableName___StorageService.toggleFavorite(___VARIABLE_categoryVariableName___)
                load___VARIABLE_categoryPluralVariableName___()
            } catch {
                logError("Error toggling favorite for ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.alert = .init(error: error)
                }
            }
        }
    }

    func toggleArchive(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        Task {
            do {
                try await ___VARIABLE_categoryVariableName___StorageService.toggleArchive(___VARIABLE_categoryVariableName___)
                load___VARIABLE_categoryPluralVariableName___()
            } catch {
                logError("Error toggling archive for ___VARIABLE_categoryVariableName___: \(error)")
                await MainActor.run {
                    state.alert = .init(error: error)
                }
            }
        }
    }

    func searchTerm(oldValue: String, newValue: String) {
        if oldValue != newValue {
            Task {
                try await Task.sleep(for: .milliseconds(300))
                load___VARIABLE_categoryPluralVariableName___()
            }
        }
    }
}