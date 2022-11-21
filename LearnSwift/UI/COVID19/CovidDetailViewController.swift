//
//  CovidDataViewController.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/19.
//

import UIKit

class CovidDetailViewController: UITableViewController {

    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var recoveredCell: UITableViewCell!
    @IBOutlet weak var deathCell: UITableViewCell!
    @IBOutlet weak var percentageCell: UITableViewCell!
    @IBOutlet weak var overseasInflowCell: UITableViewCell!
    @IBOutlet weak var regionalOutbreakCell: UITableViewCell!

    var covidOverview: CovidOverview?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    func configureView() {
        guard let covidOverview = self.covidOverview else { return }
//        self.navigationController?.isNavigationBarHidden = false
        self.title = covidOverview.countryName
//        self.newCaseCell.detailTextL

        var content = UITableViewCell().defaultContentConfiguration()

        content.secondaryText = "\(covidOverview.newCase)명"
        self.newCaseCell.contentConfiguration = content
        content.secondaryText = "\(covidOverview.totalCase)명"
        self.totalCaseCell.contentConfiguration = content
        content.secondaryText = "\(covidOverview.recovered)명"
        self.recoveredCell.contentConfiguration = content
        content.secondaryText = "\(covidOverview.death)명"
        self.deathCell.contentConfiguration = content
        content.secondaryText = "\(covidOverview.percentage)명"
        self.percentageCell.contentConfiguration = content
        content.secondaryText = "\(covidOverview.newFcase)명"
        self.overseasInflowCell.contentConfiguration = content
        content.secondaryText = "\(covidOverview.newCcase)명"
        self.regionalOutbreakCell.contentConfiguration = content


    }



}
