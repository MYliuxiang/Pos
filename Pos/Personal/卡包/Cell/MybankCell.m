//
//  MybankCell.m
//  Pos
//
//  Created by 李立 on 2021/6/27.
//

#import "MybankCell.h"

@implementation MybankCell
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
    
    //银行卡图片
    UIImageView *kapianimageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 148)];
    kapianimageview.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:kapianimageview];
    
    //银行图标
    self.iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake(30, 40, 66, 66)];
    KViewBorderRadius(self.iconimageview, 33, 0.5, [UIColor clearColor]);
    self.iconimageview.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.iconimageview];
    
    //银行名称
    self.namelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconimageview.right+8, 40, 100, 20)];
    self.namelabel.font = [UIFont boldSystemFontOfSize:14];
    self.namelabel.textColor = [UIColor whiteColor];
    self.namelabel.text = @"中信银行";
    [self.contentView addSubview:self.namelabel];
    
    //卡片类型
    self.katypelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.namelabel.left, self.namelabel.bottom+5, 100, 19)];
    self.katypelabel.font = [UIFont systemFontOfSize:14];
    self.katypelabel.textColor = [UIColor whiteColor];
    self.katypelabel.text = @"信用卡";
    [self.contentView addSubview:self.katypelabel];
    
    //卡号
    self.nuberlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.katypelabel.left, self.katypelabel.bottom+20, 300, 20)];
    self.nuberlabel.font = [UIFont boldSystemFontOfSize:14];
    self.nuberlabel.textColor = [UIColor whiteColor];
    self.nuberlabel.text = @"**** **** **** 1154";
    [self.contentView addSubview:self.nuberlabel];
    
}

@end
