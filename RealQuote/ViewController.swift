//
//  ViewController.swift
//  RealQuote
//
//  Created by Paul Baker on 4/2/19.
//  Copyright © 2019 Paul Baker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuoteDelegate {
    
    let quoteFetcher = QuoteFetcher()


    @IBOutlet var quoteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newQuoteButton.setTitle("Fetching...", for: .disabled)
        newQuoteButton.isEnabled = false
        
        quoteFetcher.quoteDelegate = self
        quoteFetcher.fetchRandomQuote()
    }
    
    @IBOutlet var newQuoteButton: UIButton!
    @IBAction func newQuoteButtonTapped(_ sender: Any) {
        newQuoteButton.isEnabled = false
        quoteFetcher.fetchRandomQuote()
    }
    
    func quoteFetchError(because quoteError: QuoteError) {
        let alert = UIAlertController(title: "Error", message: "Error fetching quote. \(quoteError.message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
        newQuoteButton.isEnabled = true
    }
    
    func quoteFetched(quote: Quote) {
        DispatchQueue.main.async {
            
        let quoteText = "<p>\(quote.text)<p><em>\(quote.author)</em></p>"
        let data = Data(quoteText.utf8) // decodes &qt; and similar
            
        let attributedString = try? NSAttributedString(
            data: data,
            options:
            [.documentType: NSAttributedString.DocumentType.html,
             .characterEncoding: String.Encoding.utf8.rawValue ],
            documentAttributes: nil)
            
        self.quoteTextView.attributedText = attributedString
        self.newQuoteButton.isEnabled = true
    }

    }

}

