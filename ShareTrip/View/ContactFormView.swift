//
//  ContactFormView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//

import SwiftUI

struct ContactFormView: View {
    @StateObject private var viewModel = ContactFormViewModel()
    
    @Binding var isPresented: Bool
    @State private var isSubmitted: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                if isSubmitted && (!viewModel.isFormValid || !viewModel.isValidEmail) {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                Form {
                    Section(header: Text("Personal Information")) {
                        TextField("Name", text: $viewModel.name)
                        TextField("Surname", text: $viewModel.surname)
                        TextField("Email", text: $viewModel.email)
                        TextField("Phone (Optional)", text: $viewModel.phone)
                    }
                    
                    Section(header: Text("Report Details")) {
                        DatePicker("Date and Time", selection: $viewModel.reportDate, displayedComponents: [.date, .hourAndMinute])
                        TextEditor(text: $viewModel.reportDescription)
                            .frame(minHeight: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .accessibilityIdentifier("textEditor")
                            .onChange(of: viewModel.reportDescription) {
                                viewModel.reportDescription = String(viewModel.reportDescription.prefix(200))
                            }
                    }
                    
                    Section {
                        Button("Submit Report") {
                            isSubmitted = true
                            if viewModel.isFormValid && viewModel.isValidEmail {
                                viewModel.submitReport()
                                self.isPresented = false
                            } else {
                                self.errorMessage = !viewModel.isValidEmail ? "Email address is not valid." : "Please fill in all required fields."
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Report an Issue", displayMode: .inline)
        }
    }
}

