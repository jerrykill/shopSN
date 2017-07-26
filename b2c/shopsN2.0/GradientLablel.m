//
//  GradientLablel.m
//  shopsN
//  渐变色文本（仅限于尾货清仓的情况，如需更高级请进行重新封装）
//  Created by imac on 2016/12/9.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "GradientLablel.h"

@implementation GradientLablel



- (void)drawRect:(CGRect)rect
{
    NSArray *colors = @[(id)LH_RGBCOLOR(255, 76, 115).CGColor,(id)LH_RGBCOLOR(255, 125, 10).CGColor];

    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}];
    CGRect textRect = (CGRect){0, 0, textSize};

    // 画文字(不做显示用 主要作用是设置layer的mask)
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.textColor set];
    [self.text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:NULL];

    // 坐标 (只对设置后的画到context起作用 之前画的文字不起作用)
    CGContextTranslateCTM(context, 0.0f, rect.size.height- (rect.size.height - textSize.height+5)*0.5);
    CGContextScaleCTM(context, 1.0f, -1.0f);

    CGImageRef alphaMask = NULL;
    alphaMask = CGBitmapContextCreateImage(context);
    CGContextClearRect(context, rect);// 清除之前画的文字


    // 设置mask
    CGContextClipToMask(context, rect, alphaMask);

    // 画渐变色

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, NULL);
    CGPoint startPoint = CGPointMake(textRect.origin.x,
                                     textRect.origin.y);
    CGPoint endPoint = CGPointMake(textRect.origin.x + textRect.size.width,
                                   textRect.origin.y + textRect.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);

    // 释放内存
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    CFRelease(alphaMask);
    
}


@end
