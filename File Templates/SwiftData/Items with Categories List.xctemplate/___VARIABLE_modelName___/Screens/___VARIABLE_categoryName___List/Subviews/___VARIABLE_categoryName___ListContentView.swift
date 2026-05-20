// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

/// Reusable content view component for displaying ___VARIABLE_categoryName___ lists
public struct ___VARIABLE_categoryName___ListContentView: View {
    public enum Action: Sendable {
        case onTapItem(___VARIABLE_categoryName___)
        case onTapEditCategory(___VARIABLE_categoryName___)
        case onTapToggleFavorite(___VARIABLE_categoryName___)
        case onTapDuplicateCategory(___VARIABLE_categoryName___)
        case onTapDeleteCategory(___VARIABLE_categoryName___)
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
        ListSection {
            ForEach(___VARIABLE_categoryPluralVariableName___) { ___VARIABLE_categoryVariableName___ in
                ___VARIABLE_categoryName___Row(___VARIABLE_categoryVariableName___, viewOption: viewOption) {
                    onAction(.onTapItem(___VARIABLE_categoryVariableName___))
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        onAction(.onTapDeleteCategory(___VARIABLE_categoryVariableName___))
                    } label: {
                        Label {
                            Text("Delete")
                        } icon: {
                            Image.Editor.Trash.fill
                        }
                    }
                    .tint(.error)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button {
                        onAction(.onTapToggleFavorite(___VARIABLE_categoryVariableName___))
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
    private func contextMenu(for category: ___VARIABLE_categoryName___) -> some View {
        Button(action: {
            onAction(.onTapEditCategory(category))
        }) {
            Label {
                Text(L10n.Button.edit)
            } icon: {
                Image.Design.PencilAndSquare.mini
            }
        }
        .tint(.onSurfacePrimary)

        Button(action: {
            onAction(.onTapToggleFavorite(category))
        }) {
            Label {
                Text(category.isFavorite ? "Unfavorite" : "Favorite")
            } icon: {
                if category.isFavorite {
                    Image.Base.Unstar.mini
                } else {
                    Image.Base.Star.mini
                }
            }
        }
        .tint(.onSurfacePrimary)

        Button(action: {
            onAction(.onTapDuplicateCategory(category))
        }) {
            Label {
                Text("Duplicate")
            } icon: {
                Image.Documentation.Copy.mini
            }
        }
        .tint(.onSurfacePrimary)

        Button(role: .destructive, action: {
            onAction(.onTapDeleteCategory(category))
        }) {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Editor.TrashWithLines.mini
            }
        }
        .tint(.error)
    }
}
