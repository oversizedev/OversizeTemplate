// ___FILEHEADER___

import Env
import Services
import FactoryKit
import Models
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___Detail.self)
public actor ___VARIABLE_categoryName___DetailViewModel: ViewModelProtocol {
    @Injected(\.___VARIABLE_categoryVariableName___Service) private var ___VARIABLE_categoryVariableName___Service: ___VARIABLE_categoryName___Service
    @Injected(\.___VARIABLE_modelVariableName___Service) private var ___VARIABLE_modelVariableName___Service: ___VARIABLE_modelName___Service

    private var saveTask: Task<Void, Never>?

    // MARK: - User Actions

    func onAppear() async {
        let hasLoadedData = await state.state.result != nil
        await fetchData(showsLoading: !hasLoadedData)
    }

    func onTapEdit() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.state.result?.___VARIABLE_categoryVariableName___ else { return }
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Edit(
                ___VARIABLE_categoryVariableName___,
                onSave: Callback { updatedCategory in
                    Task {
                        await self.fetchData()
                        self.output?.onEdit?(updatedCategory)
                    }
                }
            )
        }
    }

    func onTapDelete() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.state.result?.___VARIABLE_categoryVariableName___ else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task { await self.delete(___VARIABLE_categoryVariableName___) }
            }
        }
    }

    func onTapToggleFavorite() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.state.result?.___VARIABLE_categoryVariableName___ else { return }
        await performWrite {
            let updatedCategory = try await self.___VARIABLE_categoryVariableName___Service.toggleFavorite(___VARIABLE_categoryVariableName___)
            await self.state.update { $0.hud = updatedCategory.isFavorite ? .favorite : .unfavorite }
            await self.fetchData()
            self.output?.onEdit?(updatedCategory)
        }
    }

    func on___VARIABLE_modelName___Action(_ action: ___VARIABLE_modelName___ListContentView.Action) async {
        switch action {
        case let .open(___VARIABLE_modelVariableName___):
            await open___VARIABLE_modelName___Detail(___VARIABLE_modelVariableName___)
        case let .edit(___VARIABLE_modelVariableName___):
            await open___VARIABLE_modelName___Edit(___VARIABLE_modelVariableName___)
        case let .toggleFavorite(___VARIABLE_modelVariableName___):
            await toggle___VARIABLE_modelName___Favorite(___VARIABLE_modelVariableName___)
        case let .duplicate(___VARIABLE_modelVariableName___):
            await duplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .delete(___VARIABLE_modelVariableName___):
            await confirmDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .assignCategory(___VARIABLE_modelVariableName___, ___VARIABLE_categoryVariableName___):
            await assignCategory(___VARIABLE_categoryVariableName___, to: ___VARIABLE_modelVariableName___)
        case let .createCategory(___VARIABLE_modelVariableName___):
            await createCategory(for: ___VARIABLE_modelVariableName___)
        }
    }
}

// MARK: - Navigation

private extension ___VARIABLE_categoryName___DetailViewModel {
    func open___VARIABLE_modelName___Detail(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
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

    func open___VARIABLE_modelName___Edit(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
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

private extension ___VARIABLE_categoryName___DetailViewModel {
    func delete(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await performWrite {
            try await self.___VARIABLE_categoryVariableName___Service.delete(___VARIABLE_categoryVariableName___)
            await self.state.update { $0.isDismissed = true }
            self.output?.onDelete?(___VARIABLE_categoryVariableName___)
        }
    }

    func toggle___VARIABLE_modelName___Favorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await performWrite {
            let updated___VARIABLE_modelName___ = try await self.___VARIABLE_modelVariableName___Service.toggleFavorite(___VARIABLE_modelVariableName___)
            await self.state.update { $0.hud = updated___VARIABLE_modelName___.isFavorite ? .favorite : .unfavorite }
            await self.fetchData()
        }
    }

    func duplicate___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await performWrite {
            _ = try await self.___VARIABLE_modelVariableName___Service.duplicate(___VARIABLE_modelVariableName___)
            await self.state.update { $0.hud = .success("Duplicated") }
            await self.fetchData()
        }
    }

    func confirmDelete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task { await self.delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___) }
            }
        }
    }

    func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await performWrite {
            try await self.___VARIABLE_modelVariableName___Service.delete(___VARIABLE_modelVariableName___)
            await self.state.update { $0.hud = .delete }
            await self.fetchData()
        }
    }

    func assignCategory(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?, to ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, showsHUD: Bool = true) async {
        await performWrite {
            _ = try await self.___VARIABLE_modelVariableName___Service.update___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, categoryId: ___VARIABLE_categoryVariableName___?.id)
            if showsHUD {
                await self.state.update { $0.hud = ___VARIABLE_categoryVariableName___ == nil ? .success("Category removed") : .success("Category assigned") }
            }
            await self.fetchData()
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

private extension ___VARIABLE_categoryName___DetailViewModel {
    func fetchData(showsLoading: Bool = false) async {
        if showsLoading {
            await state.update { $0.state = .loading }
        }
        do {
            async let ___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___Service.fetch(by: state.___VARIABLE_categoryVariableName___Id)
            async let ___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelVariableName___Service.fetch(
                sortType: .date,
                sortOrder: .descending,
                ___VARIABLE_categoryVariableName___Id: state.___VARIABLE_categoryVariableName___Id
            )
            async let ___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryVariableName___Service.fetch()
            let model = try await ___VARIABLE_categoryName___DetailViewState.StateModel(
                ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___,
                ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___,
                ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___
            )
            await state.update { $0.state = .result(model) }
        } catch {
            await state.update { $0.state = .error(error) }
        }
    }
}
