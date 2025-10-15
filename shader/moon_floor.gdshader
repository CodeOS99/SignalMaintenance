shader_type spatial;

// Color parameters
uniform vec3 base_color : source_color = vec3(0.6, 0.6, 0.65);
uniform vec3 dark_color : source_color = vec3(0.3, 0.3, 0.35);
uniform float roughness : hint_range(0.0, 1.0) = 0.9;
uniform float metallic : hint_range(0.0, 1.0) = 0.1;

// Crater and detail parameters
uniform float crater_scale = 5.0;
uniform float crater_depth = 0.3;
uniform float detail_scale = 20.0;
uniform float detail_strength = 0.15;

// Noise functions
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;

    for(int i = 0; i < 5; i++) {
        value += amplitude * noise(p * frequency);
        frequency *= 2.0;
        amplitude *= 0.5;
    }

    return value;
}

// Crater pattern
float crater_pattern(vec2 uv) {
    vec2 grid = fract(uv * crater_scale) - 0.5;
    float dist = length(grid);

    // Random crater size and depth
    float random = hash(floor(uv * crater_scale));
    float crater_size = 0.3 + random * 0.2;

    float crater = smoothstep(crater_size, crater_size - 0.1, dist);
    crater *= (1.0 - smoothstep(0.0, crater_size, dist));

    return crater;
}

void fragment() {
    vec2 uv = UV;

    // Base terrain noise
    float terrain = fbm(uv * detail_scale);

    // Crater generation
    float craters = crater_pattern(uv);
    craters += crater_pattern(uv * 1.7 + vec2(0.5));
    craters += crater_pattern(uv * 2.3 + vec2(1.3, 0.7)) * 0.5;

    // Combine terrain features
    float height = terrain * detail_strength - craters * crater_depth;

    // Color variation based on height
    vec3 color = mix(dark_color, base_color, terrain);
    color = mix(color, dark_color * 0.8, craters * 0.7);

    // Add subtle color variation
    float color_noise = fbm(uv * 8.0) * 0.1;
    color += vec3(color_noise);

    // Calculate normal from height map for lighting
    float offset = 0.01;
    float h_right = fbm((uv + vec2(offset, 0.0)) * detail_scale) -
                    crater_pattern(uv + vec2(offset, 0.0));
    float h_up = fbm((uv + vec2(0.0, offset)) * detail_scale) -
                 crater_pattern(uv + vec2(0.0, offset));

    vec3 normal_offset = vec3((height - h_right), (height - h_up), offset);
    vec3 normal_map = normalize(normal_offset);

    ALBEDO = color;
    ROUGHNESS = roughness;
    METALLIC = metallic;
    NORMAL_MAP = normal_map;
}