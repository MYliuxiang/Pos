//
//  UITextField+TintColor.m
//  Pos
//
//  Created by 刘翔 on 2021/6/25.
//

#import "UITextField+TintColor.h"
#import "SwizzlingDefine.h"

@implementation UITextField (TintColor)

+ (void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        swizzling_exchangeMethod([UITextField class], @selector(initWithCoder:), @selector(swizzling_initWithCoder:));
    swizzling_exchangeMethod([UITextField class], @selector(init),
                                 @selector(swizzling_init));


    });
   
}

- (instancetype)swizzling_init
{
    id instance = [self swizzling_init];
    if (instance) {

        self.tintColor = TextFieldTintColor;
       
    }
    return instance;
    
}

- (instancetype)swizzling_initWithCoder:(NSCoder *)aDecoder
{
    id instance = [self swizzling_initWithCoder:aDecoder];
    if (instance) {
        
        self.tintColor = TextFieldTintColor;
    }
    return instance;
}



@end
