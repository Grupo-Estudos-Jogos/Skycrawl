extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file('res://scenes/cena_teste_2.tscn') # Replace with function body.
