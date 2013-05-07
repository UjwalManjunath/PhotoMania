//
//  Photographer+create.h
//  PhotoMania
//
//  Created by Ujwal Manjunath on 3/17/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "Photographer.h"

@interface Photographer (create)

+(Photographer *) photographerWithName:(NSString *)name
              inManagedObjectContext:(NSManagedObjectContext *)context;

@end
