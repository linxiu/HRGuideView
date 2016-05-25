//
//  DMPageControlView.m
//  HRGuideView
//
//  Created by linxiu on 16/5/24.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "DMPageControlView.h"

#define DMScreenWidth [UIScreen mainScreen].bounds.size.width
#define DMScreenHeight [UIScreen mainScreen].bounds.size.height
#define DMRGB(r, g, b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
@implementation DMPageControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(float)sizeForNumberOfPages:(NSInteger)pages{
    return _distanceOfPoint*(pages+1) + _PointSize*pages;
}

-(void) setNumberOfPages:(NSInteger)pages{
    for (int i = 0; i < pages; i++) {
        UIImageView * pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake([self sizeForNumberOfPages:i], (self.frame.size.height-_PointSize)/2, _PointSize, _PointSize)];
        [self addSubview:pointImageView];
    }
    
    CGRect frame = self.frame;
    frame.size.width = [self sizeForNumberOfPages:pages];
    self.frame = frame;
    CGPoint center = self.center;
    center.x = DMScreenWidth/2;
    self.center = center;
    
    [self setCurrentPage:0];
}

- (void) setCurrentPage:(NSInteger)page {
    int countOfPages = [self.subviews count];
    for (NSUInteger subviewIndex = 0; subviewIndex < countOfPages; subviewIndex++) {
        UIImageView *subview = [self.subviews objectAtIndex:subviewIndex];
        subview.layer.cornerRadius = subview.frame.size.width/2;
        subview.layer.masksToBounds = YES;
        
        if (subviewIndex == page) {
            //            subview.image = [UIImage imageNamed:@"页面指示器_当前页"];
            subview.backgroundColor = DMRGB(255, 118, 118);
        }else{
            //            subview.image = [UIImage imageNamed:@"页面指示器_非当前页"];
            subview.backgroundColor = DMRGB(255, 255, 255);
        }
    }
}


@end
