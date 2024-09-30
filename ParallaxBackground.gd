extends ParallaxBackground

@export var colors_cycle: GradientTexture1D;
@onready var game_rules: GameRules = $"../GameRules";
@onready var fog: Sprite2D = %Fog
@onready var background_0: Sprite2D = $ParallaxLayer/Background0

var _color_index: int = 0;

func _ready() -> void:
	# start timer to increase color index every 1 second
	var _timer = Timer.new();
	_timer.wait_time = 1.0;
	_timer.autostart = true
	add_child(_timer);
	_timer.timeout.connect(_on_color_index_increase);

func _on_color_index_increase():
	_color_index = (_color_index+1) % colors_cycle.width;
	background_0.modulate = colors_cycle.gradient.sample(_color_index);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset += game_rules.speed * delta;
	# set shader parameters noise_scroll_direction
	var _fog_speed = (game_rules.speed * 0.5) * delta
	fog.material.set_shader_parameter("noise_scroll_direction", -_fog_speed);
