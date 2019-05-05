//
//  ESCGPUImageScaleFilter.m
//  ESCGPUImageDemo
//
//  Created by xiang on 2019/5/5.
//  Copyright © 2019 xiang. All rights reserved.
//

#import "ESCGPUImageFillBlackFilter.h"

NSString *const kGPUImageFillBlackFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 void main()
 {
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     
     if(textureColor.a != 1.0)
         gl_FragColor = vec4(0.0,0.0,0.0,1.0);
     else
         gl_FragColor = textureColor;
     
 }
 );

@interface ESCGPUImageFillBlackFilter ()

@end

@implementation ESCGPUImageFillBlackFilter

- (id)init; {
    if (!(self = [self initWithFragmentShaderFromString:kGPUImageFillBlackFragmentShaderString])) {
        return nil;
    }
    return self;
}

@end
