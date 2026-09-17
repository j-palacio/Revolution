//
//  UsernameSetupView.swift
//  Revolution
//

import SwiftUI

/// Shown after an OAuth sign-up (e.g. Google) when the account still has an
/// auto-generated username, so the user can pick a real one before entering the app.
struct UsernameSetupView: View {
    @EnvironmentObject var authManager: AuthManager

    @State private var username = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showError = false

    private var trimmedUsername: String {
        username.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private var isValid: Bool {
        trimmedUsername.range(of: "^[a-zA-Z0-9_]{3,20}$", options: .regularExpression) != nil
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Choose a username")
                .font(.title)
                .fontWeight(.heavy)

            Text("This is how other people will find and mention you.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .frame(width: 300)
                .fontWeight(.semibold)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray3), lineWidth: 1)
                )

            Button {
                Task { await submit() }
            } label: {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(width: 300, height: 50)
                        .background(Color(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1.0)))
                        .cornerRadius(10)
                } else {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1.0)))
                        .cornerRadius(10)
                }
            }
            .disabled(isLoading || !isValid)
            .opacity(isValid ? 1 : 0.5)

            Spacer()
            Spacer()
        }
        .alert("Notice", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }

    private func submit() async {
        guard isValid else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            try await authManager.updateProfile(updates: ProfileUpdate(username: trimmedUsername))
        } catch {
            errorMessage = "That username is taken. Try another."
            showError = true
        }
    }
}

#Preview {
    UsernameSetupView()
}
