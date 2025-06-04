//
//  ContentView.swift
//  Modules
//
//  Created by Ara Hakobyan on 1/6/25.
//


import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack {
                TopBar()
                
                BalanceSection()
                
                ActionButtons()
                
                QuickSendSection()
                
                RecentTransactionsSection()
                
                Spacer()
                
                NavigationBar(selectedTab: $selectedTab)
            }
        }
    }
}

struct TopBar: View {
    var body: some View {
        HStack {
            Text("9:41")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            Spacer()
            Text("Byte")
                .font(.system(size: 18, weight: .medium))
            Image(systemName: "chevron.down")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                
            Spacer()
           
            HStack(spacing: 5) {
                Image(systemName: "signal.cellular.3")
                    .font(.system(size: 14))
                Image(systemName: "wifi")
                    .font(.system(size: 14))
                 Image(systemName: "battery.100")
                    .font(.system(size: 14))
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct BalanceSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Personal balance")
                .font(.caption)
                .foregroundColor(.gray)
                .opacity(0.7)
            Text("$ 252,312.00")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.primary, .primary.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value:  UUID())
    }
}

struct ActionButtons: View {
    var body: some View {
        HStack(spacing: 15) {
            ActionButton(iconName: "arrow.clockwise", text: "Top Up")
            ActionButton(iconName: "arrow.left.arrow.right", text: "Transfer")
            ActionButton(iconName: "creditcard", text: "Bill")
            ActionButton(iconName: "square.grid.2x2", text: "Other")
            
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        
    }
}

struct ActionButton: View {
    let iconName: String
    let text: String
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.gray.opacity(0.1))
                .frame(width: 45, height: 45)
                .overlay(
                    Image(systemName: iconName)
                        .font(.title3)
                        .foregroundColor(.primary)
                )
                .scaleEffect(1.0)
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct QuickSendSection: View {
    var body: some View {
        VStack(alignment: .leading) {
           HStack {
               Text("Quick Send")
                   .font(.headline)
               Spacer()
               Text("View all")
                   .font(.subheadline)
                   .foregroundColor(.accentColor)
           }
           .padding(.horizontal)
           
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    AddPersonButton()
                    PersonButton(name: "Sam", imageName: "sam")
                    PersonButton(name: "Ana", imageName: "ana")
                    PersonButton(name: "John", imageName: "john")
                    PersonButton(name: "Kate", imageName: "kate")
                }
            }
           .padding(.horizontal)
        }
        .padding(.vertical, 10)
         .background(RoundedRectangle(cornerRadius: 20)
                                           .fill(.white))
        .padding(.horizontal)
    }
}

struct AddPersonButton: View {
    var body: some View {
       VStack{
           Circle()
               .strokeBorder(style: StrokeStyle(dash: [3]))
               .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.primary)
                )
           Text("Add")
               .font(.caption)
               .foregroundColor(.gray)
       }
    }
}


struct PersonButton: View {
    let name: String
    let imageName: String
    @State private var isTapped = false

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .scaleEffect(isTapped ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isTapped)
                .onTapGesture {
                   isTapped = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isTapped = false
                    }
                }
             Text(name)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct RecentTransactionsSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Recent Transaction")
                   .font(.headline)
               Spacer()
               Text("View all")
                   .font(.subheadline)
                   .foregroundColor(.accentColor)
           }
           .padding(.horizontal)
            
            ScrollView(.vertical, showsIndicators: false) {
               VStack{
                    TransactionRow(iconName: "applelogo", company: "Apple services", date: "03 July 2024 • 18:24", amount: "- $50.00")
                    
                    TransactionRow(iconName: "amazon", company: "Amazon", date: "12 June 2024 • 17:37", amount: "- $32.00")
                   
                    TransactionRow(iconName: "paypal", company: "Transfer from Paypal", date: "29 June 2024 • 09", amount: "+ $125.00")
               }
            }
        }
        .padding(.vertical, 10)
         .background(RoundedRectangle(cornerRadius: 20)
                                           .fill(.white))
        .padding(.horizontal)
    }
}


struct TransactionRow: View {
    let iconName: String
    let company: String
    let date: String
    let amount: String
    @State private var isTapped = false

    var body: some View {
       HStack{
           Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
           VStack(alignment: .leading){
               Text(company)
                   .font(.subheadline)
               Text(date)
                   .font(.caption2)
                   .foregroundColor(.gray)
           }
            Spacer()
            Text(amount)
                .font(.subheadline)
       }
       .padding(.vertical, 5)
       .padding(.horizontal)
       .scaleEffect(isTapped ? 1.05 : 1.0)
       .animation(.spring(response: 0.2, dampingFraction: 0.5), value: isTapped)
       .onTapGesture {
           isTapped.toggle()
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
               isTapped.toggle()
           }
       }
    }
}


struct NavigationBar: View {
   @Binding var selectedTab: Int
    var body: some View {
        HStack(spacing: 0) {
            NavigationBarItem(iconName: "house.fill", text: "Home", tag: 0, selectedTab: $selectedTab)
            NavigationBarItem(iconName: "chart.line.uptrend.xyaxis", text: "Statistic", tag: 1, selectedTab: $selectedTab)
               .padding(.leading, 20)
            
            Circle()
                .fill(.white)
                .frame(width: 60, height: 60)
                .overlay(
                   Image(systemName: "viewfinder.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.blue)
                )
                .padding(.bottom,15)
               
            NavigationBarItem(iconName: "bell", text: "Activity", tag: 2, selectedTab: $selectedTab)
                .padding(.trailing, 20)
            NavigationBarItem(iconName: "person", text: "Profile", tag: 3, selectedTab: $selectedTab)
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
        .padding(.bottom, 10)
        .background(Color(.systemGray6))
    }
}

struct NavigationBarItem: View {
    let iconName: String
    let text: String
    let tag: Int
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundColor(selectedTab == tag ? .primary : .gray)
            Text(text)
                .font(.caption)
                .foregroundColor(selectedTab == tag ? .primary : .gray)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
           selectedTab = tag
        }
    }
}

#Preview {
    ContentView()
}