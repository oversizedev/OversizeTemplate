//___FILEHEADER___

import Env
import NavigatorUI
import Onboarding
import OversizeKit
import SwiftUI

struct OnboardingNavigationStack: View {
    var body: some View {
        ManagedNavigationStack(scene: "Onboarding") {
            OnboardingGreeting.buildCached()
                .navigationAutoReceive(OnboardingDestinations.self)
        }
        .appEnvironment()
    }
}

#Preview {
    OnboardingNavigationStack()
}
