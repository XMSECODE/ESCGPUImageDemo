//
//  ViewController.m
//  ESCGPUImageDemo
//
//  Created by xiang on 2019/5/5.
//  Copyright © 2019 xiang. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"
#import "ESCGPUImageTransformFilter.h"
#import "ESCGPUImageFillBlackFilter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self gpuimagetest];
    
    [self testCustomFilter];
}

- (void)testCustomFilter{
    UIImage *inputImage =[UIImage imageNamed:@"IMG_4370"];
    //  创建滤镜
    ESCGPUImageTransformFilter *disFilter = [[ESCGPUImageTransformFilter alloc] init];
    //设置旋转角度
    CATransform3D transfor = CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 1);
    transfor = CATransform3DRotate(transfor, 0 * M_PI / 180.0, 0, 0, 1);
    
    disFilter.transform = transfor;
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    //  创建滤镜
    ESCGPUImageFillBlackFilter *fillBlackFilter = [[ESCGPUImageFillBlackFilter alloc] init];
    //设置旋转角度
    
    [fillBlackFilter forceProcessingAtSize:newImage.size];
    [fillBlackFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource2 = [[GPUImagePicture alloc] initWithImage:newImage];
    //添加上滤镜
    [stillImageSource2 addTarget:fillBlackFilter];
    //开始渲染
    [stillImageSource2 processImage];
    //获取渲染后的图片
    UIImage *newImage2 = [fillBlackFilter imageFromCurrentFramebuffer];
    
    
    
    
    
    
    
    
    NSLog(@"%@===%@",newImage,inputImage);
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage2];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(50,300,250 ,250);
//    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    [self saveImage:newImage];
}


- (void)gpuimagetest {
    
    UIImage *inputImage =[UIImage imageNamed:@"IMG_4370"];
    //  创建滤镜
    GPUImageVignetteFilter *disFilter = [[GPUImageVignetteFilter alloc] init];
    //设置要渲染的区域
//    disFilter.vignetteStart = 0.1;
//    disFilter.vignetteEnd = 0.4;
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,45,250 ,250);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
}

- (void)saveImage:(UIImage *)image {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES).lastObject;
    path = [NSString stringWithFormat:@"%@/test.png",path];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:path atomically:YES];
}

@end
