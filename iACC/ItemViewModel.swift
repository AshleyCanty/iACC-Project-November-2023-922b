//	
// Copyright © Essential Developer. All rights reserved.
//

import Foundation
import UIKit

/// Testign source control
/// ItemViewModel struct
struct ItemViewModel {
    let title: String
    let subtitle: String
    
    init(_ item: Any, longDateStyle: Bool) {
        if let friend = item as? Friend {
            self.init(friend: friend)
        } else if let card = item as? Card {
            self.init(card: card)
        } else if let transfer = item as? Transfer {
            self.init(transfer: transfer, longDateStyle: longDateStyle)
        } else {
            fatalError("unkown item: \(item)")
        }
    }
    
}

// MARK: Friend init (can be put into seperate modules)

extension ItemViewModel {
    init(friend: Friend) {
        title = friend.name
        subtitle = friend.phone
    }
}

// MARK: Card init

extension ItemViewModel {
    init(card: Card) {
        title = card.number
        subtitle = card.holder
    }
}


// MARK: Transfer init

extension ItemViewModel {
    init(transfer: Transfer, longDateStyle: Bool) {
        let numberFormatter = Formatters.number
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = transfer.currencyCode
        
        let amount = numberFormatter.string(from: transfer.amount as NSNumber)!
        title = "\(amount) • \(transfer.description)"
        
        let dateFormatter = Formatters.date
        if longDateStyle {
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            subtitle = "Sent to: \(transfer.recipient) on \(dateFormatter.string(from: transfer.date))"
        } else {
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            subtitle = "Received from: \(transfer.sender) on \(dateFormatter.string(from: transfer.date))"
        }
    }
}
