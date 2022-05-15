//
//  NotEkleViewController.swift
//  udemy_firebase_puan
//
//  Created by Eren Demir on 14.05.2022.
//

import UIKit
import Firebase
class NotEkleViewController: UIViewController {
    @IBOutlet weak var dersTextfield: UITextField!
    @IBOutlet weak var vizeTextfield: UITextField!
    @IBOutlet weak var finalTextfield: UITextField!
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func btnEkle(_ sender: Any) {
        if let d = dersTextfield.text, let v = vizeTextfield.text, let f = finalTextfield.text {
            if let n1 = Int(v), let n2 = Int(f) {
                notEkle(ders_adi: d, not1: n1, not2: n2)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func notEkle(ders_adi:String,not1:Int,not2:Int) {
        let dict:[String:Any] = ["ders_adi":ders_adi,"not1":not1,"not2":not2]
        let newRef = ref.child("notlar").childByAutoId()
        newRef.setValue(dict)
    }
}
