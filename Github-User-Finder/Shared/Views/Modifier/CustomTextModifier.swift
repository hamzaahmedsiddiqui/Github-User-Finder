//
//  CustomTextModifier.swift
//  Github-User-Finder
//
//  Created by hamza Ahmed on 2024-11-29.
//

import SwiftUI

struct CustomTextModifier: ViewModifier {
    var font: Font?
    var foregroundColor: Color
    var alignment: TextAlignment = .leading
    var lineLimit: Int? = nil
    var frame: CGRect?
    
    func body(content: Content) -> some View {
        let view = content
            .font(font)
            .foregroundColor(foregroundColor)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
        
        if let frame = frame {
            return AnyView(view.frame(width: frame.size.width, height: frame.size.height))
        } else {
            return AnyView(view)
        }
    }
}


extension View {
    func customTextStyle(
        font: Font? = nil,
        foregroundColor: Color,
        alignment: TextAlignment = .leading,
        lineLimit: Int? = nil,
        frame: CGRect? = nil
    ) -> some View {
        self.modifier(CustomTextModifier(
            font: font,
            foregroundColor: foregroundColor,
            alignment: alignment,
            lineLimit: lineLimit,
            frame: frame
        ))
    }
}
