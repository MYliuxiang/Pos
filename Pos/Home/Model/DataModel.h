//
//  DataModel.h
//  Pos
//
//  Created by tenvine on 2021/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject

@property(nonatomic,copy) NSString *number;
@property(nonatomic,copy) NSString *total;
@property(nonatomic,copy) NSArray *children;

@end

@interface DataChildrenModel : NSObject

@property(nonatomic,copy) NSString *did;
@property(nonatomic,copy) NSString *manageDivide;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *number;
@property(nonatomic,copy) NSString *phone;
@end

NS_ASSUME_NONNULL_END
