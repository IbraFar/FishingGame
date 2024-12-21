extends Area2D

signal target_entered()
signal target_exited()

const SPEED := 200

@onready var aquaContainer = $"../PanelContainer/MarginContainer/VBoxContainer/AquaContainer"
@onready var fishingGame = $".."  # Assuming the Target is a child of the FishingGame node

var on_fish := false
var borderDistanceX := 60  # Adjust this value to shift the bounds horizontally
var borderDistanceY := 50  # Adjust this value to shift the bounds vertically

func _physics_process(delta: float) -> void:
	check_on_fish()
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	# Calculate new position
	var new_position = position + direction * SPEED * delta
	
	# Calculate the relative position of the AquaContainer within the FishingGame node
	var aqua_relative_position = aquaContainer.get_global_transform().origin - fishingGame.get_global_transform().origin
	
	# Get the size of the AquaContainer
	var aqua_size = aquaContainer.get_rect().size
	
	# Calculate the minimum and maximum bounds within the AquaContainer
	var min_bounds = aqua_relative_position + Vector2(-borderDistanceX, -borderDistanceY)
	var max_bounds = aqua_relative_position + aqua_size - Vector2(borderDistanceX, borderDistanceY)
	
	# Print detailed clamping info
	print("New pos before clamp:", new_position)
	print("Min bounds:", min_bounds)
	print("Max bounds:", max_bounds)
	
	# Clamp position within the calculated bounds
	new_position.x = clamp(new_position.x, min_bounds.x, max_bounds.x)
	new_position.y = clamp(new_position.y, min_bounds.y, max_bounds.y)
	
	print("New pos after clamp:", new_position)
	
	# Update position
	position = new_position

func check_on_fish() -> void:
	var bodies := get_overlapping_bodies()
	if bodies.is_empty() and on_fish:
		on_fish = false
		target_exited.emit()
	elif not bodies.is_empty() and not on_fish:
		on_fish = true
		target_entered.emit()
