//___FILEHEADER___

import SwiftUI

public protocol ViewProtocol: View {
    associatedtype ViewModel: ViewModelProtocol
    
    var viewModel: ViewModel { get }
}