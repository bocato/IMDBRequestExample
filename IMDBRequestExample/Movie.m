//
//  Movie.m
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 09/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import "Movie.h"

@implementation Movie

#pragma mark - Mantle JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title" : @"Title",
             @"year" : @"Year",
             @"released" : @"Released",
             @"runtime" : @"Runtime",
             @"genre" : @"Genre",
             @"director" : @"Director",
             @"writer" : @"Writer",
             @"actors" : @"Actors",
             @"plot" : @"Plot",
             @"language" : @"Language",
             @"country" : @"Country",
             @"awards" : @"Awards",
             @"poster" : @"Poster",
             @"metascore" : @"Metascore",
             @"imdbRating" : @"imdbRating",
             @"imdbVotes" : @"imdbVotes",
             @"imdbID" : @"imdbID",
             @"type" : @"Type",
             @"response" : @"Response",
             };
}

#pragma mark - JSON Transformer
+ (NSValueTransformer *)moviesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Movie.class];
}

@end
