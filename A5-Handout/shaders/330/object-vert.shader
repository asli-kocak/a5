#version 330

uniform mat4 myModelMatrix;
uniform mat4 myViewMatrix;
uniform mat4 myProjectionMatrix;

uniform vec3 myLightPos;
uniform vec3 myEyePos;

in vec3 myNormal;
in vec3 myPosition;

out vec3 normal;
out vec3 position;

void main() {
    mat4 my myModelviewMatrix = myViewMatrix * myModelMatrix;
    normal = myNormal;
    position = (myModelMatrix * vec4(myPosition, 1.0)).xyz;
    gl_Position = (myProjectionMatrix * myModelviewMatrix * vec4(myPosition, 1.0));
}
