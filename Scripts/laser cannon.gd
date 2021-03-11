extends StaticBody2D

var laser = preload("res://Scenes/objects/laser.tscn")

func _on_Timer_timeout():
	add_child(laser.instance())
