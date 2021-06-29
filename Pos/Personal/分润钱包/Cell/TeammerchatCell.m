//
//  TeammerchatCell.m
//  Pos
//
//  Created by 李立 on 2021/6/29.
//

#import "TeammerchatCell.h"

@implementation TeammerchatCell

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
    //标题
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 13, 100, 19)];
    self.titlelabel.font = [UIFont boldSystemFontOfSize:14];
    self.titlelabel.text = @"XX直属代理";
    [self.contentView addSubview:self.titlelabel];
    
    //时间
    self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 13, kScreenWidth, 19)];
    self.timelabel.font = [UIFont systemFontOfSize:14];
    self.timelabel.text = @"2021.02.23  12:23";
    self.timelabel.textAlignment = NSTextAlignmentCenter;
    self.timelabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    [self.contentView addSubview:self.timelabel];
    
    //价格
    self.piclabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-220, 13, 200, 19)];
    self.piclabel.font = [UIFont systemFontOfSize:14];
    self.piclabel.text = @"+￥0.23";
    self.piclabel.textAlignment = NSTextAlignmentRight;
    self.piclabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    [self.contentView addSubview:self.piclabel];
    
    
}
@end
