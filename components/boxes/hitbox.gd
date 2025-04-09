@tool
class_name Hitbox
extends Area2D

@export var active: bool = true:
	set(toggle):
		set_deferred("monitoring", toggle)
		set_deferred("monitorable", toggle)

@export var damage: int
@export var debug_color: Color = Color("00a4818c")

@onready var collisions: Array[CollisionShape2D] = []


func _ready() -> void:
	if Engine.is_editor_hint():
		child_entered_tree.connect(_detect_collision)
		child_exiting_tree.connect(_forget_collision)
		_set_color()


func _set_color() -> void:
	for collision in collisions:
		collision.debug_color = debug_color


func _detect_collision(node: Node) -> void:
	if not node is CollisionShape2D:
		return

	collisions.push_back(node)
	node.debug_color = debug_color


func _forget_collision(node: Node) -> void:
	if not node is CollisionShape2D:
		return

	collisions.erase(node)
