// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeLocalizable
import OversizeUI
import SwiftUI

/// Reusable content view component for displaying ___VARIABLE_modelName___ lists
public struct ___VARIABLE_modelName___ListContentView: View {
    public enum Action: Sendable {
        case tapItem(___VARIABLE_modelName___)
        case editProduct(___VARIABLE_modelName___)
        case toggleFavorite(___VARIABLE_modelName___)
        case duplicateProduct(___VARIABLE_modelName___)
        case deleteProduct(___VARIABLE_modelName___)
        case select___VARIABLE_categoryName___(___VARIABLE_modelName___, ___VARIABLE_categoryName___?)
        case create___VARIABLE_categoryName___For___VARIABLE_modelName___(___VARIABLE_modelName___)
    }

    private let ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
    private let ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    private let viewOption: ___VARIABLE_modelName___ViewOption
    private let onAction: (Action) -> Void

    public init(
        ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___],
        ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___] = [],
        viewOption: ___VARIABLE_modelName___ViewOption = .standard,
        onAction: @escaping (Action) -> Void
    ) {
        self.___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelPluralVariableName___
        self.___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryPluralVariableName___
        self.viewOption = viewOption
        self.onAction = onAction
    }

    public var body: some View {
        ListSection {
            ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, viewOption: viewOption) {
                    onAction(.tapItem(___VARIABLE_modelVariableName___))
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        onAction(.deleteProduct(___VARIABLE_modelVariableName___))
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
                .contextMenu { contextMenu(for: ___VARIABLE_modelVariableName___).tint(Color.onSurfacePrimary) }
                .listRowSeparator(.hidden)
            }
        }
    }

    @ViewBuilder
    private func contextMenu(for product: ___VARIABLE_modelName___) -> some View {
        Button(action: {
            onAction(.editProduct(product))
        }) {
            Label {
                Text(L10n.Button.edit)
            } icon: {
                Image.Design.PencilAndSquare.mini
            }
        }
        .tint(.onSurfacePrimary)

        Menu {
            Button(action: {
                onAction(.select___VARIABLE_categoryName___(product, nil))
            }) {
                Label {
                    Text("No Category")
                } icon: {
                    if product.___VARIABLE_categoryVariableName___Id == nil {
                        Image.Base.Check.mini
                    }
                }
            }

            ForEach(___VARIABLE_categoryPluralVariableName___) { category in
                Button(action: {
                    onAction(.select___VARIABLE_categoryName___(product, category))
                }) {
                    Label {
                        Text(category.name)
                    } icon: {
                        if product.___VARIABLE_categoryVariableName___Id == category.id {
                            Image.Base.Check.mini
                        }
                    }
                }
            }

            Divider()

            Button(action: {
                onAction(.create___VARIABLE_categoryName___For___VARIABLE_modelName___(product))
            }) {
                Label {
                    Text("Create New")
                } icon: {
                    Image.Base.Plus.mini
                }
            }
        } label: {
            Label {
                Text("Category")
            } icon: {
                Image.Base.Folder.mini
            }
        }
        .menuStyle(.button)
        .tint(.onSurfacePrimary)

        Button(action: {
            onAction(.toggleFavorite(product))
        }) {
            Label {
                Text(product.isFavorite ? "Unfavorite" : "Favorite")
            } icon: {
                if product.isFavorite {
                    Image.Base.Unstar.mini
                } else {
                    Image.Base.Star.mini
                }
            }
        }
        .tint(.onSurfacePrimary)

        Button(action: {
            onAction(.duplicateProduct(product))
        }) {
            Label {
                Text("Duplicate")
            } icon: {
                Image.Documentation.Copy.mini
            }
        }
        .tint(.onSurfacePrimary)

        Button(role: .destructive, action: {
            onAction(.deleteProduct(product))
        }) {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Editor.TrashWithLines.mini
            }
        }
        .tint(Color.error)
    }
}
