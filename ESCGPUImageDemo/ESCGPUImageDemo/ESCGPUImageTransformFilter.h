//
//  ESCGUPImageTestFilter.h
//  ESCGPUImageDemo
//
//  Created by xiang on 2019/5/5.
//  Copyright © 2019 xiang. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface ESCGPUImageTransformFilter : GPUImageFilter 

@property(nonatomic,assign)CATransform3D transform;

@end

NS_ASSUME_NONNULL_END
