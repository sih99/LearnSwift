//
//  CardListViewController.swift
//  LearnSwift
//
//  Created by Sungin Hong on 2022/11/21.
//

import UIKit
import Kingfisher
import FirebaseDatabase


class CardListViewController: UITableViewController {
    var ref: DatabaseReference! // Firebase Realtime database

    var creditCardList: [CreditCard] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //UITabelView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)

        self.tableView.register(nibName, forCellReuseIdentifier: "CardListCell")

        ref = Database.database().reference()
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted(by: {
                    $0.rank < $1.rank
                })

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch let error {
                print("Error JSON parsing \(error.localizedDescription)")
            }


        }

    }




    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // the number of rows
        return creditCardList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() }

        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"

        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageVIew.kf.setImage(with: imageURL)

        return cell
    }

    //    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100 //height
    //    }
    //
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //상세화면 전달

        let storyboard = UIStoryboard(name: "CreditCardList", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController else { return }

        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)



        let cardID = creditCardList[indexPath.row].id
        //option1
        ref.child("Item\(cardID)/isSelected").setValue(true)

        //option2
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//
//            guard let self = self,
//                let value = snapshot.value as? [String: [String: Any]],
//                let key = value.keys.first else { return }
//
//            self.ref.child("\(key)/isSelected").setValue(true)
//
//
//        }



    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //option1
            let cardID  = creditCardList[indexPath.row].id
            ref.child("Item\(cardID)").removeValue()
            
            //option2
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//
//                self.ref.child(key).removeValue()
//            }
        }
    }
}
