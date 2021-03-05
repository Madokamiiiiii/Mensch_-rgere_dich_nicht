extends Node2D

var besetzt = false
var figurnode

func _on_Area2D_body_entered(body):
	besetzt = true
	figurnode = body
	print(body)
	print("jetzt besetzt")

func _on_Area2D_body_exited(body):
	print("nicht mehr besetzt")
	besetzt = false
