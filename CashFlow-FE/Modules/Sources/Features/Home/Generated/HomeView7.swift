import SwiftUI

struct HomeView7: View {
    // MARK: - Properties
    @State private var selectedTab = 0
    @State private var showSettings = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                // Background
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Main Content
                    VStack(spacing: 24) {
                        // Header
                        headerSection
                        
                        ScrollView {
                            VStack(spacing: 24) {
                                // Balance Card
                                balanceCard
                                
                                // Chart Section
                                chartSection
                                
                                // Subscriptions Section
                                subscriptionsSection
                                
                                // Transactions Section
                                transactionsSection
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer(minLength: 90)
                }
                
                // Tab Bar
                customTabBar
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            // Time
            Text("7:13")
                .font(.system(size: 14))
            
            Spacer()
            
            // Status Icons
            HStack(spacing: 4) {
                Image(systemName: "cellullar")
                Image(systemName: "wifi")
                Image(systemName: "battery.100")
            }
            .font(.system(size: 14))
        }
        .padding(.horizontal)
        .foregroundColor(.secondary)
    }
    
    // MARK: - Balance Card
    private var balanceCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("$2,750,000")
                .font(.system(size: 34, weight: .bold))
            
            Text("Available balance")
                .font(.title3)
                .foregroundColor(.secondary)
            
            HStack {
                Text("Pro")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green)
                    .clipShape(Capsule())
                
                Image(systemName: "crown.fill")
                    .foregroundColor(.yellow)
                
                Spacer()
                
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
    
    // MARK: - Chart Section
    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Y-axis labels
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("$750,000")
                    Text("$500,000")
                    Text("$250,000")
                    Text("$0")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
                // Chart placeholder
                ChartView()
            }
            
            // X-axis labels
            HStack(spacing: 0) {
                ForEach(["Jan 5", "Jan 12", "Jan 19", "Jan 26"], id: \.self) { date in
                    Text(date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Chart indicators
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Circle()
                    .fill(Color.secondary.opacity(0.3))
                    .frame(width: 8, height: 8)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
    
    // MARK: - Subscriptions Section
    private var subscriptionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("My subscriptions")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.green)
            }
            
            EmptySubscriptionsView()
        }
    }
    
    // MARK: - Transactions Section
    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("My transactions")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.green)
            }
            
            TransactionRow7(
                icon: "house.fill",
                category: "Home",
                amount: "-$750,000",
                date: "2 days ago"
            )
        }
    }
    
    // MARK: - Custom Tab Bar
    private var customTabBar: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                // Tab Bar Background
//                Color(.secondarySystemBackground)
//                    .frame(height: 40)
                
                // Plus Button
                Circle()
                    .fill(Color.green)
                    .frame(width: 64, height: 64)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(.white)
                    )
                    .offset(y: -20)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = TabItem7.add.rawValue
                        }
                    }
                
                // Tab Bar Items
                HStack {
                    ForEach(TabItem7.allCases, id: \.self) { tab in
                        if tab == .add {
                            Spacer()
                                .frame(width: 100)
                        } else {
                            TabBarButton7(
                                tab: tab,
                                isSelected: selectedTab == tab.rawValue
                            ) {
                                withAnimation {
                                    selectedTab = tab.rawValue
                                }
                            }
                        }
                    }
                }
                .padding(.top)
//                .padding(.horizontal)
//                .padding(.bottom, 0)
            }
        }
        .background(Color(.secondarySystemBackground))
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Supporting Views
struct ChartView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                // Sample chart path
                path.move(to: CGPoint(x: 0, y: geometry.size.height))
                path.addLine(to: CGPoint(x: geometry.size.width * 0.7, y: geometry.size.height))
                path.addLine(to: CGPoint(x: geometry.size.width * 0.75, y: 0))
                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
            }
            .stroke(Color.pink, lineWidth: 2)
        }
    }
}

struct EmptySubscriptionsView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("You haven't registered any subscriptions yet. Start now!")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Image("subscription-robot") // Replace with your actual image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

struct TransactionRow7: View {
    let icon: String
    let category: String
    let amount: String
    let date: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(category)
                    .font(.headline)
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(amount)
                .font(.headline)
                .foregroundColor(.pink)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

// MARK: - Tab Bar Components
enum TabItem7: Int, CaseIterable {
    case stats, add, budget
    
    var icon: String {
        switch self {
        case .stats: return "chart.bar.fill"
        case .add: return "plus"
        case .budget: return "chart.bar.horizontal.page.fill"
//        case .cards: return "creditcard.fill"
//        case .type: return "calendar"
        }
    }
    
    var title: String {
        switch self {
        case .stats: return "Stats"
        case .add: return ""
        case .budget: return "Budget"
//        case .cards: return "Account"
//        case .type: return "Type"
        }
    }
}

struct TabBarButton7: View {
    let tab: TabItem7
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                if !tab.title.isEmpty {
                    Text(tab.title)
                        .font(.caption2)
                        .foregroundColor(isSelected ? .primary : .secondary)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView7()
        .preferredColorScheme(.dark)
} 
