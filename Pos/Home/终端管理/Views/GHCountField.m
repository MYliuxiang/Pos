//
//  GHCountField.m
//  GHCountTextField
//
//  Created by GHome on 2018/1/25.
//  Copyright © 2018年 GHome. All rights reserved.
//

#define kShowMessage(msg) [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
#import "GHCountField.h"
@interface GHButton()


@end
@implementation GHButton
- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
@interface GHCountField()<UITextFieldDelegate>



@end
@implementation GHCountField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
   
      
        self.leftButton = [GHButton buttonWithType:UIButtonTypeCustom];
        [self.leftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftButton setImage:[UIImage imageNamed:@"矩形 242"] forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"矩形 157"] forState:UIControlStateDisabled];
        self.leftButton.tag = GHCountFieldButtonType_sub;
        [self addSubview:self.leftButton];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.width.height.mas_equalTo(self.mas_height);
            make.left.equalTo(self);
        }];
       
        self.rightButton = [GHButton buttonWithType:UIButtonTypeCustom];
        [self.rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton setImage:[UIImage imageNamed:@"联合 3"] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"联合 2"] forState:UIControlStateDisabled];
        self.rightButton.tag = GHCountFieldButtonType_add;
        [self addSubview:self.rightButton];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.mas_height);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self);

        }];

       
        
        self.textField = [[UITextField alloc] init];
        LXViewBorder(self.textField, 5);
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        self.textField.delegate = self;
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightButton.mas_left).offset(-5);
            make.left.equalTo(self.leftButton.mas_right).offset(5);
            make.top.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
        self.minCount = 1;
        
//   8
        
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];

}

- (void)textChange: (NSNotification *)noti {
    
    NSInteger count = self.textField.text.integerValue;

    if (count >= self.maxCount) {
        self.rightButton.enabled = NO;
        self.leftButton.enabled = YES;
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)self.maxCount];
    }else if (count <= self.minCount) {
        self.leftButton.enabled = NO;
        self.rightButton.enabled = YES;
//        self.textField.text = [NSString stringWithFormat:@"%ld",(long)self.minCount];


    } else if (count < self.maxCount && count > self.minCount) {
        self.leftButton.enabled = YES;
        self.rightButton.enabled = YES;
    }
    
    if (self.countFielddDelegate && [self.countFielddDelegate respondsToSelector:@selector(countField:count:)]) {
        [self.countFielddDelegate countField:self count:self.textField.text.integerValue];
    }
    
    if (self.countBlock) {
        self.countBlock(self.textField.text.integerValue);
    }
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger count = self.textField.text.integerValue;

    if (count >= self.maxCount) {
        self.rightButton.enabled = NO;
        self.leftButton.enabled = YES;
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)self.maxCount];
    }else if (count <= self.minCount) {
        self.leftButton.enabled = NO;
        self.rightButton.enabled = YES;
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)self.minCount];

    } else if (count < self.maxCount && count > self.minCount) {
        self.leftButton.enabled = YES;
        self.rightButton.enabled = YES;
    }
    
    if (self.countFielddDelegate && [self.countFielddDelegate respondsToSelector:@selector(countField:count:)]) {
        [self.countFielddDelegate countField:self count:self.textField.text.integerValue];
    }
    
    if (self.countBlock) {
        self.countBlock(self.textField.text.integerValue);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}
- (void)setCount:(NSInteger)count {
    _count = count;
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)count];
    if (count >= self.maxCount) {
        self.rightButton.enabled = NO;
        self.leftButton.enabled = YES;
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)self.maxCount];
    }else if (count <= self.minCount) {
        self.leftButton.enabled = NO;
        self.rightButton.enabled = YES;
        self.textField.text = [NSString stringWithFormat:@"%ld",(long)self.minCount];

    } else if (count < self.maxCount && count > self.minCount) {
        self.leftButton.enabled = YES;
        self.rightButton.enabled = YES;
    }
    
    
    
}
- (void)clickButton: (UIButton *)button {
    button.selected = !button.selected;
    NSInteger count = self.textField.text.integerValue;

    if (button.tag == GHCountFieldButtonType_add) {
        if (count < self.maxCount) {
            count++;
            button.enabled = YES;
            
            if (count ==self.maxCount) {
                button.enabled = NO;
            }
            self.leftButton.enabled = YES;

        }
    } else if (button.tag == GHCountFieldButtonType_sub) {
        if (count > self.minCount) {
            count--;
            if (count == self.minCount) {
                button.enabled = NO;

            }
            self.rightButton.enabled = YES;

        } else {
            button.enabled = YES;
        }
    }
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)count];

    if (self.countFielddDelegate && [self.countFielddDelegate respondsToSelector:@selector(countField:count:)]) {
        [self.countFielddDelegate countField:self count:self.textField.text.integerValue];
    }
    
    if (self.countBlock) {
        self.countBlock(self.textField.text.integerValue);
    }
}
- (instancetype)init {
    if (self == [super init]) {
        
    }
    return self;
}


@end
