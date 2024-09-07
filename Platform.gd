@tool
extends AnimatableBody2D

const platform_scenes = {
	"blue":preload("res://Assets/Platforms/blueplatform.png"),
	"green":preload("res://Assets/Platforms/greenplatform.png"),
	"red":preload("res://Assets/Platforms/redplatform.png"),
	"yellow":preload("res://Assets/Platforms/yellowplatform.png")
}

@export var sprite_platform: Sprite2D;

@export_enum('Red', 'Blue', 'Yellow', 'Green') var platform_type: String:
	get:
		return _platform_type.to_pascal_case();
	set(value):
		if sprite_platform and value:
			_platform_type = value.to_lower();
			sprite_platform.texture = platform_scenes[_platform_type];
			# duplicate material to lose ref
			sprite_platform.material = sprite_platform.material.duplicate();
			# set shader parameters glow color by platform type
			sprite_platform.material.set_shader_parameter("glow_color", Color(_platform_type));
			

var _platform_type: String;

@onready var platform_width = $CollisionShape2D.shape.get_rect().size.x;
