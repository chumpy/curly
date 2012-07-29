//
//  HeaderTableDatasource.h
//  Curly
//
//  Created by Kevin Beddingfield on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderTableDatasource : NSObject

@property NSMutableDictionary *dictionary;
@property NSTableView *headerView;

- (void)addHeaderToTable:(id)key value:(id)value;
- (void)clearHeaders;


@end
