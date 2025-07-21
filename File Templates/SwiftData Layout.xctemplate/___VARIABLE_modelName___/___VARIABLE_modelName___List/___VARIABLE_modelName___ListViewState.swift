// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import SwiftData
import SwiftUI
import OversizeNavigation

@MainActor
@Observable
public final class ___VARIABLE_modelName___ListViewState: Sendable {
    /// App Storage
    public var storage = Storage()

    /// User Interface
    public var ___VARIABLE_modelPluralVariableName___State: LoadingViewState<[___VARIABLE_modelName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    
    /// Selection and Editing
    public var selectedItems: Set<UUID> = []
    public var isSelectionMode: Bool = false
    public var isShowingFilters: Bool = false
    public var isShowingSortOptions: Bool = false
    public var isShowingViewOptions: Bool = false
    
    /// Computed Properties
    public var isEmptyContent: Bool {
        ___VARIABLE_modelPluralVariableName___State.result?.isEmpty ?? true
    }
    
    public var hasSelectedItems: Bool {
        !selectedItems.isEmpty
    }
    
    public var selectedCount: Int {
        selectedItems.count
    }
    
    public var isAllSelected: Bool {
        guard let items = ___VARIABLE_modelPluralVariableName___State.result else { return false }
        return !items.isEmpty && selectedItems.count == items.count
    }
    
    public var filteredItemsCount: Int {
        ___VARIABLE_modelPluralVariableName___State.result?.count ?? 0
    }

    /// Initialization
    public init() {}
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___ListViewState {
    func update(_ handler: @Sendable @MainActor (___VARIABLE_modelName___ListViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }
    
    func toggleSelection(for ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        if selectedItems.contains(___VARIABLE_modelVariableName___.id) {
            selectedItems.remove(___VARIABLE_modelVariableName___.id)
        } else {
            selectedItems.insert(___VARIABLE_modelVariableName___.id)
        }
    }
    
    func selectAll() {
        guard let items = ___VARIABLE_modelPluralVariableName___State.result else { return }
        selectedItems = Set(items.map(\.id))
    }
    
    func deselectAll() {
        selectedItems.removeAll()
    }
    
    func toggleSelectAll() {
        if isAllSelected {
            deselectAll()
        } else {
            selectAll()
        }
    }
    
    func exitSelectionMode() {
        isSelectionMode = false
        selectedItems.removeAll()
    }
}

// MARK: - App Storage

public extension ___VARIABLE_modelName___ListViewState {
    @ObservableDefaults
    class Storage {
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.filterType)
        public var filterType: ___VARIABLE_modelName___ListFilterType = .standard
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.sortType)
        public var sortType: ___VARIABLE_modelName___ListSortType = .dateCreated
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.sortOrder)
        public var sortOrder: ___VARIABLE_modelName___ListSortOrder = .descending
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.displayType)
        public var displayType: ___VARIABLE_modelName___ListDisplayType = .list
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.gridSize)
        public var gridSize: ___VARIABLE_modelName___ListGridSize = .medium
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.isCompactMode)
        public var isCompactRow: Bool = false
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.showImages)
        public var showImages: Bool = true
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.showNotes)
        public var showNotes: Bool = true
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.showDates)
        public var showDates: Bool = true
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.lastSearchTerm)
        public var lastSearchTerm: String = ""
        
        // Computed Properties
        public var viewOptions: Set<___VARIABLE_modelName___ListViewOption> {
            var options: Set<___VARIABLE_modelName___ListViewOption> = []
            if showImages { options.insert(.showImages) }
            if showNotes { options.insert(.showNotes) }
            if showDates { options.insert(.showDates) }
            if isCompactRow { options.insert(.compactMode) }
            return options
        }
        
        public func toggleViewOption(_ option: ___VARIABLE_modelName___ListViewOption) {
            switch option {
            case .showImages:
                showImages.toggle()
            case .showNotes:
                showNotes.toggle()
            case .showDates:
                showDates.toggle()
            case .compactMode:
                isCompactRow.toggle()
            }
        }
        
        public var gridColumns: [GridItem] {
            [GridItem(.adaptive(minimum: gridSize.columnWidth), spacing: 12)]
        }
    }
}
