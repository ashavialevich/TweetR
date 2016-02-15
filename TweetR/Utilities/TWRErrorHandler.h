//
//  TWRErrorHandler.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @abstact Class designed to deal with various data persisting/retreiving errors.
 @discussion This class doesn't do much right now (just handles error (any error) exactly the same way), but the design
 intent is such that all of the error handling, related navigation stack management is abstracted away from the view
 controllers that are making data persisting/retreiving using respective data clients.
 */
@interface TWRErrorHandler : NSObject

+ (void)handleGenericError:(NSError *)error context:(NSObject *)context;

@end
