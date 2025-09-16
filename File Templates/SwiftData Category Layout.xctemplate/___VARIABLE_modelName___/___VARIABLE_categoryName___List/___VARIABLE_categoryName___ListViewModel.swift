//___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftData
import SwiftUI

public extension ___VARIABLE_categoryName___ListViewModel {
    enum Action: Sendable {
        case onAppear
        case onRefresh
        case onTapSearch
        case onTapCreate___VARIABLE_categoryName___
        case onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapEdit___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapDelete___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapDuplicate___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onToggleFavorite(___VARIABLE_categoryName___)
        case onTapDisplayType(___VARIABLE_categoryName___ListDisplayType)
        case onChangeSearchTerm(oldValue: String, newValue: String)
        case onChangeSortType(___VARIABLE_categoryName___SortType)
        case onChangeSortOrder(___VARIABLE_categoryName___SortOrder)
        case onChangeFilterType(___VARIABLE_categoryName___FilterType)
        case onTapArchive___VARIABLE_categoryName___s
        case onToggleCompactView
        case onChangeViewOption(___VARIABLE_categoryName___ViewOption)
        case onTapDismiss
    }
}

public actor ___VARIABLE_categoryName___ListViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    /// ViewState
    public var state: ___VARIABLE_categoryName___ListViewState

    /// Initialization
    public init(state: ___VARIABLE_categoryName___ListViewState) {
        self.state = state
    }

    public func handleAction(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()
        case .onRefresh:
            await onRefresh()
        case .onTapSearch:
            await onTapSearch()
        case .onTapCreate___VARIABLE_categoryName___:
            await onTapCreate___VARIABLE_categoryName___()
        case let .onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            await onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onTapEdit___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            await onTapEdit___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onTapDelete___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            await onTapDelete___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onTapDuplicate___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            await onTapDuplicate___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onToggleFavorite(___VARIABLE_categoryVariableName___):
            await onToggleFavorite(___VARIABLE_categoryVariableName___)
        case let .onTapDisplayType(displayType):
            await onTapDisplayType(displayType)
        case let .onChangeSearchTerm(oldValue, newValue):
            await onChangeSearchTerm(oldValue: oldValue, newValue: newValue)
        case let .onChangeSortType(sortType):
            await onChangeSortType(sortType)
        case let .onChangeSortOrder(sortOrder):
            await onChangeSortOrder(sortOrder)
        case let .onChangeFilterType(filterType):
            await onChangeFilterType(filterType)
        case .onTapArchive___VARIABLE_categoryName___s:
            await onTapArchive___VARIABLE_categoryName___s()
        case .onToggleCompactView:
            await onToggleCompactView()
        case let .onChangeViewOption(viewOption):
            await onChangeViewOption(viewOption)
        case .onTapDismiss:
            await onTapDismiss()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___ListViewModel {
    func onAppear() async {
        await fetch___VARIABLE_categoryName___s()
    }

    func onRefresh() async {
        await fetch___VARIABLE_categoryName___s()
    }

    func onTapSearch() async {
        await state.set(\.isSearch, !await state.isSearch)
    }

    func onTapCreate___VARIABLE_categoryName___() async {
        await state.set(\.destination, .create)
    }

    func onTapDetail___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await state.set(\.destination, .detail(___VARIABLE_categoryVariableName___))
    }

    func onTapEdit___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await state.set(\.destination, .edit(___VARIABLE_categoryVariableName___))
    }

    func onTapDelete___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        do {
            try await ___VARIABLE_categoryVariableName___StorageService.delete(___VARIABLE_categoryVariableName___)
            await state.showHUD(.success("___VARIABLE_categoryName___ deleted"))
            await fetch___VARIABLE_categoryName___s()
        } catch {
            await state.showAlert(.init(title: "Error", message: error.localizedDescription))
        }
    }

    func onTapDuplicate___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        let duplicate___VARIABLE_categoryName___ = ___VARIABLE_categoryName___(
            imageData: ___VARIABLE_categoryVariableName___.imageData,
            name: "\(___VARIABLE_categoryVariableName___.name) Copy",
            emoji: ___VARIABLE_categoryVariableName___.emoji,
            color: ___VARIABLE_categoryVariableName___.color,
            date: Date(),
            note: ___VARIABLE_categoryVariableName___.note,
            isFavorite: false,
            viewCount: 0,
            index: ___VARIABLE_categoryVariableName___.index
        )
        
        do {
            try await ___VARIABLE_categoryVariableName___StorageService.create(duplicate___VARIABLE_categoryName___)
            await state.showHUD(.success("___VARIABLE_categoryName___ duplicated"))
            await fetch___VARIABLE_categoryName___s()
        } catch {
            await state.showAlert(.init(title: "Error", message: error.localizedDescription))
        }
    }

    func onToggleFavorite(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        let updated___VARIABLE_categoryName___ = ___VARIABLE_categoryName___(
            id: ___VARIABLE_categoryVariableName___.id,
            imageData: ___VARIABLE_categoryVariableName___.imageData,
            name: ___VARIABLE_categoryVariableName___.name,
            emoji: ___VARIABLE_categoryVariableName___.emoji,
            color: ___VARIABLE_categoryVariableName___.color,
            date: ___VARIABLE_categoryVariableName___.date,
            note: ___VARIABLE_categoryVariableName___.note,
            isFavorite: !___VARIABLE_categoryVariableName___.isFavorite,
            viewCount: ___VARIABLE_categoryVariableName___.viewCount,
            index: ___VARIABLE_categoryVariableName___.index
        )
        
        do {
            try await ___VARIABLE_categoryVariableName___StorageService.update(updated___VARIABLE_categoryName___)
            await fetch___VARIABLE_categoryName___s()
            let message = updated___VARIABLE_categoryName___.isFavorite ? "Added to favorites" : "Removed from favorites"
            await state.showHUD(.success(message))
        } catch {
            await state.showAlert(.init(title: "Error", message: error.localizedDescription))
        }
    }

    func onTapDisplayType(_ displayType: ___VARIABLE_categoryName___ListDisplayType) async {
        await state.storage.set(\.displayType, displayType)
    }

    func onChangeSearchTerm(oldValue: String, newValue: String) async {
        await fetch___VARIABLE_categoryName___s()
    }

    func onChangeSortType(_ sortType: ___VARIABLE_categoryName___SortType) async {
        await state.storage.set(\.sortType, sortType)
        await fetch___VARIABLE_categoryName___s()
    }

    func onChangeSortOrder(_ sortOrder: ___VARIABLE_categoryName___SortOrder) async {
        await state.storage.set(\.sortOrder, sortOrder)
        await fetch___VARIABLE_categoryName___s()
    }

    func onChangeFilterType(_ filterType: ___VARIABLE_categoryName___FilterType) async {
        await state.set(\.filterType, filterType)
        await fetch___VARIABLE_categoryName___s()
    }

    func onTapArchive___VARIABLE_categoryName___s() async {
        await state.set(\.destination, .archive)
    }

    func onToggleCompactView() async {
        // Toggle compact view implementation
    }

    func onChangeViewOption(_ viewOption: ___VARIABLE_categoryName___ViewOption) async {
        await state.storage.set(\.viewOption, viewOption)
    }

    func onTapDismiss() async {
        await state.set(\.isDismissed, true)
    }
}

