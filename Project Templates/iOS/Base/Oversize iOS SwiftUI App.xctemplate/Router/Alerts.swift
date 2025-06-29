//___FILEHEADER___

import OversizeCore
import OversizeLocalizable
import OversizeModels
import SwiftUI

public enum RootAlert {
    case dismiss(_ action: () -> Void)
    case delete(_ action: () -> Void)
    case appError(error: AppError)


}

extension RootAlert: Identifiable {
    public var id: String {
        switch self {
        case .dismiss:
            return "dismiss"
        case .delete:
            return "delete"
        case .appError:
            return "appError"
        }
    }
}

public extension RootAlert {
    var alert: Alert {
        switch self {
        case let .dismiss(action):
            return Alert(
                title: Text("Are you sure you want to dismiss?"),
                primaryButton: .destructive(Text("Dismiss"), action: action),
                secondaryButton: .cancel()
            )
        case let .delete(action):
            return Alert(
                title: Text("Are you sure you want to delete?"),
                primaryButton: .destructive(Text("\(L10n.Button.delete)"), action: action),
                secondaryButton: .cancel()
            )
        case let .appError(error: error):
            return Alert(
                title: Text(error.title),
                message: Text(error.subtitle.valueOrEmpty),
                dismissButton: .cancel()
            )
        }
    }
}
