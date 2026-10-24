// https://github.com/snes19xx/surface-dots/blob/main/.config/hypr/shaders/reading_mode.glsl

#version 330

in vec2 texcoord;
uniform sampler2D tex;

vec4 window_shader() {
    vec2 uv = texcoord / textureSize(tex, 0);
    vec4 pixColor = texture(tex, uv);

    float gray = dot(pixColor.rgb, vec3(0.299, 0.587, 0.114));
    gray = clamp((gray - 0.12) / (0.88 - 0.12), 0.0, 1.0);
    // gray = pow(gray, 1.2);
    // gray = smoothstep(0.08, 0.92, gray);

    vec3 paperColor = vec3(0.94, 0.92, 0.86);
    vec3 inkColor = vec3(25.0 / 255.0);

    vec3 result = mix(inkColor, paperColor, gray);

    return vec4(result, pixColor.a);
}
