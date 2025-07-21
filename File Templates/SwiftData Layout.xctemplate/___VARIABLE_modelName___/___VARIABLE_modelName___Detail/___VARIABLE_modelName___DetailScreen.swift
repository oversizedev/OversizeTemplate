 // ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeNavigation
import OversizeUI
import SwiftUI

public extension ___VARIABLE_modelName___DetailScreen {
    static func build(id: UUID) -> some View {
        let viewState = ___VARIABLE_modelName___DetailViewState(___VARIABLE_modelVariableName___Id: id)
        let viewModel = ___VARIABLE_modelName___DetailViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___DetailReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___DetailScreen(viewState: viewState, reducer: reducer)
    }

    static func build(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        let viewState = ___VARIABLE_modelName___DetailViewState(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        let viewModel = ___VARIABLE_modelName___DetailViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___DetailReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___DetailScreen(viewState: viewState, reducer: reducer)
    }
}

public struct ___VARIABLE_modelName___DetailScreen: View {
    // States
    @State var viewState: ___VARIABLE_modelName___DetailViewState
    let reducer: ___VARIABLE_modelName___DetailReducer

    // Initial
    public init(viewState: ___VARIABLE_modelName___DetailViewState, reducer: ___VARIABLE_modelName___DetailReducer) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationCoverLayoutView(viewState.title) {
            stateView(viewState.___VARIABLE_modelVariableName___State)
        } cover: {
            cover
        } background: {
            Color.backgroundPrimary
        }
        .toolbar(content: toolbarContent)
        .alert(item: $viewState.alert) { $0.alert }
        .confirmationDialog(
            "Delete ___VARIABLE_modelName___",
            isPresented: $viewState.isShowingDeleteConfirmation
        ) {
            Button("Delete", role: .destructive) {
                reducer.callAsFunction(.onConfirmDelete)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This action cannot be undone.")
        }
        .task { reducer.callAsFunction(.onAppear) }
        .refreshable(action: { reducer.callAsFunction(.onRefresh) })
        .navigationMove($viewState.destination)
        .navigationBack($viewState.isDismissed)
    }

    @ViewBuilder
    private func stateView(_ state: LoadingViewState<___VARIABLE_modelName___>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___DetailPlaceholder()
        case let .result(model):
            content(model)
        case let .error(error):
            ErrorView(error)
        }
    }

