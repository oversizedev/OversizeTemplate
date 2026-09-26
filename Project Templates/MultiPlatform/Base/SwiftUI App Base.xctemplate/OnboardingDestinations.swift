//___FILEHEADER___

import Env
import NavigatorUI
import Onboarding
import SwiftUI

extension OnboardingDestinations: @retroactive NavigationDestination {
    @MainActor
    public var body: some View {
        switch self {
        case .setup:
            OnboardingSetup.build()
        }
    }
}
