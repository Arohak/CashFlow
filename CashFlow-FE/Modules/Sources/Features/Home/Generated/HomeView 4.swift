import SwiftUI

struct HomeView4: View {
    // MARK: - Properties
    @State private var selectedTab = 0
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                headerSection
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Balance Card
                        balanceCard
                        
                        // Quick Actions
                        quickActionsSection
                        
                        // Quick Send
                        quickSendSection
                        
                        // Recent Transactions
                        recentTransactionsSection
                    }
                    .padding(.horizontal)
                }
                
                // Custom Tab Bar
                customTabBar
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            // App Name and Balance Label
            VStack(alignment: .leading) {
                Text("Byte")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Personal balance")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Search Button
            Button {
                // Search action
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())
            }
        }
        .padding()
    }
    
    // MARK: - Balance Card
    private var balanceCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("$252,312.00")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        )
    }
    
    // MARK: - Quick Actions
    private var quickActionsSection: some View {
        HStack(spacing: 20) {
            QuickActionButton4(title: "Top Up", icon: "arrow.clockwise")
            QuickActionButton4(title: "Transfer", icon: "arrow.right")
            QuickActionButton4(title: "Bill", icon: "creditcard")
            QuickActionButton4(title: "Other", icon: "square.grid.2x2")
        }
    }
    
    // MARK: - Quick Send Section
    private var quickSendSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Quick Send")
                    .font(.headline)
                Spacer()
                Button("View all") {
                    // View all action
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    QuickSendButton(type: .add)
                    QuickSendButton(name: "Sam")
                    QuickSendButton(name: "Ana")
                    QuickSendButton(name: "John")
                    QuickSendButton(name: "Kate")
                }
            }
        }
    }
    
    // MARK: - Recent Transactions
    private var recentTransactionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Transaction")
                    .font(.headline)
                Spacer()
                Button("View all") {
                    // View all action
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            
            VStack(spacing: 16) {
                TransactionRow4(
                    icon: "apple.logo",
                    title: "Apple services",
                    date: "03 July 2024 • 18:24",
                    amount: "-$50.00"
                )
                
                TransactionRow4(
                    icon: "a.square.fill",
                    title: "Amazon",
                    date: "12 June 2024 • 17:37",
                    amount: "-$32.00"
                )
                
                TransactionRow4(
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
            ForEach(["house.fill", "chart.line.uptrend.xyaxis", "arrow.left.arrow.right", "bell", "person.circle"], id: \.self) { icon in
                Button {
                    // Tab action
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: icon)
                            .font(.title3)
                        Text(tabTitle(for: icon))
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(selectedTab == 0 ? .blue : .gray)
            }
        }
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
    }
    
    private func tabTitle(for icon: String) -> String {
        switch icon {
        case "house.fill": return "Home"
        case "chart.line.uptrend.xyaxis": return "Statistic"
        case "arrow.left.arrow.right": return "Transfer"
        case "bell": return "Activity"
        case "person.circle": return "Profile"
        default: return ""
        }
    }
}

// MARK: - Supporting Views
struct QuickActionButton4: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 44, height: 44)
                .background(Color(.systemGray5))
                .clipShape(Circle())
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct QuickSendButton4: View {
    enum ButtonType {
        case add
        case contact
    }
    
    let type: ButtonType
    let name: String?
    
    init(type: ButtonType = .contact, name: String? = nil) {
        self.type = type
        self.name = name
    }
    
    var body: some View {
        VStack(spacing: 8) {
            if type == .add {
                Image(systemName: "plus")
                    .font(.title3)
                    .frame(width: 44, height: 44)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
                Text("Add")
            } else {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Text(name?.prefix(1).uppercased() ?? "")
                            .font(.headline)
                    )
                Text(name ?? "")
            }
        }
        .font(.caption)
        .foregroundColor(.white)
    }
}

struct TransactionRow4: View {
    let icon: String
    let title: String
    let date: String
    let amount: String
    var isPositive: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(Color(.systemGray5))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(amount)
                .font(.subheadline)
                .foregroundColor(isPositive ? .green : .red)
        }
    }
}

#Preview {
    HomeView4()
} 
