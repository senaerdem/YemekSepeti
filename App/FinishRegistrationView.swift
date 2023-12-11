

import SwiftUI

struct FinishRegistrationView: View {
    
    @State var name=""
    @State var surname=""
    @State var telephone=""
    @State var adress=""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Form{
            Section() {
                Text("Kayıt")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top, .bottom],20)
                TextField("İsim", text:$name)
                TextField("Soyisim", text:$surname)
                TextField("Telefon", text:$telephone)
                TextField("Adres", text:$adress)
            }//sec
            Section() {
                Button(action: {
                    self.finishRegistration()
                },
                       label: {
                        Text("Kayıt Tamamla")
                       })
            }//sect
            .disabled(!self.fieldsCompleted())
        }//form
    }//body
    
    private func fieldsCompleted() -> Bool {
        return self.name != "" && self.surname != ""
            && self.telephone != "" && self.adress != ""
    }
    private func finishRegistration() {
        
        let fullName = name + " " + surname
        
        updateCurrentUser(withValues: [kFIRSTNAME : name, kLASTNAME : surname, kFULLNAME : fullName, kFULLADDRESS : adress, kPHONENUMBER : telephone, kONBOARD : true]) { (error) in
            
            if error != nil {
                
                print("error updating user: ", error!.localizedDescription)
                return
            }
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}
