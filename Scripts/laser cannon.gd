extends StaticBody2D

var laser = preload("res://Scenes/objects/laser.tscn")
var pew = laser.instance()

const START_POS = -44

func _ready():
	pew.position = Vector2(START_POS, 0)

func _on_Timer_timeout():
	add_child(pew)
	if get_node("screenNote").is_on_screen():
		$pewpew.play()
	pew = laser.instance()
	pew.position = Vector2(START_POS, 0)
