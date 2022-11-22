//
//  CardDetailViewController.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/22.
//


import UIKit
import Lottie


class CardDetailViewController: UIViewController {
    
    var promotionDetail:PromotionDetail?

    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benifitConditionLabel: UILabel!
    @IBOutlet weak var benifitDetailLabel: UILabel!
    @IBOutlet weak var benifitDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LottieAnimationView(name: "money")
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.addSubview(animationView)
        animationView.frame = lottieAnimationView.bounds
        animationView.loopMode = .loop
        animationView.play()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = promotionDetail else {return}
        
        titleLabel.text = """
            \(detail.companyName)카드 쓰면
            \(detail.amount)만원 드려요
            """
        periodLabel.text = detail.period
        conditionLabel.text = detail.condition
        benifitConditionLabel.text = detail.benefitCondition
        benifitDetailLabel.text = detail.benefitDetail
        benifitDateLabel.text = detail.benefitDate
    }



}
