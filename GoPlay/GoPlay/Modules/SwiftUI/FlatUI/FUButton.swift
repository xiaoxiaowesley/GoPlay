//
//  FUButton.swift
//  FlatUI
//
//  Created by xiaoxiang's m1 mbp on 2023/8/24.
//

import SwiftUI

enum ButtonType {
    case primary, success, warning, defaultType, inverse, danger, info, disable
}
struct FUButtonStyle: ButtonStyle {
    var type: ButtonType

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? pressedBackgroundColor : backgroundColor)
            .foregroundColor(configuration.isPressed ? pressedForegroundColor : Color.white)
            .opacity(configuration.isPressed && type == .disable ? 0.7 : 1.0)
            .shadow(color: configuration.isPressed ? shadowColor : Color.clear, radius: configuration.isPressed ? radius : 0)
            .animation(.easeInOut)
    }

    private var shadowColor : Color {
        switch type {
        case .primary:
            return Color(red: 0, green: 123/255, blue: 255/255, opacity: 0.5)
        case .success:
            return Color(red: 40/255, green: 167/255, blue: 69/255, opacity: 0.5)
        case .warning:
            return Color(red: 255/255, green: 193/255, blue: 7/255, opacity: 0.5)
        case .danger:
            return Color(red: 220/255, green: 53/255, blue: 69/255, opacity: 0.5)
        case .info:
            return Color(red: 23/255, green: 162/255, blue: 184/255, opacity: 0.5)
        default:
            return Color.clear
        }
    }

    private var radius: CGFloat {
        switch type {
        case .primary, .success, .warning, .inverse, .danger, .info:
            return 10
        default:
            return 0
        }
    }

    private var backgroundColor: Color {
        switch type {
        case .primary:
            return .turquoise
        case .success:
            return .emerald
        case .warning:
            return .sunFlower
        case .defaultType:
            return .silver
        case .inverse:
            return .wetAsphalt
        case .danger:
            return .alizarin
        case .info:
            return .peterRiver
        case .disable:
            return .clouds
        }
    }

    private var pressedBackgroundColor: Color {
        switch type {
        case .primary:
            return .greenSea
        case .success:
            return .nephritis
        case .warning:
            return .orange
        case .defaultType:
            return Color(red: 161/255, green: 166/255, blue: 169/255)
        case .inverse:
            return .midnightBlue
        case .danger:
            return .pomegranate
        case .info:
            return .peterRiver
        case .disable:
            return .clouds
        }
    }

    private var pressedForegroundColor: Color {
        switch type {
        case .warning:
            return Color(red: 33/255, green: 37/255, blue: 41/255)
        default:
            return Color.white
        }
    }
}


struct FUButton: View {
    var action: () -> Void
    var type: ButtonType
    var buttonText: String

    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .font(.system(size: 17))
                .fontWeight(.regular)
                .padding(.vertical, 10)
                .padding(.horizontal, 19)
        }
        .buttonStyle(FUButtonStyle(type: type))
        .cornerRadius(6)
        .frame(width: 210, height: 45)
    }

    private var buttonTextColor: Color {
        return Color(red: 52/255, green: 73/255, blue: 94/255)
    }
}
struct FUButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FUButton(action: {}, type: .primary, buttonText: "Primary Button")
            FUButton(action: {}, type: .success, buttonText: "Success Button")
            FUButton(action: {}, type: .warning, buttonText: "Warning Button")
            FUButton(action: {}, type: .defaultType, buttonText: "Default Button")
            FUButton(action: {}, type: .inverse, buttonText: "Inverse Button")
            FUButton(action: {}, type: .danger, buttonText: "Danger Button")
            FUButton(action: {}, type: .info, buttonText: "Info Button")
            FUButton(action: {}, type: .disable, buttonText: "Disable Button")
            
        }
    }
}
