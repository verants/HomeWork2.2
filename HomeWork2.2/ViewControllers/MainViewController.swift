//
//  MainViewController.swift
//  HomeWork2.2
//
//  Created by Антон Вербицкий on 11.04.2021.
//

import UIKit

protocol ColorSettingsViewControllerDelegate {
	var redValue: Float { get }
	var greenValue: Float { get }
	var blueValue: Float { get }

	func setBackgroundColor(red color: Float, green color: Float, blue color: Float)
}


class MainViewController: UIViewController {

	var redColor: Float = 0
	var greenColor: Float = 0
	var blueColor: Float = 0



	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

	// MARK: - Override Methods
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let colorSettingsVC = segue.destination as? ColorSettingsViewController else { return }
		colorSettingsVC.backgroundColor = view.backgroundColor ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

		// в свойство delegate второго контроллера передаем наш контроллер
		colorSettingsVC.delegate = self
	}


	@IBAction func unwindSegue(segue: UIStoryboardSegue) {
	}

}

// MARK: - Extensions
extension MainViewController: ColorSettingsViewControllerDelegate {
	// не знаю как, но эта реализация протокола позволяет
	// сохранить положение слайдеров при переходе на второй экран
	var redValue: Float {
		redColor
	}
	var greenValue: Float {
		greenColor
	}
	var blueValue: Float {
		blueColor
	}

	func setBackgroundColor(red redValue: Float, green greenValue: Float, blue blueValue: Float) {
		view.backgroundColor = UIColor(red: CGFloat(redValue),
									   green: CGFloat(greenValue),
									   blue:CGFloat(blueValue),
									   alpha: 1)

		// не знаю как, но это присвоение позволяет
		// сохранить положение слайдеров при переходе на второй экран
		redColor = redValue
		greenColor = greenValue
		blueColor = blueValue
	}


}
