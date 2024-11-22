//
//  NotificationBannerManager.swift
//  BreedApp
//
//  Created by Serhii Molodets on 22.11.2024.
//
import SwiftUI

class NotificationBannerManager: ObservableObject {
    @Published var show: Bool = false
    @Published var data: NotificationBannerView.BannerData = NotificationBannerView.BannerData(title: "", detail: "", type: .info)
    
    func showBanner(title: String, detail: String, type: NotificationBannerView.BannerType) {
        data = NotificationBannerView.BannerData(title: title, detail: detail, type: type)
        show = true
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct NotificationBannerView: ViewModifier {
    
    struct BannerData {
        var title: String
        var detail: String
        var type: BannerType
    }
    
    enum BannerType {
        case info
        case warning
        case success
        case error
        
        var tintColor: Color {
            switch self {
            case .info:
                return Color(red: 67/255, green: 154/255, blue: 215/255)
            case .success:
                return Color.green
            case .warning:
                return Color.yellow
            case .error:
                return Color.red
            }
        }
    }
    
    @ObservedObject var bannerManager: NotificationBannerManager
    
    func body(content: Content) -> some View {
            ZStack {
                content
                if bannerManager.show {
                    VStack {
                        bannerView
                        Spacer()
                    }
                    .padding()
                    .animation(.easeInOut)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onTapGesture {
                        withAnimation {
                            self.bannerManager.show = false
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.bannerManager.show = false
                            }
                        }
                    }
                }
            }
        }
        
        private var bannerView: some View {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(bannerManager.data.title)
                        .bold()
                    Text(bannerManager.data.detail)
                        .font(Font.system(size: 15, weight: .light, design: .default))
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(12)
            .background(
                ZStack {
                    BlurView(style: .systemChromeMaterialLight)
                    bannerManager.data.type.tintColor.opacity(0.5)
                }
                .cornerRadius(8)
            )
        }
}

extension View {
    func banner(bannerManager: NotificationBannerManager) -> some View {
        self.modifier(NotificationBannerView(bannerManager: bannerManager))
    }
}


struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello")
        }
    }
}
