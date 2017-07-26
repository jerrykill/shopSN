//
//  YPersonAppraiseCell.m
//  shopsN
//
//  Created by imac on 2017/1/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonAppraiseCell.h"
#import "YAppariseHeadView.h"
#import "YAppariseBottomView.h"
#import "YPersonAppraiseImagesView.h"

@interface YPersonAppraiseCell ()

@property (strong,nonatomic) YAppariseHeadView *headV;

@property (strong,nonatomic) YAppariseBottomView *bottomV;

@property (strong,nonatomic) YPersonAppraiseImagesView *imagesView;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIImageView *bottomIV;

@end

@implementation YPersonAppraiseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.headV];
    [self addSubview:self.titleLb];
    [self addSubview:self.bottomV];
    [self addSubview:self.bottomIV];
    [self addSubview:self.imagesView];
}

#pragma mark ==懒加载==
-(YAppariseHeadView *)headV{
    if (!_headV) {
        _headV = [[YAppariseHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 65)];
        _headV.backgroundColor = [UIColor whiteColor];
    }
    return _headV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_headV)+5, __kWidth-25, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(12);
        _titleLb.numberOfLines =0;
    }
    return _titleLb;
}

- (YPersonAppraiseImagesView *)imagesView {
    if (!_imagesView) {
        _imagesView = [[YPersonAppraiseImagesView alloc]initWithFrame:CGRectMake(0, CGRectYH(_titleLb), __kWidth, 60)];
        _imagesView.hidden = YES;
    }
    return _imagesView;
}

-(YAppariseBottomView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[YAppariseBottomView alloc]initWithFrame:CGRectMake(0, CGRectYH(_titleLb), __kWidth, 40)];
    }
    return _bottomV;
}

-(UIImageView *)bottomIV{
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectYH(_bottomV), __kWidth, 1)];
        _bottomIV.backgroundColor = __BackColor;
    }
    return _bottomIV;
}


-(void)setModel:(YGoodAppraiseModel *)model{
    _model = model;
    _headV.title =_model.model.goodTitle;
    _headV.imageName = _model.model.goodUrl;
    NSString *text = _model.info;
    CGSize size  =[text boundingRectWithSize:CGSizeMake(__kWidth-25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(12)} context:nil].size;
    _titleLb.text = text;
    _titleLb.frame = CGRectMake(10, CGRectYH(_headV)+5, __kWidth-25, size.height);

    if (_model.imageArr.count) {
        _imagesView.hidden = NO;
        _imagesView.frame = CGRectMake(0, CGRectYH(_titleLb), __kWidth, 60);
        _imagesView.imageArr = _model.imageArr;
    }else{
        _imagesView.hidden = YES;
    }
    NSInteger t =0;
    if (_model.imageArr.count) {
        t=1;
    }
    _bottomV.frame = CGRectMake(0, CGRectYH(_titleLb)+t*70, __kWidth, 40);
    _bottomV.model = _model;

    _bottomIV.frame = CGRectMake(0, CGRectYH(_bottomV), __kWidth, 1);

}

@end
