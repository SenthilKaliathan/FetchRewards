//
//  ErrorUtility.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 17/08/21.
//

import UIKit

class ErrorUtility {
    
    // Display error
    static func showError(_ error: NetworkError, viewController: UIViewController?) {
        var errorMessage: String
        switch error {
        case .badStatus, .invalidURL:
            errorMessage = NSLocalizedString("API failure. Please check your network connection and try again!", comment: "")
        case .nullData:
            errorMessage = NSLocalizedString("Data not avaialble. Please try again later!", comment: "")
        case .unknown, .invalidJSON:
            errorMessage = NSLocalizedString("Something went wrong. Please try again later!", comment: "")
        }
        // Display error based on status code
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .cancel, handler: nil)
            alertController.addAction(okAction)
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
