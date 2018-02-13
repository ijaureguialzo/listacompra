//
//  NuevaListaViewController.swift
//  ListaCompra
//
//  Created by Ion Jaureguialzo Sarasola on 8/2/18.
//  Copyright © 2018 Ion Jaureguialzo Sarasola. All rights reserved.
//

import UIKit

import Eureka

class NuevaListaViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Datos de la lista")
        <<< TextRow() { row in
            row.title = "Título"
            row.placeholder = "Supermercado"
            row.tag = "titulo"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
