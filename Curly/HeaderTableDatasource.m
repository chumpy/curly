//
//  HeaderTableDatasource.m
//  Curly
//
//  Created by Kevin Beddingfield on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeaderTableDatasource.h"

@implementation HeaderTableDatasource
@synthesize dictionary;
@synthesize headerView;

- (int)numberOfRowsInTableView:(NSTableView*) aTableView
{
    int myCount = [dictionary count];
    return myCount;
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(int)rowIndex
{
    NSArray *myKeys = [dictionary allKeys];

    NSArray *columns = [headerView tableColumns];
    NSTableColumn *firstColumn = [columns objectAtIndex:0];
    if([aTableColumn isEqual:firstColumn])
    {
        return [myKeys objectAtIndex:rowIndex];
    } else {
        return [dictionary objectForKey:[myKeys objectAtIndex:rowIndex]];
    }
    
}   

- (void)addHeaderToTable:(NSString*)key value:(NSString*)value
{
    [dictionary setObject:value forKey:key];
    [headerView reloadData];
}




@end
