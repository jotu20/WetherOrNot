//
//  Colors.swift
//  CumulusWeather
//
//  Created by Joseph Szafarowicz on 9/21/22.
//

import UIKit

let lightOrange = UIColor(hex:0xFF9500)
let pollen = UIColor(hex:0xFFD25B)
let mint = UIColor(hex:0xAEEC9D)
let lilac = UIColor(hex:0xC1D8FD)
let azure = UIColor(hex:0x879AA1)
let midnightBlue = UIColor(hex:0x6084BF)
let ultraViolet = UIColor(hex:0x7157BE)
let roseRed = UIColor(hex:0xB92946)
let antiqueWhite = UIColor(hex:0xD4B694)
let darkOlive = UIColor(hex:0x8C8C76)

/*
 
 Light Orange    #FF9500
 Pollen    #FFD25B
 Mint    #AEEC9D
 Lilac    #C1D8FD
 Azure    #879AA1
 Midnight Blue    #6084BF
 Ultra Violet    #7157BE
 Rose Red    #B92946
 Antique White    #D4B694
 Dark Olive    #8C8C76
 
 */

let defaults = UserDefaults.standard
func setColor(view: UIView, value: Int) {
    if value == 0 {
        view.backgroundColor = lightOrange
    } else if value == 1 {
        view.backgroundColor = pollen
    } else if value == 2 {
        view.backgroundColor = mint
    } else if value == 3 {
        view.backgroundColor = lilac
    } else if value == 4 {
        view.backgroundColor = azure
    } else if value == 5 {
        view.backgroundColor = midnightBlue
    } else if value == 6 {
        view.backgroundColor = ultraViolet
    } else if value == 7 {
        view.backgroundColor = roseRed
    } else if value == 8 {
        view.backgroundColor = antiqueWhite
    } else if value == 9 {
        view.backgroundColor = darkOlive
    } else {
        view.backgroundColor = pollen
    }
}
