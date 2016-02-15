//
//  TWRButton.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRButton.h"
#import "TWRUIConstants.h"
#import "TWRColors.h"

@implementation TWRButton

- (void)setType:(TWRButtonType)type {
    switch (type) {
        case TWRButtonTypeDisabled:
            self.backgroundColor = [UIColor grayColor];
            self.titleLabel.textColor = [UIColor whiteColor];
            self.userInteractionEnabled = NO;
            break;
        case TWRButtonTypeDisabledClickable:
            self.backgroundColor = [UIColor grayColor];
            self.titleLabel.textColor = [UIColor whiteColor];
            self.userInteractionEnabled = YES;
            break;
        case TWRButtonTypePrimary:
            self.backgroundColor = TWRUIColorFromRGB(TWR_TWITTER_BLUE);
            self.titleLabel.textColor = [UIColor whiteColor];
            self.userInteractionEnabled = YES;
            break;
        case TWRButtonTypeSecondary:
            self.backgroundColor = [UIColor whiteColor];
            self.titleLabel.textColor = TWRUIColorFromRGB(TWR_TWITTER_BLUE);
            self.userInteractionEnabled = YES;
            break;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = TWR_BUTTON_CORNER_RADIUS;
        _type = TWRButtonTypePrimary;
        self.backgroundColor = TWRUIColorFromRGB(TWR_TWITTER_BLUE);
        self.titleLabel.textColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = TWR_BUTTON_CORNER_RADIUS;
        _type = TWRButtonTypePrimary;
        self.backgroundColor = TWRUIColorFromRGB(TWR_TWITTER_BLUE);
        self.titleLabel.textColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
