import SwiftUI

// 1. 定義書籍資料結構
struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let imageName: String
    let price: String
    let description: String
    var rating: Int = 0
}

// 2. 外層容器 
struct ContentView: View {
    var body: some View {
        TabView {
            // 分頁1：home
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // 分頁2：wishlist
            Text("Wishlist 目前空空如也")
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Wishlist")
                }
            
            // 分頁3：mybooks
            Text("My Books 目前空空如也")
                .tabItem {
                    Image(systemName: "book.pages")
                    Text("My books")
                }
        }
        .accentColor(.purple)
        .preferredColorScheme(.light) //鎖定在淺色模式
    }
}

// 3. home頁面畫面
struct HomeView: View {
    // 第一排書籍資料
    let featuredBooks = [
        Book(title: "Fashionopolis", author: "Dana Thomas", imageName: "book1", price: "$170,170", description: "170170170170"),
        Book(title: "Chanel", author: "Patrick Mauriès", imageName: "book2", price: "$17.00", description: "170170170170"),
        Book(title: "Calligraphy", author: "June & Lucy", imageName: "book6", price: "$170.170", description: "170170170170")
    ]
    
    // 第二排書籍資料
    let newestBooks = [
        Book(title: "Yves Saint Laurent", author: "Suzy Menkes", imageName: "book5", price: "$46.99", description: "A spectacular visual journey through 40 years of haute couture from one of the best-known and most trend-setting brands in fashion.", rating: 4),
        Book(title: "The Book of Signs", author: "Rudolf Koch", imageName: "book4", price: "$1.70", description: "170170170170", rating: 3),
        Book(title: "Stitched Up", author: "Tansy E. Hoskins", imageName: "book3", price: "$17,000", description: "170170170170", rating: 3)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // Popular Books 標題
                    Text("Popular Books")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
                    // 上方列表
                    HorizontalSection(books: featuredBooks, showRating: false)
                    
                    // Newest 標題
                    Text("Newest")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
                    // 下方 Newest 列表
                    HorizontalSection(books: newestBooks, showRating: true)
                }
                .padding(.bottom, 20)
                .padding(.top, 10)
            }
            //導航列按鈕
            .navigationBarItems(leading: Image(systemName: "line.3.horizontal"), trailing: Image(systemName: "magnifyingglass"))
        }
    }
}

// 4. 橫向滑動區塊的 UI
struct HorizontalSection: View {
    let books: [Book]
    var showRating: Bool = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Image(book.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 220)
                                .clipped()
                                .cornerRadius(8)
                            
                            // 判斷是否顯示星星
                            if showRating {
                                HStack(spacing: 2) {
                                    ForEach(0..<5) { index in
                                        Image(systemName: "star.fill")
                                            .font(.caption2)
                                            .foregroundColor(index < book.rating ? .yellow : .gray.opacity(0.3))
                                    }
                                }
                                .padding(.top, 4)
                            }
                            
                            Text(book.title)
                                .font(.headline)
                                .foregroundColor(.black)
                                .lineLimit(1)
                            
                            Text(book.author)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                        .frame(width: 150)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// 5. 書籍詳情頁
struct BookDetailView: View {
    let book: Book
    
    var body: some View {
        VStack(spacing: 20) {
            Image(book.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            VStack(spacing: 8) {
                Text(book.title)
                    .font(.title)
                    .bold()
                Text(book.author)
                    .foregroundColor(.gray)
                
                HStack {
                    ForEach(0..<5, id: \.self) { index in
                         Image(systemName: "star.fill")
                             .foregroundColor(index < book.rating ? .yellow : .gray.opacity(0.3))
                     }
                    Text("\(book.rating).0 / 5.0").font(.subheadline).foregroundColor(.gray)
                }
            }
            
            Text(book.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
            }) {
                Text("BUY NOW FOR \(book.price)")
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 預覽畫面
#Preview {
    ContentView()
}
