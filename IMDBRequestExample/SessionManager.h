//
//  SessionManager.h
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 09/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SessionManager : AFHTTPSessionManager

+ (id)sharedManager;

@end
