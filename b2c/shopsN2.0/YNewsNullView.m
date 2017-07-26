//
//  YNewsNullView.m
//  shopsN
//
//  Created by imac on 2017/2/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YNewsNullView.h"

@interface YNewsNullView ()
{
    CGRect _frame;
}
@property (strong,nonatomic) UIImageView *newsIV;

@end

@implementation YNewsNullView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        _frame = frame;
        [self initView];
    }
    return self;
}

- (void)initView{
    CGFloat width = _frame.size.width;
    _newsIV = [[UIImageView alloc]initWithFrame:CGRectMake( (width-153)/2, 120, 153, 137)];
    [self addSubview:_newsIV];
    _newsIV.image = MImage(@"news_air");
    
    UIButton *gouBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(_newsIV)+30, width, 30)];
    [self addSubview:gouBtn];
    gouBtn.titleLabel.font = MFont(16);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"还没有消息哦，去选购看看"];
    [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(78, 78, 78)} range:NSMakeRange(0, attr.length-5)];
    [attr addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:__DefaultColor} range:NSMakeRange(attr.length-5, 5)];
    [gouBtn setAttributedTitle:attr forState:BtnNormal];
    [gouBtn addTarget:self action:@selector(chooseBuy) forControlEvents:BtnTouchUpInside];

}

-(void)chooseBuy{
    [self.delegate goBuying];
}

@end
