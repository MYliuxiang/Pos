//
//  RecruitmeCell.m
//  Pos
//
//  Created by 李立 on 2021/6/30.
//

#import "RecruitmeCell.h"

@implementation RecruitmeCell
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
    self.fwslabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 120, 19)];
    self.fwslabel.font = [UIFont boldSystemFontOfSize:14];
    self.fwslabel.text = @"直属服务商XXX";
    [self.contentView addSubview:self.fwslabel];
    
    //台数
    self.tailabel = [[UILabel alloc]initWithFrame:CGRectMake(self.fwslabel.right+15, 20, 80, 19)];
    self.tailabel.font = [UIFont systemFontOfSize:14];
    self.tailabel.text = @"8台";
    self.tailabel.textAlignment = NSTextAlignmentLeft;
    self.tailabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    [self.contentView addSubview:self.tailabel];
    
    //台数
    self.dblabel = [[UILabel alloc]initWithFrame:CGRectMake(self.tailabel.right+21, 20, 80, 19)];
    self.dblabel.font = [UIFont systemFontOfSize:14];
    self.dblabel.text = @"是";
    self.dblabel.textAlignment = NSTextAlignmentLeft;
    self.dblabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    [self.contentView addSubview:self.dblabel];
    
    //价格
    self.piclabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, 20, 80, 19)];
    self.piclabel.font = [UIFont systemFontOfSize:14];
    self.piclabel.text = @"+￥0.23";
    self.piclabel.textAlignment = NSTextAlignmentRight;
    self.piclabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    [self.contentView addSubview:self.piclabel];
    
}

@end
