shader_type spatial;
render_mode unshaded, world_vertex_coords;

uniform sampler2D shadows : hint_default_black;
uniform sampler2D shadow_view : hint_default_black;
uniform sampler2D noise;
uniform float uv_scale = 1.0;
uniform vec2 noise_scroll_1;
uniform vec2 noise_scroll_2;

vec3 magic(vec4 color, float brightness, float contrast, float saturation)
{
	/*mat4 brightness_matrix = mat4( vec4(1, 0, 0, 0),
                                   vec4(0, 1, 0, 0),
                                   vec4(0, 0, 1, 0),
                                   vec4(brightness, brightness, brightness, 1 ));
	float t = ( 1.0 - contrast ) / 2.0;
	mat4 contrastMatrix = mat4(vec4(contrast, 0, 0, 0),
							   vec4(0, contrast, 0, 0),
							   vec4(0, 0, contrast, 0),
							   vec4(t, t, t, 1));*/
	
	vec3 luminance = vec3( 0.3086, 0.6094, 0.0820 );
    
    float oneMinusSat = 1.0 - saturation;
    
    vec3 red = vec3( luminance.x * oneMinusSat );
    red+= vec3( saturation, 0, 0 );
    
    vec3 green = vec3( luminance.y * oneMinusSat );
    green += vec3( 0, saturation, 0 );
    
    vec3 blue = vec3( luminance.z * oneMinusSat );
    blue += vec3( 0, 0, saturation );
    
    mat4 saturation_matrix = mat4( vec4(red,     0),
                 vec4(green,   0.0),
                 vec4(blue,    0),
                 vec4(0, 0, 0, 1));
	
	
	return (saturation_matrix * color).rgb;
}

varying vec2 uv1;
varying vec2 uv2;
void vertex() {
	uv1 = VERTEX.xz * uv_scale + TIME * noise_scroll_1;
	uv2 = -VERTEX.xz * uv_scale + TIME * noise_scroll_2;
}

void fragment() {
	ALBEDO = vec3(0);
	vec4 tex = texture(shadows, SCREEN_UV);
	vec4 view = texture(shadow_view, SCREEN_UV);
	//vec3( 0.3086, 0.6094, 0.0820 )
	float ns = mix(texture(noise, uv1).r, texture(noise, uv2).r, 0.5);
	ALBEDO = magic(view, 0.0,0.0,0.0) * 1.3 * ns;
	ALPHA = clamp(1.0 - tex.r,0,1);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
