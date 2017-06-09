//
//  YApplyProgressCell.m
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplyProgressCell.h"

@implementation YApplyProgressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{
    UIImageView *progressV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-352)/2, 5, 352, 245)];
    [self addSubview:progressV];
    progressV.contentMode = UIViewContentModeScaleAspectFit;
    progressV.image = MImage(@"lc");
}



@end
