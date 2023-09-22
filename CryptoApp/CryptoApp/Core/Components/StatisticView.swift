//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 22.09.2023.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.persentagerChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.persentagerChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
                                    
            }
            .foregroundStyle((stat.persentagerChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.persentagerChange == nil ? 0.0 : 1.0)
        })
    }
}

#Preview {
    Group {
        StatisticView(stat: DeveloperPreview.shared.staticModel1)
        StatisticView(stat: DeveloperPreview.shared.staticModel2)
        StatisticView(stat: DeveloperPreview.shared.staticModel3)
    }
}
