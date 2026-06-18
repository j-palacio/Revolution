import Foundation
import Supabase

/// Singleton client for Supabase connection
final class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://dvubepapjcaaelteazup.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2dWJlcGFwamNhYWVsdGVhenVwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE3NDY5MjgsImV4cCI6MjA5NzMyMjkyOH0.7omAYaoO4mdXs4TsulXNP4FmrKGAlbMnvJrYtrY3uWI",
            options: .init(auth: .init(emitLocalSessionAsInitialSession: true))
        )
    }
}
