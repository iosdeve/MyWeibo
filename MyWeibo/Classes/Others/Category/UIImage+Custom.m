//
//  UIImage+Custom.m
//  MyWeibo
//
//  Created by ChenXin on 3/2/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
////UIImage分类，自动构建IOS6，IOS7图片

#import "UIImage+Custom.h"

@implementation UIImage (Custom)

/**
 *  传入图片名称，根据当前系统版本，返回ios6，ios7图片
 *
 *  @param name 图片名称
 *
 *  @return 返回UIImage
 */
+(UIImage *)imageWithName:(NSString *)name{
    if (iOS7) {
        //获取文件扩展名，不含点
        NSString *extension=[name pathExtension];
        //获取文件名称不含扩展名
        NSString *imageName=[name stringByDeletingPathExtension];
        //构建ios7的图片名称
        imageName=[imageName stringByAppendingString:@"_os7"];
        //如果有扩展名，构建含有扩展名的文件名称
        if (extension.length>0) {
            imageName=[NSString stringWithFormat:@"%@.%@",imageName,extension];
        }
        UIImage *image=[UIImage imageNamed:imageName];
        //如果有针对ios7的图片返回，否则还是用原来的方法生成图片
        if (image) {
            return image;
        }
    }
    return [UIImage imageNamed:name];
}

/**
 *  拉伸Image
 *
 *  @param name image图标名称
 *
 *  @return 返回UIImage
 */
+(UIImage *) imageResize:(NSString *) name{
    UIImage *image=[UIImage imageWithName:name];
    image=[image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    return image;
}

+(UIImage *) imageResize:(NSString *) name left:(CGFloat) left top:(CGFloat) top{
    UIImage *image=[UIImage imageWithName:name];
    image=[image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
    return image;
}

@end
