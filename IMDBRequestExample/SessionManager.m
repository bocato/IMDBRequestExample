//
//  SessionManager.m
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 09/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager

static NSString *const kBaseURL = @"http://www.omdbapi.com/?";

- (id)init{
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    if(!self) return nil;
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}

+ (id)sharedManager {
    static SessionManager *_sessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}

@end
