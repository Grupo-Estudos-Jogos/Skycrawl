class_name Player
extends CharacterBody2D

# TODO: Ajustar melhor os valores, movimentação parece meio travadona
@export_group("Motion")
@export var gravity: float = 50.0
@export var jump_force: float = 700.0
@export var max_speed: float = 300
@export var acceleration: float = 900
@export var friction: float = 800


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var horizontal_dir: float = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	if horizontal_dir != 0:
		velocity.x = move_toward(velocity.x, max_speed * horizontal_dir, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	if not is_on_floor():
		velocity.y += gravity

	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = -jump_force

	move_and_slide()
