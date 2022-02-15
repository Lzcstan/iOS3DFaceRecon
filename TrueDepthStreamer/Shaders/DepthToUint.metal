/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Metal compute shader that translates depth values to 16-bit uint values.
*/

#include <metal_stdlib>
using namespace metal;

struct converterParameters {
    float offset;
    float range;
};

// Compute kernel
kernel void depthToGrayscale(texture2d<float, access::read>  inputTexture      [[ texture(0) ]],
                             texture2d<float, access::write> outputTexture     [[ texture(1) ]],
                             constant converterParameters& converterParameters [[ buffer(0) ]],
                             uint2 gid [[ thread_position_in_grid ]])
{
    // Don't read or write outside of the texture.
    if ((gid.x >= inputTexture.get_width()) || (gid.y >= inputTexture.get_height())) {
        return;
    }
    
    float depth = inputTexture.read(gid).x;
    
    // Normalize the value between 0 and 1.
//    depth = (depth - converterParameters.offset) / (converterParameters.range);
    
//    float4 outputColor = float4(float3(depth), 1.0);
// lzchao
    // TODO: get the Uint value stands for depth in milimeter
//    float outputColor = 165.84 / depth;
    float outputColor = depth * 1000;
    if (outputColor > 10000) {
        outputColor = 0.0;
    }
// lzchao
    
    outputTexture.write(outputColor, gid);
}
