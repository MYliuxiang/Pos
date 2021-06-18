//
//  DataShowCell.m
//  Pos
//
//  Created by tenvine on 2021/6/18.
//

#import "DataShowCell.h"
@interface DataShowCell ()

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;


/** 横线 */
@property (nonatomic, strong) UIView *lineView;

/** 图标 */
@property (nonatomic, strong) UIImageView *iconImageView;

/** 按钮 */
@property (nonatomic, strong) UIButton *btn;

@end

@implementation DataShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.iconImageView];
        self.backgroundColor = [UIColor whiteColor];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0.5);
                    make.left.right.equalTo(self.contentView);
                    make.bottom.equalTo(self.contentView);
        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
        }];
        
    }
    return self;
}



- (UILabel *)titleLabel
{
    if (!_titleLabel) {
                
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, kScreenWidth - 42, 44)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        _lineView.backgroundColor = Color_line;

    }
    return _lineView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_down_icon"]];
        _iconImageView.size = CGSizeMake(12, 7);
        _iconImageView.right = kScreenWidth - 20;
    }
    return _iconImageView;
}

- (UIButton *)btn
{
    if (!_btn) {
        self.btn = [[UIButton alloc] init];
        [_btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _btn.backgroundColor = [UIColor clearColor];
    }
    return _btn;
}

#pragma mark - < 布局子控件 >

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - < 点击事件 >

- (void)selectBtnClick:(UIButton *)sender
{
//    if ([self.delegate respondsToSelector:@selector(cell:didSelectedBtn:)]) {
//        [self.delegate cell:self didSelectedBtn:sender];
//    }
}

#pragma mark - < set >

- (void)setModel:(DataModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
        
    self.iconImageView.hidden = !model.isCanUnfold;
    
    self.iconImageView.image = model.isUnfold ? [UIImage imageNamed:@"向下(2)"] : [UIImage imageNamed:@"向下(1)"];
    
   
    
    if (model.isCanUnfold) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(13);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-13);

        }];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        self.lineView.hidden = NO;

    }else{
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView).offset(46);
            make.top.bottom.equalTo(self.contentView).offset(10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);

        }];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#818181"];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.lineView.hidden = YES;

    }

}

@end
