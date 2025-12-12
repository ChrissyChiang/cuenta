//
//  Created by Chrissy on 12/10/25.
//

import SwiftUI

struct Plans: Decodable, Identifiable {
    let id : UUID
    let name: String
    let currency: String
    let created_by: UUID
    let created_at: Date
}

extension Plans {
    struct Insert: Encodable {
        let name: String
        let currency: String
        let created_by: UUID
    }
}
