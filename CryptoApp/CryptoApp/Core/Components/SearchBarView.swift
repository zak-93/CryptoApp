//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 21.09.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            TextField("Search by name or symbol...", text: $searchText)
                .autocorrectionDisabled()
                .foregroundStyle(Color.theme.accent)
                .overlay(alignment: .trailing, content: {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                })
            
        
        }
        .font(.headline)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15) ,radius: 10, x: 0, y: 0)
        }
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
