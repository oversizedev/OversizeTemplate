// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeUI
import SwiftData
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___List.self)
public actor ___VARIABLE_categoryName___ListViewModel: ViewModelProtocol {
    // MARK: - Services

    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData()
    }

    func onChangeSearchTerm(_ searchTerm: String) async {
        if searchTerm.isEmpty {
            await fetchData()
        } else {
            await fetchSearchedCategories(searchTerm: searchTerm)
        }
    }

    func onTapCreate___VARIABLE_categoryName___() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func onTapDetail___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        await state.update { $0.destination = .___VARIABLE_categoryVariableName___Details___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___: category) }
    }

    func onChangeSortType(_ sortType: ___VARIABLE_categoryName___SortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetchData()
    }

    func onChangeSortOrder(_ sortOrder: ___VARIABLE_categoryName___SortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetchData()
    }

    func onChangeFilterType(_ filterType: ___VARIABLE_categoryName___FilterType) async {
        await state.update { $0.filterType = filterType }
        await fetchData()
    }

    func onChangeViewOption(_ viewOption: ___VARIABLE_categoryName___ViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
    }

    func onCategoryAction(_ action: ___VARIABLE_categoryName___ListContentView.Action) async {
        switch action {
        case let .onTapItem(category):
            await onTapDetail___VARIABLE_categoryName___(category)
        case let .onTapEditCategory(category):
            await tapEdit___VARIABLE_categoryName___(category)
        case let .onTapToggleFavorite(category):
            await tapToggleFavorite(category)
        case let .onTapDuplicateCategory(category):
            await tapDuplicate___VARIABLE_categoryName___(category)
        case let .onTapDeleteCategory(category):
            await tapDelete___VARIABLE_categoryName___(category)
        }
    }
}

// MARK: - Internal methods

private extension ___VARIABLE_categoryName___ListViewModel {
    func tapDelete___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    do {
                        try await self.___VARIABLE_categoryVariableName___StorageService.delete(category)
                        await self.state.update { $0.hud = .delete() }
                        await self.fetchData()
                    } catch {
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func tapEdit___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        logUI("Edit action triggered for ___VARIABLE_categoryName___: \(category.name)")
        await state.update {
            $0.destination = .___VARIABLE_categoryVariableName___Edit(
                category,
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func tapToggleFavorite(_ category: ___VARIABLE_categoryName___) async {
        let wasFavorite = category.isFavorite
        do {
            _ = try await ___VARIABLE_categoryVariableName___StorageService.toggleFavorite(category)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func tapDuplicate___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        do {
            _ = try await ___VARIABLE_categoryVariableName___StorageService.duplicate(category)
            await state.update { $0.hud = .success("Duplicated") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func fetchSearchedCategories(searchTerm: String) async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        do {
            let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.search(
                query: searchTerm,
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder
            )

            await state.update {
                $0.state = .result(.init(___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___))
            }

        } catch {
            await state.update { $0.state = .error(error) }
        }
    }

    func fetchData() async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        do {
            let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.fetch(
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder
            )

            await state.update {
                $0.state = .result(.init(___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___))
            }
        } catch {
            await state.update { $0.state = .error(error) }
        }
    }
}
