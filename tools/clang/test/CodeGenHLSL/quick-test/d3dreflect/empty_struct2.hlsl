// RUN: %dxc -E main -T vs_6_0 %s | %D3DReflect %s | FileCheck %s

// Make sure nest empty struct works.

struct KillerStruct {};

struct InnerStruct {
  KillerStruct s;
};

struct OuterStruct {
  InnerStruct s;
};

cbuffer Params_cbuffer : register(b0) {
  OuterStruct constants;
  float4 foo;
};

float4 main(float4 pos : POSITION) : SV_POSITION { return foo; }


// CHECK: ID3D12ShaderReflection:
// CHECK:   D3D12_SHADER_BUFFER_DESC:
// CHECK:     Shader Version: Vertex 6.0
// CHECK:     ConstantBuffers: 1
// CHECK:     BoundResources: 1
// CHECK:     InputParameters: 1
// CHECK:     OutputParameters: 1
// CHECK:   Constant Buffers:
// CHECK:     ID3D12ShaderReflectionConstantBuffer:
// CHECK:       D3D12_SHADER_BUFFER_DESC: Name: Params_cbuffer
// CHECK:         Type: D3D_CT_CBUFFER
// CHECK:         Size: 16
// CHECK:         Num Variables: 2
// CHECK:       {
// CHECK:         ID3D12ShaderReflectionVariable:
// CHECK:           D3D12_SHADER_VARIABLE_DESC: Name: constants
// CHECK:           ID3D12ShaderReflectionType:
// CHECK:             D3D12_SHADER_TYPE_DESC: Name: OuterStruct
// CHECK:               Class: D3D_SVC_STRUCT
// CHECK:               Type: D3D_SVT_VOID
// CHECK:               Rows: 1
// CHECK:           CBuffer: Params_cbuffer
// CHECK:         ID3D12ShaderReflectionVariable:
// CHECK:           D3D12_SHADER_VARIABLE_DESC: Name: foo
// CHECK:             Size: 16
// CHECK:             uFlags: 0x2
// CHECK:           ID3D12ShaderReflectionType:
// CHECK:             D3D12_SHADER_TYPE_DESC: Name: float4
// CHECK:               Class: D3D_SVC_VECTOR
// CHECK:               Type: D3D_SVT_FLOAT
// CHECK:               Rows: 1
// CHECK:               Columns: 4
// CHECK:           CBuffer: Params_cbuffer
// CHECK:       }
// CHECK:   Bound Resources:
// CHECK:     D3D12_SHADER_BUFFER_DESC: Name: Params_cbuffer
// CHECK:       Type: D3D_SIT_CBUFFER
// CHECK:       uID: 0
// CHECK:       BindPoint: 0
// CHECK:       Dimension: D3D_SRV_DIMENSION_UNKNOWN