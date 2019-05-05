//
//  ESCGUPImageTestFilter.m
//  ESCGPUImageDemo
//
//  Created by xiang on 2019/5/5.
//  Copyright © 2019 xiang. All rights reserved.
//

#import "ESCGPUImageTransformFilter.h"
#import <OpenGLES/ES2/glext.h>

NSString *const kGPUImageRotateVertexShaderString = SHADER_STRING
(
 attribute vec4 position;
 attribute vec4 inputTextureCoordinate;
 varying vec2 textureCoordinate;
 
 uniform mat4 rotateMatrix;      //全局参数
  void main()
  {
      gl_Position = position * rotateMatrix;
      textureCoordinate = inputTextureCoordinate.xy;
  }
 );


NSString *const kGPUImageInvertFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;

 void main()
 {
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     
     gl_FragColor = textureColor;

 }
 );

@interface ESCGPUImageTransformFilter () {
    GLuint rotate;
}

@end

@implementation ESCGPUImageTransformFilter

#pragma mark -
#pragma mark Initialization and teardown

- (id)initWithVertexShaderFromString:(NSString *)vertexShaderString fragmentShaderFromString:(NSString *)fragmentShaderString;
{
    if (!(self = [super initWithVertexShaderFromString:vertexShaderString fragmentShaderFromString:fragmentShaderString]))
    {
        return nil;
    }
    
    rotate = [filterProgram uniformIndex:@"rotateMatrix"];

    CATransform3D transform = CATransform3DIdentity;
    GLfloat rotationtest[16] = {
        transform.m11,transform.m12,transform.m13,transform.m14,
        transform.m21,transform.m22,transform.m23,transform.m24,
        transform.m31,transform.m32,transform.m33,transform.m34,
        transform.m41,transform.m42,transform.m43,transform.m44,
    };

    //设置旋转矩阵
    glUniformMatrix4fv(rotate, 1, GL_FALSE, (GLfloat *)&rotationtest);
    
    return self;
}

- (id)init; {
    if (!(self = [self initWithVertexShaderFromString:kGPUImageRotateVertexShaderString fragmentShaderFromString:kGPUImageInvertFragmentShaderString])) {
        return nil;
    }
    return self;
}

- (void)setTransform:(CATransform3D)transform {
    _transform = transform;
    
    GLfloat rotationtest[16] = {
        transform.m11,transform.m12,transform.m13,transform.m14,
        transform.m21,transform.m22,transform.m23,transform.m24,
        transform.m31,transform.m32,transform.m33,transform.m34,
        transform.m41,transform.m42,transform.m43,transform.m44,
    };
    
    //设置旋转矩阵
    glUniformMatrix4fv(rotate, 1, GL_FALSE, (GLfloat *)&rotationtest);
    
}

@end
