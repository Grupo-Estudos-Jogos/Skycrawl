extends Node2D

@onready var fire_point = $FirePoint   # pegue o ponto do tiro
@onready var canhao: AnimationPlayer = $AnimationPlayer

@export var bala_scene: PackedScene
@export var delay: float = 2.0
var ativo = true

func _ready():
	shoot_loop()

func shoot_loop() -> void:
	while true:
		if ativo:
			atirar()
			print("🔥 TIRO DISPARADO!")
		await get_tree().create_timer(2).timeout

func atirar():
	var bala = bala_scene.instantiate()
	bala.global_position = fire_point.global_position     # nasce no Marco
	bala.global_rotation = fire_point.global_rotation     # segue direção do canhão
	get_parent().add_child(bala)
	canhao.play('atirou')



func _on_alavanca_alavancasinal(estado) -> void:
	ativo = estado # Replace with function body.
	canhao.stop()
