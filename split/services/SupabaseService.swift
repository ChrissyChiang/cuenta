//
//  supabase.swift
//  split
//
//  Created by Chrissy on 12/10/25.
//

import Supabase
import Foundation

final class SupabaseService {
    static let shared = SupabaseService()
    let client: SupabaseClient

    private init() {
        guard let url = URL(string: "https://llvddfqsksqnpdpeikfe.supabase.co")
        else {
            fatalError("Invalid Supabase URL.")
        }

        let authOptions = SupabaseClientOptions.AuthOptions(
            flowType: .pkce,
            emitLocalSessionAsInitialSession: true
        )

        client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: "sb_publishable_G0IjNRlu-3Y_EFk2R-D8Yw_5OI5bK2i",
            options: SupabaseClientOptions(
                auth: authOptions
            )
        )
    }
}
