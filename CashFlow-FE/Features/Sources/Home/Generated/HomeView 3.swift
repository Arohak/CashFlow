import SwiftUI

struct HomeView3: View {
    // MARK: - Properties
    @State private var selectedTab = 1
    @State private var showAddMoney = false
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: - Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.8),
                    Color.purple.opacity(0.6)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // MARK: - Main Content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // MARK: - Top Section
                    topSection
                    
                    // MARK: - Bottom Section
                    bottomSection
                }
            }
            
            // MARK: - Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddMoney) {
            AddMoneySheet()
        }
    }
    
    // MARK: - Top Section
    private var topSection: some View {
        ZStack(alignment: .top) {
            // Background with curved bottom
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.7),
                    Color.purple.opacity(0.5)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 420)
            .mask(CurvedBottomShape(cornerRadius: 32))
            
            // Content
            VStack(spacing: 24) {
                // Header
                headerView
                
                // Balance Card
                balanceCard
                
                // Quick Actions Grid
                quickActionsGrid
                
                // Setup Progress
                setupProgressCard
            }
            .padding(.top, 60)
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Button {
                // Menu action
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Text("Earn $100")
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            NotificationButton()
        }
        .padding(.horizontal)
    }
    
    // MARK: - Balance Card
    private var balanceCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Balance info
            VStack(alignment: .leading, spacing: 8) {
                Text("Total Balance")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                
                Text("$142,832.51")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                HStack {
                    Image(systemName: "arrow.up.right")
                    Text("+$2,354 this week")
                }
                .font(.caption)
                .foregroundColor(.green)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
            }
            
            // Add Money Button
            Button {
                showAddMoney = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Money")
                }
                .font(.headline)
                .foregroundColor(.blue)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.1), radius: 10)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.15))
                .shadow(color: .black.opacity(0.1), radius: 15)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Quick Actions Grid
    private var quickActionsGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ],
            spacing: 16
        ) {
            QuickActionTile(
                title: "Investments",
                amount: "$133.28",
                icon: "chart.line.uptrend.xyaxis",
                color: .green
            )
            QuickActionTile(
                title: "Savings",
                amount: "$9,842.55",
                icon: "banknote",
                color: .blue
            )
            QuickActionTile(
                title: "Pensions",
                amount: "$45,231.00",
                icon: "briefcase.fill",
                color: .purple
            )
            QuickActionTile(
                title: "Cards",
                amount: "$2,842.12",
                icon: "creditcard.fill",
                color: .orange
            )
        }
        .padding(.horizontal)
    }
    
    // MARK: - Bottom Section
    private var bottomSection: some View {
        VStack(spacing: 24) {
            // Analytics Section
            analyticsSection
            
            // Recent Transactions
            transactionsSection
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(.systemBackground))
        )
        .offset(y: -35)
    }
}

// MARK: - Supporting Views
struct QuickActionTile: View {
    let title: String
    let amount: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Text(amount)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct NotificationButton: View {
    @State private var hasNotifications = true
    
    var body: some View {
        Button {
            // Notification action
        } label: {
            Image(systemName: "bell.fill")
                .font(.title3)
                .foregroundColor(.white)
                .overlay(alignment: .topTrailing) {
                    if hasNotifications {
                        Circle()
                            .fill(.red)
                            .frame(width: 8, height: 8)
                            .offset(x: 2, y: -2)
                    }
                }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    private let tabs = [
        ("book.fill", "Learn"),
        ("house.fill", "Home"),
        ("square.grid.2x2.fill", "Menu")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = index
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].0)
                            .font(.title3)
                        Text(tabs[index].1)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(selectedTab == index ? .blue : .gray)
            }
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10, y: -5)
        )
        .padding(.horizontal, 24)
        .padding(.bottom, 8)
    }
}

// MARK: - CurvedBottomShape (unchanged)
struct CurvedBottomShape: Shape {
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Top-left
        path.move(to: .zero)
        // Down left side
        path.addLine(to: CGPoint(x: 0, y: rect.height - cornerRadius))
        // Curve
        path.addQuadCurve(
            to: CGPoint(x: cornerRadius, y: rect.height),
            control: CGPoint(x: 0, y: rect.height)
        )
        // Straight line to near bottom-right
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: rect.height))
        // Right curve
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: rect.height - cornerRadius),
            control: CGPoint(x: rect.width, y: rect.height)
        )
        // Up right side
        path.addLine(to: .init(x: rect.width, y: 0))
        path.closeSubpath()
        return path
    }
}

// MARK: - Add Money Sheet
struct AddMoneySheet: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Add Money")
                    .font(.title2)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Analytics Section
extension HomeView3 {
    var analyticsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Analytics")
                .font(.title3.bold())
            
            HStack(spacing: 16) {
                AnalyticCard(
                    title: "Income",
                    value: "$8,545",
                    trend: "+2.3%",
                    color: .green
                )
                AnalyticCard(
                    title: "Expenses",
                    value: "$3,884",
                    trend: "-0.8%",
                    color: .red
                )
            }
        }
    }
}

// MARK: - Transactions Section
extension HomeView3 {
    var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Transactions")
                    .font(.title3.bold())
                Spacer()
                Button("See All") {}
                    .foregroundColor(.blue)
            }
            
            ForEach(0..<3) { _ in
                TransactionRow3()
            }
        }
    }
}

// MARK: - Setup Progress Card
extension HomeView3 {
    var setupProgressCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Setup Progress")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("3/5")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            ProgressBar(value: 0.6)
                .frame(height: 6)
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

// MARK: - Supporting Views
struct AnalyticCard: View {
    let title: String
    let value: String
    let trend: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.title3.bold())
            
            HStack(spacing: 4) {
                Image(systemName: trend.hasPrefix("+") ? "arrow.up.right" : "arrow.down.right")
                Text(trend)
            }
            .font(.caption)
            .foregroundStyle(color)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TransactionRow3: View {
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 48, height: 48)
                .overlay(
                    Image(systemName: "cart.fill")
                        .foregroundStyle(.blue)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Shopping")
                    .font(.subheadline)
                Text("Today, 2:34 PM")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("-$24.99")
                .font(.subheadline.bold())
                .foregroundStyle(.red)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct ProgressBar: View {
    let value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: geometry.size.width * value)
            }
        }
        .clipShape(Capsule())
    }
}

// MARK: - Preview
#Preview {
    HomeView3()
}
