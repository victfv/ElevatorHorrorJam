shader_type spatial;
render_mode unshaded, blend_add;

uniform sampler2D tex : repeat_disable, filter_nearest;
uniform sampler2D ramp;
uniform float emission_strength = 1.0;
uniform float num_waves = 1.0;
uniform float wave_speed = 1.0;
uniform float distortion = 1.0;
uniform float texture_scale = 1.0;


void vertex() {
	UV *= texture_scale;
	//vert = VERTEX.xz;
}

void fragment() {
	vec2 stime = (UV * num_waves + TIME * wave_speed) * TAU;
	vec2 uv = UV + vec2(sin(stime.x), sin(stime.y)) * distortion;
	vec4 tx = texture(tex, uv);
	vec3 col = texture(ramp, vec2(tx.r, 0.5)).rgb;
	ALBEDO = col * emission_strength;
	ALPHA = tx.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
