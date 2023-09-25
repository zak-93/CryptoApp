//
//  DetailView.swift
//  CryptoApp
//
//  Created by Yashin Zahar on 24.09.2023.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    @State private var showFullDescription = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
        
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                VStack(spacing: 20, content: {
                    overviewTitle
                    Divider()
                    destinationSection
                    overviewGrid
                    additaonalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                })
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.shared.coin)
    }
}

extension DetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var destinationSection: some View {
        ZStack {
            if let coinDestination = viewModel.coinDestination, !coinDestination.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDestination)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "Less" : "Read more..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                    .foregroundStyle(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additaonalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(viewModel.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(viewModel.additionalStatistics) { stat in
                StatisticView(stat: stat)                    }
        })
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let websiteString = viewModel.websiteURL,
                let url = URL(string: websiteString) {
                Link(destination: url) {
                    Text("Website")
                }
            }
            if let redditURL = viewModel.redditURL,
               let url = URL(string: redditURL) {
                Link(destination: url) {
                    Text("Reddit")
                }
            }
        }
        .foregroundStyle(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
