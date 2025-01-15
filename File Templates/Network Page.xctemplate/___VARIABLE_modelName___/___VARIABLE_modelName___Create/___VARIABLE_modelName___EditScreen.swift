// ___FILEHEADER___

import OversizeAppStoreKit
import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizePhotoComponents
import OversizeRouter
import OversizeUI
import SwiftUI

public struct ___VARIABLE_modelName___EditScreen: View {
    /// Global
    @Environment(Router<Screen>.self) var router
    @Environment(AlertRouter.self) var alertRouter
    @Environment(HUDRouter.self) var hud
    @Environment(\.modelContext) private var context

    /// Local
    @State private var viewModel: ___VARIABLE_modelName___EditViewModel
    @FocusState private var focusedField: ___VARIABLE_modelName___EditViewModel.FocusField?

    /// Init
    public init(_ mode: ___VARIABLE_modelName___EditViewModel.EditMode = .create) {
        viewModel = .init(mode)
    }

    public var body: some View {
        Page(viewModel.title, onScroll: onScroll, content: content)
            .toolbar(content: toolbarContent)
            .navigationBarBackButtonHidden()
            .onAppear(perform: onAppear)
            .onChange(of: viewModel.isEmptyForm, onChangeEmptyState)
    }

    @ViewBuilder
    private func content() -> some View {
        VStack(spacing: .small) {
            titleField

            noteField

            #if !os(tvOS)
            urlField

            colorField
            #endif

            #if os(iOS)
            dateField

            imageField
            #endif
        }
        .fieldLabelPosition(.overInput)
        .controlRadius(.large)
        .paddingContent()
    }
}

// MARK: - Fields

private extension ___VARIABLE_modelName___EditScreen {
    private var titleField: some View {
        TextField("Name", text: $viewModel.name)
            .textFieldStyle(.placeholder("Name", text: $viewModel.name))
            .focused($focusedField, equals: .name)
            .submitLabel(.continue)
            .onSubmit { focusedField = .note }
    }

    private var noteField: some View {
        TextEditor(text: $viewModel.note)
            .focused($focusedField, equals: .note)
            .submitLabel(.continue)
            .onSubmit { focusedField = .url }
            .textEditorPlaceholder("Note", text: $viewModel.note)
    }

    private var urlField: some View {
        URLField(url: $viewModel.url)
            .textFieldStyle(.placeholder(
                "URL",
                text: Binding(
                    get: { viewModel.url?.absoluteString ?? "" },
                    set: { _ in })))
            .focused($focusedField, equals: .url)
            .submitLabel(.done)
            .onSubmit { focusedField = nil }
    }

    #if os(iOS)
    private var dateField: some View {
        DateField(selection: $viewModel.date)
    }
    #endif

    private var colorField: some View {
        Row("Color", trailing: {
            ColorPicker("", selection: $viewModel.color)
                .labelsHidden()
        })
        .rowOnSurface(backgroundColor: Color.surfaceSecondary)
        .surfaceContentMargins(.init(horizontal: .small, vertical: .small))
    }

    #if os(iOS)
    private var imageField: some View {
        PhotoFieldView($viewModel.image)
    }
    #endif
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___EditScreen {
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button(action: onTapCancel) {
                #if os(macOS)
                Text(L10n.Button.cancel)
                #else
                Image.Base.close.icon()
                #endif
            }
            #if !os(tvOS)
            .keyboardShortcut(.cancelAction)
            #endif
        }

        ToolbarItem(placement: .confirmationAction) {
            Button(action: onTapSave) {
                Text(L10n.Button.save)
            }
            .disabled(!viewModel.isValidForm)
            #if !os(tvOS)
                .keyboardShortcut(.defaultAction)
            #endif
        }
    }
}

// MARK: - Actions

private extension ___VARIABLE_modelName___EditScreen {
    private func onTapCancel() {
        if viewModel.isEmptyForm {
            router.backOrDismiss()
        } else {
            alertRouter.present(.dismiss {
                router.backOrDismiss()
            })
        }
    }

    private func onTapSave() {
        save()
    }

    private func onScroll(_ offset: CGPoint, _ headerVisibleRatio: CGFloat) {
        DispatchQueue.main.async {
            viewModel.offset = offset
            viewModel.headerVisibleRatio = headerVisibleRatio
        }
    }

    private func onChangeEmptyState(_: Bool, _ newValue: Bool) {
        if newValue {
            router.dismissDisabled(false)
        } else {
            router.dismissDisabled(true)
        }
    }

    private func onAppear() {
        delay(time: 0.6) {
            Task { @MainActor in
                focusedField = .name
            }
        }
    }
}

// MARK: - Saving

private extension ___VARIABLE_modelName___EditScreen {
    private func save() {
//        guard let url = viewModel.url else {
//            focusedField = .url
//            hud.present("Error in url", style: .destructive)
//            return
//        }
//
//        guard viewModel.isValidForm else {
//            hud.present("Errors in the fields", style: .destructive)
//            return
//        }
//        switch viewModel.mode {
//        case .create:
//            let ___VARIABLE_modelName___ = ___VARIABLE_modelName___(
//                id: UUID(),
//                name: viewModel.name,
//                url: url,
//                color: viewModel.color,
//                date: viewModel.date,
//                image: viewModel.image?.jpegData(compressionQuality: 1.0),
//                note: viewModel.note,
//                isFavorite: false,
//                isArchive: false
//            )
//            context.insert(___VARIABLE_modelName___)
//            hud.present("___VARIABLE_modelName___ saved", style: .success)
//
//        case let .edit(___VARIABLE_modelName___):
//            ___VARIABLE_modelName___.name = viewModel.name
//            ___VARIABLE_modelName___.colorData = .init(color: viewModel.color)
//            ___VARIABLE_modelName___.note = viewModel.note
//            ___VARIABLE_modelName___.url = url
//            if let data = viewModel.image?.jpegData(compressionQuality: 1.0),
//            ___VARIABLE_modelName___.imageData != data {
//                ___VARIABLE_modelName___.imageData = data
//            }
//            ___VARIABLE_modelName___.date = viewModel.date
//            ___VARIABLE_modelName___.url = url
//            hud.present("___VARIABLE_modelName___ edited", style: .success)
//        }
        router.backOrDismiss()
    }
}

// MARK: - FocusFields

public extension ___VARIABLE_modelName___EditScreen {
    enum FocusField: Hashable {
        case name, note, url
    }
}

// MARK: - Preview

// #Preview("Create ___VARIABLE_modelName___") {
//    NavigationStack {
//        ___VARIABLE_modelName___EditScreen(.create)
//    }
// }
//
// #Preview("Edit ___VARIABLE_modelName___") {
//    Color.backgroundTertiary.ignoresSafeArea(.all)
//        .sheet(isPresented: .constant(true)) {
//            NavigationStack {
//                ___VARIABLE_modelName___EditScreen(.edit(.init(
//                    id: UUID(),
//                    name: "Name example",
//                    url: .init(string: "https://www.apple.com")!,
//                    color: Color.red,
//                    note: "Note text"
//                )))
//            }
//        }
// }
