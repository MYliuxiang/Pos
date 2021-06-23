//
//  TerminalBatchVC.m
//  Pos
//
//  Created by tenvine on 2021/6/23.
//

#import "TerminalBatchVC.h"
#import "GHCountField.h"
#import "TerminalBatchDoneVC.h"

@interface TerminalBatchVC ()
@property (weak, nonatomic) IBOutlet UILabel *startL;
@property (weak, nonatomic) IBOutlet UIButton *number1B;
@property (weak, nonatomic) IBOutlet UIButton *number2B;
@property (weak, nonatomic) IBOutlet UIButton *number3B;
@property (weak, nonatomic) IBOutlet UIButton *doneB;
@property (nonatomic,strong) GHCountField *field;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation TerminalBatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"终端划拨";
    [self setUI];
    
    
}

- (void)setUI{
    LXViewBorder(self.number1B, 5);
    LXViewBorder(self.number2B, 5);
    LXViewBorder(self.number3B, 5);
    LXViewBorder(self.doneB, 22);
    
    self.field = [[GHCountField alloc] init];
    self.field.minCount = 1;
    self.field.maxCount = 50;
    self.field.count = 5;
    [self.bgView addSubview:self.field];
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.startL.mas_bottom).offset(24);
            make.left.right.equalTo(self.bgView).offset(20);
           make.right.equalTo(self.bgView).offset(-20);
        make.height.mas_equalTo(44);

    }];
    

    
}

- (IBAction)numberAC:(UIButton *)sender {
}


- (IBAction)doneAC:(id)sender {
    
    TerminalBatchDoneVC *vc = [TerminalBatchDoneVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
