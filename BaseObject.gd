extends AnimatableBody2D
class_name BaseObject

@onready var object_width = $CollisionShape2D.shape.get_rect().size.x;
var animated_sprites: Node2D;

func _ready() -> void:
	animated_sprites = get_node_or_null("AnimatedSprites");
	if not animated_sprites:
		return;
	for sprite in animated_sprites.get_children():
		sprite.play("default");
