//
//  Created by Chrissy on 12/10/25.
//
import Supabase

class PlansRepository{
    private let supabase = SupabaseService.shared.client

    func fetchPlans() async throws -> [Plans] {
        return try await supabase.from("plans").select().execute().value
    }

    func createPlan(plan: Plans.Insert) async throws {
        try await supabase.from("plans").insert(plan).execute()
    }
}
