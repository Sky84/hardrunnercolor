shader_type canvas_item;

uniform vec4 current_color : source_color = vec4(1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// override the pixel color by the uniform current_color
	COLOR.rgb = texture(TEXTURE, UV).rgb * current_color.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
