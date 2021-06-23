//
//  MessageCell.m
//  Pos
//
//  Created by 李立 on 2021/6/24.
//

#import "MessageCell.h"

@implementation MessageCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        [self setui];
//        [self creatViews];
    }
    return self;
}

-(void)setui{
    //标题
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 26, 280, 19)];
    self.titlelabel.font = [UIFont systemFontOfSize:14];
    self.titlelabel.text = @"支付伙伴最新官方咨询";
    [self.contentView addSubview:self.titlelabel];
    
    //时间
    self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-164, 28, 144, 16)];
    self.timelabel.font = [UIFont systemFontOfSize:14];
    self.timelabel.textColor = [UIColor colorWithHexString:@"BDBDBD"];
    self.timelabel.text = @"2020-09-12  12:34:55";
    [self.contentView addSubview:self.timelabel];
    
    //内容
    self.contelabel = [[UILabel alloc]initWithFrame:CGRectMake(21, self.timelabel.bottom+12, kScreenWidth-94, 19)];
    self.contelabel.textColor = [UIColor colorWithHexString:@"282828"];
    self.contelabel.text = @"尊敬的服务商您好，根据公司最近战略发展方向，公...";
    self.contelabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contelabel];
    
    //分割线
    UIView *fegeview = [[UIView alloc]initWithFrame:CGRectMake(0, self.contelabel.bottom+25, kScreenWidth, 5)];
    fegeview.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    [self.contentView addSubview:fegeview];
    
}

@end
