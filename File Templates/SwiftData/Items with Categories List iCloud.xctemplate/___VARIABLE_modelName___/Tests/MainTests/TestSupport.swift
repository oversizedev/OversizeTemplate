// ___FILEHEADER___

import Services
import FactoryKit
import Foundation
import Models
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import Synchronization
import Testing

@MainActor
func waitUntil(
    timeout: Duration = .seconds(3),
    sourceLocation: SourceLocation = #_sourceLocation,
    _ condition: @MainActor () -> Bool
) async {
    let clock = ContinuousClock()
    let deadline = clock.now + timeout
    while !condition() {
        if clock.now > deadline {
            Issue.record("Timed out waiting for condition", sourceLocation: sourceLocation)
            return
        }
        try? await Task.sleep(for: .milliseconds(10))
    }
}

func confirmDelete(_ alert: AppAlert?, sourceLocation: SourceLocation = #_sourceLocation) {
    guard case let .delete(action) = alert else {
        Issue.record("Expected delete alert, got \(String(describing: alert))", sourceLocation: sourceLocation)
        return
    }
    action()
}

final class CallbackRecorder<Value: Sendable>: Sendable {
    private let storage = Mutex<[Value]>([])

    var values: [Value] {
        storage.withLock { $0 }
    }

    var callback: Callback<Value> {
        Callback { value in
            self.storage.withLock { $0.append(value) }
        }
    }
}

enum TestData {
    @discardableResult
    static func make___VARIABLE_modelName___(
        _ name: String,
        note: String? = nil,
        isFavorite: Bool = false,
        categoryId: UUID? = nil
    ) async throws -> ___VARIABLE_modelName___ {
        let storage = Container.shared.___VARIABLE_modelVariableName___Service()
        let ___VARIABLE_modelVariableName___ = try await storage.save(name: name, color: .blue, note: note, ___VARIABLE_categoryVariableName___Id: categoryId)
        return isFavorite ? try await storage.toggleFavorite(___VARIABLE_modelVariableName___) : ___VARIABLE_modelVariableName___
    }

    @discardableResult
    static func makeCategory(_ name: String, isFavorite: Bool = false) async throws -> ___VARIABLE_categoryName___ {
        let storage = Container.shared.___VARIABLE_categoryVariableName___Service()
        let category = try await storage.save(name: name, color: .red)
        return isFavorite ? try await storage.toggleFavorite(category) : category
    }
}

extension LoadingState {
    var isError: Bool {
        if case .error = self {
            return true
        }
        return false
    }
}
