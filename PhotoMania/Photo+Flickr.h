//
//  Photo+Flickr.h
//  PhotoMania
//
//  Created by Ujwal Manjunath on 3/17/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+(Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
       inManagedObjectContext:(NSManagedObjectContext *)context;
@end
