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
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService

    func onAppear() async {
        let hasLoadedData = await state.state.result != nil
        await fetchData(showsLoading: !hasLoadedData)
    }

    func onRefresh() async {
        await fetchData()
    }

    func onChangeSearchTerm(_: String) async {
        await fetchData()
    }

    func onTapCreate___VARIABLE_categoryName___() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
                onSave: Callback { [weak self] _ in
                    Task { await self?.fetchData() }
                }
            )
        }
    }

    func onTapDetail___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        await state.update {
            $0.presented___VARIABLE_categoryName___Id = category.id
            $0.destination = .___VARIABLE_categoryVariableName___Details___VARIABLE_categoryName___(
                ___VARIABLE_categoryVariableName___: category,
                onEdit: Callback { [weak self] _ in
                    Task { await self?.fetchData() }
                },
                onDelete: Callback { [weak self] deletedCategory in
                    guard let self else { return }
                    Task {
                        await self.state.update { viewState in
                            if viewState.presented___VARIABLE_categoryName___Id == deletedCategory.id {
                                viewState.hud = .delete()
                                viewState.dismissDetail = true
                            }
                        }
                        await self.fetchData()
                    }
                }
            )
        }
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

    func onTapUncategorized() async {
        await state.update { $0.destination = .___VARIABLE_modelPluralVariableName___List(filter: .uncategorized) }
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
        case .onTapUncategorized:
            await onTapUncategorized()
        }
    }
}

// MARK: - Internal methods

private extension ___VARIABLE_categoryName___ListViewModel {
    func tapDelete___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        await state.update { viewState in
            viewState.alert = .delete { [weak self] in
                guard let self else { return }
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
        Log.ui("Edit action triggered for ___VARIABLE_categoryName___: \(category.name)")
        await state.update {
            $0.destination = .___VARIABLE_categoryVariableName___Edit(
                category,
                onSave: Callback { [weak self] _ in
                    Task { await self?.fetchData() }
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

    func fetchData(showsLoading: Bool = false) async {
        if showsLoading {
            await state.update { $0.state = .loading }
        }

        let query = await ___VARIABLE_categoryName___ListQuery(state)

        do {
            async let uncategorized = ___VARIABLE_modelVariableName___StorageService.fetch(filterType: .uncategorized)
            let ___VARIABLE_categoryPluralVariableName___ = if query.searchTerm.isEmpty {
                try await ___VARIABLE_categoryVariableName___StorageService.fetch(
                    filterType: query.filterType,
                    sortType: query.sortType,
                    sortOrder: query.sortOrder
                )
            } else {
                try await ___VARIABLE_categoryVariableName___StorageService.search(
                    query: query.searchTerm,
                    filterType: query.filterType,
                    sortType: query.sortType,
                    sortOrder: query.sortOrder
                )
            }
            let hasUncategorized = await (try? uncategorized)?.isEmpty == false
            await state.update { viewState in
                guard query == .init(viewState) else { return }
                viewState.state = .result(.init(___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___, hasUncategorized: hasUncategorized))
            }
        } catch {
            await state.update { viewState in
                guard query == .init(viewState) else { return }
                viewState.state = .error(error)
            }
        }
    }
}
