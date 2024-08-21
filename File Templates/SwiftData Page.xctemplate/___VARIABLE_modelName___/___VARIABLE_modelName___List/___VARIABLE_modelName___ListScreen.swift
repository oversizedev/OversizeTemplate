// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeComponents
import OversizeCore
import OversizeResources
import OversizeRouter
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___ListScreen: View {
    
    /// Global
    @Environment(Router<___VARIABLE_routerDestinationType___>.self) var router
    @Environment(AlertRouter.self) var alertRouter
    @Environment(HUDRouter.self) var hud
    @Environment(\.modelContext) private var context: ModelContext

    /// Local
    @State private var viewModel: ___VARIABLE_modelName___ListViewModel = .init()
    @AppStorage("___VARIABLE_modelName___ListScreen.IsCompactMode") private var isCompactRow: Bool = false
    @AppStorage("___VARIABLE_modelName___ListScreen.___VARIABLE_modelName___ListType") private var listType: ___VARIABLE_modelName___ListType = .list

    /// Init
    public init() {}

    public var body: some View {
        Page("Links") {
            ___VARIABLE_modelName___ListView(
                searchTerm: viewModel.searchTerm,
                predicate: viewModel.predicate,
                sort: viewModel.sort,
                type: listType,
                emptyAction: createAction
            ) { ___VARIABLE_modelVariableName___ in

                listItemView(___VARIABLE_modelVariableName___)
                    .contextMenu {
                        ___VARIABLE_modelName___ContextMenu(
                            editAction: { editAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) },
                            compactRowAction: compactRowAction,
                            favoriteAction: { favoriteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) },
                            archiveAction: { archiveAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) },
                            deleteAction: { deleteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                        )
                    }
            }
        }
        .backgroundSecondary()
        #if os(iOS)
            .searchable(text: $viewModel.searchTerm, isSearch: $viewModel.isSearch)
        #endif
            .toolbar {
                #if os(iOS)
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button(action: createAction) {
                        Image.Base.plus.icon()
                    }

                    ___VARIABLE_modelName___ListMenu(
                        searchAction: searchAction,
                        filterAction: filterAction
                    )
                }
                #else

                ToolbarItem(placement: .navigation) {
                    Button(action: createAction) {
                        Image.Base.Plus.square.icon(.onSurfaceMediumEmphasis, size: .medium)
                    }
                }

                ToolbarItemGroup(placement: .primaryAction) {
                    Picker("", selection: $listType) {
                        ForEach(___VARIABLE_modelName___ListType.allCases) { type in
                            type.icon.icon()
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)

                    Spacer()

                    ___VARIABLE_modelName___ListSortingMenu(sort: $viewModel.sort)
                }
                #endif
            }
        #if os(macOS)
            .searchable(text: $viewModel.searchTerm)
        #endif
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

    @ViewBuilder
    private func listItemView(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        switch listType {
        case .grid:
            ___VARIABLE_modelName___GridItem(___VARIABLE_modelVariableName___) {
                detailAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            }
        case .list:
            ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, isCompact: isCompactRow) {
                detailAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            }
        }
    }
}

// MARK: - Actions

public extension ___VARIABLE_modelName___ListScreen {
    private func createAction() {
        router.present(.___VARIABLE_modelVariableName___Create)
    }

    private func searchAction() {
        viewModel.isSearch.toggle()
    }

    private func compactRowAction() {
        isCompactRow.toggle()
    }

    private func favoriteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___.isFavorite.toggle()
        if ___VARIABLE_modelVariableName___.isFavorite {
            hud.present("Added to favorites", style: .favorite)
        } else {
            hud.present("Removed from favorites", style: .unfavorite)
        }
    }

    private func archiveAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___.isArchive.toggle()
        if ___VARIABLE_modelVariableName___.isArchive {
            hud.present("Archived", style: .archive)
        } else {
            hud.present("Unarchived", style: .unarchive)
        }
    }

    private func filterAction() {
        router.present(.___VARIABLE_modelPluralVariableName___ListSorting(sort: $viewModel.sort), detents: [.height(380)])
    }

    private func editAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        router.present(.___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___))
    }

    private func detailAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        router.move(.___VARIABLE_modelVariableName___Detail(___VARIABLE_modelVariableName___))
    }

    private func deleteAction(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        alertRouter.present(.delete {
            context.delete(___VARIABLE_modelVariableName___)
            hud.present("Deleted", style: .delete)
        })
    }
}

public enum ___VARIABLE_modelName___ListType: String, CaseIterable, Identifiable {
    case list, grid

    public var title: String {
        rawValue.capitalizingFirstLetter()
    }

    public var id: String {
        rawValue
    }

    public var icon: Image {
        switch self {
        case .list:
            Image.GridsAndLayout.List.mini
        case .grid:
            Image.GridsAndLayout.Grid.mini
        }
    }
}

#Preview { @MainActor in
    ___VARIABLE_modelName___ListScreen()
        .modelContainer(___VARIABLE_modelPluralVariableName___PreviewContainer)
}
