extends Area2D

@onready var bala_canhao: AnimationPlayer = $AnimationPlayer

@export var speed: float = 600.0   # velocidade da bala
var direction: Vector2 = Vector2.LEFT  # define direção inicialmente

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta  # movimento em linha reta


func explodir():
	bala_canhao.play('explode')
	speed *= 0
	await bala_canhao.animation_finished
	queue_free() 
func _on_area_entered(area: Area2D) -> void:
	explodir()

func _on_body_entered(body: Node2D) -> void:
	explodir()  # desaparece ao colidir com corpos (player, inimigos, paredes etc)
