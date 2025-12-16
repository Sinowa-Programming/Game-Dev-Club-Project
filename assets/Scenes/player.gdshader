shader_type spatial;

uniform sampler2D height_texture : hint_default_black;
uniform float height_scale = 1.0;
uniform float alpha_cutoff = 0.5;

void vertex() {
    vec4 tex = texture(height_texture, UV);

    float height = tex.r * tex.a;
    VERTEX.y += height * height_scale;
}

void fragment() {
    vec4 tex = texture(height_texture, UV);

    if (tex.a < alpha_cutoff) {
        discard;
    }

    ALBEDO = tex.rgb;
}
