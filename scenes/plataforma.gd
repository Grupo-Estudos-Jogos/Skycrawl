extends Node2D

@export var força: float = -200
var player = null

func _ready() -> void:
	pass




func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		print('entrou')
		body.max_speed = 100
		print(body.max_speed)


func _on_body_exited(body: Node2D) -> void:
	print('saiu')
	if body.name == 'Player':
		body.max_speed = body.speed_padrao
