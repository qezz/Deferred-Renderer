#version 130
#extension GL_ARB_explicit_attrib_location : enable

layout(location = 0) in vec3 a_pos;
layout(location = 1) in vec3 a_nor;
layout(location = 2) in vec2 a_tex;
layout(location = 3) in vec4 a_tan;


uniform mat3 u_normalMat;
uniform mat4 u_modelViewMat;
uniform mat4 u_modelViewProjMat;
uniform vec2 u_texScale;

// uniform float u_parallaxFocalDistance;
// uniform float u_parallaxFocalRange;

out vec4 position;
out mat3 tbnMatrix;
out vec3 positionTS;
// varying float blur;

out vec3 v_nor;
out vec3 v_tan;
out vec3 v_bin;

out vec2 v_tex;

void main() {
  position = u_modelViewMat*vec4(a_pos,1.0);
  // blur=clamp(abs(-position.z-u_parallaxFocalDistance)/u_parallaxFocalRange,0.0,1.0);

  vec3 normal = normalize(u_normalMat * a_nor);
  vec3 tangent = normalize(u_normalMat * a_tan.xyz);
  vec3 binormal = normalize(-a_tan.w * cross(normal, tangent));

  v_nor=normal;
  v_tan=tangent;
  v_bin=binormal;

  // column-major matrix
  tbnMatrix = mat3(tangent.x, binormal.x, normal.x,
                   tangent.y, binormal.y, normal.y,
                   tangent.z, binormal.z, normal.z);

  positionTS = (tbnMatrix * position.xyz);


  gl_Position=u_modelViewProjMat*vec4(a_pos,1.0);
  // gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
  v_tex=a_tex*u_texScale;
}
