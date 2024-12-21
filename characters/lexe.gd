extends CharacterBody2D

@onready var chat_button = $chat_detection_area/Button
@onready var animation_player = $chat_detection_area/ButtonPress
var is_chatting = false

var player
var player_in_chat_zone = false

func _ready() -> void:
	chat_button.hide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") && player_in_chat_zone:
		is_chatting = true



func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	print("body entered!")
	print(body)
	if body.is_in_group("player"):
		player_in_chat_zone = true
		chat_button.show()
		animation_player.play("ButtonPress")

func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_chat_zone = false
		chat_button.hide()
		animation_player.stop() 
