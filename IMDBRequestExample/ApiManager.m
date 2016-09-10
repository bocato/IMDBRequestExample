//
//  ApiManager.m
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 09/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import "ApiManager.h"
#import "SessionManager.h"
#import "Mantle.h"
#import "Movie.h"

static NSString *const kBaseURL = @"https://www.omdbapi.com/";

@implementation ApiManager

- (NSURLSessionDataTask *)getMovieWithName:(NSString *)name success:(void (^)(Movie *response))success failure:(void (^)(NSError *error))failure{
    
    NSString *requestUrl = [kBaseURL stringByAppendingString:[NSString stringWithFormat:@"?t=%@", name ?: @""]];
    
    return [self GET:requestUrl parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 
                 NSError *error;
                 Movie *movie = [MTLJSONAdapter modelOfClass:Movie.class
                                          fromJSONDictionary:responseDictionary error:&error];
                 success(movie);
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 
                 failure(error);
                 
             }];
    
}

@end
