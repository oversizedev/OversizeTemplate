// ___FILEHEADER___

import Foundation
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

extension LoadingState {
    var isError: Bool {
        if case .error = self {
            return true
        }
        return false
    }
}
