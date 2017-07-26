//
//  YSOrderGoodCell.m
//  shopsN2.0
//
//  Created by imac on 2017/7/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSOrderGoodCell.h"
#import "YSOrderGoodOnlyOneView.h"
#import "YSOrderGoodsView.h"


@interface YSOrderGoodCell ()<YSOrderGoodOnlyOneViewDelegate,YSOrderGoodsViewDelegate>
/**公司名*/
@property (strong,nonatomic) UILabel *nameLabel;
/**状态*/
@property (strong,nonatomic) UILabel *statusLabel;
/**虚线 */
@property (strong,nonatomic) UIImageView *lineIV;
/**单商品订单view*/
@property (strong,nonatomic) YSOrderGoodOnlyOneView *oneView;
/**多订单商品view*/
@property (strong,nonatomic) YSOrderGoodsView *twoView;

/**下单时间*/
@property (strong,nonatomic) UILabel *timeLb;
/**操作*/
@property (strong,nonatomic) UIButton *actionBtn;

@property (strong,nonatomic) UIImageView *bottomIV;

@end

@implementation YSOrderGoodCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.nameLabel];
    [self addSubview:self.statusLabel];
    [self addSubview:self.lineIV];
    [self addSubview:self.oneView];
    [self addSubview:self.twoView];
    [self addSubview:self.timeLb];
    [self addSubview:self.actionBtn];
    [self addSubview:self.bottomIV];
}

#pragma mark ==懒加载==
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 15)];
        _nameLabel.textColor = __TextColor;
        _nameLabel.font = MFont(15);
        _nameLabel.textAlignment =NSTextAlignmentLeft;
        _nameLabel.text = [NSString stringWithFormat:@"%@自营",ShortTitle];
    }
    return _nameLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-80, 6, 70, 16)];
        _statusLabel.textColor = __TextColor;
        _statusLabel.font = MFont(16);
        _statusLabel.textAlignment = NSTextAlignmentRight;
    }
    return _statusLabel;
}

- (UIImageView *)lineIV {
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 38, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

- (YSOrderGoodOnlyOneView *)oneView {
    if (!_oneView) {
        _oneView = [[YSOrderGoodOnlyOneView alloc]initWithFrame:CGRectMake(0, 40, __kWidth, 132)];
        _oneView.delegate = self;
    }
    return _oneView;
}

- (YSOrderGoodsView *)twoView {
    if (!_twoView) {
        _twoView = [[YSOrderGoodsView alloc]initWithFrame:CGRectMake(0, 40, __kWidth, 132)];
        _twoView.delegate = self;
    }
    return _twoView;
}

-(UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_oneView)+15, 190, 15)];
        _timeLb.textColor = LH_RGBCOLOR(117, 117, 117);
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.font = MFont(14);

    }
    return _timeLb;
}

-(UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn =[[UIButton alloc]initWithFrame:CGRectMake(__kWidth-110, CGRectYH(_oneView)+5, 100, 35)];
        _actionBtn.layer.cornerRadius = 5;
        _actionBtn.layer.borderColor = LH_RGBCOLOR(227, 100, 100).CGColor;
        _actionBtn.layer.borderWidth = 1;
        _actionBtn.titleLabel.font = MFont(15);
        [_actionBtn setTitleColor:LH_RGBCOLOR(227, 100, 100) forState:BtnNormal];
        [_actionBtn addTarget:self action:@selector(chooseAction:) forControlEvents:BtnTouchUpInside];
    }
    return _actionBtn;
}

- (UIImageView *)bottomIV {
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 217, __kWidth, 3)];
        _bottomIV.backgroundColor =__BackColor;
    }
    return _bottomIV;
}

-(void)chooseAction:(UIButton*)sender{
    [self.delegate chooseAction:self.tag];
}

- (void)makeOrderDelete:(NSInteger)sender {
    [self.delegate orderDelete:sender];
}

- (void)makeOrdersRemove:(NSInteger)sender {
    [self.delegate orderDelete:sender];
}

- (void)setModel:(YSOrderModel *)model {
    _model = model;
    switch ([_model.orderStatus integerValue]) {
        case 0:
        {
            _statusLabel.text = @"待付款";
            _statusLabel.textColor = __DefaultColor;
            [_actionBtn setTitle:@"马上付款" forState:BtnNormal];
        }
            break;
        case 1:
        case 2:
        {
            _statusLabel.text = @"待处理";
            _statusLabel.textColor = __DefaultColor;
            [_actionBtn setTitle:@"查看订单" forState:BtnNormal];
        }
            break;
        case 3:
        {
            _statusLabel.text = @"已发货";
            _statusLabel.textColor =__DefaultColor;
            [_actionBtn setTitle:@"查看物流" forState:BtnNormal];
        }
            break;
        case 4:
        {
            if ([_model.comment isEqualToString:@"1"]) {
                _statusLabel.text = @"已完成";
                [_actionBtn setTitle:@"再次购买" forState:BtnNormal];
            }else{
                _statusLabel.text = @"待评价";
                [_actionBtn setTitle:@"马上评价" forState:BtnNormal];
            }
            _statusLabel.textColor = __DTextColor;
        }
            break;
        case -1:
        {
            _statusLabel.text = @"已取消";
            _statusLabel.textColor = __DTextColor;
            [_actionBtn setTitle:@"再次购买" forState:BtnNormal];
        }
            break;
        default:
            break;
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:[_model.createTime integerValue]];
    NSString *now = [formatter stringFromDate:date];

    _timeLb.text = [NSString stringWithFormat:@"下单时间：%@",now];

    if (_model.imageArr.count==1) {
        _oneView.hidden = NO;
        _twoView.hidden = YES;
        _oneView.model = _model;
    }else{
        _oneView.hidden = YES;
        _twoView.hidden = NO;
        _twoView.model = _model;
    }
    
}


@end
