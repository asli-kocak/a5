#version 330
#define PI 3.1415926535897932384626433832795
#define RADIUS 3.5 //because scale factor is 7

out vec4 outputColor;

uniform sampler2D envTexture;

in vec3 normal;
in vec3 position;

const float EPSILON = 1e-5;
#define IN_RANGE(a,b)   (((a>(b-EPSILON))&&(a<(b+EPSILON)))?1:0)

vec2 textureLocation(vec3 position) {

	//texture mapping from slides
	float theta = atan(position.z, position.x);
	float u;
	if (theta < 0) {
		u = -theta / (2 * PI);
	}
	else {
		u = 1 - theta / (2 * PI);
	}
	float v = -asin(position.y / RADIUS) / PI + 0.5;

	if (IN_RANGE(v, 1.0) == 1 || IN_RANGE(v, 0) == 1) {
		u = 0.5;
	}

	vec2 coord = vec2(-u, v);
	return coord;
}

void main()
{
	vec2 coord = textureLocation(position);

	//get envioronment texture based on u and v
	vec4 tex = texture(envTexture, coord);

	outputColor = vec4(tex.x, tex.y, tex.z, 1.0);
}