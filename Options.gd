extends Control

func _ready():
	pass

func _on_AnzahlSpieler_changed(ID):
	var idx = ID
	ID = $MarginContainer/CenterContainer/HBoxContainer/CenterContainer2/OptionButton.get_item_id(ID)
	Global.anzahlSpieler = ID
	if (ID == 2):
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(0, false)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(1, false)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(2, true)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(3, true)
	
	if (ID == 3):
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(0, false)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(1, false)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(2, false)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(3, true)
	
	if (ID == 4):
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(0, false)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(1, false)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(2, false)
		$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.set_item_disabled(3, false)
	$MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.select(idx)

func _on_AnzahlReal_selected(ID):
	Global.anzahlReal = $MarginContainer/CenterContainer/HBoxContainer/CenterContainer4/OptionButton2.get_item_id(ID)
	Global.anzahlCPU = Global.anzahlSpieler - Global.anzahlReal


func _on_Button_pressed():
	Global.change_scene("res://Main.tscn")
