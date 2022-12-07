#version 330

uniform mat4 myProjectionMatrix;
uniform mat4 myViewMatrix;
uniform mat4 myModelMatrix;

in vec3 myNormal;
in vec3 myPosition;

out vec3 normal;
out vec3 position;

void main()
{
	//2.1 is scale
	vec3 tmpPos = myPosition * 7;

	//Pass camera space position and normal
	//position = vec3(myViewMatrix * vec4(tmpPos, 1.0));
	position = tmpPos;

	normal = vec3(myProjectionMatrix * myViewMatrix * vec4(myNormal, 0.0));

	gl_Position = myProjectionMatrix * myViewMatrix * vec4(tmpPos, 1.0);
}

