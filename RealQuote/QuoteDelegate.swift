//
//  QuoteDelegate.swift
//  RealQuote
//
//  Created by Paul Baker on 4/2/19.
//  Copyright © 2019 Paul Baker. All rights reserved.
//

import Foundation


protocol QuoteDelegate {
    func quoteFetched(quote: Quote)
    func quoteFetchError(because quoteError: QuoteError)
}
