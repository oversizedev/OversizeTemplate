//___FILEHEADER___

import OversizeServices
import OversizeUI
import SwiftUI
import Factory

struct OnboardingView: View {
    @Injected(\.appStateService) var appStateService: AppStateService
    @Environment(\.screenSize) var screenSize: ScreenSize
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        if horizontalSizeClass == .compact, verticalSizeClass == .regular {
            phoneRegular
        } else if horizontalSizeClass == .regular, verticalSizeClass == .compact {
            phoneCompact
        } else {
            ipad
        }
    }

    var phoneRegular: some View {
        ZStack {
            VStack {
                Spacer()
                Image("OnbardingBackground", bundle: .main)

                Spacer()

                VStack(spacing: .medium) {
                    Text("Welcome to\n___PACKAGENAME:identifier___")
                        .largeTitle()
                        .onBackgroundHighEmphasisForegroundColor()

                    Text("Welcome text")
                        .title2(.semibold)
                        .onBackgroundMediumEmphasisForegroundColor()
                }
                .paddingContent(.horizontal)
                .multilineTextAlignment(.center)

                Spacer()

                Button("Contine") {
                    appStateService.completedOnbarding()
                }
                .buttonStyle(.primary)
                .accent()
                .paddingContent(.bottom)
                .paddingContent(.horizontal)
                .elevation(.z2)
            }

            // VStack {
            //
            //     Spacer()
            //     Image("OnbardingBackground", bundle: .main)
            //     Spacer()
            // }
        }
        .ignoresSafeArea(edges: .top)
        .background {
            Color.backgroundSecondary.ignoresSafeArea()
        }
    }

    var phoneCompact: some View {
        HStack(spacing: .zero) {
            Image("OnbardingBackground", bundle: .main)

            Divider()

            VStack {
                Spacer()

                VStack(spacing: .medium) {
                    Text("Welcome to\n___PACKAGENAME:identifier___")
                        .largeTitle()
                        .onBackgroundHighEmphasisForegroundColor()

                    Text("Welcome text")
                        .title2(.semibold)
                        .onBackgroundMediumEmphasisForegroundColor()
                }
                .paddingContent(.horizontal)
                .multilineTextAlignment(.center)

                Spacer()

                HStack {
                    Spacer()
                    Button("Contine") {
                        appStateService.completedOnbarding()
                    }
                    .buttonStyle(.primary)
                    .accent()
                    .elevation(.z2)
                    .frame(maxWidth: 300)
                    .paddingContent(.horizontal)
                    .paddingContent(.bottom)
                    Spacer()
                }
            }
        }
        .background {
            Color.backgroundSecondary.ignoresSafeArea()
        }
    }

    var ipad: some View {
        ZStack {
            VStack {
                VStack {}
                    .frame(maxHeight: screenSize.height < 1000 ? 320 : 490)

                Spacer()

                VStack(spacing: .medium) {
                    Text("___PACKAGENAME:identifier___")
                        .largeTitle()
                        .onBackgroundHighEmphasisForegroundColor()

                    Text("Welcome text")
                        .title2(.semibold)
                        .onBackgroundMediumEmphasisForegroundColor()
                }
                .paddingContent(.horizontal)
                .multilineTextAlignment(.center)

                Spacer()

                Button("Contine") {
                    appStateService.completedOnbarding()
                }
                .buttonStyle(.primary)
                .accent()
                .paddingContent(.bottom)
                .paddingContent(.horizontal)
                .elevation(.z2)
            }

            VStack {
                Surface {
                    Image("OnbardingBackground", bundle: .main)
                        .offset(y: -44)
                        .frame(width: screenSize.height < 1000 ? 320 : 490, height: screenSize.height < 1000 ? 320 : 490)
                        .cornerRadius(.xLarge)
                        .clipped()
                }
                .elevation(.z2)
                .innerPadding(.zero)
                .controlRadius(.xLarge)
                .padding(.top, .large)
                Spacer()
            }
        }
        .background {
            Color.backgroundSecondary.ignoresSafeArea()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
