//
//  AdressModel.h
//  Pos
//
//  Created by 刘翔 on 2021/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdressModel : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *adress;
@property(nonatomic,copy) NSString *adressDetail;
@property(nonatomic,assign) BOOL isDefalut;



@end

NS_ASSUME_NONNULL_END
