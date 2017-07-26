//
//  YServiceFirstHeadView.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YServiceFirstHeadView.h"
#import "YWarnTitleView.h"


@interface YServiceFirstHeadView ()<YWarnTitleViewDelegate>
{
    CGFloat _width;
}

@property (strong,nonatomic) UILabel *adLb;

@property (strong,nonatomic) UIImageView *noiceIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) YWarnTitleView *titleV;

@property (strong,nonatomic) UIButton *moreBtn;

@property (strong,nonatomic) UIView *headV;

@property (strong,nonatomic) UILabel *headLb;

@end

@implementation YServiceFirstHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.adLb];
    [self addSubview:self.noiceIV];
    [self addSubview:self.titleV];;
    [self addSubview:self.moreBtn];
    [self addSubview:self.headV];
    [_headV addSubview:self.headLb];
}

#pragma mark ==懒加载==
-(UILabel *)adLb{
    if (!_adLb) {
        _adLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 30, 20)];
        _adLb.textColor = [UIColor blackColor];
        _adLb.font = MFont(15);
        _adLb.text =@"公告";
    }
    return _adLb;
}

-(UIImageView *)noiceIV{
    if (!_noiceIV) {
        _noiceIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_adLb)+30, 12, 15, 15)];
        _noiceIV.image = MImage(@"speaker");
    }
    return _noiceIV;
}

//-(UILabel *)titleLb{
//    if (!_titleLb) {
//        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_noiceIV)+5, 10, __kWidth-170, 18)];
//        _titleLb.textAlignment = NSTextAlignmentLeft;
//        _titleLb.textColor = LH_RGBCOLOR(85, 85, 85);
//        _titleLb.font = MFont(14);
//    }
//    return _titleLb;
//}

-(YWarnTitleView *)titleV{
    if (!_titleV) {
        _titleV = [[YWarnTitleView alloc]initWithFrame:CGRectMake(CGRectXW(_noiceIV)+5, 10, __kWidth-170, 18)];
        _titleV.delegate = self;
    }
    return _titleV;
}


-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(_width-65, 8, 65, 20)];
        _moreBtn.titleLabel.font = MFont(15);
        [_moreBtn setTitle:@"更多" forState:BtnNormal];
        [_moreBtn setTitleColor:[UIColor blackColor] forState:BtnNormal];
        [_moreBtn addTarget:self action:@selector(getMore) forControlEvents:BtnTouchUpInside];
    }
    return _moreBtn;
}

-(UIView *)headV{
    if (!_headV) {
        _headV = [[UIView alloc]initWithFrame:CGRectMake(0, 40, __kWidth, 45)];
        _headV.backgroundColor = __BackColor;
    }
    return _headV;
}

-(UILabel *)headLb{
    if (!_headLb) {
        _headLb = [[UILabel alloc]initWithFrame:CGRectMake(18, 16, 100, 15)];
        _headLb.textAlignment = NSTextAlignmentLeft;
        _headLb.textColor = __TextColor;
        _headLb.font = MFont(13);
        _headLb.text = @"自动服务";
    }
    return _headLb;
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
    _titleV.titleArr = titleArr;
}

#pragma mark ==YWarnTitleViewDelegate==
-(void)chooseWarnTitle:(NSInteger)index{
    [self.delegate chooseWarnIndex:index];
}


-(void)getMore{
    [self.delegate getMore];
}



@end
