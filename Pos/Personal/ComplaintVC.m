//
//  ComplaintVC.m
//  Pos
//
//  Created by 李立 on 2021/6/22.
//

#import "ComplaintVC.h"
#import "PhoneCell.h"
#define MAXSTRINGLENGTH 260   //限定输入长度

@interface ComplaintVC ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UILabel *label1;
}

@end

@implementation ComplaintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

//初始化视图
-(void)setUI{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [self ykStatusbarHeight]+12, kScreenWidth, 21)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont boldSystemFontOfSize:16];
    titlelabel.text = @"投诉建议";
    [self.view addSubview:titlelabel];
    
    //详细问题
    UILabel *infotlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, [self ykNavigationbarAndTopHeight]+20, 200, 21)];
    infotlabel.text = @"详细问题或建议";
    infotlabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:infotlabel];
    
    //白色背景视图
    UIView *baiseview = [[UIView alloc]initWithFrame:CGRectMake(0, infotlabel.bottom+5, kScreenWidth, 226)];
    baiseview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baiseview];
    
    //文本输入框
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 8, baiseview.width-30, baiseview.height-30)];
    _textViewH = baiseview.height-30;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.delegate = self;
//    _textView.backgroundColor =[UIColor colorWithHexString:@"#F5F6FB"];
    _textView.textAlignment = NSTextAlignmentLeft;
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(11, 0, 300, 30)];
    label1.text = @"请输入您的反馈意见";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor grayColor];
    //    label1.backgroundColor = [UIColor redColor];
    [_textView addSubview:label1];
    [baiseview addSubview:_textView];
    
    //当前还能输入多少字
    _surplusLbl = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-85, baiseview.bottom-20, 30, 12)];
    _surplusLbl.font = [UIFont systemFontOfSize:12];
    _surplusLbl.text = @"0";
    _surplusLbl.textColor = [UIColor colorWithHexString:@"999999"];
    _surplusLbl.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_surplusLbl];
    UILabel *zuidalabel = [[UILabel alloc]initWithFrame:CGRectMake(_surplusLbl.right,_surplusLbl.top, 40, 12)];
    zuidalabel.text = @"/260";
    zuidalabel.textColor = [UIColor colorWithHexString:@"999999"];
    zuidalabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:zuidalabel];
    //最大输入字数
    _maxLength = 200;
    
    //请提供
    UILabel *tigonglabel = [[UILabel alloc]initWithFrame:CGRectMake(20, baiseview.bottom+18, 240, 19)];
    tigonglabel.font = [UIFont systemFontOfSize:14];
    tigonglabel.textColor = [UIColor colorWithHexString:@"9E9E9E"];
    tigonglabel.text = @"请提供相关问题的截图或照片";
    [self.view addSubview:tigonglabel];
    
    //colltionview   滑动控件
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
     
          // 设置item的行间距和列间距
         layout.minimumInteritemSpacing = 0;
         layout.minimumLineSpacing = 0;
     
          // 设置item的大小
//          CGFloat itemW = kScreenWidth / 2.5 ;
         layout.itemSize = CGSizeMake(96, 88);
    
         // 设置每个分区的 上左下右 的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);
//        layout.footerReferenceSize = CGSizeMake(KScreen_Width, 300);

         // 设置区头和区尾的大小
//         layout.headerReferenceSize = CGSizeMake(kScreenWidth, 65);
//         layout.footerReferenceSize = CGSizeMake(kScreenWidth, 65);
    
         // 设置分区的头视图和尾视图 是否始终固定在屏幕上边和下边
         layout.sectionFootersPinToVisibleBounds = YES;
    
         // 设置滚动条方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(16, tigonglabel.bottom+10,kScreenWidth-32, 130) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;  //滚动使能
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //3、添加到控制器的view
    [self.view addSubview:self.collectionView];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];

    [self.collectionView registerClass:[PhoneCell class] forCellWithReuseIdentifier:@"PhoneCell"];
    
    //提交按钮
    UIButton *actionbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionbutton.frame = CGRectMake((kScreenWidth-335)/2, self.collectionView.bottom+130, 335, 44);
    actionbutton.backgroundColor = [UIColor colorWithHexString:@"FF8901"];
    [actionbutton setTitle:@"提交" forState:UIControlStateNormal];
    [actionbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    KViewBorderRadius(actionbutton, 22, 0.5, [UIColor clearColor]);
    actionbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [actionbutton addTarget:self action:@selector(actionbutton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionbutton];
    
}
//文本开始编辑的响应事件
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
    label1.hidden = YES;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([_textView.text isEqualToString:@""]) {
        label1.hidden = NO;
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSString *lang = [[[UITextInputMode activeInputModes] firstObject] primaryLanguage];//当前的输入模式
    if ([lang isEqualToString:@"zh-Hans"])
    {
        UITextRange *range = [textView markedTextRange];
        UITextPosition *start = range.start;
        UITextPosition*end = range.end;
        NSInteger selectLength = [textView offsetFromPosition:start toPosition:end];
        NSInteger contentLength = textView.text.length - selectLength;
        
        if (contentLength > MAXSTRINGLENGTH)
        {
            textView.text = [textView.text substringToIndex:MAXSTRINGLENGTH];
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"最长限制260个字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        }
        if (contentLength < MAXSTRINGLENGTH)
        {
            _surplusLbl.text = [NSString stringWithFormat:@"%ld", (long)contentLength];
        }
        else
        {
            _surplusLbl.text = @"0";
        }
    }
    else
    {
        if (textView.text.length > MAXSTRINGLENGTH)
        {
            textView.text = [textView.text substringToIndex:MAXSTRINGLENGTH];
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"最长限制260个字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
            
        }
        _surplusLbl.text = [NSString stringWithFormat:@"%ld", textView.text.length];
    }
}

// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
     

    }
    return reusableView;
}
#pragma mark -collectionview 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;   //返回section数
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (_imagearry.count >3) {
//        return 3;
//    }
//    return _imagearry.count+1;  //每个section的Item数
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    创建item / 从缓存池中拿 Item
    PhoneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhoneCell" forIndexPath:indexPath];
    // 外界在此给Item添加模型数据
  
   
//
//        [cell setmodel:model];
//    }
    return cell;
    
}

#pragma mark - 点击 某个Item时 调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//     [collectionView deselectItemAtIndexPath:indexPath animated:YES];//取消选中
            //选中之后的cell变颜色
     
//            [self.collectionView reloadData];
    
 }

//提交按钮
-(void)actionbutton{
    
    
}
@end
