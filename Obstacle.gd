extends AnimatableBody2D

@onready var obstacle_width = $CollisionShape2D.shape.get_rect().size.x;
@onready var animated_sprites: Node2D = $AnimatedSprites


func _ready() -> void:
	for sprite in animated_sprites.get_children():
		sprite.play("default");
