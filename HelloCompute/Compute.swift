//
//  Compute.swift
//  HelloCompute
//
//  Created by Shogo Nobuhara on 2021/02/14.
//

import Foundation
import Metal

class Compute {
    var device: MTLDevice? = nil
    var cmdQueue: MTLCommandQueue? = nil
    
    init(){
        // 初期化処理。デバイスの作成とコマンドキューを作成する
        if let device = MTLCreateSystemDefaultDevice() {
            self.device = device
            self.cmdQueue = device.makeCommandQueue()
        }
    }
    
    // 計算を行う
    func executeCalc(
        completion: @escaping ((_ rowValuesArray: [[Int32]]?) -> ())) {
        let cmdBuffer = self.cmdQueue?.makeCommandBuffer()
        let cmdEncoder = cmdBuffer?.makeComputeCommandEncoder()
        
        guard let pipeline = makeKukuPipeline() else {
            completion(nil)
            return
        }
        
        cmdEncoder?.setComputePipelineState(pipeline)
        
        var column: Int32 = 9
        var row: Int32 = 9
        let resultBuffer = self.device?.makeBuffer(
            length: MemoryLayout<Int32>.size + 81,
            options: .storageModeShared)
        
        cmdEncoder?.setBytes(&column, length: MemoryLayout<Int32>.size, index: kKernelKukuIndexColumnCount)
        cmdEncoder?.setBytes(&row, length: MemoryLayout<Int32>.size, index: kKernelKukuIndexRowCount)
        cmdEncoder?.setBuffer(resultBuffer, offset: 0, index: kKernelKukuIndexResult)
        
        // GPUが同時実行可能なスレッド数
        let w = pipeline.threadExecutionWidth
        // 1つのスレッドグループに許可される最大スレッド数
        let h = pipeline.maxTotalThreadsPerThreadgroup / w
        let threadsPerGroup = MTLSizeMake(w,h,1)
        let threadsPerGrid = MTLSizeMake(Int(column),Int(row),1)
        cmdEncoder?.dispatchThreads(threadsPerGrid, threadsPerThreadgroup: threadsPerGroup)
        
        cmdEncoder?.endEncoding()
        
        cmdBuffer?.addCompletedHandler({(cb) in
            if let buf = resultBuffer {
                completion(self.makeRowValuesArray(buf))
            } else {
                completion(nil)
            }
        })
        
        cmdBuffer?.commit()
    }
    
    // バッファからKukuTable用の配列を作る
    func makeRowValuesArray(_ buffer: MTLBuffer)->[[Int32]] {
        var result = [[Int32]]()
        
        let p = buffer.contents().bindMemory(to: Int32.self,capacity: 81)
        let values = UnsafeBufferPointer<Int32>(start: p, count: 81)
        
        for i in 0 ..< 9 {
            let rowValues = [Int32](values[(i * 9) ..< ((i + 1) * 9)])
            result.append(rowValues)
        }
        
        return result
    }
    
    
    // コンピュートパイプライン状態オブジェクトを作成する
    func makeKukuPipeline() -> MTLComputePipelineState? {
        // カーネル関数を取得する
        let lib = self.device?.makeDefaultLibrary()
        guard let kukuFunc = lib?.makeFunction(name:"generateKuKu") else {
            return nil
        }
        
        // コンピュートパイプライン状態オブジェクトを作成する
        do {
            return try self.device?.makeComputePipelineState(function: kukuFunc)
        } catch _ {
            return nil
        }
    }
    
}

