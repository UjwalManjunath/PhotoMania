//
//  PhotographerCDTVC.m
//  PhotoMania
//
//  Created by Ujwal Manjunath on 5/7/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "PhotographerCDTVC.h"
#import "Photographer.h"

@interface PhotographerCDTVC ()

@end

@implementation PhotographerCDTVC

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    
    if([sender isKindOfClass:[UITableViewCell class]]){
        indexPath = [self.tableView indexPathForCell:sender];
    }
    
    if(indexPath){
        if([segue.identifier isEqualToString:@"setPhotographer"]){
            Photographer *photographer = [self.fetchedResultsController objectAtIndexPath:indexPath];
            if( [segue.destinationViewController respondsToSelector:@selector(setPhotographer:)]){
                [segue.destinationViewController performSelector:@selector(setPhotographer:) withObject:photographer];
            }
        }
    }
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext =  managedObjectContext ;
    if(managedObjectContext){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate =nil; //all photographers
        self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }else {
        self.fetchedResultsController = nil;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photographer"];
    Photographer *photographer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = photographer.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photos",[photographer.photos count]];
    return cell;
}

@end
