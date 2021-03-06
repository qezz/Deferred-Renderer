#version 440
//#extension GL_ARB_explicit_attrib_location : enable

layout(location = 0) in vec4 a_pos;

out int vertexID;

uniform mat4 u_modelViewMat;


void main() {
    vertexID=gl_VertexID;
  gl_Position=u_modelViewMat*a_pos;
}