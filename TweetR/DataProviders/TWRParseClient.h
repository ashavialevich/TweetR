//
//  TWRParseClient.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRWebServiceClient.h"
#import <Foundation/Foundation.h>

/**
 @abstract Class used to make all the service requests to parse.com DB.
 @discusstion This class will invoke all of it's methods' handlers on main thread.
 */
@interface TWRParseClient : NSObject <TWRWebServiceClientProtocol>

@end
