// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___DetailScreen: View {
    @StateObject private var viewModel: ___VARIABLE_categoryName___DetailViewModel
    private let reducer: Reducer<___VARIABLE_categoryName___DetailViewModel>

    public init(viewModel: ___VARIABLE_categoryName___DetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        reducer = Reducer(viewModel: viewModel)
    }

    public var body: some View {
        switch viewModel.state.___VARIABLE_categoryVariableName___State {
        case .idle:
            ProgressView()
                .onAppear { reducer(.onAppear) }
        case .loading:
            ProgressView()
        case let .result(___VARIABLE_categoryVariableName___):
            content(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        case let .error(error):
            ErrorView(error.localizedDescription)
        }
    }

    private func content(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        NavigationLayoutView(___VARIABLE_categoryVariableName___.name) {
            VStack(alignment: .leading, spacing: .large) {
                ___VARIABLE_categoryName___InfoView(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
                
                Text("___VARIABLE_modelPluralVariableName___ (\(___VARIABLE_categoryVariableName___.___VARIABLE_modelPluralVariableName___.count))")
                    .headline(.medium)
                    .foregroundStyle(.primary)
                
                // List of products in this category
                ForEach(___VARIABLE_categoryVariableName___.___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    Row(___VARIABLE_modelVariableName___.name, subtitle: ___VARIABLE_modelVariableName___.description)
                }
                
                Spacer()
            }
            .paddingContent()
        }
        .navigationDestinationAutoReceive(___VARIABLE_categoryName___Destinations.self)
        .alert(using: $viewModel.state.alert)
        .hud(using: $viewModel.state.hud)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Edit", systemImage: "pencil") {
                        reducer(.onEdit)
                    }
                    
                    Button("Duplicate", systemImage: "doc.on.doc") {
                        reducer(.onDuplicate)
                    }
                    
                    Divider()
                    
                    Button(___VARIABLE_categoryVariableName___.isFavorite ? "Remove from Favorites" : "Add to Favorites", 
                           systemImage: ___VARIABLE_categoryVariableName___.isFavorite ? "heart.fill" : "heart") {
                        reducer(.onToggleFavorite)
                    }
                    
                    Button(___VARIABLE_categoryVariableName___.isArchive ? "Unarchive" : "Archive", 
                           systemImage: ___VARIABLE_categoryVariableName___.isArchive ? "tray.and.arrow.up" : "tray.and.arrow.down") {
                        reducer(.onToggleArchive)
                    }
                    
                    Divider()
                    
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        reducer(.onDelete)
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

private struct ___VARIABLE_categoryName___InfoView: View {
    let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
    
    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            HStack {
                Circle()
                    .fill(___VARIABLE_categoryVariableName___.color)
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading, spacing: .xSmall) {
                    Text(___VARIABLE_categoryVariableName___.name)
                        .headline(.medium)
                    
                    if !___VARIABLE_categoryVariableName___.description.isEmpty {
                        Text(___VARIABLE_categoryVariableName___.description)
                            .body(.medium)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.medium)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: .medium))
    }
}

// MARK: - Builders

public extension ___VARIABLE_categoryName___DetailScreen {
    @MainActor
    static func build(id: UUID) -> some View {
        let state = ___VARIABLE_categoryName___DetailViewState(___VARIABLE_categoryVariableName___Id: id)
        let viewModel = ___VARIABLE_categoryName___DetailViewModel(state: state)
        return ___VARIABLE_categoryName___DetailScreen(viewModel: viewModel)
    }

    @MainActor
    static func build(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        let state = ___VARIABLE_categoryName___DetailViewState(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        let viewModel = ___VARIABLE_categoryName___DetailViewModel(state: state)
        return ___VARIABLE_categoryName___DetailScreen(viewModel: viewModel)
    }
}