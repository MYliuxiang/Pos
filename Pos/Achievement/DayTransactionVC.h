//
//  DayTransactionVC.h
//  Pos
//
//  Created by tenvine on 2021/6/25.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DayTransactionVC : BaseViewController
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) AgentDataModel *model;
@property (nonatomic,strong) AgentModel *agentModel;

@end

NS_ASSUME_NONNULL_END
