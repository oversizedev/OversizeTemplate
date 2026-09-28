// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Env
import FactoryKit
import Models
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___List.self)
public actor ___VARIABLE_modelName___ListViewModel: ViewModelProtocol {
    @LazyInjected(\.___VARIABLE_modelVariableName___StorageService) private var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @LazyInjected(\.___VARIABLE_categoryVariableName___StorageService) private var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    private var saveTask: Task<Void, Never>?

    // MARK: - User Actions

    func onAppear() async {
        let hasLoadedData = await state.state.result != nil
        await fetchData(showsLoading: !hasLoadedData)
    }

    func onChangeSearchTerm(_: String) async {
        await fetchData()
    }

    func onChangeFilterType(_ filterType: ___VARIABLE_modelName___FilterType) async {
        await state.update { $0.filterType = filterType }
        await fetchData()
    }

    func onChangeSortType(_ sortType: ___VARIABLE_modelName___SortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetchData()
    }

    func onChangeSortOrder(_ sortOrder: ___VARIABLE_modelName___SortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetchData()
    }

    func onChangeViewOption(_ viewOption: ___VARIABLE_modelName___ViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
    }

    func onTapCreate___VARIABLE_modelName___() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Create(
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func onTapCategories() async {
        await state.update { $0.destination = .___VARIABLE_categoryVariableName___List }
    }

    func on___VARIABLE_modelName___Action(_ action: ___VARIABLE_modelName___ListContentView.Action) async {
        switch action {
        case let .open(___VARIABLE_modelVariableName___):
            await openDetail(___VARIABLE_modelVariableName___)
        case let .edit(___VARIABLE_modelVariableName___):
            await openEdit(___VARIABLE_modelVariableName___)
        case let .toggleFavorite(___VARIABLE_modelVariableName___):
            await toggleFavorite(___VARIABLE_modelVariableName___)
        case let .duplicate(___VARIABLE_modelVariableName___):
            await duplicate(___VARIABLE_modelVariableName___)
        case let .delete(___VARIABLE_modelVariableName___):
            await confirmDelete(___VARIABLE_modelVariableName___)
        case let .assignCategory(___VARIABLE_modelVariableName___, ___VARIABLE_categoryVariableName___):
            await assignCategory(___VARIABLE_categoryVariableName___, to: ___VARIABLE_modelVariableName___)
        case let .createCategory(___VARIABLE_modelVariableName___):
            await createCategory(for: ___VARIABLE_modelVariableName___)
        }
    }
}

// MARK: - Navigation

private extension ___VARIABLE_modelName___ListViewModel {
    func openDetail(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Detail(
                ___VARIABLE_modelVariableName___,
                onEdit: Callback { _ in
                    Task { await self.fetchData() }
                },
                onDelete: Callback { _ in
                    Task {
                        await self.state.update { $0.hud = .delete }
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func openEdit(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Edit(
                ___VARIABLE_modelVariableName___,
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func createCategory(for ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
                onSave: Callback { ___VARIABLE_categoryVariableName___ in
                    Task { await self.assignCategory(___VARIABLE_categoryVariableName___, to: ___VARIABLE_modelVariableName___, showsHUD: false) }
                }
            )
        }
    }
}

// MARK: - Write Operations

private extension ___VARIABLE_modelName___ListViewModel {
    func toggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await performWrite {
            let updated___VARIABLE_modelName___ = try await self.___VARIABLE_modelVariableName___StorageService.toggleFavorite(___VARIABLE_modelVariableName___)
            await self.state.update { $0.hud = updated___VARIABLE_modelName___.isFavorite ? .favorite : .unfavorite }
        }
    }

    func duplicate(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await performWrite {
            _ = try await self.___VARIABLE_modelVariableName___StorageService.duplicate(___VARIABLE_modelVariableName___)
            await self.state.update { $0.hud = .success("Duplicated") }
        }
    }

    func assignCategory(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?, to ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, showsHUD: Bool = true) async {
        await performWrite {
            _ = try await self.___VARIABLE_modelVariableName___StorageService.update___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, categoryId: ___VARIABLE_categoryVariableName___?.id)
            if showsHUD {
                await self.state.update { $0.hud = ___VARIABLE_categoryVariableName___ == nil ? .success("Category removed") : .success("Category assigned") }
            }
        }
    }

    func confirmDelete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task { await self.delete(___VARIABLE_modelVariableName___) }
            }
        }
    }

    func delete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await performWrite {
            try await self.___VARIABLE_modelVariableName___StorageService.delete(___VARIABLE_modelVariableName___)
            await self.state.update { $0.hud = .delete }
        }
    }

    func performWrite(_ operation: @Sendable @escaping () async throws -> Void) async {
        if let saveTask {
            return await saveTask.value
        }
        let task = Task {
            defer { saveTask = nil }
            do {
                try await operation()
                await fetchData()
            } catch {
                Log.error("___VARIABLE_modelName___ write failed:", error: error)
                await state.update { $0.alert = .error(error) }
            }
        }
        saveTask = task
        await task.value
    }
}

// MARK: - Data Fetching

private extension ___VARIABLE_modelName___ListViewModel {
    func fetchData(showsLoading: Bool = false) async {
        if showsLoading {
            await state.update { $0.state = .loading }
        }

        let query = await ___VARIABLE_modelName___ListQuery(state)

        do {
            async let ___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryVariableName___StorageService.fetch()
            let ___VARIABLE_modelPluralVariableName___ = if query.searchTerm.isEmpty {
                try await ___VARIABLE_modelVariableName___StorageService.fetch(
                    filterType: query.filterType,
                    sortType: query.sortType,
                    sortOrder: query.sortOrder
                )
            } else {
                try await ___VARIABLE_modelVariableName___StorageService.search(
                    query: query.searchTerm,
                    filterType: query.filterType,
                    sortType: query.sortType,
                    sortOrder: query.sortOrder
                )
            }
            let model = try await ___VARIABLE_modelName___ListViewState.StateModel(
                ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___,
                ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___
            )
            await state.update { viewState in
                guard query == .init(viewState) else { return }
                viewState.state = .result(model)
            }
        } catch {
            await state.update { viewState in
                guard query == .init(viewState) else { return }
                viewState.state = .error(error)
            }
        }
    }
}
