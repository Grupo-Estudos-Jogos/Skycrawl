extends Area2D


@export var speed: float = 0.5

var overgame = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not overgame:
		position += position * (-Vector2.UP) * 9.8 * speed * delta

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("floor") or body.name.to_lower() == "floor":
		overgame = true
		$Sprite2D.visible = false
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play("run")

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.stop()
	visible = false
	queue_free()
