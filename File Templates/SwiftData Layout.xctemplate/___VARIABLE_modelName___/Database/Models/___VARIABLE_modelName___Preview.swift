// ___FILEHEADER___

import Foundation
import SwiftData
import SwiftUI

@MainActor
public let ___VARIABLE_modelVariableName___PreviewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: ___VARIABLE_modelName___.self, configurations: .init(isStoredInMemoryOnly: true))
        container.mainContext.insert(___VARIABLE_modelName___SampleData.___VARIABLE_modelPluralVariableName___.first!)
        return container
    } catch {
        fatalError("Failed to create container.")
    }
}()

@MainActor
public let ___VARIABLE_modelPluralVariableName___PreviewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: ___VARIABLE_modelName___.self, configurations: .init(isStoredInMemoryOnly: true))
        for (index, ___VARIABLE_modelVariableName___) in ___VARIABLE_modelName___SampleData.___VARIABLE_modelPluralVariableName___.enumerated() {
            container.mainContext.insert(___VARIABLE_modelVariableName___)
        }
        return container

    } catch {
        fatalError("Failed to create container.")
    }
}()

enum ___VARIABLE_modelName___SampleData {
    static let ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___] = (1 ... 10).map {
        ___VARIABLE_modelName___(
            id: UUID(),
            name: "___VARIABLE_modelName___ \($0)",
            color: Color.accentColor,
            date: Date.now.addingTimeInterval(TimeInterval($0 * 86400)),
            note: "Sample note for ___VARIABLE_modelName___ \($0)",
            isFavorite: $0 % 3 == 0,
            isArchive: false,
            viewCount: $0 * 5
        )
    }
}