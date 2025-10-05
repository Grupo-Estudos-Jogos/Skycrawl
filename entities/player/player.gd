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

@onready var animation_tree = $AnimationTree as AnimationTree
@onready var animation_playback = animation_tree["parameters/playback"] as AnimationNodeStateMachinePlayback

const ANIMATION_STATES: PackedStringArray = [
	"Idle",
	"Run",
	"Walk",
]


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var horizontal_dir: float = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	if horizontal_dir != 0:
		_set_blend_position(horizontal_dir)

		if Input.is_action_pressed("run"):
			velocity.x = move_toward(velocity.x, max_speed * horizontal_dir, run_acceleration * delta)
			animation_playback.travel("Run")
		else:
			velocity.x = move_toward(velocity.x, max_speed * horizontal_dir, walk_acceleration * delta)
			animation_playback.travel("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		animation_playback.travel("Idle")

	velocity.y += gravity
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = -jump_force

	move_and_slide()


func _set_blend_position(blend_pos: float) -> void:
	for state in ANIMATION_STATES:
		var blend_path: String = "parameters/%s/blend_position" % state
		animation_tree.set(blend_path, blend_pos)
