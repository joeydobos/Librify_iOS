import SwiftUI

struct ContentView: View {
    let grey = Color(red: 122 / 255, green: 122 / 255, blue: 122 / 255)

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let boxColours: [Color] = [
        Color(red: 242 / 255, green: 132 / 255, blue: 158 / 255),
        Color(red: 126 / 255, green: 202 / 255, blue: 246 / 255),
        Color(red: 123 / 255, green: 208 / 255, blue: 193 / 255),
        Color(red: 199 / 255, green: 91 / 255, blue: 155 / 255),
        Color(red: 174 / 255, green: 133 / 255, blue: 202 / 255),
        Color(red: 132 / 255, green: 153 / 255, blue: 231 / 255)
    ]
    
    let items = [
        "Foundation Year",
        "First Year",
        "Second Year",
        "Third Year",
        "Masters",
        "Additional Reading"
    ]

    let yearModules: [String: [String]] = [
        "Foundation Year": ["Full Maths", "Additional Maths", "Computer Science"],
        "First Year": ["COMP116", "COMP124", "COMP108", "COMP107", "COMP109", "COMP111", "COMP122", "COMP101", "COMP105"],
        "Second Year": ["COMP202", "COMP207", "COMP208", "COMP201", "COMP282", "COMP219", "COMP285", "COMP226", "COMP211", "COMP218", "COMP212", "COMP221", "COMP281", "COMP222", "COMP284", "COMP220", "COMP232", "COMP229", "COMP228"],
        "Third Year": ["COMP390", "COMP305", "COMP335", "COMP324", "COMP326", "COMP309", "COMP313", "ELEC319", "COMP323", "COMP304", "COMP310", "ELEC320", "COMP318", "COMP331", "COMP329", "COMP319", "COMP343", "COMP336", "COMP338", "COMP337", "COMP328", "COMP341", "COMP342"],
        "Masters": ["COMP516", "COMP517", "COMP518", "COMP526", "COMP519", "COMP575", "COMP527", "COMP532", "COMP524", "COMP525", "COMP310", "COMP315", "COMP318", "ENVS456", "COMP530", "COMP720"],
        "Additional Reading": ["Interview Prep", "Web Development", "Artificial Intelligence", "Database Management", "Cyber Security", "Computer Hardware"]
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    
                    Text("Welcome to LIBRIFY")
                        .font(.custom("Helvetica Neue", size: 24))
                        .foregroundColor(grey)
                        .padding()
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(items.indices, id: \.self) { index in
                            if let modules = yearModules[items[index]] {
                                NavigationLink(destination: ModulesView(year: items[index], modules: modules)) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(boxColours[index])
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150)
                                        .overlay(
                                            Text(items[index])
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .padding(5)
                                                .multilineTextAlignment(.center),
                                            alignment: .center
                                        )
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
