//___FILEHEADER___

import Foundation

@MainActor
public protocol ViewModelProtocol: AnyObject, Observable {
    associatedtype InputEvent
    associatedtype ViewState: ViewStateProtocol

    var state: ViewState { get }

    func handleAction(_ action: InputEvent) async
}