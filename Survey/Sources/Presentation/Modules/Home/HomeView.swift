//
//  HomeView.swift
//  SurveyTests
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject var input: HomeViewModel.Input
    @ObservedObject var output: HomeViewModel.Output
    @State var currentPage = 0
    @State var tabSelection = 0
    @State var isModalPresented = false
    @State var isShowingPersonalMenu = false
    @State var showSkeletonAnimation = true

    private let logoutTrigger = PassthroughSubject<Void, Never>()
    private let loadUserInfoTrigger = PassthroughSubject<Void, Never>()
    private let loadTrigger = PassthroughSubject<Void, Never>()
    private let willGoToDetail = PassthroughSubject<Void, Never>()
    private let minDragTranslationForSwipe: CGFloat = 60.0

    var body: some View {
        LoadingView(
            isShowing: $output.isLoading,
            text: .constant(""),
            content: {
                ZStack {
                    setUpTabView()
                        .overlay(alignment: .top) {
                            HeaderHomeView(
                                imageURL: output.user?.avatarUrl ?? "",
                                isShowingPersonalMenu: $isShowingPersonalMenu
                            )
                            .padding(.top, 60.0)
                            .padding(.leading, 20.0)
                        }
                        .overlay {
                            if isShowingPersonalMenu {
                                setUpPersonalMenu()
                            }
                        }
                }
            }
        )
        .onAppear(perform: {
            withAnimation(Animation.easeInOut(duration: 1.0).delay(1.0)) {
                showSkeletonAnimation.toggle()
            }
            output.surveys = UserStorage.cachedSurveyList
            self.loadUserInfoTrigger.send()
            self.loadTrigger.send()
        })
        .overlay {
            SkeletonView()
                .hidden(!showSkeletonAnimation)
        }
        .preferredColorScheme(.dark)
    }

    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input(
            loadUserInfoTrigger: loadUserInfoTrigger.asDriver(),
            loadTrigger: loadTrigger.asDriver(),
            willGoToDetail: willGoToDetail.asDriver(),
            logoutTrigger: logoutTrigger.asDriver()
        )
        output = viewModel.transform(input)
        self.input = input
    }

    private func setUpPersonalMenu() -> some View {
        PersonalMenuView(
            user: output.user,
            willLogoutAction: {
                logoutTrigger.send()
            },
            showPersonalMenu: $isShowingPersonalMenu
        )
        .padding(.top, 60.0)
        .transition(.move(edge: .trailing))
        .onReceive(output.$didLogoutSuccessfully) {
            guard $0 else { return }
            appRouter.state = .login
        }
    }

    private func setUpTabView() -> some View {
        let surveyList = Array(output.surveys.enumerated())

        return TabView(selection: $tabSelection) {
            ForEach(surveyList, id: \.element.id) { args in
                let (index, survey) = args
                setUpSurveyItemView(
                    with: index,
                    and: survey
                )
            }
            .highPriorityGesture(DragGesture().onEnded {
                handleSwipe(translation: $0.translation.width)
            })
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(alignment: .leading) {
            setUpPageControlView()
        }
        .alert(isPresented: .constant($output.alert.wrappedValue != nil)) {
            Alert(
                title: Text(output.alert?.title ?? ""),
                message: Text(output.alert?.message ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    $output.alert.wrappedValue = nil
                })
            )
        }
        .edgesIgnoringSafeArea(.all)
    }

    private func setUpSurveyItemView(with index: Int, and survey: Survey) -> some View {
        SurveyItemView(
            survey: survey,
            willGoToDetail: {
                willGoToDetail.send()
            }
        )
        .tag(index)
        .onChange(of: tabSelection, perform: { newValue in
            currentPage = newValue
        })
        .onReceive(output.$willGoToDetail) {
            guard $0 else { return }
            withoutAnimation {
                isModalPresented = true
            }
        }
        .fullScreenCover(isPresented: $isModalPresented) {
            SurveyDetailView(
                viewModel: SurveyDetailViewModel(),
                isPresented: $isModalPresented,
                survey: survey
            )
        }
    }

    private func setUpPageControlView() -> some View {
        VStack(alignment: .leading) {
            Spacer()
            PageControlView(
                currentPage: $currentPage,
                numberOfPages: output.surveys.count,
                didSelect: { index in
                    tabSelection = index
                }
            )
            .frame(
                width: .zero,
                height: 8.0,
                alignment: .leading
            )
            .accessibilityIdentifier(TestConstants.Home.pageIndicator)
            .padding(.bottom, 200.0)
        }
    }

    private func handleSwipe(translation: CGFloat) {
        let surveyListCount = output.surveys.count
        let didMoveLeft = translation > minDragTranslationForSwipe && tabSelection > 0
        let didMoveRight = translation < -minDragTranslationForSwipe && tabSelection < surveyListCount - 1

        if didMoveLeft {
            tabSelection -= 1
        } else if didMoveRight {
            tabSelection += 1
        }

        if tabSelection == surveyListCount - 1 {
            loadTrigger.send()
        }
    }
}

struct HomeViewPreView: PreviewProvider {

    static var previews: some View {
        let viewModel = HomeViewModel(
            homeUseCase: HomeUseCase(
                surveyRepository: SurveyRepository(
                    api: AuthenticationNetworkAPI()
                )
            ),
            userUseCase: UserUseCase(
                userRepository: UserRepository(
                    api: AuthenticationNetworkAPI()
                )
            ),
            userSessionUseCase: UserSessionUseCase()
        )
        HomeView(viewModel: viewModel)
    }
}
