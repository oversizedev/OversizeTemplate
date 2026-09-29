// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeLocalizable
import OversizeUI
import SwiftUI

public struct ___VARIABLE_modelName___ListContentView: View {
    public enum Action: Sendable {
        case open(___VARIABLE_modelName___)
        case edit(___VARIABLE_modelName___)
        case toggleFavorite(___VARIABLE_modelName___)
        case duplicate(___VARIABLE_modelName___)
        case delete(___VARIABLE_modelName___)
        case assignCategory(___VARIABLE_modelName___, ___VARIABLE_categoryName___?)
        case createCategory(for: ___VARIABLE_modelName___)
    }

    private let title: String?
    private let ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
    private let ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    private let viewOption: ___VARIABLE_modelName___ViewOption
    private let onAction: (Action) -> Void

    public init(
        _ title: String? = nil,
        ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___],
        ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___] = [],
        viewOption: ___VARIABLE_modelName___ViewOption = .standard,
        onAction: @escaping (Action) -> Void
    ) {
        self.title = title
        self.___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelPluralVariableName___
        self.___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryPluralVariableName___
        self.viewOption = viewOption
        self.onAction = onAction
    }

    public var body: some View {
        if let title {
            Section(title) {
                rows
            }
        } else {
            Section {
                rows
            }
        }
    }

    private var rows: some View {
        ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
            ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, viewOption: viewOption) {
                onAction(.open(___VARIABLE_modelVariableName___))
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button {
                    onAction(.delete(___VARIABLE_modelVariableName___))
                } label: {
                    Label {
                        Text(L10n.Button.delete)
                    } icon: {
                        Image.Editor.Trash.fill
                    }
                }
                .tint(.error)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                Button {
                    onAction(.toggleFavorite(___VARIABLE_modelVariableName___))
                } label: {
                    Label {
                        Text(___VARIABLE_modelVariableName___.isFavorite ? "Unfavorite" : "Favorite")
                    } icon: {
                        ___VARIABLE_modelVariableName___.isFavorite ? Image.Base.Unstar.fill : Image.Base.Star.fill
                    }
                }
                .tint(.warning)
            }
            .contextMenu { contextMenu(for: ___VARIABLE_modelVariableName___) }
            .listRowSeparator(.hidden)
        }
    }

    @ViewBuilder
    private func contextMenu(for ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        Button {
            onAction(.edit(___VARIABLE_modelVariableName___))
        } label: {
            Label {
                Text(L10n.Button.edit)
            } icon: {
                Image.Design.PencilAndSquare.mini
            }
        }
        .tint(.onSurfacePrimary)

        ___VARIABLE_categoryName___Menu(
            selected___VARIABLE_categoryName___Id: ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id,
            ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___,
            onSelect___VARIABLE_categoryName___: { onAction(.assignCategory(___VARIABLE_modelVariableName___, $0)) },
            onTapCreate___VARIABLE_categoryName___: { onAction(.createCategory(for: ___VARIABLE_modelVariableName___)) }
        )
        .tint(.onSurfacePrimary)

        Button {
            onAction(.toggleFavorite(___VARIABLE_modelVariableName___))
        } label: {
            Label {
                Text(___VARIABLE_modelVariableName___.isFavorite ? "Unfavorite" : "Favorite")
            } icon: {
                ___VARIABLE_modelVariableName___.isFavorite ? Image.Base.Unstar.mini : Image.Base.Star.mini
            }
        }
        .tint(.onSurfacePrimary)

        Button {
            onAction(.duplicate(___VARIABLE_modelVariableName___))
        } label: {
            Label {
                Text("Duplicate")
            } icon: {
                Image.Documentation.Copy.mini
            }
        }
        .tint(.onSurfacePrimary)

        Button(role: .destructive) {
            onAction(.delete(___VARIABLE_modelVariableName___))
        } label: {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Editor.TrashWithLines.mini
            }
        }
        .tint(.error)
    }
}

#Preview {
    List {
        ___VARIABLE_modelName___ListContentView(
            ___VARIABLE_modelPluralVariableName___: [
                .init(name: "Netflix", color: .red, date: .now, isFavorite: true),
                .init(name: "Spotify", color: .green, date: .now),
            ],
            onAction: { _ in }
        )
    }
}
