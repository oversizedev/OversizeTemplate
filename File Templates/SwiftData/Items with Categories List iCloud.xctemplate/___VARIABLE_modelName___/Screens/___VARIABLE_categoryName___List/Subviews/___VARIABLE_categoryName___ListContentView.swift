// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Models
import OversizeLocalizable
import OversizeUI
import SwiftUI

public struct ___VARIABLE_categoryName___ListContentView: View {
    public enum Action: Sendable {
        case open(___VARIABLE_categoryName___)
        case edit(___VARIABLE_categoryName___)
        case toggleFavorite(___VARIABLE_categoryName___)
        case duplicate(___VARIABLE_categoryName___)
        case delete(___VARIABLE_categoryName___)
    }

    private let ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    private let viewOption: ___VARIABLE_categoryName___ViewOption
    private let onAction: (Action) -> Void

    public init(
        ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___],
        viewOption: ___VARIABLE_categoryName___ViewOption = .standard,
        onAction: @escaping (Action) -> Void
    ) {
        self.___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryPluralVariableName___
        self.viewOption = viewOption
        self.onAction = onAction
    }

    public var body: some View {
        Section {
            ForEach(___VARIABLE_categoryPluralVariableName___) { ___VARIABLE_categoryVariableName___ in
                ___VARIABLE_categoryName___Row(___VARIABLE_categoryVariableName___, viewOption: viewOption) {
                    onAction(.open(___VARIABLE_categoryVariableName___))
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        onAction(.delete(___VARIABLE_categoryVariableName___))
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
                        onAction(.toggleFavorite(___VARIABLE_categoryVariableName___))
                    } label: {
                        Label {
                            Text(___VARIABLE_categoryVariableName___.isFavorite ? "Unfavorite" : "Favorite")
                        } icon: {
                            ___VARIABLE_categoryVariableName___.isFavorite ? Image.Base.Unstar.fill : Image.Base.Star.fill
                        }
                    }
                    .tint(.warning)
                }
                .contextMenu { contextMenu(for: ___VARIABLE_categoryVariableName___) }
                .listRowSeparator(.hidden)
            }
        }
    }

    @ViewBuilder
    private func contextMenu(for ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        Button {
            onAction(.edit(___VARIABLE_categoryVariableName___))
        } label: {
            Label {
                Text(L10n.Button.edit)
            } icon: {
                Image.Design.PencilAndSquare.mini
            }
        }
        .tint(Color.onSurfacePrimary)

        Button {
            onAction(.toggleFavorite(___VARIABLE_categoryVariableName___))
        } label: {
            Label {
                Text(___VARIABLE_categoryVariableName___.isFavorite ? "Unfavorite" : "Favorite")
            } icon: {
                ___VARIABLE_categoryVariableName___.isFavorite ? Image.Base.Unstar.mini : Image.Base.Star.mini
            }
        }
        .tint(Color.onSurfacePrimary)

        Button {
            onAction(.duplicate(___VARIABLE_categoryVariableName___))
        } label: {
            Label {
                Text("Duplicate")
            } icon: {
                Image.Documentation.Copy.mini
            }
        }
        .tint(Color.onSurfacePrimary)

        Button(role: .destructive) {
            onAction(.delete(___VARIABLE_categoryVariableName___))
        } label: {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Editor.TrashWithLines.mini
            }
        }
        .tint(Color.error)
    }
}

#Preview {
    List {
        ___VARIABLE_categoryName___ListContentView(
            ___VARIABLE_categoryPluralVariableName___: [
                .init(name: "Video", emoji: "🎬", color: .red, date: .now, isFavorite: true),
                .init(name: "Music", emoji: "🎵", color: .blue, date: .now),
            ],
            onAction: { _ in }
        )
    }
}
