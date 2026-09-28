// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Env
import FactoryKit
import Models
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___List.self)
public actor ___VARIABLE_categoryName___ListViewModel: ViewModelProtocol {
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

    func onChangeFilterType(_ filterType: ___VARIABLE_categoryName___FilterType) async {
        await state.update { $0.filterType = filterType }
        await fetchData()
    }

    func onChangeSortType(_ sortType: ___VARIABLE_categoryName___SortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetchData()
    }

    func onChangeSortOrder(_ sortOrder: ___VARIABLE_categoryName___SortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetchData()
    }

    func onChangeViewOption(_ viewOption: ___VARIABLE_categoryName___ViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
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

    func onCategoryAction(_ action: ___VARIABLE_categoryName___ListContentView.Action) async {
        switch action {
        case let .open(___VARIABLE_categoryVariableName___):
            await openDetail(___VARIABLE_categoryVariableName___)
        case let .edit(___VARIABLE_categoryVariableName___):
            await openEdit(___VARIABLE_categoryVariableName___)
        case let .toggleFavorite(___VARIABLE_categoryVariableName___):
            await toggleFavorite(___VARIABLE_categoryVariableName___)
        case let .duplicate(___VARIABLE_categoryVariableName___):
            await duplicate(___VARIABLE_categoryVariableName___)
        case let .delete(___VARIABLE_categoryVariableName___):
            await confirmDelete(___VARIABLE_categoryVariableName___)
        }
    }
}

// MARK: - Navigation

private extension ___VARIABLE_categoryName___ListViewModel {
    func openDetail(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Detail(
                ___VARIABLE_categoryVariableName___,
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

    func openEdit(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Edit(
                ___VARIABLE_categoryVariableName___,
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }
}

// MARK: - Write Operations

private extension ___VARIABLE_categoryName___ListViewModel {
    func toggleFavorite(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await performWrite {
            let updatedCategory = try await self.___VARIABLE_categoryVariableName___StorageService.toggleFavorite(___VARIABLE_categoryVariableName___)
            await self.state.update { $0.hud = updatedCategory.isFavorite ? .favorite : .unfavorite }
        }
    }

    func duplicate(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await performWrite {
            _ = try await self.___VARIABLE_categoryVariableName___StorageService.duplicate(___VARIABLE_categoryVariableName___)
            await self.state.update { $0.hud = .success("Duplicated") }
        }
    }

    func confirmDelete(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task { await self.delete(___VARIABLE_categoryVariableName___) }
            }
        }
    }

    func delete(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await performWrite {
            try await self.___VARIABLE_categoryVariableName___StorageService.delete(___VARIABLE_categoryVariableName___)
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
                Log.error("___VARIABLE_categoryName___ write failed:", error: error)
                await state.update { $0.alert = .error(error) }
            }
        }
        saveTask = task
        await task.value
    }
}

// MARK: - Data Fetching

private extension ___VARIABLE_categoryName___ListViewModel {
    func fetchData(showsLoading: Bool = false) async {
        if showsLoading {
            await state.update { $0.state = .loading }
        }

        let query = await ___VARIABLE_categoryName___ListQuery(state)

        do {
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
            await state.update { viewState in
                guard query == .init(viewState) else { return }
                viewState.state = .result(.init(___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___))
            }
        } catch {
            await state.update { viewState in
                guard query == .init(viewState) else { return }
                viewState.state = .error(error)
            }
        }
    }
}
