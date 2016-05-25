//
//  DMPageControlView.h
//  HRGuideView
//
//  Created by linxiu on 16/5/24.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMPageControlView : UIView
@property (nonatomic,assign) int numberOfPages;//总页数
@property (nonatomic,assign) int currentPage;//当前的页面的点
@property (nonatomic,assign) float PointSize;//点的大小
@property (nonatomic,assign) float distanceOfPoint;//点间距
@property (nonatomic,assign) UIColor * currentPagePointColor;
@property (nonatomic,assign) UIColor * pagePointColor;

//-(float)sizeForNumberOfPages:(NSInteger)pages;

-(void)setNumberOfPages:(NSInteger)pages;
-(void)setCurrentPage:(NSInteger)page;
@end
