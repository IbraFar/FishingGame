extends CharacterBody2D

@onready var aquaContainer = $"../PanelContainer/MarginContainer/VBoxContainer/AquaContainer"
@onready var fish_sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED := 50.0  # Reduced speed for more visible movement
var targetPosition: Vector2
var borderDistance := 20  # Adjusted for more movement range

func _ready() -> void:
	if aquaContainer:
		set_target_position()

func set_target_position() -> void:
	await get_tree().physics_frame
	set_new_target_position()

func set_new_target_position() -> void:
	if !aquaContainer:
		return

	var container_rect = aquaContainer.get_global_rect()
	
	# Increase movement range
	var xPosition = randf_range(
		container_rect.position.x + borderDistance,
		container_rect.position.x + container_rect.size.x - borderDistance
	)
	var yPosition = randf_range(
		container_rect.position.y + borderDistance,
		container_rect.position.y + container_rect.size.y - borderDistance
	)

	targetPosition = Vector2(xPosition, yPosition)

func _physics_process(delta: float) -> void:
	if !targetPosition:
		return

	var direction = (targetPosition - global_position).normalized()
	
	if direction.length() > 0:
		velocity = direction * SPEED
		move_and_slide()
	
	# Increased distance threshold for reaching target
	if global_position.distance_to(targetPosition) < 15:
		on_target()
		
	set_animation()

func on_target() -> void:
	set_physics_process(false)
	await get_tree().create_timer(0.5).timeout  # Increased pause time
	set_new_target_position()
	set_physics_process(true)

func set_animation() -> void:
	if velocity.length() > 0:
		fish_sprite.play("move")
		fish_sprite.flip_h = velocity.x < 0
	else:
		fish_sprite.stop()
