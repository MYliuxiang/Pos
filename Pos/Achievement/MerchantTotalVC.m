//
//  MerchantTotalVC.m
//  Pos
//
//  Created by tenvine on 2021/6/25.
//

#import "MerchantTotalVC.h"
#import "TradeDCell.h"
#import "TradeDSubCell.h"

@interface MerchantTotalVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation MerchantTotalVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"商户总数";
    
    [self loadData];


}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    
    NSString *url;
    if (self.type == 0) {
        url = Url_proxyResults_mercList;
    }else{
        url = Url_proxyResults_mercListMonth;
    }
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,url];
    entity.needCache = NO;
    entity.parameters = @{@"id":self.agentModel.aid,@"time":self.model.time};
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
//
//            [self.values addObject: [NSString stringWithFormat:@"%@",result[@"data"][@"sum"]]];
//            [self.values addObject: [NSString stringWithFormat:@"%@",result[@"data"][@"directlySum"]]];
//            [self.values addObject: [NSString stringWithFormat:@"%@",result[@"data"][@"teamSum"]]];

            [self.tableView reloadData];
          
        }
        
    } failureBlock:^(NSError *error) {
      

        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [UIView new];
        lineView.frame = CGRectMake(0, 61, kScreenWidth, 1);
        lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [cell.contentView addSubview:lineView];
        
    }
//    cell.lab1.text = self.titles[indexPath.row];
    cell.lab1.textColor = [UIColor colorWithHexString:@"#232323"];
    cell.lab1.font = [UIFont boldSystemFontOfSize:14];

    cell.lab2.text = @"33";
    cell.lab2.textColor = [UIColor colorWithHexString:@"#BDBDBD"];

    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = @"当日总交易额";
    label.textColor = [UIColor colorWithHexString:@"#FF8901"];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.top.bottom.equalTo(view);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"275";
    label1.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    label1.backgroundColor = [UIColor clearColor];
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-20);
        make.top.bottom.equalTo(view);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.bottom.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}








@end
