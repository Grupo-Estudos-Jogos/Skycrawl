@tool
class_name Hurtbox
extends Area2D

signal hit(damage: int)

@export var active: bool = true:
	set(toggle):
		set_deferred("monitoring", toggle)
		set_deferred("monitorable", toggle)

@export var invincibility_time: float = 0.25

@onready var inv_timer := $InvincibilityTimer as Timer


func _ready() -> void:
	print("Ativa? ", monitoring, monitorable)
	area_entered.connect(_on_Hitbox_entered)

	inv_timer.wait_time = invincibility_time
	inv_timer.connect("timeout", _on_invincibility_ended)


func _on_Hitbox_entered(hitbox: Hitbox) -> void:
	hit.emit(hitbox.damage)

	active = false
	inv_timer.start()


func _on_invincibility_ended() -> void:
	active = true
