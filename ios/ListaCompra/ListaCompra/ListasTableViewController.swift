//
//  ListasTableViewController.swift
//  ListaCompra
//
//  Created by Ion Jaureguialzo Sarasola on 2/2/18.
//  Copyright © 2018 Ion Jaureguialzo Sarasola. All rights reserved.
//

import UIKit

import Eureka

import Firebase

class ListasTableViewController: UITableViewController {

    var listas = [Lista]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //let lista = Lista(titulo:"Prueba")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Acceso con el usuario anónimo de Firebase
        Auth.auth().signInAnonymously() { (user, error) in

            // UID de usuario asignado por Firebase
            let uid = user!.uid
            log.debug("Usuario: \(uid)")

            db.collection("listas").whereField("propietario", isEqualTo: uid)
                .addSnapshotListener { querySnapshot, error in
                    guard let documents = querySnapshot?.documents else {
                        log.error("Error al recuperar documentos: \(error!)")
                        return
                    }

                    // Limpiar el array de objetos
                    self.listas.removeAll()

                    for document in documents {
                        // Recuperar los datos de la lista y crear el objeto
                        let datos = document.data()
                        let titulo = datos["titulo"] as? String ?? "?"
                        let lista = Lista(titulo: titulo)
                        self.listas.append(lista)
                    }

                    // Recargar la tabla
                    self.tableView.reloadData()

            }

        }

    }

    @IBAction func guardarNuevaLista(segue: UIStoryboardSegue) {

        let formulario = segue.source as! NuevaListaViewController

        let titulo: TextRow? = formulario.form.rowBy(tag: "titulo")

        log.debug(titulo?.value)

        // Acceso con el usuario anónimo de Firebase
        Auth.auth().signInAnonymously() { (user, error) in

            // UID de usuario asignado por Firebase
            let uid = user!.uid

            db.collection("listas").addDocument(data: [
                "titulo": titulo?.value ?? "?",
                "propietario": uid
            ]) { err in
                if let err = err {
                    log.error("Error al añadir el documento: \(err)")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)

        cell.textLabel?.text = listas[indexPath.row].titulo

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
