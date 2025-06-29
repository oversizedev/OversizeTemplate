 // ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___DetailScreen: View {
    
    /// Global
    @Environment(Router<___VARIABLE_routerDestinationType___>.self) var router: Router
    @Environment(AlertRouter.self) var alertRouter
    @Environment(HUDRouter.self) var hud: HUDRouter
    @Environment(\.modelContext) private var context: ModelContext
    
    /// Local
    private var viewModel: ___VARIABLE_modelName___DetailViewModel
    
    /// Init
    public init(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        viewModel = .init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
    }

    public var body: some View {
        Page(
            viewModel.___VARIABLE_modelVariableName___.name,
            headerHeight: 240,
            onScroll: onScroll
        ) {
            content(viewModel.___VARIABLE_modelVariableName___)
        } header: {
            header
        }
        .backgroundSecondary()
        .toolbar(content: toolbarContent)
        .onAppear(perform: onViewAction)
    }
    
    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        VStack(alignment: .leading, spacing: .xxSmall) {
            Text(___VARIABLE_modelVariableName___.name)
        }
        .surfaceRadius(.xLarge)
        .padding(.horizontal, .xxSmall)
        .padding(.vertical, .xxSmall)
    }
}


// MARK: - Header

private extension ___VARIABLE_modelName___DetailScreen {
    private var header: some View {
        VStack {
            Text("Header")
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .background {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                LinearGradient(
                    colors: [
                        viewModel.___VARIABLE_modelVariableName___.color,
                        Color.surfaceSecondary,
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                Divider()
                    .opacity(1 - viewModel.headerVisibleRatio)
            }
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___DetailScreen {
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        #if os(iOS)
        ToolbarItem(placement: .confirmationAction) {
            ___VARIABLE_modelName___DetailMenu(
                editAction: editAction,
                deleteAction: deleteAction
            )
        }
        #else
        ToolbarItemGroup(placement: .primaryAction) {
            Button(action: editAction) {
                Label {
                    Text(L10n.Button.edit)
                } icon: {
                    Image.Base.edit.icon(.onSurfaceMediumEmphasis, size: .medium)
                }
            }

            Button(action: deleteAction) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Editor.trashWithLines.icon(.onSurfaceMediumEmphasis, size: .medium)
                }
            }
        }
        #endif
    }
}

// MARK: - Actions

public extension ___VARIABLE_modelName___DetailScreen {
    private func onScroll(_ offset: CGPoint, _ headerVisibleRatio: CGFloat) {
        DispatchQueue.main.async {
            self.viewModel.offset = offset
            self.viewModel.headerVisibleRatio = headerVisibleRatio
        }
    }

    private func editAction() {
        router.present(.___VARIABLE_modelVariableName___Edit(viewModel.___VARIABLE_modelVariableName___))
    }

    private func deleteAction() {
        alertRouter.present(.delete {
            context.delete(viewModel.___VARIABLE_modelVariableName___)
            hud.present("Deleted", style: .delete)
        })
    }

    private func onViewAction() {
        delay(time: 1.5) {
            viewModel.___VARIABLE_modelVariableName___.views += 1
        }
    }
}

#Preview { @MainActor in
    ___VARIABLE_modelName___DetailScreen(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___(
        id: UUID(),
        name: "Link",
        url: URL(string: "http://oversize.app")!,
        color: Color.red
    ))
}
