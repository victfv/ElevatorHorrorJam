shader_type spatial;
render_mode unshaded;

uniform sampler2D shadows : hint_default_black;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = vec3(0);
	vec4 tex = texture(shadows, SCREEN_UV);
	//ALBEDO = tex.rgb;
	ALPHA = clamp(1.0 - tex.r,0,1);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
