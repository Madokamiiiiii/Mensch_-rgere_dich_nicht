extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	show()


func _on_Button_pressed():
	Global.change_scene("res://Options2.tscn")
