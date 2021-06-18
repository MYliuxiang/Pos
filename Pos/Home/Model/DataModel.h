//
//  DataModel.h
//  Pos
//
//  Created by tenvine on 2021/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject
/** 名字 */
@property (nonatomic, strong) NSString *title;
/** 子层 */
@property (nonatomic, strong) NSArray<DataModel *> *subs;

/** 是否展开 */
@property (nonatomic, assign) BOOL isUnfold;

/** 是否能展开 */
@property (nonatomic, assign) BOOL isCanUnfold;


@end

NS_ASSUME_NONNULL_END
