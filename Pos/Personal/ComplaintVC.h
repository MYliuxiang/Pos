//
//  ComplaintVC.h
//  Pos
//
//  Created by 李立 on 2021/6/22.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComplaintVC : BaseViewController
@property (nonatomic, strong)  UITextView *textView;
@property (assign, nonatomic) CGFloat textViewH; // 初始化时的textView高度
@property (assign, nonatomic) NSInteger maxLength; // 最大文字长度
@property (strong, nonatomic) UILabel *surplusLbl; // 剩余可输入字数
@property (nonatomic,strong) UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
