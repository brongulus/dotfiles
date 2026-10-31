//!HOOK MAIN
//!BIND HOOKED
//!DESC bSide

#define Offsets vec3(0.0, 1.3846153846, 3.2307692308)
#define K       vec3(0.2270270270, 0.3162162162, 0.0702702703)

vec4 blur(vec4 color) {
  // color += HOOKED_tex(HOOKED_pos) * K[0];
  // Horizontal Pass
  uint i=1; //unroll loop
        color+= HOOKED_tex(HOOKED_pos +HOOKED_pt*vec2(Offsets[i], 0)) *K[i];
        color+= HOOKED_tex(HOOKED_pos -HOOKED_pt*vec2(Offsets[i], 0)) *K[i];
	i=2;
        color+= HOOKED_tex(HOOKED_pos +HOOKED_pt*vec2(Offsets[i], 0)) *K[i];
        color+= HOOKED_tex(HOOKED_pos -HOOKED_pt*vec2(Offsets[i], 0)) *K[i];
  // Vertical Pass
	i=1; //unroll loop
        color+= HOOKED_tex(HOOKED_pos +HOOKED_pt*vec2(0, Offsets[i])) *K[i];
        color+= HOOKED_tex(HOOKED_pos -HOOKED_pt*vec2(0, Offsets[i])) *K[i];
	i=2;
        color+= HOOKED_tex(HOOKED_pos +HOOKED_pt*vec2(Offsets[i], 0)) *K[i];
        color+= HOOKED_tex(HOOKED_pos -HOOKED_pt*vec2(Offsets[i], 0)) *K[i];

  return color;
}

#define pos HOOKED_pos

vec4 hook() {
  vec4 color = HOOKED_tex(pos);
	vec4 rem = vec4(0, 0, 0, 1);
	if (pos.y > 0.83 && pos.x > 0.25 && pos.y < 0.93 && pos.x < 0.75) {
    return rem;
  }
	else return color;
}
