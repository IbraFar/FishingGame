extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		$player.global_position = Global.player_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass