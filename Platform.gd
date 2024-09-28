@tool
extends AnimatableBody2D

const platform_scenes = {
	"blue":preload("res://Assets/Platforms/blueplatform.png"),
	"green":preload("res://Assets/Platforms/greenplatform.png"),
	"red":preload("res://Assets/Platforms/redplatform.png"),
	"yellow":preload("res://Assets/Platforms/yellowplatform.png")
}

@export var tile_map_platform: TileMapLayer;

@export_enum('Red', 'Blue', 'Yellow', 'Green') var platform_type: String:
	get:
		return _platform_type.to_pascal_case();
	set(value):
		if tile_map_platform and value:
			_platform_type = value.to_lower();
			# duplicate material to lose ref
			tile_map_platform.material = tile_map_platform.material.duplicate();
			# set shader parameters glow color by platform type
			tile_map_platform.material.set_shader_parameter("current_color", Color(_platform_type));
			

var _platform_type: String;

@onready var platform_width = $CollisionShape2D.shape.get_rect().size.x;
