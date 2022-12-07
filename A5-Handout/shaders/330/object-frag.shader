#version 330
#define PI 3.1415926535897932384626433832795
#define RADIUS 0.5

uniform mat4 myModelMatrix;
uniform mat4 myViewMatrix;
uniform mat4 myProjectionMatrix;

uniform vec3 myLightPos;
uniform vec3 myEyePos;

uniform sampler2D objTexture;

in vec3 position;
in vec3 normal;

out vec4 outputColor; //this tells OpenGL that this variable is the output color

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
	//texture mapping from slides
	//want to texture the sphere based on the environment for "refleciton"
	vec3 envPosition = vec3(myModelMatrix * vec4(position, 1.0));
	vec2 coord = textureLocation(envPosition);

	//get texture based on u and v
	//obj texture is really envTexture 
	vec4 tex = texture(objTexture, coord);

	//TODO: get the other texture based on object position (recompute u and v)
	//      rather than envPosition, then blend the two based on slider

	// If diffuse box is checked:
	//float diffuse = dot(normal, -myEyePos);
	//outputColor = vec4(diffuse * tex.x, diffuse * tex.y, diffuse * tex.z, 1.0);

	//without diffuse
	outputColor = vec4(tex.x,  tex.y,  tex.z, 1.0);
}