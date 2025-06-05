import SwiftUI

struct HomeView8: View {
    // MARK: - Properties
    @State private var selectedTab = 0
    @State private var selectedSegment = 0
    
    private let segments = ["OVERVIEW", "SPENDING", "LIST"]
    private let gradientColors = [
        Color(red: 0.6, green: 0.4, blue: 0.9), // Light purple
        Color(red: 0.5, green: 0.3, blue: 0.8)  // Dark purple
    ]
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: gradientColors),
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                headerSection
                
                // Segment Control
                segmentControl
                
                // Main Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Month selector
                        monthSelector
                        
                        // Stats cards
                        statsOverview
                        
                        // Expenses chart
                        expensesSection
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Tab Bar
                customTabBar
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            // Settings button
            Button {
                // Action
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Title with dropdown
            HStack {
                Text("Overview: My Household")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Image(systemName: "chevron.down")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
            
            // Status icons
            HStack(spacing: 4) {
                Text("8:04")
                    .font(.footnote)
                Image(systemName: "wifi")
                Image(systemName: "battery.75")
            }
            .foregroundColor(.white.opacity(0.8))
        }
        .padding()
    }
    
    // MARK: - Segment Control
    private var segmentControl: some View {
        HStack {
            ForEach(Array(segments.enumerated()), id: \.element) { index, segment in
                Button {
                    withAnimation {
                        selectedSegment = index
                    }
                } label: {
                    Text(segment)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(selectedSegment == index ? .white : .white.opacity(0.6))
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedSegment == index ?
                            Color.white.opacity(0.2) :
                            Color.clear
                        )
                }
            }
        }
        .background(Color.black.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
    
    // MARK: - Month Selector
    private var monthSelector: some View {
        HStack {
            Button {
                // Previous month
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                Text("March 2025")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("7 TRANSACTIONS")
                    .font(.caption)
                    .opacity(0.8)
            }
            .foregroundColor(.white)
            
            Spacer()
            
            Button {
                // Next month
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    // MARK: - Stats Overview
    private var statsOverview: some View {
        HStack(spacing: 16) {
            StatCard(title: "INCOME", amount: "$3,830", color: .green)
            StatCard(title: "EXPENSES", amount: "$1,305", color: .pink)
            StatCard(title: "LEFT", amount: "$2,525", color: .purple)
        }
    }
    
    // MARK: - Expenses Section
    private var expensesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("EXPENSES")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.8))
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                
                Circle()
                    .trim(from: 0, to: 0.65)
                    .stroke(Color.purple, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    Image(systemName: "creditcard.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("$750")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("OVERDRAFT")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .frame(height: 200)
            .padding()
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    // MARK: - Custom Tab Bar
    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(["eye.fill", "chart.pie.fill", "heart.fill", "briefcase.fill"], id: \.self) { icon in
                Button {
                    // Tab action
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: icon)
                            .font(.system(size: 20))
                        Text(tabTitle(for: icon))
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == 0 ? .purple : .gray)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal)
    }
    
    private func tabTitle(for icon: String) -> String {
        switch icon {
        case "eye.fill": return "Overview"
        case "chart.pie.fill": return "Budget"
        case "heart.fill": return "Save"
        case "briefcase.fill": return "Tools"
        default: return ""
        }
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let title: String
    let amount: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(amount)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(color.opacity(0.3))
        )
    }
}

#Preview {
    HomeView8()
} 