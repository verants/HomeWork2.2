//
//  ViewController.swift
//  HomeWork2.2
//
//  Created by Антон Вербицкий on 27.03.2021.
//

import UIKit

class ColorSettingsViewController: UIViewController {

	// MARK: - @IBOutlets
	@IBOutlet weak var colorMapView: UIView!

	@IBOutlet weak var redValueLabel: UILabel!
	@IBOutlet weak var greenValueLabel: UILabel!
	@IBOutlet weak var blueValueLabel: UILabel!

	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!

	var backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)

	var delegate: ColorSettingsViewControllerDelegate!

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		// Устанавливаем положение слайдеров через delegate
		redSlider.value = delegate.redValue
		greenSlider.value = delegate.greenValue
		blueSlider.value = delegate.blueValue

		// Закругляем углы ColorMapView
		colorMapView.layer.cornerRadius  = colorMapView.frame.width / 40

		// Устанавливаем переданный по сегвею цвет
		colorMapView.backgroundColor = backgroundColor

		// Меняем числовые значения при изменении слайдеров
		redValueLabel.text = String(format: "%.2f", redSlider.value)
		greenValueLabel.text = String(format: "%.2f", greenSlider.value)
		blueValueLabel.text = String(format: "%.2f", blueSlider.value)

	}

	// MARK: - @IBActions
	@IBAction func redSliderAction() {
		redValueLabel.text = String(format: "%.2f", redSlider.value)
		changeColorMapView()
	}
	@IBAction func greenSliderAction() {
		greenValueLabel.text = String(format: "%.2f", greenSlider.value)
		changeColorMapView()
	}
	@IBAction func blueSliderAction() {
		blueValueLabel.text = String(format: "%.2f", blueSlider.value)
		changeColorMapView()
	}


	// MARK: - Private Methods
	private func changeColorMapView() {
		colorMapView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
											   green: CGFloat(greenSlider.value),
											   blue:CGFloat(blueSlider.value),
											   alpha: 1)

		// Через делегата передаем цвет на MainViewController
		delegate.setBackgroundColor(red: redSlider.value,
									green: greenSlider.value,
									blue: blueSlider.value)
	}

}

