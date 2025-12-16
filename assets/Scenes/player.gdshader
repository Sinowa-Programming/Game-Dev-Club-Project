shader_type spatial;

// Make sure transparency works
render_mode blend_mix, cull_disabled, unshaded;

uniform sampler2D albedo_texture : source_color; // <-- Works in Godot 4.5.1
uniform float alpha_cutoff = 0.5;
uniform float height_scale = 1.0;

void vertex() {
    vec4 tex = texture(albedo_texture, UV);
    VERTEX.y += tex.r * tex.a * height_scale;
}

void fragment() {
    vec4 tex = texture(albedo_texture, UV);

    if (tex.a < alpha_cutoff) {
        discard;
    }

    ALBEDO = tex.rgb;
}
