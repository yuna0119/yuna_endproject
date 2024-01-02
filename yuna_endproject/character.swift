import Foundation
import SwiftUI
import Combine

class character: ObservableObject{
    var cancellable: AnyCancellable?
    @Published var countries = [Country]()
    
    init(){
        // 解碼，讀檔
        if let data = UserDefaults.standard.data(forKey: "countries"){
          let decoder = JSONDecoder()
          if let decodedData = try? decoder.decode([Country].self, from: data){
            countries = decodedData
          }
        }
        // 編碼，存檔
        cancellable = $countries
            .sink(receiveValue: { (value) in
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(value) {
              UserDefaults.standard.set(data, forKey: "countries")
             }
            })
    }
}

struct Country: Identifiable, Codable {
    var id = UUID()
    var champion: String
    var champion2:String
    var selectedPosition: String
    var finisedtime: Int
    var times: Date
    var favorite: Bool
    var airclass:String
}

struct CountryEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var champsData: character
    @State private var showSelectPhoto = false
    @State private var selectImage = Image(systemName: "photo")
    @State private var champion = ""
    @State private var champion2 = ""
    @State private var airclass = ""
    @State private var selectedPosition = ""
    @State private var finisedtime : CGFloat = 1
    @State private var times = Date()
    let dateFormatter: DateFormatter = {
     let dateFormatter = DateFormatter()
     dateFormatter.dateStyle = .short
     return dateFormatter
     }()
    @State private var favorite = true
    var disableForm: Bool {
        champion.isEmpty || selectedPosition.isEmpty || champion2.isEmpty
    }
    
    var editCountry: Country?
    var region = ["Top", "Jungle", "Mid", "ADC", "Support"]
    var Class = ["Character", "Event", "Scenery"]
    var kingdom = ["烏野", "音駒", "青城", "白鳥澤", "梟谷", "伊達工業","稻荷崎"]
    
    var body: some View {
        
        VStack{
          VStack {
            Button(action: {
                self.showSelectPhoto = true
             }) {
                selectImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $showSelectPhoto) {
              ImagePickerController(showSelectPhoto: self.$showSelectPhoto, selectImage: self.$selectImage)
            }
            

        }

            Form {
                VStack(alignment: .leading) {
                    Picker(selection: self.$airclass, label: Text("Class")) {
                        ForEach(self.Class, id:\.self) { (city) in
                            Text(city)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                TextField("Name", text: $champion)
                TextField("Painter", text: $champion2)
                DatePicker("Upload Time", selection: self.$times, in: Date()..., displayedComponents: .date)
                VStack{
                    Picker(selection: $selectedPosition, label: Text("學校")) {
                        ForEach(self.kingdom, id:\.self) { (city) in
                            Text(city)
                        }
                    }
                }
                
                
                HStack {
                    Text("Like Degree: \(Int(finisedtime))")
                    Slider(value: $finisedtime, in: 1...10)
                }
                Toggle("最愛?", isOn:  $favorite)
            }
            .navigationBarTitle(editCountry == nil ? "Add" : "Edit Country")
            .navigationBarItems(trailing: Button("save"){
                let champion = Country(champion: self.champion, champion2: self.champion2, selectedPosition: self.selectedPosition, finisedtime: Int(self.finisedtime), times: self.times, favorite: self.favorite,airclass:self.airclass)
                if let editCountry = self.editCountry{
                    let index = self.champsData.countries.firstIndex{
                        $0.id == editCountry.id
                    }!      // 因為必有值，所以用驚嘆號
                    self.champsData.countries[index] = champion
                } else{
                    self.champsData.countries.insert(champion, at: 0)
                }
                self.presentationMode.wrappedValue.dismiss()
            }.disabled(disableForm))
       
                .onAppear{
                    if let editCountry = self.editCountry, self.champion == "" {
                        self.champion = editCountry.champion
                        self.selectedPosition = editCountry.selectedPosition
                        self.champion2=editCountry.champion2
                        self.times = editCountry.times
                        self.finisedtime = CGFloat(editCountry.finisedtime)
                        self.favorite = editCountry.favorite
                    }
        }
    }
    }
}


struct ChampionList: View {
    @ObservedObject var champsData = character()
    @State private var show = false
    var body: some View {
        NavigationView {
            List {
                ForEach(champsData.countries){ (champion) in
                    NavigationLink(destination: CountryEditor(champsData:  self.champsData, editCountry: champion)) {
                        CountryRow(country1: champion)
                    }
                }
                .onMove { (indexSet, index) in
                    self.champsData.countries.move(fromOffsets: indexSet,
                                    toOffset: index)
                }
                .onDelete{ (index) in
                    self.champsData.countries.remove(atOffsets: index)
                }
            }
            
            .navigationBarTitle("喜愛圖片")
            .navigationBarItems(leading: EditButton().accentColor(.purple), trailing: Button(action: {
                    self.show = true
                },label: {
                    Image(systemName: "plus.circle.fill")
                        .accentColor(.purple)
                    }))
                .sheet(isPresented: $show){
                    NavigationView {
                        CountryEditor(champsData: self.champsData) // 新增時不用修改
                    }
            }
        }
    }
}

struct CountryRow: View {
    var country1: Country
    var body: some View {
      VStack{
        HStack{
            Text("\(country1.champion)")
            Spacer()
            Image(systemName: country1.favorite ? "crown.fill": "crown")

        }
        
        HStack {
            Text("學校:\(country1.selectedPosition)")
            Spacer()
            Text("位置:\(country1.champion2)")
         }
        
    }
    }
}
