//
//  MyoerderCellTableViewCell.m
//  Pos
//
//  Created by 李立 on 2021/6/26.
//

#import "MyoerderCellTableViewCell.h"

@implementation MyoerderCellTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        [self setui];
//        [self creatViews];
    }
    return self;
}

//初始化视图
-(void)setui{
    
    //背景视图
    UIView *baiseview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 224)];
    baiseview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baiseview];
    
    //订单编号
    self.ordernubuerlabel = [[UILabel alloc]initWithFrame:CGRectMake(26, 15, 300, 19)];
    self.ordernubuerlabel.textColor = [UIColor colorWithHexString:@"#282828"];
    self.ordernubuerlabel.font = [UIFont boldSystemFontOfSize:14];
    self.ordernubuerlabel.text = @"订单号：9999098787";
    [self.contentView addSubview:self.ordernubuerlabel];
    
    //图片
    self.iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake(26, self.ordernubuerlabel.bottom+9, 87, 76)];
    self.iconimageview.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.iconimageview];
    
    //商品名称
    self.namelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconimageview.right+19, self.iconimageview.top+9, 200, 19)];
    self.namelabel.textColor = [UIColor colorWithHexString:@"#282828"];
    self.namelabel.font = [UIFont boldSystemFontOfSize:14];
    self.namelabel.text = @"瑞XX宝MPOS";
    [self.contentView addSubview:self.namelabel];
    
    //价格
    self.picelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconimageview.right+19, self.namelabel.bottom+14, 200, 16)];
    self.picelabel.font = [UIFont boldSystemFontOfSize:14];
    self.picelabel.textColor = [UIColor colorWithHexString:@"#F22323"];
    self.picelabel.text = @"¥ 3000.00";
    [self.contentView addSubview:self.picelabel];
    
    //线条
    UIView *xtview = [[UIView alloc]initWithFrame:CGRectMake(0, self.iconimageview.bottom+14, kScreenWidth, 1)];
    xtview.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self.contentView addSubview:xtview];
    
    //订单号时间
    UILabel *orderlabel = [[UILabel alloc]initWithFrame:CGRectMake(27, xtview.bottom+14, 60, 16)];
    orderlabel.font = [UIFont boldSystemFontOfSize:14];
    orderlabel.text = @"订单时间";
    [self.contentView addSubview:orderlabel];
    
    //时间
    self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(orderlabel.right+17, orderlabel.top, 300, 16)];
    self.timelabel.font = [UIFont systemFontOfSize:14];
    self.timelabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    self.timelabel.text = @"2021.09.12 23:34:23";
    [self.contentView addSubview:self.timelabel];
    
    //线条
    UIView *xtview1 = [[UIView alloc]initWithFrame:CGRectMake(26, self.timelabel.bottom+15, kScreenWidth, 1)];
    xtview1.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self.contentView addSubview:xtview1];
    
    //快递单号
    UILabel *exprlabel = [[UILabel alloc]initWithFrame:CGRectMake(27, xtview1.bottom+14, 60, 16)];
    exprlabel.font = [UIFont boldSystemFontOfSize:14];
    exprlabel.text = @"快递单号";
    [self.contentView addSubview:exprlabel];
    
    //时间
    self.exprnuberlabel = [[UILabel alloc]initWithFrame:CGRectMake(exprlabel.right+17, exprlabel.top, 200, 16)];
    self.exprnuberlabel.font = [UIFont systemFontOfSize:14];
    self.exprnuberlabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    self.exprnuberlabel.text = @"SF9080879089080";
    [self.contentView addSubview:self.exprnuberlabel];
    
    //状态
    self.staslabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-80, 49, 60, 19)];
    self.staslabel.textAlignment = NSTextAlignmentRight;
    self.staslabel.font = [UIFont systemFontOfSize:14];
    self.staslabel.text = @"已完成";
    self.staslabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    [self.contentView addSubview:self.staslabel];
    
    //复制按钮
    self.fzbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fzbutton.frame = CGRectMake(self.exprnuberlabel.right, xtview1.bottom+11, 28, 30);
    [self.fzbutton setImage:[UIImage imageNamed:@"复制"] forState:UIControlStateNormal];
    [self.fzbutton addTarget:self action:@selector(fzbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.fzbutton];
}

//复制按钮
-(void)fzbuttonaciton{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
       pab.string = self.exprnuberlabel.text;
    [MBProgressHUD showSuccess:@"快递单号已复制" toView:self];
}
@end
