//
//  TerSearchCell.h
//  Pos
//
//  Created by tenvine on 2021/6/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerSearchCell : UITableViewCell
@property(nonatomic,strong) TerminalModel *model;

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *numberL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;



@end

NS_ASSUME_NONNULL_END
