//___FILEHEADER___

import Env
import NavigatorUI
import Onboarding
import OversizeKit
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

struct OnboardingNavigationStack: View {
    var body: some View {
        ManagedNavigationStack(scene: "Onboarding") {
            OnboardingGreeting.buildCached()
                .navigationAutoReceive(OnboardingDestinations.self)
        }
        .coreServices()
    }
}
