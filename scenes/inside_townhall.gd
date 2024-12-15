extends Node2D

var entered = false

var outside_home = "res://scenes/Main.tscn"

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if entered:
		get_tree().change_scene_to_file(outside_home)


func _on_area_2d_body_exited(body: Node2D) -> void:
	entered = true
