// https://github.com/snes19xx/surface-dots/blob/main/.config/hypr/shaders/reading_mode.glsl

#version 330

in vec2 texcoord;
uniform sampler2D tex;

vec4 window_shader() {
    vec2 uv = texcoord / vec2(textureSize(tex, 0));
    vec4 pixColor = texture(tex, uv);

    float gray = dot(pixColor.rgb, vec3(0.299, 0.587, 0.114));

    // Softer tonal mapping preserves more shadow and highlight detail.
    gray = smoothstep(0.025, 0.95, gray);

    // Warm paper and slightly warm charcoal ink.
    vec3 paperColor = vec3(0.918, 0.890, 0.808); // #eae3ce
    vec3 inkColor   = vec3(0.075, 0.071, 0.063); // #131211

    vec3 result = mix(inkColor, paperColor, gray);

    return vec4(result, pixColor.a);
}
