extends Node

var current_scene = null
var anzahlSpieler = 4
var anzahlCPU = 3
var anzahlReal = 1
var green = true
var red = true
var gelb = true
var blau = true
var cpugreen = false
var cpured = false
var cpugelb = false
var cpublau = false
var mehrwurf = false

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(path):
	call_deferred("_deferred_change_scene", path)

func _deferred_change_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
