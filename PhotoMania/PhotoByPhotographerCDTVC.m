//
//  PhotoByPhotographerCDTVC.m
//  PhotoMania
//
//  Created by Ujwal Manjunath on 5/7/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "PhotoByPhotographerCDTVC.h"
#import "Photo.h"

@interface PhotoByPhotographerCDTVC ()

@end

@implementation PhotoByPhotographerCDTVC

-(void) setPhotographer:(Photographer *)photographer
{
    _photographer = photographer;
    self.title = photographer.name;
    [self setupFetchedResultsController];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo"];
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    return cell;
}

-(void) setupFetchedResultsController
{
    if(self.photographer.managedObjectContext){
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"whoTook = %@",self.photographer];
    
    self.fetchedResultsController = [[ NSFetchedResultsController alloc]initWithFetchRequest:request
                                                                       managedObjectContext:self.photographer.managedObjectContext sectionNameKeyPath:nil
                                                                                  cacheName:nil];
    }else{
        self.fetchedResultsController = nil;
    }
    
}
@end
