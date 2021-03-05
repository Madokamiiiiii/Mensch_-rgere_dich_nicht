extends Control

onready var optiongreen = get_node("MarginContainer/VBoxContainer/GridContainer/OptionButton") # 0
onready var optionred = get_node("MarginContainer/VBoxContainer/GridContainer/OptionButton2") # 1
onready var optiongelb = get_node("MarginContainer/VBoxContainer/GridContainer/OptionButton3") # 2
onready var optionblau = get_node("MarginContainer/VBoxContainer/GridContainer/OptionButton4") # 3
var anzahlSpieler = 0
var anzahlReal = 0
var anzahlCPU = 0

func _ready():
	optiongreen.select(0)
	optionred.select(0)
	optiongelb.select(1)
	optionblau.select(1)
	show()

func _on_Button_pressed():
	for option in [optiongreen, optionred, optiongelb, optionblau]:
		if option.selected == 0:
			anzahlSpieler += 1
			anzahlReal += 1
		elif option.selected == 1:
			anzahlSpieler += 1
			anzahlCPU += 1
	Global.anzahlSpieler = anzahlSpieler
	Global.anzahlReal = anzahlReal
	Global.anzahlCPU = anzahlCPU 
	if optiongreen.selected == 1:
		Global.cpugreen = true
	if optionred.selected == 1:
		Global.cpured = true
	if optiongelb.selected == 1:
		Global.cpugelb = true
	if optionblau.selected == 1:
		Global.cpublau = true
	if optiongreen.selected == 1:
		Global.green = false
	if optionred.selected == 2:
		Global.red = false
	if optiongelb.selected == 2:
		Global.gelb = false
	if optionblau.selected == 2:
		Global.blau = false
	Global.change_scene("res://Main.tscn")
