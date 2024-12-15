extends Node2D

@export var inside_home: PackedScene

func _on_doorway_body_entered(body: Node2D) -> void:
	body.set_house(self)


func _on_doorway_body_exited(body: Node2D) -> void:
	if body.house == self:
		body.set_house(null)
		
func enter():
	get_tree().change_scene_to_file(inside_home.resource_path)
