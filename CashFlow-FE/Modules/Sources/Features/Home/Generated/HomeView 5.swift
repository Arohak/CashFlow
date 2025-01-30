import SwiftUI

struct HomeView5: View {
    // MARK: - Properties
    @State private var selectedTab = 0
    @State private var isRefreshing = false
    @Environment(\.colorScheme) var colorScheme
    
    // Custom colors
    private let backgroundColor = Color.black.opacity(0.95)
    private let cardBackgroundColor = Color(red: 28/255, green: 28/255, blue: 30/255)
    private let accentColor = Color.blue
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerSection
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        balanceCard
                            .transition(.scale.combined(with: .opacity))
                        
                        quickActionsSection
                            .transition(.move(edge: .trailing))
                        
                        quickSendSection
                            .transition(.move(edge: .leading))
                        
                        recentTransactionsSection
                            .transition(.move(edge: .bottom))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 60) // Extra padding for tab bar
                }
                .refreshable {
                    // Simulate refresh
                    isRefreshing = true
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    isRefreshing = false
                }
                
                customTabBar
            }
        }
        .preferredColorScheme(.dark)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text("Byte")
                        .font(.title2.weight(.bold))
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(accentColor)
                        .font(.subheadline)
                }
                
                Text("Personal balance")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button {
                // Search action
                withAnimation(.spring()) {
                    // Implement search
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    )
            }
        }
        .padding()
        .background(
            backgroundColor
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
    }
    
    // MARK: - Balance Card
    private var balanceCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("$252,312.00")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
            
            HStack(spacing: 24) {
                BalanceInfoItem(title: "Income", value: "+$12,400", trend: .up)
                BalanceInfoItem(title: "Expenses", value: "-$4,600", trend: .down)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(cardBackgroundColor)
                .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
        )
    }
    
    // MARK: - Quick Actions
    private var quickActionsSection: some View {
        HStack(spacing: 20) {
            QuickActionButton(title: "Top Up", icon: "arrow.clockwise", color: .green)
            QuickActionButton(title: "Transfer", icon: "arrow.right", color: .blue)
            QuickActionButton(title: "Bill", icon: "creditcard", color: .purple)
            QuickActionButton(title: "Other", icon: "square.grid.2x2", color: .orange)
        }
        .padding(.vertical, 8)
    }
    
    // MARK: - Quick Send Section
    private var quickSendSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Quick Send", actionTitle: "View all")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    QuickSendButton(type: .add)
                    QuickSendButton(name: "Sam", color: .blue)
                    QuickSendButton(name: "Ana", color: .purple)
                    QuickSendButton(name: "John", color: .green)
                    QuickSendButton(name: "Kate", color: .orange)
                }
                .padding(.horizontal, 4)
            }
        }
    }
    
    // MARK: - Recent Transactions
    private var recentTransactionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Recent Transaction", actionTitle: "View all")
            
            VStack(spacing: 16) {
                TransactionRow5(
                    icon: "apple.logo",
                    title: "Apple services",
                    date: "03 July 2024 • 18:24",
                    amount: "-$50.00"
                )
                
                TransactionRow5(
                    icon: "a.square.fill",
                    title: "Amazon",
                    date: "12 June 2024 • 17:37",
                    amount: "-$32.00"
                )
                
                TransactionRow5(
                    icon: "p.square.fill",
                    title: "Transfer from Paypal",
                    date: "29 June 2024 • 09:15",
                    amount: "+$125.00",
                    isPositive: true
                )
            }
        }
    }
    
    // MARK: - Custom Tab Bar
    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab.rawValue
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab.rawValue
                    }
                }
            }
        }
        .padding(.vertical, 12)
        .background(
            cardBackgroundColor
                .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: -5)
        )
    }
}

// MARK: - Supporting Views
struct BalanceInfoItem: View {
    let title: String
    let value: String
    let trend: TrendDirection
    
    enum TrendDirection {
        case up, down
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack(spacing: 4) {
                Image(systemName: trend == .up ? "arrow.up.right" : "arrow.down.right")
                    .font(.caption2)
                Text(value)
                    .font(.subheadline.weight(.semibold))
            }
            .foregroundColor(trend == .up ? .green : .red)
        }
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(color.opacity(0.2))
                        .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
                )
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct QuickSendButton: View {
    enum ButtonType {
        case add
        case contact
    }
    
    let type: ButtonType
    let name: String?
    var color: Color = .blue
    
    init(type: ButtonType = .contact, name: String? = nil, color: Color = .blue) {
        self.type = type
        self.name = name
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: 8) {
            if type == .add {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "plus")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                
                Text("Add")
                    .foregroundColor(.gray)
            } else {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Text(name?.prefix(1).uppercased() ?? "")
                        .font(.headline)
                        .foregroundColor(color)
                }
                
                Text(name ?? "")
                    .foregroundColor(.white)
            }
        }
        .font(.caption)
    }
}

struct TransactionRow5: View {
    let icon: String
    let title: String
    let date: String
    let amount: String
    var isPositive: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(isPositive ? .green : .white)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(amount)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(isPositive ? .green : .red)
        }
        .padding(.vertical, 8)
    }
}

struct SectionHeader: View {
    let title: String
    let actionTitle: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(actionTitle) {
                // View all action
            }
            .font(.subheadline)
            .foregroundColor(.blue)
        }
    }
}

// MARK: - Tab Bar Components
enum TabItem: Int, CaseIterable {
    case home, statistics, transfer, activity, profile
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .statistics: return "chart.line.uptrend.xyaxis"
        case .transfer: return "arrow.left.arrow.right"
        case .activity: return "bell"
        case .profile: return "person.circle"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .statistics: return "Statistic"
        case .transfer: return "Transfer"
        case .activity: return "Activity"
        case .profile: return "Profile"
        }
    }
}

struct TabBarButton: View {
    let tab: TabItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(isSelected ? .title3 : .body)
                    .symbolEffect(.bounce, value: isSelected)
                
                Text(tab.title)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(isSelected ? .blue : .gray)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView5()
}
