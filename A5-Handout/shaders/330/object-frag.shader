#version 330

uniform mat4 myModelMatrix;
uniform mat4 myViewMatrix;
uniform mat4 myProjectionMatrix;

uniform vec3 myLightPos;
uniform vec3 myEyePos;

out vec4 outputColor; //this tells OpenGL that this variable is the output color

void main()
{
    outputColor = vec4(1.0, 1.0, 1.0, 1.0);
}