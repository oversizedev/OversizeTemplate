// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___ListSidebar: View {
    @Environment(\.modelContext) private var context
    @State private var viewModel: ___VARIABLE_modelName___ListViewModel = .init()
    @State private var listSelection: ___VARIABLE_modelName___?
    
    @AppStorage("___VARIABLE_modelName___List.IsCompactMode")
    public var isCompactRow: Bool = false

    private let onItemSelected: (___VARIABLE_modelName___) -> Void

    public init(onItemSelected: @escaping (___VARIABLE_modelName___) -> Void) {
        self.onItemSelected = onItemSelected
    }

    public var body: some View {
        ScrollView {
            ___VARIABLE_modelName___ListView(
                searchTerm: viewModel.searchTerm,
                predicate: viewModel.predicate,
                sort: viewModel.sort,
                emptyAction: createAction
            ) { ___VARIABLE_modelVariableName___ in
                ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, isCompact: isCompactRow)
                    .rowOnSurface(backgroundColor: ___VARIABLE_modelVariableName___ == listSelection ? Color.accent.opacity(0.2) : Color.clear)
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
                        listSelection = ___VARIABLE_modelVariableName___
                        onItemSelected(___VARIABLE_modelVariableName___)
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
        // Create action would need router integration
    }

    private func compactRowAction() {
        isCompactRow.toggle()
    }

    private func editAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        // Edit action would need router integration
    }

    private func favoriteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___.isFavorite.toggle()
    }

    private func archiveAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___.isArchive.toggle()
    }

    private func deleteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        context.delete(___VARIABLE_modelVariableName___)
    }
}