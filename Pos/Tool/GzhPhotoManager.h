//
//  GzhPhotoManager.h
//  Pos
//
//  Created by 李立 on 2021/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol gzhPhotoManagerDelegate;
@interface gzhPhotoManager : NSObject

+(instancetype)instance;

/// 选择图片
/// @param controller 当前控制器
/// @param target 代理
/// @param pSize 选择照片尺寸 尺寸传（0，0）不进行裁剪
- (void)selectPhotoWithController:(UIViewController *)controller delegate:(id)target size:(CGSize)pSize;

@end


@protocol gzhPhotoManagerDelegate <NSObject>

- (void)selectedPhotoImage:(UIImage *)image;

@end
NS_ASSUME_NONNULL_END
