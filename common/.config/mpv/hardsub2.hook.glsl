out vec4 FinalColor;
in vec2 FragUV;
uniform sampler2D Texture;

void main()
{
        float Pixels = 4.0;
        float dx = 15.0 * (1.0 / Pixels);
        float dy = 10.0 * (1.0 / Pixels);
        vec2 Coord = vec2(dx * floor(FragUV.x / dx),
                          dy * floor(FragUV.y / dy));
        FinalColor = texture(Texture, Coord);
}
