//
//  MerchantModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchantModel : NSObject

@property(nonatomic,copy) NSString *deviceNo;
@property(nonatomic,copy) NSString *mercId;
@property(nonatomic,copy) NSString *mercName;
@property(nonatomic,copy) NSString *mercPhone;       

@end

NS_ASSUME_NONNULL_END
