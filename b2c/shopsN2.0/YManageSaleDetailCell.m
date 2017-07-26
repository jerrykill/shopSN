//
//  YManageSaleDetailCell.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YManageSaleDetailCell.h"

@interface YManageSaleDetailCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end


@implementation YManageSaleDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.detailLb];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 80, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(13);
        _titleLb.textColor = LH_RGBCOLOR(121, 121, 121);
    }
    return _titleLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 12, __kWidth-100, 15)];
        _detailLb.textAlignment = NSTextAlignmentLeft;
        _detailLb.textColor = __DTextColor;
        _detailLb.font = MFont(13);
        _detailLb.numberOfLines = 0;
    }
    return _detailLb;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detail= detail;
    _detailLb.text = detail;
     CGSize size =[detail boundingRectWithSize:CGSizeMake(__kWidth-100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(13)} context:nil].size;
    _detailLb.frame = CGRectMake(CGRectXW(_titleLb), 12, __kWidth-100, size.height);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25+size.height, __kWidth-20, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setColor:(NSString *)color{
    if ([color isEqualToString:@"1"]) {
        _detailLb.textColor = __DefaultColor;
    }else if ([color isEqualToString:@"2"]){
        _detailLb.textColor = LH_RGBCOLOR(121, 121, 121);
        if (_detail.integerValue>0) {
            NSDate *times =[NSDate dateWithTimeIntervalSince1970:[_detail integerValue]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            _detailLb.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:times]];
        }else{
            _detailLb.text = @"暂无";
        }
    }
}


- (void)setIndex:(NSString *)index {
    if ([index isEqualToString:@"类型"]) {
        switch ([_detail integerValue]) {
            case 1:
                _detailLb.text = @"未收到";
                break;
            case 2:
                _detailLb.text = @"收到";
                break;
            default:
                break;
        }
    }else if ([index isEqualToString:@"要求"]){
        switch ([_detail integerValue]) {
            case 0:
                _detailLb.text = @"换货";
                break;
            case 1:
                _detailLb.text = @"退货";
                break;
            case 2:
                _detailLb.text = @"退款";
                break;
            default:
                break;
        }
    }else if ([index isEqualToString:@"状态"]){
        switch ([_detail integerValue]) {
            case 2:
                _detailLb.text = @"未发货";
                break;
            case 3:
                _detailLb.text = @"已发货";
                break;
            case 4:
                _detailLb.text = @"已收货";
                break;
            default:
                _detailLb.text = @"信息不详";
                break;
        }
    }
}
@end
