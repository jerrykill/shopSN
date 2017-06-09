//
//  YBuyingGoodPicCell.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingGoodPicCell.h"
#import "YPutPictureView.h"

@interface YBuyingGoodPicCell()<YPutPictureViewDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) YPutPictureView *picPutV;

@property (strong,nonatomic) UILabel *textLb;

@end

@implementation YBuyingGoodPicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];

    [self addSubview:self.picPutV];

    [self addSubview:self.textLb];

}
#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, 100, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _titleLb.font = MFont(15);
        _titleLb.text = @"商品图片：";
    }
    return _titleLb;
}

-(YPutPictureView *)picPutV{
    if (!_picPutV) {
        _picPutV = [[YPutPictureView alloc]initWithFrame:CGRectMake(0, CGRectYH(_titleLb)+5, __kWidth, 80)];
        _picPutV.delegate = self;
    }
    return _picPutV;
}

-(UILabel *)textLb{
    if (!_textLb) {
        _textLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_picPutV)+5, __kWidth, 15)];
        _textLb.textAlignment = NSTextAlignmentLeft;
        _textLb.font = MFont(10);
        _textLb.textColor = LH_RGBCOLOR(189, 189, 189);
        _textLb.text = @"商品图片文件大小必须≤5MB，文件格式支持 JPG、PNG、GIF、BMP、JPEG。";
    }
    return _textLb;
}

#pragma mark ==YDrawBackInputCellDelegate==
-(void)deleteImgIndex:(NSInteger)index{
    [self.delegate  deletePicIndex:index];
}

-(void)addPhoto{
    [self.delegate addPhotos];
}



-(void)setImageArr:(NSMutableArray *)imageArr{
    _picPutV.imageArr = imageArr;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}



@end
