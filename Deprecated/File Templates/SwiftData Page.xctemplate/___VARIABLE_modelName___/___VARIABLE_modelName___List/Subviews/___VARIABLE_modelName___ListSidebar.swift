// ___FILEHEADER___
/*
import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___ListSidebar: View {
    @Environment(\.router)
    private var router

    @Environment(\.modelContext)
    private var context

    @State
    private var viewModel: ___VARIABLE_modelName___ListViewModel = .init()

    @AppStorage("___VARIABLE_modelName___List.IsCompactMode")
    public var isCompactRow: Bool = false

    public init() {}

    public var body: some View {
        ScrollView {
            ___VARIABLE_modelName___ListView(
                searchTerm: viewModel.searchTerm,
                predicate: viewModel.predicate,
                sort: viewModel.sort,
                emptyAction: createAction
            ) { ___VARIABLE_modelVariableName___ in

                ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, isCompact: isCompactRow)
                    .rowOnSurface(backgroundColor: ___VARIABLE_modelVariableName___ == viewModel.listSelection ? Color.accent.opacity(0.2) : Color.clear)
                    .contentShape(Rectangle())
                    .contextMenu {
                        ___VARIABLE_modelName___ContextMenu(
                            editAction: { editAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) },
                            compactRowAction: compactRowAction,
                            favoriteAction: { favoriteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) },
                            archiveAction: { archiveAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) },
                            deleteAction: { deleteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                        )
                    }
                    .padding(.horizontal, .xSmall)
                    .rowContentMargins(.init(horizontal: .zero, vertical: .zero))
                    .surfaceContentMargins(.init(horizontal: .small, vertical: .xxSmall))
                    .surfaceRadius(.small)
                    .onTapGesture {
                        viewModel.listSelection = ___VARIABLE_modelVariableName___
                    }
            }
            .padding(.top, .xSmall)
        }
        .background(Color.backgroundPrimary)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: createAction) {
                    Image.Base.Plus.square.icon(.onSurfaceMediumEmphasis, size: .medium)
                }
            }

            ToolbarItem(placement: .primaryAction) {
                ___VARIABLE_modelName___ListSortingMenu(sort: $viewModel.sort)
            }
        }
        .searchable(text: $viewModel.searchTerm)
        .onChange(of: viewModel.listSelection) { _, newValue in
            router(.menu(.___VARIABLE_modelVariableName___Detail(newValue)))
        }
        .onChange(of: viewModel.searchTerm) { old, new in
            guard old != new else { return }
            if new.isEmpty {
                viewModel.predicate = .true
            } else {
                viewModel.predicate = #Predicate<___VARIABLE_modelName___> {
                    $0.name.contains(new)
                }
            }
        }
    }
}

// MARK: - Actions

public extension ___VARIABLE_modelName___ListSidebar {
    private func createAction() {
        router(.present(.___VARIABLE_modelVariableName___Create))
    }

    private func searchAction() {
        viewModel.isSearch.toggle()
    }

    private func compactRowAction() {
        isCompactRow.toggle()
    }

    private func filterAction() {
        router(.present(.___VARIABLE_modelPluralVariableName___ListSorting(sort: $viewModel.sort), detents: [.height(380)]))
    }

    private func editAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        router(.present(.___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___)))
    }

    private func detailAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        router(.move(.___VARIABLE_modelVariableName___Detail(___VARIABLE_modelVariableName___)))
    }

    private func favoriteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___.isFavorite.toggle()
        if ___VARIABLE_modelVariableName___.isFavorite {
            router(.presentHUD("Pinned"))
        } else {
            router(.presentHUD("Unpinned"))
        }
    }

    private func archiveAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___.isArchive.toggle()
        if ___VARIABLE_modelVariableName___.isArchive {
            router(.presentHUD("Archived"))
        } else {
            router(.presentHUD("Unarchived"))
        }
    }

    private func deleteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        router(.presentAlert(.delete {
            context.delete(___VARIABLE_modelVariableName___)
            router(.presentHUD("Deleted"))
        }))
    }
}
*/
