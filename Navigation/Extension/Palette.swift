import Foundation
import UIKit

struct Palette {
    static var feedBackground = UIColor.createColor(lightMode: .systemGray6, darkMode: .gray)
    static var postBackground = UIColor.createColor(lightMode: .systemGray6, darkMode: .gray)
    static var infoBackground = UIColor.createColor(lightMode: .systemGray4, darkMode: .darkGray)
    static var favouritesBackground = UIColor.createColor(lightMode: .white, darkMode: .black)
    static var loginBackground = UIColor.createColor(lightMode: .white, darkMode: .black)
    static var profileBackground = UIColor.createColor(lightMode: .systemGray6, darkMode: .gray)
    static var photosBackground = UIColor.createColor(lightMode: .systemGray6, darkMode: .gray)
    static var mediaBackground = UIColor.createColor(lightMode: .systemGray6, darkMode: .gray)

    static var whiteAndBlack = UIColor.createColor(lightMode: .white, darkMode: .black)
    static var blackAndWhite = UIColor.createColor(lightMode: .black, darkMode: .white)
    static var grayAndLightGray = UIColor.createColor(lightMode: .systemGray, darkMode: .lightGray)
    static var blueAndRed = UIColor.createColor(lightMode: .blue, darkMode: .red)
}
