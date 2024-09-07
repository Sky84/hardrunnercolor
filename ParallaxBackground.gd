extends ParallaxBackground

@onready var game_rules: GameRules = $"../GameRules";
@onready var fog: Sprite2D = $Fog

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset += game_rules.speed * delta;
