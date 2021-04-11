//
//  ViewController.swift
//  HomeWork2.2
//
//  Created by Антон Вербицкий on 27.03.2021.
//

import UIKit

class ColorSettingsViewController: UIViewController {

	// MARK: - @IBOutlets
	@IBOutlet var redLabel: UILabel!
	@IBOutlet var greenLabel: UILabel!
	@IBOutlet var blueLabel: UILabel!

	@IBOutlet weak var colorMapView: UIView!

	@IBOutlet var redTextField: UITextField!
	@IBOutlet var greenTextField: UITextField!
	@IBOutlet var blueTextField: UITextField!

	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!

	// MARK: -  Public Properties
	var backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

	var delegate: ColorSettingsViewControllerDelegate!

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		// обращаемся к текстовым полям, чтобы работать с методами протокола UITextFieldDelegate
		redTextField.delegate = self
		greenTextField.delegate = self
		blueTextField.delegate = self

		// устанавливаем положение слайдеров через delegate
		redSlider.value = delegate.redValue
		greenSlider.value = delegate.greenValue
		blueSlider.value = delegate.blueValue

		// закругляем углы
		redLabel.layer.masksToBounds  = true
		greenLabel.layer.masksToBounds  = true
		blueLabel.layer.masksToBounds  = true

		// устанавливаем цвет, переданный по сегвею
		colorMapView.backgroundColor = backgroundColor

		// меняем числовые значения при изменении слайдеров
		redTextField.text = String(format: "%.2f", redSlider.value)
		greenTextField.text = String(format: "%.2f", greenSlider.value)
		blueTextField.text = String(format: "%.2f", blueSlider.value)

		// обноввляем цвет, реализуем кнопку Done на клавиатуре
		refreshColors()
		addDoneButtonOnKeyboard()
	}
	// MARK: - Override Methods
	// реализуем автоматическое закрытие клавиатуры
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}

	// MARK: - @IBActions
	@IBAction func redSliderAction() {
		redTextField.text = String(format: "%.2f", redSlider.value)
		refreshColors()
	}
	@IBAction func greenSliderAction() {
		greenTextField.text = String(format: "%.2f", greenSlider.value)
		refreshColors()
	}
	@IBAction func blueSliderAction() {
		blueTextField.text = String(format: "%.2f", blueSlider.value)
		refreshColors()
	}

	// скрытие клавиатуры по нажатию на кнопку Done
	@IBAction func doneButtonAction()
	{
		view.endEditing(true)
	}

	// MARK: - Private Methods
	// Обновляем цвета ColorMapView и значения лейблов
	private func refreshColors() {
		colorMapView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
											   green: CGFloat(greenSlider.value),
											   blue:CGFloat(blueSlider.value),
											   alpha: 1)

		redLabel.text = String(Int(redSlider.value * 255))
		greenLabel.text = String(Int(greenSlider.value * 255))
		blueLabel.text = String(Int(blueSlider.value * 255))

		// через делегата передаем цвет на MainViewController
		delegate.setBackgroundColor(red: redSlider.value,
									green: greenSlider.value,
									blue: blueSlider.value)
	}

	// Добавляем кнопку Done
	private func addDoneButtonOnKeyboard()
	{
		let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
		doneToolbar.barStyle = UIBarStyle.default

		let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
										target: nil,
										action: nil)
		let done: UIBarButtonItem = UIBarButtonItem(title: "Done",
													style: UIBarButtonItem.Style.done,
													target: self,
													action: #selector(doneButtonAction))

		var items = [UIBarButtonItem]()
		items.append(flexSpace)
		items.append(done)

		doneToolbar.items = items
		doneToolbar.sizeToFit()

		// добавляем на клавиатуру кнопку Done для каждого текстового поля
		redTextField.inputAccessoryView = doneToolbar
		greenTextField.inputAccessoryView = doneToolbar
		blueTextField.inputAccessoryView = doneToolbar
	}

}


// MARK: - Extension
extension ColorSettingsViewController: UITextFieldDelegate {
	// Изменяем по редактированию текстового поля пложения слайдеров, обновляем цвета
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let newValue = textField.text else { return }
		guard let numberValue = Float(newValue) else { return }

		switch textField {
		case redTextField:
			redSlider.value = numberValue
			redTextField.text = String(format: "%.2f", redSlider.value)
		case greenTextField:
			greenSlider.value = numberValue
			greenTextField.text = String(format: "%.2f", greenSlider.value)
		case blueTextField:
			blueSlider.value = numberValue
			blueTextField.text = String(format: "%.2f", blueSlider.value)
		default:
			break
		}
		refreshColors()
	}

}

