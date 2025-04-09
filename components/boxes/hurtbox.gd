@tool
class_name Hurtbox
extends Area2D

signal hit(damage: int)

@export var active: bool = true:
	set(toggle):
		set_deferred("monitoring", toggle)
		set_deferred("monitorable", toggle)

@export var debug_color: Color = Color("90311b8c")
@export var invincibility_time: float = 0.25

@onready var collisions: Array[CollisionShape2D] = []
@onready var inv_timer := $InvincibilityTimer as Timer


func _ready() -> void:
	if Engine.is_editor_hint():
		child_entered_tree.connect(_detect_collision)
		child_exiting_tree.connect(_forget_collision)
		_set_colors()

	area_entered.connect(_on_Hitbox_entered)

	inv_timer.wait_time = invincibility_time
	inv_timer.connect("timeout", _on_invincibility_ended)


func _set_colors() -> void:
	for collision in collisions:
		collision.debug_color = debug_color


func _detect_collision(node: Node) -> void:
	if not node is CollisionShape2D:
		return

	collisions.append(node)
	node.debug_color = debug_color


func _forget_collision(node: Node) -> void:
	if not node is CollisionShape2D:
		return

	collisions.erase(node)


func _on_Hitbox_entered(hitbox: Hitbox) -> void:
	hit.emit(hitbox.damage)

	active = false
	inv_timer.start()


func _on_invincibility_ended() -> void:
	active = true
