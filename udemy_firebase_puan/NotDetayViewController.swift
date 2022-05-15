//
//  NotDetayViewController.swift
//  udemy_firebase_puan
//
//  Created by Eren Demir on 14.05.2022.
//

import UIKit
import Firebase

class NotDetayViewController: UIViewController {
    @IBOutlet weak var dersTextfield: UITextField!
    @IBOutlet weak var vizeTextfield: UITextField!
    @IBOutlet weak var finalTextfield: UITextField!
    var gelenNot:Notlar?
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if let n = gelenNot {
            dersTextfield.text = n.ders_adi
            vizeTextfield.text = "\(n.not1!)"
            finalTextfield.text = "\(n.not2!)"
        }
    }
    
    @IBAction func btnGuncelle(_ sender: Any) {
        
        if let n = gelenNot, let ad = dersTextfield.text, let not1 = vizeTextfield.text, let not2 = finalTextfield.text {
            if let nid = n.not_id, let n1 = Int(not1), let n2 = Int(not2) {
                notGuncelle(not_id: nid, ders_adi: ad, not1: n1, not2: n2)
            }
        }
    }
    
    @IBAction func btnSil(_ sender: Any) {
        if let n = gelenNot {
            if let nid = n.not_id {
                notSil(not_id: nid)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    func notGuncelle(not_id:String,ders_adi:String,not1:Int,not2:Int){
        let dict:[String:Any] = ["ders_adi":ders_adi,"not1":not1,"not2":not2]
        ref?.child("notlar").child(not_id).updateChildValues(dict)
    }
    func notSil(not_id:String){
        ref?.child("notlar").child(not_id).removeValue()
    }
}