    @ViewBuilder
    private var cover: some View {
        if let ___VARIABLE_modelVariableName___ = viewState.___VARIABLE_modelVariableName___State.result {
            Group {
                if let image = ___VARIABLE_modelVariableName___.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Rectangle()
                        .fill(___VARIABLE_modelVariableName___.color.gradient)
                        .overlay {
                            VStack(spacing: .medium) {
                                Image.Base.image
                                    .font(.title)
                                    .foregroundStyle(.white.opacity(0.8))
                                
                                Text(___VARIABLE_modelVariableName___.name)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .topTrailing) {
                if ___VARIABLE_modelVariableName___.isFavorite {
                    Image.Base.heart
                        .foregroundStyle(.red)
                        .font(.title2)
                        .padding(.medium)
                }
            }
        } else {
            Rectangle()
                .fill(Color.surfaceTertiary.gradient)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shimmering()
        }
    }

    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        LazyVStack(spacing: .medium) {
            // Basic Info Section
            VStack(alignment: .leading, spacing: .small) {
                SectionView("Information") {
                    VStack(spacing: .zero) {
                        Row("Name", subtitle: ___VARIABLE_modelVariableName___.name)
                        
                        if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                            Row("Note", subtitle: note)
                        }
                        
                        Row("Date Created", subtitle: ___VARIABLE_modelVariableName___.date.formatted(date: .complete, time: .shortened))
                        
                        Row("Color") {
                            HStack {
                                Circle()
                                    .fill(___VARIABLE_modelVariableName___.color)
                                    .frame(width: 20, height: 20)
                                Text(___VARIABLE_modelVariableName___.color.description)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            
            // Status Section
            VStack(alignment: .leading, spacing: .small) {
                SectionView("Status") {
                    VStack(spacing: .zero) {
                        Row("Favorite") {
                            Button {
                                reducer.callAsFunction(.onTapToggleFavorite)
                            } label: {
                                Image.Base.heart
                                    .foregroundStyle(___VARIABLE_modelVariableName___.isFavorite ? .red : .secondary)
                            }
                        }
                        
                        Row("Archived") {
                            Button {
                                reducer.callAsFunction(.onTapToggleArchive)
                            } label: {
                                Image.Base.archive
                                    .foregroundStyle(___VARIABLE_modelVariableName___.isArchive ? .primary : .secondary)
                            }
                        }
                        
                        Row("View Count", subtitle: "\(___VARIABLE_modelVariableName___.viewCount)")
                    }
                }
            }
            
            // Actions Section
            VStack(alignment: .leading, spacing: .small) {
                SectionView("Actions") {
                    VStack(spacing: .zero) {
                        Row("Edit") {
                            Button {
                                reducer.callAsFunction(.onTapEdit)
                            } label: {
                                Image.Base.edit
                                    .foregroundStyle(.primary)
                            }
                        }
                        
                        Row("Duplicate") {
                            Button {
                                reducer.callAsFunction(.onTapDuplicate)
                            } label: {
                                Image.Base.copy
                                    .foregroundStyle(.primary)
                            }
                        }
                        
                        Row("Delete") {
                            Button {
                                reducer.callAsFunction(.onTapDelete)
                            } label: {
                                Image.Base.delete
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
            }
        }
        .paddingContent()
    }

    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        #if os(macOS)
        ToolbarItemGroup(placement: .primaryAction) {
            if let ___VARIABLE_modelVariableName___ = viewState.___VARIABLE_modelVariableName___State.result {
                Button {
                    reducer.callAsFunction(.onTapToggleFavorite)
                } label: {
                    Image.Base.heart
                        .foregroundStyle(___VARIABLE_modelVariableName___.isFavorite ? .red : .secondary)
                }
                
                Button {
                    reducer.callAsFunction(.onTapEdit)
                } label: {
                    Image.Base.edit.icon()
                }
                
                Button {
                    reducer.callAsFunction(.onTapDelete)
                } label: {
                    Image.Editor.trashWithLines.icon(
                        .onSurfaceSecondary,
                        size: .medium
                    )
                }
            }
        }
        #else
        ToolbarItem(placement: .confirmationAction) {
            if let ___VARIABLE_modelVariableName___ = viewState.___VARIABLE_modelVariableName___State.result {
                Menu {
                    Button {
                        reducer.callAsFunction(.onTapEdit)
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }

                    Button {
                        reducer.callAsFunction(.onTapDuplicate)
                    } label: {
                        Label("Duplicate", systemImage: "doc.on.doc")
                    }

                    Divider()

                    Button {
                        reducer.callAsFunction(.onTapToggleFavorite)
                    } label: {
                        Label(
                            ___VARIABLE_modelVariableName___.isFavorite ? "Remove from Favorites" : "Add to Favorites",
                            systemImage: ___VARIABLE_modelVariableName___.isFavorite ? "heart.slash" : "heart"
                        )
                    }

                    Button {
                        reducer.callAsFunction(.onTapToggleArchive)
                    } label: {
                        Label(
                            ___VARIABLE_modelVariableName___.isArchive ? "Unarchive" : "Archive",
                            systemImage: ___VARIABLE_modelVariableName___.isArchive ? "archivebox.circle" : "archivebox"
                        )
                    }

                    Divider()

                    Button(role: .destructive) {
                        reducer.callAsFunction(.onTapDelete)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                } label: {
                    Image.Base.more.icon()
                }
            }
        }
        #endif
    }
}
