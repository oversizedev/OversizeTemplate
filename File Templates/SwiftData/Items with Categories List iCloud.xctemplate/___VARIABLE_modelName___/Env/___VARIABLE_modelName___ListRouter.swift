// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Env
import NavigatorUI
import OversizeNavigation
import SwiftUI

extension ___VARIABLE_modelName___Destinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            ___VARIABLE_modelName___List.buildCached()
        case let .___VARIABLE_modelVariableName___Details(id):
            ___VARIABLE_modelName___Detail.buildCached(
                cacheKey: "___VARIABLE_modelVariableName___-detail-id\(id)",
                input: .init(id: id)
            )
        case let .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___Detail.buildCached(
                cacheKey: "___VARIABLE_modelVariableName___-detail-___VARIABLE_modelVariableName___-\(___VARIABLE_modelVariableName___.id)",
                input: .init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            )
        case let .___VARIABLE_modelVariableName___Create(onSave: onSave):
            ___VARIABLE_modelName___Edit.build(
                input: ___VARIABLE_modelName___EditInput(),
                output: .init(onSave: onSave)
            )
        case let .___VARIABLE_modelVariableName___EditId(id: id, onSave: onSave):
            ___VARIABLE_modelName___Edit.buildCached(
                cacheKey: "___VARIABLE_modelVariableName___-edit-id\(id)",
                input: .init(id: id),
                output: .init(onSave: onSave)
            )
        case let .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___, onSave: onSave):
            ___VARIABLE_modelName___Edit.buildCached(
                cacheKey: "___VARIABLE_modelVariableName___-edit-___VARIABLE_modelVariableName___-\(___VARIABLE_modelVariableName___.id)",
                input: .init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___),
                output: .init(onSave: onSave)
            )
        case .___VARIABLE_categoryPluralVariableName___List:
            ___VARIABLE_categoryName___List.buildCached()
        case let .___VARIABLE_categoryVariableName___Details(id):
            ___VARIABLE_categoryName___Detail.buildCached(
                cacheKey: "___VARIABLE_categoryVariableName___-detail-id\(id)",
                input: .init(id: id)
            )
        case let .___VARIABLE_categoryVariableName___Details___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryName___Detail.buildCached(
                cacheKey: "___VARIABLE_categoryVariableName___-detail-\(___VARIABLE_categoryVariableName___.id)",
                input: .init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
            )
        case let .___VARIABLE_categoryVariableName___Create(onSave: onSave):
            ___VARIABLE_categoryName___Edit.build(
                input: ___VARIABLE_categoryName___EditInput(),
                output: .init(onSave: onSave)
            )
        case let .___VARIABLE_categoryVariableName___EditId(id: id, onSave: onSave):
            ___VARIABLE_categoryName___Edit.buildCached(
                cacheKey: "___VARIABLE_categoryVariableName___-edit-id\(id)",
                input: .init(id: id),
                output: .init(onSave: onSave)
            )
        case let .___VARIABLE_categoryVariableName___Edit(___VARIABLE_categoryVariableName___, onSave: onSave):
            ___VARIABLE_categoryName___Edit.buildCached(
                cacheKey: "___VARIABLE_categoryVariableName___-edit-\(___VARIABLE_categoryVariableName___.id)",
                input: .init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___),
                output: .init(onSave: onSave)
            )
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .___VARIABLE_modelVariableName___Create, .___VARIABLE_modelVariableName___Edit, .___VARIABLE_modelVariableName___EditId,
             .___VARIABLE_categoryVariableName___Create, .___VARIABLE_categoryVariableName___Edit, .___VARIABLE_categoryVariableName___EditId:
            .managedSheet
        default:
            .push
        }
    }
}
