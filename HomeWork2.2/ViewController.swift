//
//  ViewController.swift
//  HomeWork2.2
//
//  Created by Антон Вербицкий on 27.03.2021.
//

import UIKit





class ViewController: UIViewController {

	@IBOutlet weak var colorMapView: UIView!

	@IBOutlet weak var redValueLabel: UILabel!
	@IBOutlet weak var greenValueLabel: UILabel!
	@IBOutlet weak var blueValueLabel: UILabel!

	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!

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

	private func changeColorMapView() {
		colorMapView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
											   green: CGFloat(greenSlider.value),
											   blue:CGFloat(blueSlider.value),
											   alpha: 1)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		colorMapView.layer.cornerRadius  = colorMapView.frame.width / 40
		changeColorMapView()

		redValueLabel.text = String(format: "%.2f", redSlider.value)
		greenValueLabel.text = String(format: "%.2f", greenSlider.value)
		blueValueLabel.text = String(format: "%.2f", blueSlider.value)
	}
}

