
//
//  YGoodClassCell.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodClassCell.h"

@interface YGoodClassCell(){
    CGFloat _width;
    CGFloat _height;
}

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *desLb;

@property (strong,nonatomic) UIImageView *headIV;

@end

@implementation YGoodClassCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;
        _height = frame.size.height;
        [self addSubview:self.titleLb];
        [self addSubview:self.desLb];
        [self addSubview:self.headIV];
    }
    return self;
}

-(void)setDataModel:(YGoodClassModel *)dataModel{
    _dataModel = dataModel;
    _titleLb.text = _dataModel.classTitle;
    _desLb.text = _dataModel.classdesc;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RootURL,_dataModel.imageName]]];

}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, _width, 17)];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = BFont(15);
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

-(UILabel *)desLb{
    if (!_desLb) {
        _desLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_titleLb)+3, _width, 12)];
        _desLb.textColor = LH_RGBCOLOR(85, 85, 85);
        _desLb.font = MFont(11);
        _desLb.textAlignment = NSTextAlignmentCenter;
    }
    return _desLb;
}


-(UIImageView *)headIV{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, CGRectYH(_desLb)+5, _width-20, _height-52)];
        _headIV.backgroundColor = [UIColor whiteColor];
        _headIV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headIV;
}

@end
