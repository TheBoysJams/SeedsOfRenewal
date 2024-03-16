shader_type canvas_item;

void fragment() {
    vec2 size = vec2(textureSize(TEXTURE, 0));
    vec2 uv = UV;

    // Adjust this value to control the smoothing effect
    float pixelSize = 20.0 / min(size.x, size.y);

    vec4 color = vec4(0.0);
    vec2 offsets = vec2(pixelSize, pixelSize);

    // Sample surrounding pixels
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            vec2 offset = vec2(float(x), float(y)) * offsets;
            color += texture(TEXTURE, uv + offset);
        }
    }

    // Average the color
    color /= 9.0;

    COLOR = color;
}
