//
//  TWRUserFeedTableViewCell.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRUIConstants.h"
#import "TWRUserFeedTableViewCell.h"

@implementation TWRUserFeedTableViewCell

- (void)awakeFromNib {
    self.userImageView.layer.cornerRadius = TWR_PROFILE_IMAGE_CORNER_RADIUS;
}

@end
