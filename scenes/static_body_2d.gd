extends Area2D


# Called when the node enters the scene tree for the first time.
@onready var bau: AnimationPlayer = $AnimationPlayer



func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		bau.play('bau') # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		bau.play("bau_2") # Replace with function body.
