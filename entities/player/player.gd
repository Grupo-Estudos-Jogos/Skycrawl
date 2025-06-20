class_name Player
extends CharacterBody2D

# TODO: Ajustar melhor os valores, movimentação parece meio travadona
@export_group("Motion")
@export var gravity: float = 50.0
@export var jump_force: float = 700.0
@export var max_speed: float = 300
@export var walk_acceleration: float = 900
@export var run_acceleration: float = 1000
@export var friction: float = 800

@onready var animation = $AnimatedSprite2D as AnimatedSprite2D

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var horizontal_dir: float = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	if horizontal_dir != 0:
		animation.flip_h = true if horizontal_dir < 0 else false

		if Input.is_action_pressed("run"):
			velocity.x = move_toward(velocity.x, max_speed * horizontal_dir, run_acceleration * delta)
			animation.play("run")
		else:
			velocity.x = move_toward(velocity.x, max_speed * horizontal_dir, walk_acceleration * delta)
			animation.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		animation.play("idle")

	if not is_on_floor():
		velocity.y += gravity

	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = -jump_force

	move_and_slide()
