// ___FILEHEADER___

import Env
import Main
import Models
import NavigatorUI
import OversizeNavigation
import SwiftUI

extension ___VARIABLE_modelName___Destinations: @retroactive NavigationDestination {
    @MainActor
    public var body: some View {
        switch self {
        case .___VARIABLE_modelVariableName___List:
            ___VARIABLE_modelName___List.build()
        case let .___VARIABLE_modelVariableName___Detail(___VARIABLE_modelVariableName___, onEdit, onDelete):
            ___VARIABLE_modelName___Detail.build(
                input: .init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___),
                output: .init(onEdit: onEdit, onDelete: onDelete)
            )
        case let .___VARIABLE_modelVariableName___DetailId(id, onEdit, onDelete):
            ___VARIABLE_modelName___Detail.build(
                input: .init(id: id),
                output: .init(onEdit: onEdit, onDelete: onDelete)
            )
        case let .___VARIABLE_modelVariableName___Create(onSave):
            ___VARIABLE_modelName___Edit.build(
                input: .init(),
                output: .init(onSave: onSave)
            )
        case let .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___, onSave):
            ___VARIABLE_modelName___Edit.build(
                input: .init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___),
                output: .init(onSave: onSave)
            )
        case let .___VARIABLE_modelVariableName___EditId(id, onSave):
            ___VARIABLE_modelName___Edit.build(
                input: .init(id: id),
                output: .init(onSave: onSave)
            )
        case .___VARIABLE_categoryVariableName___List:
            ___VARIABLE_categoryName___List.build()
        case let .___VARIABLE_categoryVariableName___Detail(___VARIABLE_categoryVariableName___, onEdit, onDelete):
            ___VARIABLE_categoryName___Detail.build(
                input: .init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___),
                output: .init(onEdit: onEdit, onDelete: onDelete)
            )
        case let .___VARIABLE_categoryVariableName___DetailId(id, onEdit, onDelete):
            ___VARIABLE_categoryName___Detail.build(
                input: .init(id: id),
                output: .init(onEdit: onEdit, onDelete: onDelete)
            )
        case let .___VARIABLE_categoryVariableName___Create(onSave):
            ___VARIABLE_categoryName___Edit.build(
                input: .init(),
                output: .init(onSave: onSave)
            )
        case let .___VARIABLE_categoryVariableName___Edit(___VARIABLE_categoryVariableName___, onSave):
            ___VARIABLE_categoryName___Edit.build(
                input: .init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___),
                output: .init(onSave: onSave)
            )
        case let .___VARIABLE_categoryVariableName___EditId(id, onSave):
            ___VARIABLE_categoryName___Edit.build(
                input: .init(id: id),
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
