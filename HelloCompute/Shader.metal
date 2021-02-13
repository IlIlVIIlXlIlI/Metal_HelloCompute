//
//  Shader.metal
//  HelloCompute
//
//  Created by Shogo Nobuhara on 2021/02/14.
//

#include <metal_stdlib>
#include "ShaderTypes.h"

kernel void generateKuku(
                         constant int32_t &columnCount [[buffer(kKernelKukuIndexColumnCount)]],
                         constant int32_t &rowCount [[buffer(kKernelKukuIndexRowCount)]],
                         device int32_t *resultValues [[buffer(kKernelKukuIndexResult)]],
                         uint2 position [[thread_position_in_grid]]
                         ){
    if (position.x >= (uint)columnCount ||
        position.y >= (uint)rowCount) {
            return;
        }
    
    uint index = position.y * columnCount + position.x;
    resultValues[index] = (position.x + 1) * (position.y + 1);
}


