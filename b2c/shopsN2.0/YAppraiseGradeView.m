//
//  YAppraiseGradeView.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAppraiseGradeView.h"

@interface YAppraiseGradeView()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIImageView *logoIV;

@end

@implementation YAppraiseGradeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[ UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.logoIV];
    
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 25, 12)];
        _titleLb.font = MFont(10);
        _titleLb.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLb;
}

-(UIImageView *)logoIV{
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 6, 15, 15)];
        _logoIV.layer.cornerRadius = 7.5;
    }
    return _logoIV;
}


-(void)setStar:(NSInteger)star{
    NSArray *titleArr = @[@"差评",@"中评",@"好评"];
    switch (star) {
        case 1:
        {
            _titleLb.text = titleArr[star-1];
            _titleLb.textColor = LH_RGBCOLOR(208, 17, 27);
            _logoIV.image = MImage(@"bad_grade");
        }
            break;
        case 2:
        {
            _titleLb.text = titleArr[star-1];
            _titleLb.textColor = LH_RGBCOLOR(255, 153, 33);
            _logoIV.image = MImage(@"middle_grade");
        }
            break;
        case 3:
        {
            _titleLb.text = titleArr[star-1];
            _titleLb.textColor = LH_RGBCOLOR(107, 198, 139);
            _logoIV.image = MImage(@"good_grade");
        }
            break;

        default:
            break;
    }
}

@end
