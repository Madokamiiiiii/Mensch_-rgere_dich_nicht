extends Node2D

signal spielerAusgewaehlt(figur, farbe, feld, base)

var green = preload("res://.import/gruen.png-ecf60b3e489b4c5dc0d35ae062bafa4b.stex")
var rot = preload("res://.import/red.png-c4ab227a75bbc144a9af0bc0188ea4ba.stex")
var gelb = preload("res://.import/gelb.png-1faebba80be0286107fb78050894ef3e.stex")
var blau = preload("res://.import/blue.png-958c7f45f3af13badcd9713d84b15efb.stex")
var ichBin = 0
var feld = 0
var base = true
var feldGelaufen = 0

func init(spieler, nummer):
	ichBin = spieler
	match spieler:
		0:
			# grün
			$Sprite.set_texture(green)
			feld = 1
		1:
			# rot
			$Sprite.set_texture(rot)
			feld = 11
		2:
			# gelb
			$Sprite.set_texture(gelb)
			feld = 31
		3:
			# blau
			$Sprite.set_texture(blau)
			feld = 21
	

func _on_Button_pressed():
	emit_signal("spielerAusgewaehlt", self, ichBin, feld, base)
