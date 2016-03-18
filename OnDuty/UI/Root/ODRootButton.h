//
//  ODRootButton.h
//  OnDuty
//
//  Created by Vision on 16/3/19.
//  Copyright © 2016年 VisionBao. All rights reserved.
//

typedef void (^SelectBlock)();

#import <UIKit/UIKit.h>

@interface ODRootButton : UIView

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) SelectBlock block;
@end
