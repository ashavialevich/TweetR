//
//  TWRFormView.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/14/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWRValidatable.h"

/**
 @discussion The form view is a container view for form fields. Adding form fields to this view will
 automatically register the form fields with an error provider.
 */
@interface TWRFormView : UIView <TWRValidatable>

@end
