//
//  ServiceVC.m
//  Pos
//
//  Created by tenvine on 2021/6/25.
//

#import "ServiceVC.h"

@interface ServiceVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,strong) NSMutableArray *values;
@end

@implementation ServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"服务商总数";
    self.bottomView.hidden = YES;
    self.titles = @[@"服务商总数",@"直属服务商",@"服务商团队"];
    self.values = [NSMutableArray array];
    [self loadData];
        
}

- (void)loadData{
    BADataEntity *entity = [BADataEntity new];
    
    NSString *url;
    if (self.type == 0) {
        url = Url_proxyResults_serviceSum;
    }else{
        url = Url_proxyResults_serviceSumMonth;
    }
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,url];
    entity.needCache = NO;
    entity.parameters = @{@"id":self.agentModel.aid,@"time":self.model.time};
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
           
            [self.values addObject: [NSString stringWithFormat:@"%@",result[@"data"][@"sum"]]];
            [self.values addObject: [NSString stringWithFormat:@"%@",result[@"data"][@"directlySum"]]];
            [self.values addObject: [NSString stringWithFormat:@"%@",result[@"data"][@"teamSum"]]];

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
    
    return self.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    LxSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LxSubTitleCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.lab1.text = self.titles[indexPath.row];
    cell.lab2.text = @"33";
    cell.lab1.textColor = [UIColor colorWithHexString:@"#232323"];
    cell.lab1.font = [UIFont boldSystemFontOfSize:14];

    cell.lab2.textColor = [UIColor colorWithHexString:@"#BDBDBD"];

    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 20;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
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
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
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
