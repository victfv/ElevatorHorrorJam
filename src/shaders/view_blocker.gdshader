shader_type spatial;
render_mode ambient_light_disabled;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = vec3(0);
	//ALPHA = 0.5;
}

void light() {
	//DIFFUSE_LIGHT = vec3(ATTENUATION);
	SPECULAR_LIGHT = vec3(ATTENUATION);
	//ALPHA = 0.0;//ATTENUATION;
}
