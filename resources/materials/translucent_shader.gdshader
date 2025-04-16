shader_type canvas_item;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	COLOR = vec4(color.rgb, min(color.a, 0.5));
}
