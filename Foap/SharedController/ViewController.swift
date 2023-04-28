//
//  ViewController.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 27/04/2023.
//

import UIKit
import Apollo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        title = "Countries"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "arrow.counterclockwise.circle"), style: .done, target: self, action: #selector(refresh))
//        let countries = await CountryViewModel.shared.getCountries()
        
        // Do any additional setup after loading the view.
        
    
//        lazy var apollo = ApolloClient(url: URL(string: apolloEndPoint)!)
//
//        apollo.fetch(query: CountriesQuery()) { result, error in
//
//        }
//
//
//        let request = Linker(path: "Nigeria") { data, response, error in
//            guard error == nil else {
//                return
//            }
//            let responseData = PopulationResponse(data!.json() as NSDictionary)
//
//        }
        
    }

    @objc func refresh() {
        print("refresh")
    }

}