// MARK: - Private Methods

private extension ___VARIABLE_categoryName___ListViewModel {
    func fetch___VARIABLE_categoryName___s() async {
        await state.set(\.___VARIABLE_categoryPluralVariableName___State, .loading)
        
        do {
            let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.getAll()
            let filtered___VARIABLE_categoryName___s = await filter___VARIABLE_categoryName___s(___VARIABLE_categoryPluralVariableName___)
            await state.set(\.___VARIABLE_categoryPluralVariableName___State, .result(filtered___VARIABLE_categoryName___s))
        } catch {
            await state.set(\.___VARIABLE_categoryPluralVariableName___State, .error(error))
        }
    }

    func filter___VARIABLE_categoryName___s(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) async -> [___VARIABLE_categoryName___] {
        var filtered = ___VARIABLE_categoryPluralVariableName___
        
        // Apply search filter
        let searchTerm = await state.searchTerm
        if !searchTerm.isEmpty {
            filtered = filtered.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
        }
        
        // Apply type filter
        let filterType = await state.filterType
        switch filterType {
        case .standard:
            break // Show all
        case .favorites:
            filtered = filtered.filter { $0.isFavorite }
        case .archived:
            // Implement archived logic if needed
            break
        }
        
        // Apply sorting
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        
        filtered = filtered.sorted { lhs, rhs in
            let ascending = sortOrder == .ascending
            switch sortType {
            case .name:
                return ascending ? lhs.name < rhs.name : lhs.name > rhs.name
            case .date:
                return ascending ? lhs.date < rhs.date : lhs.date > rhs.date
            case .viewCount:
                return ascending ? lhs.viewCount < rhs.viewCount : lhs.viewCount > rhs.viewCount
            }
        }
        
        return filtered
    }
}