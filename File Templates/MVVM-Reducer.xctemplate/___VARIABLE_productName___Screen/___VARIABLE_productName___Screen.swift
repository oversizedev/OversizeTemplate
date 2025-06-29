// ___FILEHEADER___

import OversizeUI
import SwiftUI

// MARK: - View Protocol

public protocol ViewProtocol: View {
    associatedtype ViewStateType: ViewStateProtocol
    associatedtype ReducerType
    
    var viewState: ViewStateType { get }
    var reducer: ReducerType { get }
}

// MARK: - Screen View

public struct ___FILEBASENAMEASIDENTIFIER___: ViewProtocol {
    
    @ObservedObject public var viewState: ___VARIABLE_productName___ViewState
    public let reducer: ___VARIABLE_productName___Reducer
    
    /// Initialization
    public init(viewState: ___VARIABLE_productName___ViewState, reducer: ___VARIABLE_productName___Reducer) {
        self.viewState = viewState
        self.reducer = reducer
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                if viewState.isLoading {
                    ProgressView("Loading...")
                } else {
                    contentView
                }
            }
            .navigationTitle("___VARIABLE_productName___")
            .onAppear {
                reducer(.onAppear)
            }
            .alert("Error", isPresented: .constant(viewState.errorMessage != nil)) {
                Button("OK") {
                    viewState.errorMessage = nil
                }
            } message: {
                if let errorMessage = viewState.errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack {
            Text("Hello, ___VARIABLE_productName___!")
                .font(.title)
            
            Button("Refresh") {
                reducer(.refresh)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    ___VARIABLE_productName___Module.buildView()
}
