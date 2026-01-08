shader_type canvas_item;

// Exports
uniform vec2 fx_pos = vec2(0.0,0.0);
uniform vec2 aspect = vec2(100.0, 100.0);
uniform vec3 color = vec3(0.0,0.0,0.0);

// Random Seeds
const vec2 seed_vec = vec2(15.15, 25.15);
const float dot_seed = 25.15;
const float sin_seed = 5000.0;

// Other Constants
const float fx_size = 10.0;
const float alpha = 0.55;
const float fx_alpha = 0.00;


//// FUNCTIONS ////

// Multiply vector values
vec2 mult_vec(vec2 a, vec2 b) {
	return vec2(a.x * b.x, a.y * b.y);
}

// Returns 1.0 if a > b
float when_gt(float a, float b) {
  return max(sign(a - b), 0.0);
}

// Returns float bool in range
float check_fx(vec2 fx, vec2 pixel) {
	return when_gt(fx_size, distance(fx, mult_vec(pixel, aspect) ) ) * (fx_pos.x+fx_pos.y);
}

// Equation to generate random value
float noise(vec2 input, float fx_flag) {
	float val = fract(sin(dot(input, seed_vec)*dot_seed + fx_flag )*sin_seed );
	return val;
}

void fragment () {
	float fx_flag = check_fx(fx_pos, UV);
	float random = noise(UV, fx_flag);
	COLOR = vec4(color, (random * alpha*(fx_alpha*fx_flag+1.0) ) );
}