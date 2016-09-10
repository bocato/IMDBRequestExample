//
//  ApiManager.h
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 09/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import "SessionManager.h"
#import "Movie.h"

@interface ApiManager : SessionManager

- (NSURLSessionDataTask *)getMovieWithName:(NSString *)name success:(void (^)(Movie *response))success failure:(void (^)(NSError *error))failure;

@end
