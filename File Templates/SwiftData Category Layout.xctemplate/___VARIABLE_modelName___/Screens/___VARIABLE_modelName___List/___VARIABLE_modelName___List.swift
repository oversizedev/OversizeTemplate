// ___FILEHEADER___

import Database
import OversizeArchitecture
import OversizeComponents
import OversizeCore
import OversizeNavigation
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___List: Module {
    public typealias Input = ___VARIABLE_modelName___ListInput
    public typealias Output = ___VARIABLE_modelName___ListOutput

    public struct Input: Sendable {
        public let categoryId: UUID?

        public init(categoryId: UUID? = nil) {
            self.categoryId = categoryId
        }
    }

    public struct Output: Sendable {
        public init() {}
    }

    public static func build(input: Input? = nil, output: Output? = nil) -> some View {
        ___VARIABLE_modelName___ListView()
            .attachModule(
                ___VARIABLE_modelName___ListViewModel.self,
                input: input,
                output: output
            )
    }

    public static func buildArchive() -> some View {
        build(input: Input(categoryId: nil))
    }

    public static func buildFavorites() -> some View {
        build(input: Input(categoryId: nil))
    }
}

// MARK: - Types

public typealias ___VARIABLE_modelName___ListInput = ___VARIABLE_modelName___List.Input
public typealias ___VARIABLE_modelName___ListOutput = ___VARIABLE_modelName___List.Output

public enum ___VARIABLE_modelName___ListDisplayType: String, CaseIterable, Identifiable, Sendable {
    case list
    case grid

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .list:
            return "List"
        case .grid:
            return "Grid"
        }
    }

    public var icon: Image {
        switch self {
        case .list:
            return Image.Base.List.bullet
        case .grid:
            return Image.Base.squares.twoByTwo
        }
    }
}