//
//  ProductVC.m
//  Pos
//
//  Created by 刘翔 on 2021/6/21.
//

#import "ProductVC.h"
#import "ProductDoneVC.h"

@interface ProductVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buyB;


@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"商品详情";
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 100;
    self.bottomView.hidden = YES;
    self.buyB.layer.cornerRadius = 22;
    self.buyB.layer.masksToBounds = YES;
    
    [self.buyB setTitle:[NSString stringWithFormat:@"￥%.f",self.model.price] forState:UIControlStateNormal];
    
    
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.model.itemImgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
//    [cell.img sd_setImageWithURL:[NSURL URLWithString:self.model.itemImgs[indexPath.row]]];
    [self configureCell:cell atIndexPath:indexPath];

    
    return cell;
    
}

- (void)configureCell:(ProductCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *imgURL = self.model.itemImgs[indexPath.row];
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgURL];
      
    if ( !cachedImage ) {
        [self downloadImage:self.model.itemImgs[indexPath.row] forIndexPath:indexPath];
    } else {
//        cell.img.image = cachedImage;
        [cell.btn setBackgroundImage:cachedImage forState:UIControlStateNormal];

    }
}

- (void)downloadImage:(NSString *)imageURL forIndexPath:(NSIndexPath *)indexPath {
    
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            [[SDImageCache sharedImageCache] storeImage:image forKey:imageURL toDisk:YES completion:^{
                            
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    
    
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 先从缓存中查找图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: self.model.itemImgs[indexPath.row]];
      
    // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了，除了高度不固定的文字部分。
    if (!image) {
        return 100;
    }
  
    //手动计算cell
    CGFloat imgHeight = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
    return imgHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


- (IBAction)bugAC:(id)sender {
    
  
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_address_default];
    entity.needCache = NO;
    [MBProgressHUD showHUDAddedTo:lxMbProgressView animated:YES];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 200){
            
            AdressModel *amodel = [AdressModel mj_objectWithKeyValues:result[@"data"]];
            ProductDoneVC *vc = [ProductDoneVC new];
            vc.smodel = self.model;
            vc.amodel = amodel;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    } failureBlock:^(NSError *error) {

    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
    
}





@end
