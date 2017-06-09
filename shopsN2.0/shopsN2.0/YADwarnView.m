//
//  YADwarnView.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YADwarnView.h"
#import "YWarnTitleView.h"

@interface YADwarnView()<YWarnTitleViewDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) YWarnTitleView *titleV;

@end

@implementation YADwarnView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = frame.size.width;

        UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 1)];
        [self addSubview:headIV];
        headIV.backgroundColor = HEXCOLOR(0xeaf0f4);

        UILabel *adLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 30, 20)];
        [self addSubview:adLb];
        adLb.textColor = [UIColor blackColor];
        adLb.font = MFont(15);
        adLb.text =@"公告";


        UIImageView *noiceIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(adLb)+30, 12, 15, 15)];
        [self addSubview:noiceIV];
        noiceIV.image = MImage(@"speaker");

        _titleV = [[YWarnTitleView alloc]initWithFrame:CGRectMake(CGRectXW(noiceIV)+5, 9, __kWidth-170, 20)];
        [self addSubview:_titleV];
        _titleV.delegate = self;


        UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-65, 8, 65, 20)];
        [self addSubview:moreBtn];
        moreBtn.titleLabel.font = MFont(15);
        [moreBtn setTitle:@"更多" forState:BtnNormal];
        [moreBtn setTitleColor:[UIColor blackColor] forState:BtnNormal];
        [moreBtn addTarget:self action:@selector(getMore) forControlEvents:BtnTouchUpInside];
    }
    return self;
}



- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor lightGrayColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 0.5);
    CGContextMoveToPoint(currentContext, 60, 3);
    CGContextAddLineToPoint(currentContext, 60, self.frame.size.height-3);
    CGFloat arr[] = {3,1};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 1);
    CGContextDrawPath(currentContext, kCGPathStroke);


    CGContextRef currentContext2 = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext2, [UIColor lightGrayColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext2, 0.5);
    CGContextMoveToPoint(currentContext2, self.frame.size.width-65, 3);
    CGContextAddLineToPoint(currentContext2, self.frame.size.width-65, self.frame.size.height-3);
    CGFloat arr1[] = {3,1};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext2, 0, arr1, 1);
    CGContextDrawPath(currentContext2, kCGPathStroke);

}

//-(void)setNotice:(NSString *)notice{
//    _titleLb.text = notice;
//}

-(void)setTitleArr:(NSArray<YWarnModel *> *)titleArr{
    _titleArr = titleArr;
    _titleV.titleArr =_titleArr;
}

#pragma mark ==YWarnTitleView==
-(void)chooseWarnTitle:(NSInteger)index{
    [self.delegate chooseWarn:index];
}

-(void)getMore{
    [self.delegate getMore];
}

@end
