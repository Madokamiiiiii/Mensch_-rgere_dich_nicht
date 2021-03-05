extends Node2D

signal rolled(zahl)
export var randmin = 0.5
export var randmax = 2

var dice1 = preload("res://.import/diceGreen1.png-e085c5c769c11804b2f0748707131b01.stex")
var dice2 = preload("res://.import/diceGreen2.png-90f659b4149a66e76ce0e331f29a9966.stex")
var dice3 = preload("res://.import/diceGreen3.png-3e1b94800bd56058e41e036f3d43350e.stex")
var dice4 = preload("res://.import/diceGreen4.png-8ec23ba019c3b1aaada146a5d1944f4c.stex")
var dice5 = preload("res://.import/diceGreen5.png-19f52e5b7248bf61b0972981589a4d2a.stex")
var dice6 = preload("res://.import/diceGreen6.png-0c7931e47a3e8f2fd24988f46764cc2b.stex")
var diceArray = [dice1, dice2, dice3, dice4, dice5, dice6]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	show()

func roll():
	$Sprite/Button.disabled = true
	var randTime = rand_range(randmin, randmax)
	var time = 0
	var rand = 0
	while time < randTime:
		rand = rand_range(0,6)
		$Sprite.set_texture(diceArray[rand])
		time += 0.08
		yield(get_tree().create_timer(0.08), "timeout")
	emit_signal("rolled", rand)
