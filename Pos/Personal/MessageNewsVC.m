//
//  MessageNewsVC.m
//  Pos
//
//  Created by 李立 on 2021/6/24.
//

#import "MessageNewsVC.h"

@interface MessageNewsVC ()

@end

@implementation MessageNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"消息详情";
    [self.view addSubview:titlelabel];
    
    //背景视图
    UIView *witreview = [[UIView alloc]initWithFrame:CGRectMake(0, [self ykNavigationbarAndTopHeight]+20, kScreenWidth, 226)];
    witreview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:witreview];
    
    //标题
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, kScreenWidth, 21)];
    self.titlelabel.font = [UIFont systemFontOfSize:16];
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
    self.titlelabel.text = @"支付伙伴";
    [witreview addSubview:self.titlelabel];
    
    //时间
    self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.titlelabel.bottom+20, kScreenWidth, 16)];
    self.timelabel.textColor = [UIColor colorWithHexString:@"BDBDBD"];
    self.timelabel.text = @"2020-09-12  12:34:55";
    self.timelabel.font = [UIFont systemFontOfSize:14];
    self.timelabel.textAlignment = NSTextAlignmentCenter;
    [witreview addSubview:self.timelabel];
    
    //内容
    self.contelabel = [[UILabel alloc]initWithFrame:CGRectMake(39, self.timelabel.bottom+32, kScreenWidth-39*2, 0)];
    self.contelabel.textColor = [UIColor colorWithHexString:@"B0B0B0"];
    self.contelabel.numberOfLines = 0;
    self.contelabel.font = [UIFont systemFontOfSize:14];
    [witreview addSubview:self.contelabel];
    NSString *contersring = @"   尊敬的服务商您好，根据公司最近战略发展方向，公尊敬的服务商您好，根据公司最近战略发展方向，公尊敬的服务商您好，根据公司最近战略发展方向，公尊敬的服务商您好，根据公司最近战略发展方向，公";
    CGSize baseSize = CGSizeMake(kScreenWidth-39*2, CGFLOAT_MAX);
    CGSize labelsize  = [contersring
                        boundingRectWithSize:baseSize
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}
                        context:nil].size;
    self.contelabel.text = contersring;
    self.contelabel.height = labelsize.height;
}
@end
