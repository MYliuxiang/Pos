//
//  MainTabBarController.m
//  MyMovie
//
//  Created by zsm on 14-8-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()<AxcAE_TabBarDelegate>

@end

static MainTabBarController *mainTVC = nil;

@implementation MainTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewControllers];
    mainTVC = self;
    if (@available(iOS 13.0, *)) {
        [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    } else {
        // Fallback on earlier versions
    }if (@available(iOS 12.0, *)) {
        if (@available(iOS 13.0, *)) {
            [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
        } else {
            // Fallback on earlier versions
        }
    } else {
        // Fallback on earlier versions
    }
    
    
}

- (void)addChildViewControllers{
    
    HomeVC *vc1 = [HomeVC new];
    vc1.hidesBottomBarWhenPushed = NO;
    AchievementVC *vc2 = [AchievementVC new];
    vc2.hidesBottomBarWhenPushed = NO;
    MailListVC *vc3 = [MailListVC new];
    vc3.hidesBottomBarWhenPushed = NO;
    PersonalVC *vc4 = [PersonalVC new];
    vc4.hidesBottomBarWhenPushed = NO;
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:vc2];
    BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:vc3];
    BaseNavigationController *nav4 = [[BaseNavigationController alloc] initWithRootViewController:vc4];
    
    NSArray <NSDictionary *>*VCArray;
    VCArray = @[
        @{@"vc":nav1,@"itemTitle":@"首页",@"selectImg":@"首页(1)",@"normalImg":@"首页"},
        @{@"vc":nav2,@"itemTitle":@"业绩",@"selectImg":@"业绩",@"normalImg":@"业绩(1)"},
        
        @{@"vc":nav3,@"itemTitle":@"通讯录",@"selectImg":@"通讯录(1)",@"normalImg":@"通讯录"},
        @{@"vc":nav4,@"itemTitle":@"我的",@"selectImg":@"个人中心-1",@"normalImg":@"个人中心"}];
    
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    NSMutableArray *tabBarVCs = @[].mutableCopy;
      
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        // 3.item基础数据三连
        model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTopPictureBottomTitle;
        model.titleLabel.font = [UIFont systemFontOfSize:10];
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        // 4.设置单个选中item标题状态下的颜色
        model.selectColor = [UIColor colorWithHexString:@"#232323"];
        model.normalColor = [UIColor colorWithHexString:@"#C4C4C4"];
        model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleNormal;
            
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了
        BaseNavigationController *nav = [obj objectForKey:@"vc"];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:nav];
        
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.viewControllers = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
    //    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 6.2 使用Set方式：
    self.axcTabBar = [AxcAE_TabBar new] ;
    self.axcTabBar.tabBarConfig = tabBarConfs;
    
    // 7.设置委托
    self.axcTabBar.delegate = self;
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.axcTabBar];
    
    //    [self.tabBar setShadowImage:[UIImage imageWithColor:[MyColor colorWithHexString:@"#F1F1F8"]]];
    [self.tabBar setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, kScreenWidth, 1)];
//        view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F8"];
//    [[UITabBar appearance] insertSubview:view atIndex:0];
    
    [self addLayoutTabBar]; // 10.添加适配
}


// 9.实现代理，如下：
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    // 通知 切换视图控制器
    
    
    
    if (index == 5) {
        
        
        
        [self.axcTabBar setSelectIndex:_lastIdx WithAnimation:NO]; // 换回上一个选中状态
        
        
        
    }else{
        
        [self setSelectedIndex:index];
        _lastIdx = index;
    }
    
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar){
        self.axcTabBar.selectIndex = selectedIndex;
    }
}

// 10.添加适配
- (void)addLayoutTabBar{
    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
    // 能兼容转屏时的自动布局
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

//单例方法
+ (instancetype)shareMainTabBarController
{
    return mainTVC;
    
}

+ (void)clearMainTabBarVC
{
    mainTVC = nil;
}


@end
