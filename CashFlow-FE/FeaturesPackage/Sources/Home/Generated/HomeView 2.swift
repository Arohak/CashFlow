//
//  HomeView3.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/5/25.
//

import SwiftUI

struct HomeView2: View {
    // MARK: - Properties
    @State private var selectedTab = 0
    @State private var showingProfile = false
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    balanceCard
                    quickActionsGrid
                    recentTransactionsSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarItems
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("John Doe")
                    .font(.title2.bold())
            }
            
            Spacer()
            
            Button {
                showingProfile.toggle()
            } label: {
                CircularProfileImage()
            }
        }
    }
    
    // MARK: - Balance Card
    private var balanceCard: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Balance")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("$24,562.00")
                        .font(.title.bold())
                }
                Spacer()
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.title2)
                    .foregroundStyle(.green)
            }
            
            Divider()
            
            HStack(spacing: 24) {
                StatView(title: "Income", value: "$8,545", trend: .up)
                StatView(title: "Expenses", value: "$3,884", trend: .down)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10)
        )
    }
    
    // MARK: - Quick Actions Grid
    private var quickActionsGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            QuickActionButton2(icon: "arrow.up.circle.fill", title: "Send", color: .blue)
            QuickActionButton2(icon: "arrow.down.circle.fill", title: "Receive", color: .green)
            QuickActionButton2(icon: "creditcard.fill", title: "Cards", color: .purple)
            QuickActionButton2(icon: "chart.bar.fill", title: "Analytics", color: .orange)
            QuickActionButton2(icon: "dollarsign.circle.fill", title: "Bills", color: .red)
            QuickActionButton2(icon: "ellipsis.circle.fill", title: "More", color: .gray)
        }
    }
    
    // MARK: - Recent Transactions
    private var recentTransactionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Transactions")
                    .font(.title3.bold())
                Spacer()
                Button("See All") {}
                    .font(.subheadline)
                    .tint(.blue)
            }
            
            ForEach(0..<3) { _ in
                TransactionRow2()
            }
        }
    }
    
    // MARK: - Toolbar Items
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Show notifications
                } label: {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.blue, .red)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Show search
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
}

// MARK: - Supporting Views
struct CircularProfileImage: View {
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .font(.title)
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.blue)
            .frame(width: 40, height: 40)
            .background(Circle().fill(.blue.opacity(0.1)))
    }
}

struct StatView: View {
    enum Trend {
        case up, down
    }
    
    let title: String
    let value: String
    let trend: Trend
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 4) {
                Text(value)
                    .font(.headline)
                Image(systemName: trend == .up ? "arrow.up.right" : "arrow.down.right")
                    .font(.caption)
                    .foregroundStyle(trend == .up ? .green : .red)
            }
        }
    }
}

struct QuickActionButton2: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 50, height: 50)
                .background(color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

struct TransactionRow2: View {
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(.blue.opacity(0.1))
                .frame(width: 48, height: 48)
                .overlay(
                    Image(systemName: "bag.fill")
                        .foregroundStyle(.blue)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Shopping")
                    .font(.subheadline)
                Text("Apple Store")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("-$299.00")
                    .font(.subheadline)
                Text("4:20 PM")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
        )
    }
}

// MARK: - Preview
#Preview {
    HomeView2()
}
