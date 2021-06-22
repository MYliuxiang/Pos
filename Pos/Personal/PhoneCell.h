//
//  PhoneCell.h
//  HMOnlineRetailers
//
//  Created by 李立 on 2021/1/12.
//  Copyright © 2021 luopinchao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PhoneModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol PhonecellDelegate <NSObject>
//-(void)delectimage:(PhoneModel *)model;
@end
@interface PhoneCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UIButton *delectbutton;
//@property (nonatomic,strong) PhoneModel *model;

@property(nonatomic,weak)id<PhonecellDelegate>phonecellDelegate;

//-(void)setimagearry:(PhoneModel *)model;
@end

NS_ASSUME_NONNULL_END
