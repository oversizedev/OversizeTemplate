//___FILEHEADER___

import Foundation
import OversizeCore
import OversizeNavigation

@MainActor
public protocol ViewStateProtocol: AnyObject, Observable {
    var destination: (any Hashable)? { get set }
    var alert: AppAlert? { get set }
    var hud: OversizeNavigation.HUD? { get set }
    var isDismissed: Bool { get set }
}