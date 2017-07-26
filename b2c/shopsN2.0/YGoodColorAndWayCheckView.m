//
//  YGoodColorAndWayCheckView.m
//  shopsN
//
//  Created by imac on 2016/12/15.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodColorAndWayCheckView.h"
#import "YGoodDetailWayColorCell.h"
#import "YGoodCountCell.h"

@interface YGoodColorAndWayCheckView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YGoodDetailWayColorCellDelegate,YGoodCountCellDelegate>

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titileLb;

@property (strong,nonatomic) UIButton *cancelBtn;

@property (strong,nonatomic) UILabel *priceLb;

@property (strong,nonatomic) UICollectionView *typeV;

@property (strong,nonatomic) UILabel *totalLb;

@property (strong,nonatomic) UIButton *addShopBtn;

@property (strong,nonatomic) UIButton *payBtn;

@property (strong,nonatomic) NSString *isFirst;

@end

@implementation YGoodColorAndWayCheckView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCancel)];
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight/3)];
    [self addSubview:headV];
    headV.backgroundColor = [UIColor blackColor];
    headV.alpha = 0.2;
    [headV addGestureRecognizer:tap];

    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, __kHeight/3, __kWidth, __kHeight*2/3)];
    [self addSubview:backV];
    backV.backgroundColor = [UIColor whiteColor];

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, __kHeight/3-10, 89, 89)];
    [self addSubview:_goodIV];
    _goodIV.layer.cornerRadius = 5;
    _goodIV.layer.borderWidth = 0.5;
    _goodIV.layer.borderColor = __BackColor.CGColor;
    _goodIV.layer.masksToBounds = YES;
    

    _titileLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+8, 18, __kWidth-150, 36)];
    [backV addSubview:_titileLb];
    _titileLb.textAlignment=NSTextAlignmentLeft;
    _titileLb.numberOfLines = 2;
    _titileLb.font = MFont(13);
    _titileLb.textColor = __DTextColor;

    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_titileLb)+15, 11, 18, 18)];
    [backV addSubview:_cancelBtn];
    _cancelBtn.layer.cornerRadius = 9;
    _cancelBtn.layer.borderWidth = 1;
    _cancelBtn.layer.borderColor = LH_RGBCOLOR(186, 186, 186).CGColor;
    [_cancelBtn setTitle:@"×" forState:BtnNormal];
    _cancelBtn.titleLabel.font = MFont(15);
    [_cancelBtn setTitleColor:LH_RGBCOLOR(186, 186, 186) forState:BtnNormal];
    [_cancelBtn addTarget:self action:@selector(chooseCancel) forControlEvents:BtnTouchUpInside];

    _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+11, CGRectYH(_titileLb)+8, __kWidth-160, 15)];
    [backV addSubview:_priceLb];
    _priceLb.textAlignment = NSTextAlignmentLeft;
    _priceLb.font =  MFont(13);
    _priceLb.textColor =  LH_RGBCOLOR(249, 79, 7);

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

    _typeV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, __kWidth, __kHeight*2/3-210) collectionViewLayout:flowLayout];
    [backV addSubview:_typeV];
    _typeV.delegate = self;
    _typeV.dataSource = self;
    _typeV.backgroundColor = [UIColor whiteColor];
   //section 0
    [_typeV registerClass:[YGoodDetailWayColorCell class] forCellWithReuseIdentifier:@"YGoodDetailWayColorCell"];
    //section 1
    [_typeV registerClass:[YGoodCountCell class] forCellWithReuseIdentifier:@"YGoodCountCell"];


    _totalLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_typeV)+20, __kWidth-35, 20)];
    [backV addSubview:_totalLb];
    _totalLb.textAlignment = NSTextAlignmentRight;

    _addShopBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(_totalLb)+20, __kWidth/2, 50)];
    [backV addSubview:_addShopBtn];
    _addShopBtn.backgroundColor = LH_RGBCOLOR(255, 114, 0);
    _addShopBtn.titleLabel.font = MFont(16);
    [_addShopBtn setTitle:@"加入购物车" forState:BtnNormal];
    [_addShopBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_addShopBtn addTarget:self action:@selector(addShop) forControlEvents:BtnTouchUpInside];

    _payBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_addShopBtn), CGRectYH(_totalLb)+20, __kWidth/2, 50)];
    [backV addSubview:_payBtn];
    _payBtn.backgroundColor = __DefaultColor;
    _payBtn.titleLabel.font = MFont(16);
    [_payBtn setTitle:@"马上购买" forState:BtnNormal];
    [_payBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_payBtn addTarget:self action:@selector(payMoney) forControlEvents:BtnTouchUpInside];

}
#pragma mark ==UICollectionViewDelegate==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _model.goodSize.count;
    }else{
        return 1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cells =nil;
    if (indexPath.section == 0) {
        YGoodDetailWayColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodDetailWayColorCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodDetailWayColorCell alloc]init];
        }
        cell.tag = indexPath.row;
        YGoodSizeModel *model = _model.goodSize[indexPath.row];
        cell.title = model.typeName;
        if (_checkModel.goodTypeArr.count) {
            for (YGoodTypeModel*dic in _checkModel.goodTypeArr) {
                if ([dic.name isEqualToString:model.typeName]) {
                    cell.check =dic.size;
                }
            }
        }
        cell.BtnArr = model.size;
        cell.delegate = self;
        cells = cell;
    }else if (indexPath.section == 1){
        YGoodCountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodCountCell" forIndexPath:indexPath];
        if (!cell) {
            cell =[[YGoodCountCell alloc]init];
        }
        cell.stock = _model.stock;
        cell.num = _checkModel.goodCount;
        cell.delegate = self;
        cells = cell;
    }
    return cells;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSInteger c = (__kWidth-50)/60;
        YGoodSizeModel *model =_model.goodSize[indexPath.row];
        CGFloat height = 46+(model.size.count/c+1)*49;
        return CGSizeMake(__kWidth, height);
    }else if (indexPath.section==1){
        return CGSizeMake(__kWidth, 50);
    }else{
        return CGSizeZero;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

-(void)setModel:(YGoodDetailModel *)model{
    _model =model;
    [_typeV reloadData];
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titileLb.text = _model.goodTitle;
    [self getTotal];
    _priceLb.text = [NSString stringWithFormat:@"¥%@",_model.goodMoney];
}

-(void)setCheckModel:(YShopGoodModel *)checkModel{
    _checkModel = checkModel;
    [self getTotal];
}

- (void)getTotal{
    if ([_checkModel.goodCount integerValue]==1||IsNilString(_checkModel.goodCount)) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共1件共计¥%@",_model.goodMoney]];
        [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(0, 6)];
        [attr addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(6, _model.goodMoney.length-3)];
        [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(_model.goodMoney.length+3, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(102, 102, 102) range:NSMakeRange(0, 1)];
        [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(1, 1)];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(102, 102, 102) range:NSMakeRange(2, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(5, _model.goodMoney.length+1)];
        _totalLb.attributedText = attr;
    }else{
        NSString *totalMoney = [NSString stringWithFormat:@"%.2f",[_model.goodMoney floatValue]*[_checkModel.goodCount integerValue]];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共%ld件共计¥%@",[_checkModel.goodCount integerValue],totalMoney]];
        [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(0, 5+_checkModel.goodCount.length)];
        [attr addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(5+_checkModel.goodCount.length, totalMoney.length-3)];
        [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(totalMoney.length+2+_checkModel.goodCount.length, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(102, 102, 102) range:NSMakeRange(0, 1)];
        [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(1, _checkModel.goodCount.length)];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(102, 102, 102) range:NSMakeRange(_checkModel.goodCount.length+1, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(_checkModel.goodCount.length+4, totalMoney.length+1)];
        _totalLb.attributedText = attr;
    }
}

- (void)checkNull{
    for (int i=0; i<_checkModel.goodTypeArr.count; i++) {
        YGoodTypeModel*type =_checkModel.goodTypeArr[i];
        for (YGoodSizeModel *size in _model.goodSize) {
            for (YSSizeModel*list in size.size) {
                if ([type.size isEqualToString:list.name]) {
                    type.sizeId = list.sizeId ;
                    [_checkModel.goodTypeArr replaceObjectAtIndex:i withObject:type];
                }
            }
        }
    }
}


#pragma mark ==YGoodDetailWayColorCellDelegate==
-(void)chooseType:(NSInteger)idx index:(NSInteger)sender{
    [self checkNull];
    YGoodTypeModel *type = [[YGoodTypeModel alloc]init];
    YGoodSizeModel *model = _model.goodSize[idx];
    type.name = model.typeName;
    YSSizeModel *list = model.size[sender];
    type.size = list.name;
    type.sizeId = list.sizeId;
    if (_checkModel.goodTypeArr.count) {
        for (YGoodTypeModel *data in _checkModel.goodTypeArr) {
            if ([data.name isEqualToString:type.name]) {
                [_checkModel.goodTypeArr removeObject:data];
                break;
            }
        }
    }
    [_checkModel.goodTypeArr addObject:type];
    
    [self.delegate chooseModel:_checkModel];
}
#pragma mark ==YGoodCountCellDelegate==
-(void)countChange:(BOOL)sender{
    NSInteger i = [_checkModel.goodCount integerValue];
    if (sender) {
            i++;
        }else{
            i--;
        }
    _checkModel.goodCount = [NSString stringWithFormat:@"%ld",i];
    NSString *totalMoney = [NSString stringWithFormat:@"%.2f",[_model.goodMoney floatValue]*i];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共%ld件共计¥%@",i,totalMoney]];
    [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(0, 5+_checkModel.goodCount.length)];
    [attr addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(5+_checkModel.goodCount.length, totalMoney.length-3)];
    [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(totalMoney.length+2+_checkModel.goodCount.length, 3)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(102, 102, 102) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(1, _checkModel.goodCount.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(102, 102, 102) range:NSMakeRange(_checkModel.goodCount.length+1, 3)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(_checkModel.goodCount.length+4, totalMoney.length+1)];
    _totalLb.attributedText = attr;
    [self.delegate chooseModel:_checkModel];
}


#pragma mark ==取消按钮==
-(void)chooseCancel{
    [self removeFromSuperview];
}
#pragma mark ==加入购物车==
-(void)addShop{
    [self.delegate addShop];
}

#pragma mark ==立即购买==
-(void)payMoney{
    [self.delegate PayNow];
}


@end
