//
//  ViewController.swift
//  practica1Manel
//
//  Created by Manel Sitjar on 9/10/18.
//  Copyright © 2018 Manel Sitjar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var LblTemporizador: UILabel!
    @IBOutlet weak var lblPuntuacion: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var lblGameOver: UILabel!
    @IBOutlet weak var btnTry: UIButton!
    
    var segundos = 30
    var contador = Timer()
    var puntos: Int = 0
    var gameOver: Bool = false
    var losBotones: [UIButton] = []
    var valoresAleatorios: [Int] = []
    var tituloActual = 0
    
    
    func empezarCuentaAtras(){
        contador = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.renovarContador)), userInfo: nil, repeats: true)
    }
    
    @objc func renovarContador(){
        segundos -= 1
        LblTemporizador.text = "\(segundos)"
        if segundos == 0 {
            contador.invalidate()
            perdiste()
        }
    }
    
    @IBAction func clicaBoton(_ sender: UIButton) {
        tituloActual = Int(sender.currentTitle!)!
        if tituloActual == valoresAleatorios[0]{
            sender.isHidden = true
            valoresAleatorios.removeFirst();
            puntos += 1
            lblPuntuacion.text = String(puntos)
            if valoresAleatorios.isEmpty{
                restart()
            }
        }else{
            perdiste()
        }
    }
    
    
    @IBAction func tryAgain(_ sender: UIButton) {
        restartDesdePerdido()
    }
    
    func restart(){        
        contador.invalidate()
        segundos = 30
        //puntos = 0
        LblTemporizador.text = "\(segundos)"
        empezarCuentaAtras()
        losBotones = [btn1, btn2, btn3, btn4, btn5, btn6]
        for button in 0...5{
            let aleatori = Int.random(in: -101 ..< 101)
            valoresAleatorios.append(aleatori)
            let aleatoriString = String(aleatori)
            losBotones[button].setTitle(aleatoriString, for: .normal)
            losBotones[button].isHidden = false
        }
        valoresAleatorios.sort()
        btnTry.isHidden = true
        lblGameOver.isHidden = true
        print(valoresAleatorios)
    }
    
    func restartDesdePerdido(){
        contador.invalidate()
        segundos = 30
        puntos = 0
        lblPuntuacion.text = "\(puntos)"
        LblTemporizador.text = "\(segundos)"
        empezarCuentaAtras()
        losBotones = [btn1, btn2, btn3, btn4, btn5, btn6]
        for button in 0...5{
            let aleatori = Int.random(in: -101 ..< 101)
            valoresAleatorios.append(aleatori)
            let aleatoriString = String(aleatori)
            losBotones[button].setTitle(aleatoriString, for: .normal)
            losBotones[button].isHidden = false
        }
        valoresAleatorios.sort()
        btnTry.isHidden = true
        lblGameOver.isHidden = true
        print(valoresAleatorios)
    }
    
    func perdiste(){
        contador.invalidate()
        LblTemporizador.text = ""
        segundos = 0
        //lblPuntuacion.text = String(puntos)
        gameOver = true
        btnTry.isHidden = false
        for boton in 0...5{
            losBotones[boton].isHidden = true
        }
        lblGameOver.isHidden = false
        valoresAleatorios.removeAll()
    }
    
    override func viewDidLoad() {
        LblTemporizador.text = ""
        lblGameOver.isHidden = true
        super.viewDidLoad()
        restart()
        btnTry.isHidden = true
    }
}

