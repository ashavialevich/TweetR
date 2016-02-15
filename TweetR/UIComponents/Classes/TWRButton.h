//
//  TWRButton.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TWRButtonType) {
    TWRButtonTypePrimary = 0,
    TWRButtonTypeSecondary = 1,
    TWRButtonTypeDisabled,
    TWRButtonTypeDisabledClickable
};

@interface TWRButton : UIButton

@property (assign, nonatomic) TWRButtonType type;

@end
