//
//  SearchTerminalVC.m
//  Pos
//
//  Created by 刘翔 on 2021/7/2.
//

#import "SearchTerminalVC.h"
#import "TerSearchCell.h"
#import "TerminalSDetailVC.h"

@interface SearchTerminalVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,copy) NSString *keyword;
@property (nonatomic,copy) NSArray *dataList;

@end

@implementation SearchTerminalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"搜索";
    [self setUI];
}

- (void)setUI{
   
        
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BBBBBB"],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.textField.attributedPlaceholder = attrString;
    
    [self.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIView *rightView = [[UIView alloc]init];
    rightView.size = CGSizeMake(44, 44);
    rightView.contentMode = UIViewContentModeCenter;
    UIImageView *rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"搜索"];
    rightImage.frame = CGRectMake(11, 11, 20, 20);
    [rightView addSubview:rightImage];
    self.textField.rightView = rightView;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc]init];
    leftView.size = CGSizeMake(22 , 22);
    leftView.contentMode = UIViewContentModeCenter;
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    LXViewBorder(self.textField, 5);
   
  
}

- (void)textFieldChange:(UITextField *)textField{
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

        NSString *handleStr =  [self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (handleStr.length == 0) {
            self.textField.text = handleStr;
            return;
        }
    self.keyword = handleStr;
    [self performSelector:@selector(searchAC) withObject:nil afterDelay:1.f];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    //搜索操作
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];

    [self searchAC];
    return YES;
}



- (void)searchAC{

    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_devicec_query];
    entity.needCache = NO;
    entity.parameters = @{@"deviceNo":self.keyword};
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200) {
            
            self.dataList = [TerminalModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"rows"]];
            self.pageNum++;
            [self.tableView reloadData];
          
        }
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        
    } failureBlock:^(NSError *error) {
      
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];

        
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
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    TerSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TerSearchCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.model = self.dataList[indexPath.row];
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TerminalSDetailVC *vc =[TerminalSDetailVC new];
    vc.model = self.dataList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
