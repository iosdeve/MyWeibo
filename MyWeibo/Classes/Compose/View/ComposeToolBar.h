//
//  ComposeToolBar.h
//  MyWeibo
//
//  Created by ChenXin on 3/20/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ComposeToolBarButtonTypeCamera,
    ComposeToolBarButtonTypeAlbum,
    ComposeToolBarButtonTypeEmoticon,
    ComposeToolBarButtonTypeMetion,
    ComposeToolBarButtonTypeTrend
} ComposeToolBarButtonType;

@interface ComposeToolBar : UIView

@end
