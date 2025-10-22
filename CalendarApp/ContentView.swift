import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CalendarView(selectedDate: $selectedDate)
                    .padding()

                Divider()

                // 선택된 날짜 정보
                VStack(alignment: .leading, spacing: 12) {
                    Text("선택된 날짜")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text(selectedDate, style: .date)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(selectedDate, style: .time)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

                Spacer()
            }
            .navigationTitle("달력")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
