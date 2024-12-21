extends Area2D

var player_in_range = false
@onready var fishing_button = $FishingButton
@onready var animation_player = $ButtonPress

func _ready():
	fishing_button.hide()  # Hide button initially

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		fishing_button.show()
		animation_player.play("fishing_button_press")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		fishing_button.hide()
		animation_player.stop()  # Stop the animation when player leaves

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("fish"):
		start_fishing()

func start_fishing():
	get_tree().paused = true
	PhysicsServer2D.set_active(true)
	var fishingGame = preload("res://scenes/FishingMinigame.tscn").instantiate()
	get_tree().current_scene.add_child(fishingGame)
