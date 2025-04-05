@tool
class_name Hitbox
extends Area2D

@export var active: bool = true:
	set(toggle):
		set_deferred("monitoring", toggle)
		set_deferred("monitorable", toggle)

@export var damage: int
