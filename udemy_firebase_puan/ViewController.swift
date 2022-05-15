//
//  ViewController.swift
//  udemy_firebase_puan
//
//  Created by Eren Demir on 14.05.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var notTableView: UITableView!
    var notlarListesi = [Notlar]()
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        notTableView.delegate = self
        notTableView.dataSource = self
        ref = Database.database().reference()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tumNotlar()
    }
    
    func ortalamaHesapla() {
        var toplam = 0
        for n in notlarListesi {
            toplam = toplam + (n.not1! + n.not2!)/2
        }
        if notlarListesi.count != 0 {
            navigationItem.prompt = "Ortalama: \(toplam/notlarListesi.count)"
        }else {
            navigationItem.prompt = "Ortalama: YOK"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            print("toDetay")
            if let index = sender as? Int{
                let gidilecekVC = segue.destination as! NotDetayViewController
                gidilecekVC.gelenNot = notlarListesi[index]
            }
        }
    }
    
    func tumNotlar() {
        ref.child("notlar").observe(.value, with: { snapshot in
            if let gelenVeriButunu = snapshot.value as? [String:AnyObject]{
                self.notlarListesi.removeAll()
                for gelenSatirVerisi in gelenVeriButunu {
                    if let sozluk = gelenSatirVerisi.value as? NSDictionary {
                        let key = gelenSatirVerisi.key
                        let ders_adi = sozluk["ders_adi"] as? String ?? ""
                        let not1 = sozluk["not1"] as? Int ?? 0
                        let not2 = sozluk["not2"] as? Int ?? 0
                        let not = Notlar(not_id: key, ders_adi: ders_adi, not1: not1, not2: not2)
                        self.notlarListesi.append(not)
                    }
                }
                DispatchQueue.main.async {
                    self.notTableView.reloadData()
                }
            }
        })
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlarListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let not = notlarListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "notHucre", for: indexPath) as! NotHucreTableViewCell
        cell.dersLabel.text = not.ders_adi
        cell.vizeLabel.text = "\(not.not1!)"
        cell.finalLabel.text = "\(not.not2!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}
