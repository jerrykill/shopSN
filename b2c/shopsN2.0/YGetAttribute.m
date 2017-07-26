//
//  YGetAttribute.m
//  shopsN
//  自定义字体行间隔和宽高计算
//  Created by imac on 2017/1/20.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGetAttribute.h"

@implementation YGetAttribute

+(CGSize)getSpaceHeight:(NSString *)text size:(CGSize)size rowHeight:(CGFloat)heght font:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = heght;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:text attributes:dic];

     CGSize sizes = [attr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return sizes;
}

+(NSAttributedString *)getSpaceString:(NSString *)text size:(CGSize)size rowHeight:(CGFloat)heght font:(UIFont*)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = heght;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:text attributes:dic];
    return attr;
}

@end
