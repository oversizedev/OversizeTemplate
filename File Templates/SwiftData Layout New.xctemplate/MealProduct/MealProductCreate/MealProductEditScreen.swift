// ___FILEHEADER___

import Database
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizePhotoComponents
import OversizeNavigation
import OversizeUI
import SwiftUI

extension MealProductEditScreen {
    static func build() -> some View {
        let viewState = MealProductEditViewState(.create)
        let viewModel = MealProductEditViewModel(state: viewState)
        let reducer = MealProductEditReducer(viewModel: viewModel)
        return MealProductEditScreen(viewState: viewState, reducer: reducer)
    }

    static func buildEdit(id: UUID) -> some View {
        let viewState = MealProductEditViewState(.editId(id))
        let viewModel = MealProductEditViewModel(state: viewState)
        let reducer = MealProductEditReducer(viewModel: viewModel)
        return MealProductEditScreen(viewState: viewState, reducer: reducer)
    }

    static func buildEdit(mealProduct: MealProduct) -> some View {
        let viewState = MealProductEditViewState(.edit(mealProduct))
        let viewModel = MealProductEditViewModel(state: viewState)
        let reducer = MealProductEditReducer(viewModel: viewModel)
        return MealProductEditScreen(viewState: viewState, reducer: reducer)
    }
}

public struct MealProductEditScreen: View {
    @Environment(\.platform) private var platform

    // States
    @State var viewState: MealProductEditViewState
    let reducer: MealProductEditReducer
    @FocusState private var focusedField: MealProductEditViewState.FocusField?

    // Initial
    public init(viewState: MealProductEditViewState, reducer: MealProductEditReducer) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView(
            viewState.title,
            content: content
        )
        .backConfirmationDialog(viewState.isEmptyForm ? nil : .discard)
        .toolbarTitleDisplayMode(.inline)
        .toolbar(content: toolbarContent)
        .task { reducer.callAsFunction(.onAppear) }
        .onChange(of: viewState.focusedField) { focusedField = $1 }
    }

    @ViewBuilder
    private func content() -> some View {
        VStack(spacing: .small) {
            titleField

            categoryField
            
            servingSizeField
            
            brandField

            noteField
            
            GroupBox("Nutrition Information") {
                VStack(spacing: .small) {
                    caloriesField
                    
                    macroFields
                    
                    optionalNutritionFields
                }
            }

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

private extension MealProductEditScreen {
    private var titleField: some View {
        TextField("Name", text: $viewState.name)
            .textFieldStyle(.placeholder("Name", text: $viewState.name))
            .focused($focusedField, equals: .name)
            .submitLabel(.continue)
            .onSubmit { focusedField = .category }
    }
    
    private var categoryField: some View {
        TextField("Category", text: $viewState.category)
            .textFieldStyle(.placeholder("Category (e.g., Dairy, Meat, Vegetables)", text: $viewState.category))
            .focused($focusedField, equals: .category)
            .submitLabel(.continue)
            .onSubmit { focusedField = .servingSize }
    }
    
    private var servingSizeField: some View {
        TextField("Serving Size", text: $viewState.servingSize)
            .textFieldStyle(.placeholder("Serving Size (e.g., 100g, 1 cup)", text: $viewState.servingSize))
            .focused($focusedField, equals: .servingSize)
            .submitLabel(.continue)
            .onSubmit { focusedField = .brand }
    }
    
    private var brandField: some View {
        TextField("Brand", text: Binding(
            get: { viewState.brand ?? "" },
            set: { viewState.brand = $0.isEmpty ? nil : $0 }
        ))
        .textFieldStyle(.placeholder("Brand (optional)", text: Binding(
            get: { viewState.brand ?? "" },
            set: { _ in }
        )))
        .focused($focusedField, equals: .brand)
        .submitLabel(.continue)
        .onSubmit { focusedField = .note }
    }
    
    private var caloriesField: some View {
        HStack {
            Text("Calories")
            Spacer()
            TextField("0", value: $viewState.calories, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 80)
                .keyboardType(.decimalPad)
        }
    }
    
    private var macroFields: some View {
        VStack(spacing: .small) {
            HStack {
                Text("Protein (g)")
                Spacer()
                TextField("0", value: $viewState.protein, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 80)
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                Text("Carbs (g)")
                Spacer()
                TextField("0", value: $viewState.carbs, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 80)
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                Text("Fat (g)")
                Spacer()
                TextField("0", value: $viewState.fat, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 80)
                    .keyboardType(.decimalPad)
            }
        }
    }
    
    private var optionalNutritionFields: some View {
        VStack(spacing: .small) {
            HStack {
                Text("Fiber (g)")
                Spacer()
                TextField("0", value: Binding(
                    get: { viewState.fiber ?? 0 },
                    set: { viewState.fiber = $0 == 0 ? nil : $0 }
                ), format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 80)
                .keyboardType(.decimalPad)
            }
            
            HStack {
                Text("Sugar (g)")
                Spacer()
                TextField("0", value: Binding(
                    get: { viewState.sugar ?? 0 },
                    set: { viewState.sugar = $0 == 0 ? nil : $0 }
                ), format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 80)
                .keyboardType(.decimalPad)
            }
            
            HStack {
                Text("Sodium (mg)")
                Spacer()
                TextField("0", value: Binding(
                    get: { viewState.sodium ?? 0 },
                    set: { viewState.sodium = $0 == 0 ? nil : $0 }
                ), format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 80)
                .keyboardType(.decimalPad)
            }
        }
    }

    private var noteField: some View {
        TextEditor(text: $viewState.note)
            .focused($focusedField, equals: .note)
            .submitLabel(.continue)
            .onSubmit { focusedField = .url }
            .textEditorPlaceholder("Note", text: $viewState.note)
    }

    private var urlField: some View {
        URLField(url: $viewState.url)
            .textFieldStyle(.placeholder(
                "URL",
                text: Binding(
                    get: { viewState.url?.absoluteString ?? "" },
                    set: { _ in }
                )
            ))
            .focused($focusedField, equals: .url)
            .submitLabel(.done)
            .onSubmit { focusedField = nil }
    }

    #if os(iOS)
    private var dateField: some View {
        DateField(selection: $viewState.date)
    }
    #endif

    private var colorField: some View {
        Row("Color", trailing: {
            ColorPicker("", selection: $viewState.color)
                .labelsHidden()
        })
        .rowOnSurface(backgroundColor: Color.surfaceSecondary)
        .surfaceContentMargins(.init(horizontal: .small, vertical: .small))
    }

    #if os(iOS)
    private var imageField: some View {
        PhotoFieldView($viewState.image)
    }
    #endif
}

// MARK: - Toolbar

private extension MealProductEditScreen {
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(action: { reducer.callAsFunction(.onTapSave) }) {
                Text(L10n.Button.save)
            }
            .disabled(!viewState.isValidForm)
            #if !os(tvOS)
                .keyboardShortcut(.defaultAction)
            #endif
        }
    }
}
