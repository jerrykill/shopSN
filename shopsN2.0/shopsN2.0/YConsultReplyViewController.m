//
//  YConsultReplyViewController.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YConsultReplyViewController.h"
#import "YGoodConsultCell.h"

@interface YConsultReplyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) YPopView *popV;

@property (strong,nonatomic) UITableView *tableV;


@end

@implementation YConsultReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品咨询";
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
}
#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGoodConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGoodConsultCell"];
    if (!cell) {
        cell = [[YGoodConsultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGoodConsultCell"];
    }
    YGoodsConsultationModel *model = [[YGoodsConsultationModel alloc]init];
    model.content = @"质量怎么样？之扥洗很悲的金额UI？";
    model.answer =@"我么的上册的互动尿素的和UI到呢不会测UC吧沪迪士尼的是不吃不此时不出版社";
    model.addTime = @"12345617";
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = @"质量怎么样？之扥洗很悲的金额UI？";
    CGSize size  =[title boundingRectWithSize:CGSizeMake(__kWidth-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(16)} context:nil].size;
    NSString *detail = @"我么的上册的互动尿素的和UI到呢不会测UC吧沪迪士尼的是不吃不此时不出版社";
    CGSize size1  =[detail boundingRectWithSize:CGSizeMake(__kWidth-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(14)} context:nil].size;
    CGFloat height = size.height+size1.height+70;
    return height;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
