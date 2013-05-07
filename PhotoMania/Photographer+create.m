//
//  Photographer+create.m
//  PhotoMania
//
//  Created by Ujwal Manjunath on 3/17/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "Photographer+create.h"

@implementation Photographer (create)


+(Photographer *)photographerWithName:(NSString *)name
               inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photographer *photographer = nil;
    if(name.length >1 ){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
        request.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                 ascending:YES
                                                                  selector:@selector(localizedCaseInsensitiveCompare:) ]];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if(!matches || [matches count] > 1){
            //handle error
        }
        else if(![matches count]){
            photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
            photographer.name = name;
        }
        else{
            name = [matches lastObject];
        }
    }
   
    return photographer;
}
@end
