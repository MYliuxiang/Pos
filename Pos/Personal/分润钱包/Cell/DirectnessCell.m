//
//  DirectnessCell.m
//  Pos
//
//  Created by 李立 on 2021/6/29.
//

#import "DirectnessCell.h"

@implementation DirectnessCell

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
    
    //商户
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 13, 100, 19)];
    self.label1.text = @"XX商户";
    self.label1.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:self.label1];
    
    //价格
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 13, kScreenWidth, 19)];
    self.label2.text = @"￥250.00";
    self.label2.font = [UIFont systemFontOfSize:14];
    self.label2.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    self.label2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label2];
    
    //正负
    self.label3 =  [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-220, 13, 200, 19)];
    self.label3.text = @"+￥0.23";
    self.label3.font = [UIFont systemFontOfSize:14];
    self.label3.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    self.label3.textAlignment =NSTextAlignmentRight;
    [self.contentView addSubview:self.label3];
    
    //品牌
    self.label4 =[[UILabel alloc]initWithFrame:CGRectMake(20, self.label1.bottom+14, 100, 19)];
    self.label4.text = @"XX品牌";
    self.label4.font = [UIFont systemFontOfSize:14];
    self.label4.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    [self.contentView addSubview:self.label4];
    
    //借记卡
    self.label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.label1.bottom+14, kScreenWidth, 19)];
    self.label5.text = @"借记卡支付";
    self.label5.font = [UIFont systemFontOfSize:14];
    self.label5.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    self.label5.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label5];
    
    //时间
    self.label6 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-220, self.label1.bottom+14, 200, 19)];
    self.label6.text = @"2021.02.23  12:23";
    self.label6.font = [UIFont systemFontOfSize:14];
    self.label6.textAlignment =NSTextAlignmentRight;
    self.label6.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    [self.contentView addSubview:self.label6];
    
}
@end
