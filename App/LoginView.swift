

import SwiftUI

struct LoginView: View {
    
    @State var showingSignup = false
    @State var showingFinishReg = false

    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    var body: some View {
        
        VStack {
            
            Text("Giriş")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            
            
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading) {
                    
                    Text("E-posta")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    TextField("Epostanı yaz", text: $email)
                    Divider()
                    
                    
                    Text("Şifre")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Şifreni Yaz", text: $password)
                    Divider()
                    
                    if showingSignup {
                        Text("Şifreni Tekrarla")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                        
                        SecureField("Şifreni Tekrarla", text: $repeatPassword)
                        Divider()
                    }
                    
                }
                .padding(.bottom, 15)
                .animation(.easeOut(duration: 0.1))
                //End of VStack
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.resetPassword()
                    }, label: {
                        Text("Şifreni Unuttum?")
                            .foregroundColor(Color.gray.opacity(0.5))
                    })
                }//End of HStack
                
            } .padding(.horizontal, 6)
            //End of VStack
            
            Button(action: {

                self.showingSignup ? self.signUpUser() : self.loginUser()
            }, label: {
                Text(showingSignup ? "Kayıt ol" : "Giriş")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            }) //End of Button
                .background(Color.red)
                .clipShape(Capsule())
                .padding(.top, 45)
            
            SignUpView(showingSignup: $showingSignup)
            
            
        }//End of VStack
            .sheet(isPresented: $showingFinishReg) {
                FinishRegistrationView()
        }
        
    }//End of body
    
    
    private func loginUser() {
        
        
        
        
        if email != "" && password != "" {
            
            FUser.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                
                if error != nil {
                    
                    print("error loging in the user: ", error!.localizedDescription)
                    return
                }
                
                if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingFinishReg.toggle()
                }
                
            }
        }
        
    }
    
    private func signUpUser() {
        
        if email != "" && password != "" && repeatPassword != "" {
            if password == repeatPassword {
                
                FUser.registerUserWith(email: email, password: password) { (error) in
                    
                    if error != nil {
                        print("Error registering user: ", error!.localizedDescription)
                        return
                    }
                    print("user has been created")
                    //go back to the app
                    //check if user onboarding is done
                }

                
            } else {
                print("passwords dont match")
            }
            
            
        } else {
            print("Email and password must be set")
        }
        
    }
    
    private func resetPassword() {
        
        if email != "" {
            FUser.resetPassword(email: email) { (error) in
                if error != nil {
                    print("error sending reset password, ", error!.localizedDescription)
                    return
                }
                
                print("please check you email")
            }

        } else {
            //notify the suer
            
            print("email is empty")
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SignUpView : View {
    
    @Binding var showingSignup: Bool
    
    var body: some View {
        
        
        VStack {
            
            Spacer()
            
            HStack(spacing: 8) {
                
                Text("Kayıt Olmadın Mı?")
                    .foregroundColor(Color.gray.opacity(0.5))
                
                Button(action: {
                    
                    self.showingSignup.toggle()
                }, label: {
                    Text("Kayıt ol")
                })
                    .foregroundColor(.blue)
                
            }//End of HStack
                .padding(.top, 25)
            
        } //End of VStack
    }
}
