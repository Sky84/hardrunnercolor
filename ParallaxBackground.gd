extends ParallaxBackground

@onready var game_rules: GameRules = $"../GameRules";
@onready var fog: Sprite2D = %Fog

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset += game_rules.speed * delta;
	# set shader parameters noise_scroll_direction
	var _fog_speed = (game_rules.start_speed * 0.5) * delta
	fog.material.set_shader_parameter("noise_scroll_direction", -_fog_speed);
