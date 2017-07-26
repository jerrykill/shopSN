//
//  YShopGoodColorAndWayCheckView.m
//  shopsN
//
//  Created by imac on 2016/12/17.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YShopGoodColorAndWayCheckView.h"
#import "YShopGoodColorAndWayCheckView.h"
#import "YGoodDetailWayColorCell.h"

@interface YShopGoodColorAndWayCheckView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YGoodDetailWayColorCellDelegate>
@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titileLb;

@property (strong,nonatomic) UIButton *cancelBtn;

@property (strong,nonatomic) UILabel *priceLb;

@property (strong,nonatomic) UICollectionView *typeV;


@end

@implementation YShopGoodColorAndWayCheckView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCancel)];
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight-350)];
    [self addSubview:headV];
    headV.backgroundColor = [UIColor blackColor];
    headV.alpha = 0.4;
    [headV addGestureRecognizer:tap];
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, __kHeight-350, __kWidth, 350)];
    [self addSubview:backV];
    backV.backgroundColor = [UIColor whiteColor];

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, __kHeight-360, 89, 89)];
    [self addSubview:_goodIV];
    _goodIV.layer.cornerRadius = 5;
    _goodIV.layer.borderWidth = 0.5;
    _goodIV.layer.backgroundColor = __BackColor.CGColor;
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
//    _priceLb.font =  MFont(13);
    _priceLb.textColor =  LH_RGBCOLOR(249, 79, 7);

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

    _typeV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, __kWidth, 190) collectionViewLayout:flowLayout];
    [backV addSubview:_typeV];
    _typeV.delegate = self;
    _typeV.dataSource = self;
    _typeV.backgroundColor = [UIColor whiteColor];
    //section 0
    [_typeV registerClass:[YGoodDetailWayColorCell class] forCellWithReuseIdentifier:@"YGoodDetailWayColorCell"];

    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(_typeV)+10, __kWidth, 50)];
    [backV addSubview:sureBtn];
    sureBtn.titleLabel.font = MFont(16);
    [sureBtn setTitle:@"确认" forState:BtnNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    sureBtn.backgroundColor = __DefaultColor;
    [sureBtn addTarget:self action:@selector(chooseSure) forControlEvents:BtnTouchUpInside];

}
#pragma mark ==UICollectionViewDelegate==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.goodSize.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YGoodDetailWayColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodDetailWayColorCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YGoodDetailWayColorCell alloc]init];
    }
    cell.tag = indexPath.row;
    YGoodTypeModel *size = _checkModel.goodTypeArr[indexPath.row];
    cell.check =size.size;
    YGoodSizeModel *model = _model.goodSize[indexPath.row];
    cell.title = model.typeName;
    cell.BtnArr = model.size;
    cell.delegate = self;
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger c = (__kWidth-50)/60;
    YGoodSizeModel *model =_model.goodSize[indexPath.row];
    CGFloat height = 46+(model.size.count/c+1)*49;
    return CGSizeMake(__kWidth, height);
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
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_model.goodMoney]];
    [attr addAttribute:NSFontAttributeName value:MFont(11) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:MFont(13) range:NSMakeRange(1, attr.length-1)];
    _priceLb.attributedText = attr;

}

-(void)setCheckModel:(YShopGoodModel *)checkModel{
    _checkModel =checkModel;
    [_typeV reloadData];
}



-(void)setGoodList:(NSMutableArray<YSGoodTypeEditModel *> *)goodList{
    _goodList = goodList;
}

#pragma mark ==取消按钮==
-(void)chooseCancel{
    [self removeFromSuperview];
}

#pragma mark ==确认==
- (void)chooseSure{
    [self removeFromSuperview];
    [self.delegate changeModel:_checkModel index:self.tag];

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

-(NSArray*)compares:(NSMutableArray*)data{
       [data sortUsingComparator:^NSComparisonResult(id  obj1, id  obj2) {
          if ([obj1 integerValue] < [obj2 integerValue]){
            return NSOrderedAscending;
          }else{
            return NSOrderedDescending;
          }
           }];
    return data;
}

#pragma mark ==YGoodDetailWayColorCellDelegate==
-(void)chooseType:(NSInteger)idx index:(NSInteger)sender{
    [self checkNull];
    NSMutableArray *counts = [NSMutableArray array];
    for (int i=0; i<_checkModel.goodTypeArr.count; i++) {
        [counts addObject:@""];
    }
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
                [counts removeObjectAtIndex:0];
                break;
            }
        }
    }
    [counts addObject:@""];
    [_checkModel.goodTypeArr addObject:type];
    if (_checkModel.goodTypeArr.count==_model.goodSize.count) {
        for (YGoodTypeModel *tp in _checkModel.goodTypeArr) {
            for (int i=0; i<_model.goodSize.count; i++) {
                YGoodSizeModel *lt = _model.goodSize[i];
                if ([lt.typeName isEqualToString:tp.name]) {
                    [counts replaceObjectAtIndex:i withObject:tp.sizeId];
                }
            }
        }
      NSArray *datas =[self compares:counts];
        NSString *key=datas[0];
        for (int i=1; i<datas.count; i++) {
            key =[key stringByAppendingString:[NSString stringWithFormat:@"_%@",datas[i]]];
        }
        for (YSGoodTypeEditModel *god in _goodList) {
            if ([god.key isEqualToString:key] ) {
                if ([god.stock integerValue]>=[_checkModel.goodCount integerValue]) {
                    _checkModel.goodId = god.goodsId;
                    _checkModel.goodMoney= god.goodMoney;
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_checkModel.goodMoney]];
                    [attr addAttribute:NSFontAttributeName value:MFont(11) range:NSMakeRange(0, 1)];
                    [attr addAttribute:NSFontAttributeName value:MFont(13) range:NSMakeRange(1, attr.length-1)];
                    _priceLb.attributedText = attr;
                }else{
                    [SXLoadingView showAlertHUD:@"该类商品库存不足，请重新选择" duration:0.5];
                }
            }
        }

    }
}

@end
