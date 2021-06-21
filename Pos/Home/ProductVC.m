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

@property(nonatomic,copy) NSArray *dataList;

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
    {
        self.dataList = @[@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=120863573,3150351979&fm=11&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=120863573,3150351979&fm=11&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=120863573,3150351979&fm=11&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=120863573,3150351979&fm=11&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=120863573,3150351979&fm=11&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=120863573,3150351979&fm=11&gp=0.jpg",@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=120863573,3150351979&fm=11&gp=0.jpg"];
    }
    
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
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
//    [cell.img sd_setImageWithURL:[NSURL URLWithString:self.dataList[indexPath.row]]];
    [self configureCell:cell atIndexPath:indexPath];

    
    return cell;
    
}

- (void)configureCell:(ProductCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *imgURL = self.dataList[indexPath.row];
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgURL];
      
    if ( !cachedImage ) {
        [self downloadImage:self.dataList[indexPath.row] forIndexPath:indexPath];
    } else {
        cell.img.image = cachedImage;
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
- (UIView *)tableView:(UITableView *)tableView viewFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 先从缓存中查找图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: self.dataList[indexPath.row]];
      
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
    
    ProductDoneVC *vc = [ProductDoneVC new];
    [self.navigationController pushViewController:vc animated:YES];
}





@end
